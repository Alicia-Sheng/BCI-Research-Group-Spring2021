%{
This function is to draw the graph of for 4 nodes 5 bands
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
for session_id = 6:6
    filename = strcat("7_tcr_s",string(session_id),".txt");  
    t = dlmread(strcat("clean_and_labeled_abs_main_result/", filename));
    % use data from 2 to 21 col
    t = t(1:3000, 2:21);
    % add all sessions' data together
    data_matrix = vertcat(data_matrix, t); %final size 18000*20
end
disp("initial size of input:");
disp(size(data_matrix));

%add row number to the col #21
row_num=[1:1:size(data_matrix,1)];
row_num = row_num.';
data_matrix = [data_matrix row_num];
disp("size after adding row number to column #6");%should be 3000*21
disp(size(data_matrix));

tcr_overview(data_matrix, 6 ,40);