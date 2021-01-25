%{
This function is to draw the graph of for 5 different waves
Author: Duowen Sheng, Ruyang Wang

Input:
data files in this folder
clean_and_labeled_abs_main_result
input file name example: /abs_tcr_1_1_clean_lbd.csv

Output:
a graph (need to be saved)
%}

% test subject x, session x
subject_id=1;

%read table from session a to b
data_matrix = [];
for session_id = 1:6
    filename = strcat("7_tcr_s",string(session_id),".txt");  
    %filename = strcat("abs_tcr_",string(subject_id),"_",string(session_id),"_clean_lbd.csv");  
    t = dlmread(strcat("clean_and_labeled_abs_main_result/", filename));
    % use data from 2 to 21 col
    t = t(1:3000, 2:21);
    % add all sessions' data together
    data_matrix = vertcat(data_matrix, t); %final size 18000*20
    disp(size(data_matrix));
end
disp("initial size of input:");
disp(size(data_matrix));

%{
%add row number to the col #21
row_num=[1:1:size(data_matrix,1)];
row_num = row_num.';
data_matrix = [data_matrix row_num];
disp("size after adding row number to column #6");%should be 3000*21
disp(size(data_matrix));
%}

%{
%remove zeros
zero_data = data_matrix(:, 1) == 0;
data_matrix(zero_data, :) = [];
disp("size after removing 0");
disp(size(data_matrix));
%}

%{

%plot the wave graph with 5 lines
%each line shows the value change for a wave
hold on
for i=1:20
    switch mod(i,5)
        case 0
            plot(data_matrix(:,21),data_matrix(:,i)+fix((i-1)/5)*4,'Color','m');
        case 1
            plot(data_matrix(:,21),data_matrix(:,i)+fix((i-1)/5)*4,'Color','r');
        case 2
            plot(data_matrix(:,21),data_matrix(:,i)+fix((i-1)/5)*4,'Color','g');
        case 3
            plot(data_matrix(:,21),data_matrix(:,i)+fix((i-1)/5)*4,'Color','b');
        case 4
            plot(data_matrix(:,21),data_matrix(:,i)+fix((i-1)/5)*4,'Color','c');
    end
end

l1=plot([NaN, NaN], 'color', 'm');
l2=plot([NaN, NaN], 'color', 'r');
l3=plot([NaN, NaN], 'color', 'g');
l4=plot([NaN, NaN], 'color', 'b');
l5=plot([NaN, NaN], 'color', 'c');
legend([l1,l2,l3,l4,l5],{'alpha','beta','delta','gamma','theta'});

set(gca,'xtick',[600 1200 1800 2400 3000]);

axis([0 3000 -1 19]);
%}

%tcr_overview(data_matrix, 1 ,94);

activity = [];
%Think
activity = [data_matrix(1:600,:);data_matrix(3601:4200,:);data_matrix(6001:6600,:);data_matrix(9001:9600,:);data_matrix(12601:13200,:);data_matrix(15001:15600,:)];
%Count
%activity = [data_matrix(601:1200,:);data_matrix(4201:4800,:);data_matrix(8401:9000,:);data_matrix(9601:10200,:);data_matrix(12001:12600,:);data_matrix(15601:16200,:)];
%Recall
%activity = [data_matrix(1201:1800,:);data_matrix(4801:5400,:);data_matrix(7201:7800,:);data_matrix(10201:10800,:);data_matrix(13201:13800,:);data_matrix(16801:17400,:)];
%Breathe
%activity = [data_matrix(1801:2400,:);data_matrix(3001:3600,:);data_matrix(6601:7200,:);data_matrix(10801:11400,:);data_matrix(14401:15000,:);data_matrix(16201:16800,:)];
%Draw
%activity = [data_matrix(2401:3000,:);data_matrix(5401:6000,:);data_matrix(7801:8400,:);data_matrix(11401:12000,:);data_matrix(13801:14400,:);data_matrix(17401:18000,:)];

row_num=[1:1:size(activity,1)];
row_num = row_num.';
activity = [activity row_num];
%disp("size after adding row number to column #6");%should be 3000*21
%disp(size(think));

hold on
for i=1:20
    switch mod(i,5)
        case 0
            plot(activity(:,21),activity(:,i)+fix((i-1)/5)*4,'Color','m');
        case 1
            plot(activity(:,21),activity(:,i)+fix((i-1)/5)*4,'Color','r');
        case 2
            plot(activity(:,21),activity(:,i)+fix((i-1)/5)*4,'Color','g');
        case 3
            plot(activity(:,21),activity(:,i)+fix((i-1)/5)*4,'Color','b');
        case 4
            plot(activity(:,21),activity(:,i)+fix((i-1)/5)*4,'Color','c');
    end
end

l1=plot([NaN, NaN], 'color', 'm');
l2=plot([NaN, NaN], 'color', 'r');
l3=plot([NaN, NaN], 'color', 'g');
l4=plot([NaN, NaN], 'color', 'b');
l5=plot([NaN, NaN], 'color', 'c');
legend([l1,l2,l3,l4,l5],{'alpha','beta','delta','gamma','theta'});

set(gca,'xtick',[600 1200 1800 2400 3000 3600]);

axis([0 3600 -1 19]);