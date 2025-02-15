function [X_norm, mu, sigma] = featureNormalize(X)

% Calculate the mean of each feature
mu = sum(X) / size(X, 1);

% Calculate the standard deviation of each feature
sigma = sqrt(sum((X - mu) .^ 2) / (size(X, 1) - 1));

% Normalize each feature
X_norm = (X - mu) ./ sigma;

end
