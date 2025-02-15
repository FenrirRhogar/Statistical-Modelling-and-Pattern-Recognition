function A = myLDA(Samples, Labels, NewDim)
% Input:    
%   Samples: The Data Samples 
%   Labels: The labels that correspond to the Samples
%   NewDim: The New Dimension of the Feature Vector after applying LDA

% 	A=zeros(NumFeatures,NewDim);
    
	[NumSamples NumFeatures] = size(Samples);
    NumLabels = length(Labels);
    if(NumSamples ~= NumLabels) then
        fprintf('\nNumber of Samples are not the same with the Number of Labels.\n\n');
        exit
    end
    Classes = unique(Labels);
    NumClasses = length(Classes)  %The number of classes

    %For each class i
	%Find the necessary statistics
    
   for i = 1:NumClasses
        % Extract the samples of the i-th class
        X = Samples(Labels == Classes(i, :));
        % Calculate the prior probability of the i-th class
        P(i) = size(X, 1) / NumSamples;
        % Calculate the mean vector of the i-th class
        m(i, :) = mean(X);
        %Calculate the Within Class Scatter Matrix
        Z = X - m(i,:);
        Si =( Z' * Z) / (size(X,1) - 1);

        Sw = sum(Si, 3);
%         %Calculate the Globan Mean
%         m0= m0 + mean(m(i,:))
       
   end
    
   
    %Calculate the Globan Mean
    gmean = mean(Samples);
    %Calculate the Between Class Scatter Matrix
    Sb = zeros(NumFeatures);
    for i = 1:NumClasses
      Z = m(i, :) - gmean;
      Sb = Sb + P(i) * (Z' * Z);
    end
%     
%     %Eigen matrix 
      EigMat=inv(Sw)*Sb;
      
    
        
         
%     
%     %Perform Eigendecomposition
     [V, D] = eig(EigMat);
     [~, idx] = sort(diag(D), 'descend');
      V = V(:, idx);
%     
%     %Select the NewDim eigenvectors corresponding to the top NewDim
%     %eigenvalues (Assuming they are NewDim<=NumClasses-1)
% 	%% You need to return the following variable correctly.
% Return the LDA projection vectors
    A=zeros(NumFeatures,NewDim);
    A = V(:, 1:NewDim);
