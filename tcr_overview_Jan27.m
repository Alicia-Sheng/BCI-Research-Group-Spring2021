function tcr_overview(data_matrix, session ,numClusters)
    if session == 1
        legendstring = {'Think','Count','Recall','Breathe','Draw'};
    elseif session == 2
        legendstring = {'Breathe','Think','Count','Recall','Draw'};
    elseif session == 3 
        legendstring = {'Think','Breate','Recall','Draw','Count'};
    elseif session == 4
        legendstring = {'Think','Count','Recall','Breathe','Draw'};
    elseif session == 5
        legendstring = {'Count','Think','Recall','Draw','Breathe'};
    else
        legendstring = {'Think','Count','Breathe','Recall','Draw'};
    end
    
    windowSize = 150; %window size: 15s

    f1 = figure(1);

    data = data_matrix(:,1:20);
    musePlot(data);  % look at all data, select some

    
    % classify 

    [idx,X,sumd,D] = kmeans(data,numClusters); %kmeans / kmedoids

    [C,D]=museClassifyAll(data,1,X); %C stores the cluster number of each point
    %{
    count=zeros(numClusters,1);
    row_num=[1:1:size(count,1)];
    row_num = row_num.';
    count = [row_num count(:,1:1)];
    for i=C
        disp(i);
        count(i,2) = count(i,2)+1;
    end
    %B = sort(count(:,2),'descend')
    plot(count)
    disp(B(1:6));
    
    %}
    
    %plot(B);
    
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
    
    % size of a1-a5: 1*cluster number, records the distribution of cluster
    % throughout a task
%     a1= hist(C(1:600),0.5:numClusters-0.5);
%     a2= hist(C(600:1200),0.5:numClusters-0.5);
%     a3= hist(C(1200:1800),0.5:numClusters-0.5);
%     a4= hist(C(1800:2400),0.5:numClusters-0.5);
%     a5= hist(C(2400:3000),0.5:numClusters-0.5);
%     a6= hist(C(1:3000),0.5:numClusters-0.5); %Task 6
    a = hist(C(1:3000), 0.5:5.5)
    bar(a)
    return
%     number = (1:40)
%     a6 = [a6;number]
%     a6 = sortrows(a6,1)
%     %tasks = a6(1:6,:)
%     disp(a6)

    %aa = [a1./30;a2./30;a3./30;a4./30;a5./30;a6./150]';%Assume its correct
    aa = [a1;a2;a3;a4;a5]';%Assume its correct
    disp(aa)
    bar(aa); 
    legend([legendstring 'unknown'],'Location','eastoutside');
    title('Plot B. Frequency each cluster appears in each sections') 

    %{
    subplot(numg,1,pos); pos=pos+1;
    bar(aa'); legend(string([1:numClusters]));
    %}

    %vv = min(max(C),[1:max(C)]*(zz'==max(zz'))); % find which cluster is highest at each point
    %plot(vv,'.'); % this plots the cluster which is higest in the previous plot
    %legend(string(1:max(C)));
    subplot(numg,1,pos); pos=pos+1;

    vv = (aa' == max(aa')); %number of tasks * number of clusters
    numCC = 5;
    dd = [1:numCC]*vv; %1 * number of clusters, represents the corresponding task_number of each cluster
%     disp("dd")
%     disp(dd)
%     disp("a1")
%     disp(a1)
%     return
    
    CC = dd(C); %1 * data_row_number, represents the corresponding task_number of each data point
    disp(CC);
%     task6index = []
%     for i = 1:600
%         if CC(i)~=1
%             task6index = [task6index i]
%         end
%     end
%     for i = 601:1200
%         if CC(i)~=2
%             task6index = [task6index i]
%         end
%     end
%     for i = 1201:1800
%         if CC(i)~=3
%             task6index = [task6index i]
%         end
%     end
%     for i = 1801:2400
%         if CC(i)~=3
%             task6index = [task6index i]
%         end
%     end
%     for i = 2401:3000
%         if CC(i)~=5
%             task6index = [task6index i]
%         end
%     end
%     disp(task6index)
    
    % c1-c5 are 1 * numCC matrices, each represents the number of the
    % corresponding task k-means classifies
    c1= hist(CC(1:600),0.5:numCC-0.5);
    c2= hist(CC(600:1200),0.5:numCC-0.5);
    c3= hist(CC(1200:1800),0.5:numCC-0.5);
    c4= hist(CC(1800:2400),0.5:numCC-0.5);
    c5= hist(CC(2400:3000),0.5:numCC-0.5);
    %ccs = [c1;c2;c3;c4;c5]'./30;
    ccs = [c1;c2;c3;c4;c5]'./6;
    bar(ccs'); 
%     a = []
%     %ismember()
%     for i = 1:40
%         [number, index] = max(a6)
%         if ~ismember(dd(index), a)
%             a = [a dd(index)]
%         end
%         a6(index) = -1
%     end
    legend([legendstring],'Location','eastoutside');
    grid on;
    grid minor;
    %axis([0,6,0,25])
    axis([0,6,0,100])
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
    %unkonwnClusters = clusters(vv(6,:)==1);
    title('Plot D: 15s smoothing of k-means classification');


end
    
    