function accuracy = get_accuracy(predictions, labels)
    % Calculate the number of correct predictions
    correct = sum(all(predictions == labels, 1));
    
    % Calculate the total number of predictions
    total = size(predictions, 2);
    
    % Calculate the accuracy as a percentage
    accuracy = correct / total;
end