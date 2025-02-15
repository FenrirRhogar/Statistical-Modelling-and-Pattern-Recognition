close all;
clear all;
clc;

data_file = './data/mnist.mat';

data = load(data_file);

% Read the train data
[train_C1_indices, train_C2_indices, train_C1_images, train_C2_images] = read_data(data.trainX, data.trainY.');

% Read the test data
[test_C1_indices, test_C2_indices, test_C1_images, test_C2_images] = read_data(data.testX, data.testY.');

% Compute the aspect ratios of the number 1 and number 2 images
aRatio_1 = zeros(size(train_C1_indices,2),1)';

for i = 1:length(train_C1_indices)
    [aRatio_1(i), row_min_C1(i), col_min_C1(i), height_C1(i), width_C1(i)] = computeAspectRatio(squeeze(train_C1_images(i,:,:)));
end

aRatio_2 = zeros(size(train_C2_indices,2),1)';

for k = 1:length(train_C2_indices)
    [aRatio_2(k), row_min_C2(k), col_min_C2(k), height_C2(k), width_C2(k)] = computeAspectRatio(squeeze(train_C2_images(k,:,:)));
end



% Find the minimum and maximum aspect ratios among all images
aRatios = [aRatio_1, aRatio_2];
minAspectRatio = min(aRatios);
maxAspectRatio = max(aRatios);



% Print minimum and maximum aspect ratio
fprintf('Minimum aspect ratio: %.2f\n', minAspectRatio)
fprintf('Maximum aspect ratio: %.2f\n', maxAspectRatio)

% % Plot two samples from the dataset with bounding rectangles
% Display two random samples with aspect ratio rectangles
figure;
subplot(1,2,1);
idx1 = randi(size(train_C1_images, 1));
imshow(squeeze(train_C1_images(idx1,:,:)));
rectangle('Position', [col_min_C1(idx1)-0.5, row_min_C1(idx1)-0.5, width_C1(idx1), height_C1(idx1)], 'EdgeColor', 'r', 'LineWidth', 2);
title(sprintf('Class 1: aspect ratio = %.2f', aRatio_1(idx1)));
subplot(1,2,2);
idx2 = randi(size(train_C2_images, 1));
imshow(squeeze(train_C2_images(idx2,:,:)));
rectangle('Position', [col_min_C2(idx2)-0.5, row_min_C2(idx2)-0.5, width_C2(idx2), height_C2(idx2)], 'EdgeColor', 'r', 'LineWidth', 2);
title(sprintf('Class 2: aspect ratio = %.2f', aRatio_2(idx2)));
 
 %% Bayesian Classifier
 
 
 % Prior Probabilities
 trainNum1 = length(train_C1_indices); % arithmos deigmaton ekpaideushs sth class 1 
 trainNum2 = length(train_C2_indices); % arithmos deigmaton ekpaideushs sth class 2
 
 % oi prior probabilities ypologizontai apo ton aritho samples apo kathe
 % klash pros ton sunoliko arithmo samples
 PC1 =  trainNum1/( trainNum1+ trainNum2);
 PC2 = trainNum2/( trainNum1+ trainNum2);
 
 m1 = sum(aRatio_1)./length(train_C1_indices);
 m2 = sum(aRatio_2)./length(train_C2_indices);
 Var1 = sum((aRatio_1-m1).^2)/length(train_C1_indices);
 Var2 = sum((aRatio_2-m2).^2)/length(train_C2_indices);


errors=0;

for j = 1:length(test_C1_indices)
   a_Ratio_test_1(j)=computeAspectRatio(squeeze(test_C1_images(j,:,:)));
   % Likelihoods
   PgivenC1(j) = normpdf(a_Ratio_test_1(j),m1,sqrt(Var1));
   PgivenC2(j) = normpdf(a_Ratio_test_1(j),m2,sqrt(Var2));
   % % Posterior Probabilities
   PC1givenL(j) = PC1*PgivenC1(j);
   PC2givenL(j) = PC2*PgivenC2(j);
   
   if( PC1givenL(j)< PC2givenL(j))
       errors = errors +1;
   end
end

 
for l = 1:length(test_C2_indices)
a_Ratio_test_2(l)=computeAspectRatio(squeeze(test_C2_images(l,:,:)));
% Likelihoods
PgivenC2(l) = normpdf(a_Ratio_test_2(l),m2,sqrt(Var2));
PgivenC2(l) = normpdf(a_Ratio_test_2(l),m1,sqrt(Var1));

% % Posterior Probabilities
PC2givenL(l) = PC2*PgivenC2(l);
PC1givenL(l) = PC1*PgivenC1(l);

if( PC2givenL(l)< PC1givenL(l))
      errors = errors +1;
   end
end

Error = errors/(length(test_C2_indices)+length(test_C1_indices));

