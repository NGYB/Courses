function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

%Inputs
%   num_labels : no of outputs
%   X          :Input matrix of size no. of examples by no. of input features
%   y          :vector of size no. of examples by 1. Each element y(i) is a value from 1 to 10. 

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
%Theta1 has size no of hidden nodes by input nodes+1
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

%Theta2 has size num_labels/no of output nodes by (hidden_layer_size+1).             
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m

X = [ones(m, 1) X];
a2 = sigmoid(Theta1*X');  %matrix of size number of hidden nodes by no. of examples
                          %ie. for column 1, these are the outputs for the hidden
                          %nodes, for example 1.

a2 = [ones(1, m); a2];
a3 = sigmoid(Theta2*a2);  %matrix of size number of output nodes by no. of examples
                          %ie. for column 1, these are the outputs for the
                          %NN, for example 1.    

yi = zeros(num_labels, m);
for i = 1:m
    yi(y(i),i) = 1;    
end    

%unregularized cost function
J = 1/m*sum(sum(-yi.*log(a3) - (1-yi).*log(1-a3)));

%regularized cost function
J = J + lambda/2/m*(sum(sum(Theta1(:,2:end).^2)) + sum(sum(Theta2(:,2:end).^2)));



% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.

for i = 1:m
   a1 = X(i,:)';   %vector of size no. of inputs+1 by 1.
   z2 = Theta1*a1;      %vector of size number of hidden nodes by 1
   a2 = sigmoid(z2);                    

   a2 = [1; a2];        %vector of size no. of hidden nodes+1 by 1.
   z3 = Theta2*a2;      %vector of size number of output nodes by 1
   a3 = sigmoid(z3);
   
   delta3 = a3-yi(:,i); %vector of size number of ouput nodes by 1
   
   delta2 = (Theta2'*delta3).*[1; sigmoidGradient(z2)]; %size no. of hidden nodes+1 by 1
   
   delta2 = delta2(2:end);
   
   %Theta1_grad has size no of hidden nodes by input nodes+1
   Theta1_grad = Theta1_grad + delta2*a1';
   
   %Theta2_grad has size num_labels/no of output nodes by
   %(hidden_layer_size+1).  
   Theta2_grad = Theta2_grad + delta3*a2'; 
         
end

Theta1_grad = 1/m*Theta1_grad;
Theta2_grad = 1/m*Theta2_grad;

% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

Theta1Temp = [zeros(hidden_layer_size,1) Theta1(:,2:end)];
Theta1_grad = Theta1_grad + lambda/m*Theta1Temp;

Theta2Temp = [zeros(num_labels,1) Theta2(:,2:end)];
Theta2_grad = Theta2_grad + lambda/m*Theta2Temp;


















% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
