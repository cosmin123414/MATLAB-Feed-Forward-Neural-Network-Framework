function Z = label_matrix(X)
    Z = zeros(length(X), max(X) + 1);
    for i=1:length(X)
        j = X(i) + 1;
        Z(i,j) = 1;
    end
end