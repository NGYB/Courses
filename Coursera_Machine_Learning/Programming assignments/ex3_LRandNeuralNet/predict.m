function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

%Inputs
%   Theta 1 : size 25 by 401. Number of hidden nodes by no. of input
%             features
%   Theta 2 : size 10 by 26. Number of output nodes by (no. of hidden nodes+1) 
%   X       : number of examples by no. of input features per example
%Outputs
%   p       : number of examples by 1 column vector. p(i) will be an
%             element of 1,2,...,10.

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned neural network. You should set p to a 
%               vector containing labels between 1 to num_labels.
%
% Hint: The max function might come in useful. In particular, the max
%       function can also return the index of the max element, for more
%       information see 'help max'. If your examples are in rows, then, you
%       can use max(A, [], 2) to obtain the max for each row.
%

% Add ones to the X data matrix
X = [ones(m, 1) X];
a2 = sigmoid(Theta1*X');  %matrix of size number of hidden nodes by no. of examples
                          %ie. for column 1, these are the outputs for the hidden
                          %nodes, for example 1.

a2 = [ones(1, m); a2];
a3 = sigmoid(Theta2*a2);  %matrix of size number of output nodes by no. of examples
                          %ie. for column 1, these are the outputs for the
                          %NN, for example 1.                          

[max_value, p] = max(a3);
p=p';




% =========================================================================


end
