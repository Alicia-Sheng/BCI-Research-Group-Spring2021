%{

find the closest centroid for each 20-dimention point in data_matrix

Input:
data_point: a line of the data matrix represents a point
X: cluster medoid locations, returned as a numeric matrix

Output:
class_distance_set size: 3000 * 2
3000 rows of [class squared_distance] for each data point
class_number: 1 * 3000
3000 columns, each presents the corresponding class number of the point
%}

function [class_number,class_distance_set] = museClassifyAll(data,k,X)
  data_size = size(data);
  data_row_number = data_size(1);
  for(i=1:1:data_row_number)
      class_distance_set(i) = museClassify(data(i,:),X);
  end
  point_number_each_class = ones(1, 40)
  class_number = zeros(1,data_row_number);% 1*3000
  %point_number_each_class = ones(1,data_row_number); % 1*3000
  %E = zeros(1,data_size(2)); %1*20
  for(i=1:1:data_row_number)
      %when k = 1, the following 4 lines do not have practical meanings
      point_number_each_class(class_distance_set(i)) = point_number_each_class(class_distance_set(i))+1;
      if (i>k)
          point_number_each_class(class_distance_set(i-k)) = point_number_each_class(class_distance_set(i-k))-1;
      end
      %when k = 1, matrix class_number is the same as matrix class_distance_set
      [max_class,current_class_number]=max(point_number_each_class);
      class_number(i)=current_class_number;
  end
  return
end

      