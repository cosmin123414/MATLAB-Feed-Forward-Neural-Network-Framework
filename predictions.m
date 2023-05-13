function pred = predictions(X)
    % Find the indices of the maximum element in each column
    [~, maxIdx] = max(X, [], 1);
    
    % Create a matrix of the same size as A2, filled with zeros
    pred = zeros(size(X));
    
    % Set the elements at the maximum indices to 1
    pred(sub2ind(size(pred), maxIdx, 1:size(pred, 2))) = 1;
end