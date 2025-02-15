 function [aRatio,row_min,col_min,height,width] = computeAspectRatio(image)
    %[num_rows, num_cols] = size(image);
    
    % Find the rows and columns of the bounding box that encloses the digit
    row_indices = any(image, 2);
    col_indices = any(image, 1);
    row_min = find(row_indices, 1, 'first'); %index of the first none zero element in the rows
    row_max = find(row_indices, 1, 'last');%index of the last none zero element in the rows
    col_min = find(col_indices, 1, 'first');%index of the first none zero element in the cols
    col_max = find(col_indices, 1, 'last');%index of the last none zero element in the last

    % Compute the aspect ratio of the bounding box
    height = (row_max - row_min + 1);
    width =(col_max - col_min + 1);
    
    aRatio = width ./ height;
end


