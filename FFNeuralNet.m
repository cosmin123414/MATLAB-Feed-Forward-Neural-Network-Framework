classdef FFNeuralNet
    % Feed Forward Neural Net with a single hidden layer
    % Variable dimensions of layers
    % Activation functions ReLu and softmax
    % Cost function: MSE

    properties
        W1 % Weights between input layer and hidden layer
        b1 % Hidden layer biases
        W2 % Weights between hidden layer and output layer
        b2 % Output layer biases
        dims %dimensions of layers
    end

    methods
        function obj = FFNeuralNet(dim_input, dim_hidden, dim_output)
            %Constructs an instance of the Neural Network
            obj.W1 = rand(dim_hidden, dim_input) - 0.5;
            obj.b1 = rand(dim_hidden, 1) - 0.5;
            obj.W2 = rand(dim_output, dim_hidden) - 0.5;
            obj.b2 = rand(dim_output,1) - 0.5;
            obj.dims = [dim_input; dim_hidden; dim_output];
        end

        function [Z1, A1, Z2, A2] = forward_propagation(obj, X)
            %Forward propagation
            Z1 = obj.W1*X + obj.b1;          %Unactivated hidden layer
            A1 = ReLu(Z1);                   %Activated hidden layer
            Z2 = obj.W2*A1 + obj.b2;         %Unactivated output layer
            A2 = softmax(Z2);                %Activated output layer 
        end

        function [dW1, db1, dW2, db2] = back_propagation(obj, X, Z1, A1, A2, labels)
            %Backwards propagation
            n = size(labels,2);
            Y = label_matrix(labels)';
            dZ2 = A2 - Y;                     %Error in output layer
            dW2 = (1/n) * (dZ2*A1');          %Gradient of MSE with respect to W2
            db2 = (1/n) * sum(dZ2, 'all');    %Gradient of MSE with repspect to b2
            dZ1 = obj.W2'*dZ2 .* dReLu(Z1);   %Gradient with respect to Z1
            dW1 = (1/n) * dZ1*X';             %Gradient with respect to W1
            db1 = (1/n) * sum(dZ1, 'all');    %Gradient with respect to b1
        end

        function nobj = update(obj, dW1, db1, dW2, db2, alpha) 
            %Update properties
            nobj = FFNeuralNet(obj.dims(1), obj.dims(2), obj.dims(3));
            nobj.W1 = obj.W1 - alpha*dW1;
            nobj.W2 = obj.W2 - alpha*dW2;
            nobj.b1 = obj.b1 - alpha*db1;
            nobj.b2 = obj.b2 - alpha*db2;
        end
        function network = train(obj, X, Y, alpha, threshold)
            %Train the neural network
            labels = label_matrix(Y)';
            acc = 0;
            i = 0;
            while acc < threshold
                [Z1, A1, ~, A2] = obj.forward_propagation(X);
                [dW1, db1, dW2, db2] = obj.back_propagation(X, Z1, A1, A2, Y);
                network = obj.update(dW1, db1, dW2, db2, alpha);
                obj = network;
                i = i + 1;
                if mod(i, 10) == 0
                    pred = predictions(A2);
                    acc = get_accuracy(pred, labels);
                    display(acc);
                end  
            end
        end
        function [A2, accuracy] = test(network, X, Y)
            % Returns accuracy of network on test data
            [~, ~, ~, A2] = network.forward_propagation(X);
            pred = predictions(A2);
            accuracy = get_accuracy(pred, label_matrix(Y)');
        end

        function pred = predict(obj, imagePath, size)
            pixel_data = ImageToVector(imagePath, size)';
            [~, ~, ~, A2] = obj.forward_propagation(pixel_data);
            [~, pred] = max(A2);
        end
    end
end