function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

testVal = [0.01 0.03 0.1 0.3 1 3 10 30];
prederr = zeros(length(testVal), length(testVal)); %the rows correspond to the C values.
                                                   %the cols correspond to
                                                   %the sigma values

for i = 1:length(testVal)
    for j = 1:length(testVal)
        model= svmTrain(X, y, testVal(i), @(x1, x2) gaussianKernel(x1, x2, testVal(j))); 
        predictions = svmPredict(model, Xval);
        prederr(i,j) = mean(double(predictions ~= yval));
        
        
    end
end
[prederrmincol Ind] = min(prederr);
[prederrmin Ind2] = min(prederrmincol);
sigma = testVal(Ind2);
C = testVal(Ind(Ind2));


% =========================================================================

end