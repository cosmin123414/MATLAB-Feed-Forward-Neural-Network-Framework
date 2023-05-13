function y = softmax(x)
    % Subtract the maximum value from each element to prevent overflow
    x = x - max(x);
    % Calculate the exponent of each element
    ex = exp(x);
    % Normalize the exponents to sum to 1
    y = ex ./ sum(ex);
end