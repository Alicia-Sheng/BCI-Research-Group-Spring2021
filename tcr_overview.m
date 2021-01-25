function tcr_overview(data_matrix, session ,numClusters)
    if session == 1
        legendstring = {'Think','Count','Recall','Breathe','Draw'};
    elseif session == 2
        legendstring = {'Breathe','Think','Count','Read','Draw'};
    elseif session == 3 
        legendstring = {'Think','Breate','Read','Draw','Count'};
    elseif session == 4
        legendstring = {'Think','Count','Read','Breathe','Draw'};
    elseif session == 5
        legendstring = {'Count','Think','Read','Draw','Breathe'};
    else
        legendstring = {'Think','Count','Breathe','Read','Draw'};
    end
    
    windowSize = 150; %window size: 15s

    f1 = figure(1);

    data = data_matrix(:,1:20);
    musePlot(data);  % look at all data, select some


    % classify 

    [idx,X,sumd,D] = kmeans(data,numClusters); %kmeans / kmedoids

    [C,D]=museClassifyAll(data,1,X); %C stores the cluster number of each point

    % plot
    hold off;

    numg = 4;
    pos = 1;

    subplot(numg,1,pos); pos=pos+1;
    musePlot(data);
    xticks([0:600:3000])
    axis tight;
    grid on; grid minor;
    legend('alpha','beta','delta','gamma','theta','Location','eastoutside');
    title('Plot A. Brainwave Data Overview')

    %{
    subplot(numg,1,pos); pos=pos+1;
    plot(C*0.2+0.5,'.b');grid on; grid minor;

    subplot(numg,1,pos); pos=pos+1;
    zz = clusterWindow(C,windowSize);
    plot(zz);
    legend(string(1:max(C)));
    grid on; grid minor;
    %}


    %Ctemp = [C(1:4:length(C)), C(2:4:length(C)),C(3:4:length(C)),C(4:4:length(C))];
    %C = Ctemp;
    %Ctemp2 = C(randperm(length(C)));
    %C=Ctemp2;
    subplot(numg,1,pos); pos=pos+1;
    
    a1= hist(C(1:600),0.5:numClusters-0.5);
    a2= hist(C(600:1200),0.5:numClusters-0.5);
    a3= hist(C(1200:1800),0.5:numClusters-0.5);
    a4= hist(C(1800:2400),0.5:numClusters-0.5);
    a5= hist(C(2400:3000),0.5:numClusters-0.5);

    aa = [a1;a2;a3;a4;a5]';
    disp(aa)
    bar(aa./30); 
    legend(legendstring,'Location','eastoutside');
    title('Plot B. Frequency each cluster appears in each sections') 

    %{
    subplot(numg,1,pos); pos=pos+1;
    bar(aa'); legend(string([1:numClusters]));
    %}

    %vv = min(max(C),[1:max(C)]*(zz'==max(zz'))); % find which cluster is highest at each point
    %plot(vv,'.'); % this plots the cluster which is higest in the previous plot
    %legend(string(1:max(C)));
    subplot(numg,1,pos); pos=pos+1;

     vv = (aa' == max(aa'));
     numCC = 5;
     dd = [1:numCC]*vv;
     CC = dd(C);
     c1= hist(CC(1:600),0.5:numCC-0.5);
    c2= hist(CC(600:1200),0.5:numCC-0.5);
    c3= hist(CC(1200:1800),0.5:numCC-0.5);
    c4= hist(CC(1800:2400),0.5:numCC-0.5);
     c5= hist(CC(2400:3000),0.5:numCC-0.5);
    ccs = [c1;c2;c3;c4;c5]'./30;
    bar(ccs'); 
    legend(legendstring,'Location','eastoutside');
    grid on;
    grid minor;
    axis([0,6,0,25])
    title('Plot C: Accuracy of k-means classification for each region')




    subplot(numg,1,pos); pos=pos+1;
    zz1 = clusterWindow(CC,windowSize);
    plot(zz1./(windowSize/100));
    %legend(string(1:max(CC)));
    legend(legendstring,'Location','eastoutside');
    grid on; grid minor;
    xticks([0:600:3000])
    xline(75,'-r','DisplayName','SW starts(75)');
    xline(2925,'-r','DisplayName','SW ends(2925)');
    % look into analyzing data using pca(all) to see which
    % vectors have the most importance, and cluster on those??
    clusters = [1:numClusters];
    readClusters = clusters(vv(1,:)==1);
    wpClusters = clusters(vv(2,:)==1);
    wcClusters = clusters(vv(3,:)==1);
    tpClusters = clusters(vv(4,:)==1);
    tcClusters = clusters(vv(5,:)==1);
    title('Plot D: 15s smoothing of k-means classification');


end