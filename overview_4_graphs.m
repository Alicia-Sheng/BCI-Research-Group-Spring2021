%{
This function is to draw 4 graphs for 4 nodes 5 bands
Author: Yulu Pan

Input:
data files in this folder
clean_and_labeled_abs_main_result
input file name example: /abs_tcr_1_1_clean_lbd.csv

Output:
a graph (need to be saved)
%}

%read table from session a to b
data_matrix = [];
for session_id = 1:6
    filename = strcat("7_tcr_s",string(session_id),".txt");  
    t = dlmread(strcat("clean_and_labeled_abs_main_result/", filename));
    % use data from 2 to 21 col
    t = t(1:3000, 2:21);
    % add all sessions' data together
    data_matrix = vertcat(data_matrix, t); %final size 18000*20
end
disp("initial size of input:");
disp(size(data_matrix));

%sort activities
activity = [];
activity = [data_matrix(1:600,:);data_matrix(3601:4200,:);data_matrix(6001:6600,:);data_matrix(9001:9600,:);data_matrix(12601:13200,:);data_matrix(15001:15600,:);
    data_matrix(601:1200,:);data_matrix(4201:4800,:);data_matrix(8401:9000,:);data_matrix(9601:10200,:);data_matrix(12001:12600,:);data_matrix(15601:16200,:);
    data_matrix(1201:1800,:);data_matrix(4801:5400,:);data_matrix(7201:7800,:);data_matrix(10201:10800,:);data_matrix(13201:13800,:);data_matrix(16801:17400,:);
    data_matrix(1801:2400,:);data_matrix(3001:3600,:);data_matrix(6601:7200,:);data_matrix(10801:11400,:);data_matrix(14401:15000,:);data_matrix(16201:16800,:);
    data_matrix(2401:3000,:);data_matrix(5401:6000,:);data_matrix(7801:8400,:);data_matrix(11401:12000,:);data_matrix(13801:14400,:);data_matrix(17401:18000,:)];
data_matrix = activity
disp("size for all");%should be 18000*20
disp(size(data_matrix));

%add row number to the col #21
row_num=[1:1:size(data_matrix,1)];
row_num = row_num.';
data_matrix = [data_matrix row_num];
disp("size after adding row number to column #6");%should be 3000*21
disp(size(data_matrix));

tcr_overview(data_matrix, 6 ,40);