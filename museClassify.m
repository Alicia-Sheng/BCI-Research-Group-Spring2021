%{

find the closest centroid for each 20-dimention point in data_matrix

Input:
data_point: a line of the data matrix represents a point
X: cluster medoid locations, returned as a numeric matrix

Output:
class: the cluster the point z is assigned
squared_distance: the distance between the point z and its closest centroid
%}

function [class,squared_distance]=museClassify(data_point,X)
centroid_size = size(X);
centroid_row_number = centroid_size(1); % row number of X
class = 1;
distance = X(1,:) - data_point; % distance between the first medoid and the point z represents, should be 1*20
squared_distance = distance*distance'; % the sum of squared distance

% compare the distances, and assign the point to the centroid with the
% closest distance
for(i=2:1:centroid_row_number)
    distance = X(i,:)-data_point;
    squared_distance_temp = distance*distance';
    if (squared_distance_temp < squared_distance)
        class = i;
        squared_distance = squared_distance_temp;
    end
end
return
end

    