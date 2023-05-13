# MATLAB Feed-Forward Neural Network Framework
 This project is a MATLAB implementation of a flexible, feed-forward neural network (FFNN) with customizable layer dimensions. It can be trained for a variety of tasks, such as image recognition, data classification, and more.

The implemented neural network has a single hidden layer, but the dimensions of the input, hidden, and output layers can be defined by the user. It uses the ReLU activation function for the hidden layer and the softmax activation function for the output layer. The cost function used for optimization is the Mean Squared Error (MSE).

Example: Handwritten Digit Recognition
As a demonstration of the capabilities of this FFNN implementation, I have trained it to recognize handwritten digits. A pre-trained model is included in the repository for this purpose.

To use the pre-trained model for handwritten digit recognition, you can load the model included in the repository, you can then use the predict method, which takes as arguments the path of an image file and the size to which the image should be resized before processing. The predict method returns the digit that the network predicts is represented in the image.

# Training Your Own Models
You can train your own models using this framework. The train method takes as arguments the input and output data, the learning rate, and the accuracy threshold for stopping training. It performs forward and backward propagation, adjusts the weights and biases of the network using gradient descent, and repeats this process until the accuracy threshold is reached. After training, the test method can be used to evaluate the network's performance on test data.

# Preparing Your Own Data
Users can prepare their own data using the DataPreparation function. This function takes a directory path, a set of labels, and a desired image size as inputs. It iterates over each subdirectory of the given directory, with each subdirectory representing a different category of images. The function converts each image to grayscale, resizes the image to the desired size, and reshapes the image into a 1D vector. It stores these image vectors along with their corresponding labels in a data cell. The data cell is then converted into a table and written to a CSV file. The resulting CSV file contains one row for each image, where the first column is the label of the image, and the remaining columns represent the pixel values of the image.

Once data is prepared, users can split their data into training and testing sets using the TestTrainSplit function. This function takes a filepath, a proportion for the test set, and the image size as inputs. It converts the data into matrices, shuffles the data, and splits it into training and testing sets based on the provided proportion.

# Future Plans
In the future, I aim to expand this project by introducing more flexibility and functionality. My plans include the addition of options for convolutional layers, transforming the network into a recurrent neural network, and integrating other common neural network architectures.

For any further clarification or assistance, please refer to the in-code documentation or open an issue on the project repository. Enjoy using the FFNN!
