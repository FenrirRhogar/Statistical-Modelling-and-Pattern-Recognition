function [J, grad] = costFunctionReg(theta, X, y, lambda)
    %COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
    %   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
    %   theta as the parameter for regularized logistic regression and the
    %   gradient of the cost w.r.t. to the parameters.

    % Initialize some useful values
    m = length(y); % number of training examples

    % You need to return the following variables correctly
    J = 0;
    grad = zeros(size(theta));

    % Compute the cost function
    h = sigmoid(X * theta);
    J = (1/m)*sum((-y' * log(h)) - ((1 - y)' * log(1 - h)),m(1:end));
    regularization = (lambda / (2 * m)) * sum(theta(1:end) .^ 2);
    J = J + regularization;

    % Compute the gradient
    grad = (X' * (h - y)) / m;
    grad(2:end) = grad(2:end) + (lambda / m) * theta(2:end);

    % =============================================================

end
