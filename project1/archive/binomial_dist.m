clc; clear all; close all;

% Binomial distribution parameters
N = 1:1:100; % No. of observations, we are interested in various N values
p = 0.5; % Probability of success for one trial
        % - Also the mean for Bernoulli distribution (individual trials)
        % - This is the true value of the parameter being compared with
        %   the ML and CP estimates

% Number of trials for each distinct number of observations (for MEAN
% squared error calculation VS. N)
nTrials = 100;

% Data generation
% - Generate vector of 1's and 0's for EACH distinct N MULTIPLE times
% - Since these vectors are differently sized, I store them in a cell array
% - The rows of the cell matrix represent each distinct N
% - Each element of the cell matrix is an N-by-nTrials normal matrix
%   (for vectorization purposes)
%   - So each COLUMN of the inner matrix represents a different trial for
%     the fixed N associated with that matrix
x = cell(size(N,2),1); % can just use length(N) for vectors
for i = 1:size(N,2)
    % Temporary inner matrix
    x_i = [];
    % Fill the inner matrix with trials
    % Take transpose of output of rand so you get a column vector (trials
    % are columns)
    for j = 1:nTrials
        x_i = [x_i (rand(1,N(i))<=p)'];
    end
    % Store the matrix in the cell array
    x{i,1} = x_i; % USE CURLY BRACES TO REPLACE DATA,
                % smooth brace indexing replaces cells
end


% Compute mean-squared errors of ML estimates for each observation
% - Store them a vector the same size as N (to plot them together later)
% - We'll also store the counts of 1's and 0's because we'll need it later
%   to calculate the CP estimates (which rely on m and l)
%   - m and l will be N-by-nTrials matrices, like the inner matrices of x
MSE_ML = [];
m = [];
l = [];
for i = 1:size(N,2)
    % Sum matrix elements along columns (i.e. sum all the rows/observations)
    % to count the number of 1's for each trial for a fixed N (m)
    % Subtract m from N to get l
    m_i = sum(x{i,1},1); % be careful when dealing with row/col vectors,
                        % make sure you're adding along the proper dim
                        % dim = 1: sum the cols, dim = 2: sum the rows
    l_i = N(i)-m_i;
    % Find ML estimate by dividing m by no. of observations
    mu_ML_i = m_i/N(i);
    % Find mean squared error by averaging squared error for each
    % ML measurement across all trials (average the columns)
    MSE_ML_i = mean((mu_ML_i-p).^2,2);
    % Store values into overall ML, m, and l vectors/matrices
    MSE_ML = [MSE_ML MSE_ML_i];
    m = [m; m_i];
    l = [l; l_i];
end

% Compute mean-squared errors of conjugate prior estimates

% Beta distribution hyperparameters for prior (4 sets)
a = [0.1, 1, 2, 8];
b = [0.1, 1, 3, 4];

% Store these conjugate prior estimates in a matrix, same row length as N
% Row - distinct observations, Col - hyperparameter sets
MSE_CP = [];
% Iterate through hyperparameters sets
for i = 1:size(a,2)
    % Calculate the conj. prior estimates using metric on P73
    % Since we're using m and l, recall that the output is an N-by-nTrials
    % matrix and perform element-wise operations
    mu_CP_i = (m+a(i))./(m+a(i)+l+b(i));
    % Take difference from true value (p) and average across trials
    % (average the columns) to get mean-squared error
    MSE_CP_i = mean((mu_CP_i-p).^2,2);
    % Store in overall MSE_CP matrix
    MSE_CP = [MSE_CP MSE_CP_i];
end

% Plots of mean-squared errors for each case
figure
plot(N,MSE_ML)
hold on

for i = 1:size(a,2)
    plot(N,MSE_CP(:,i))
    hold on
end

title(['Mean-Squared Error Comparison of ML and CP Estimates of Probability of Success '...
        'for Binomial Distribution ',sprintf('(No. Trials = %d)',nTrials)])
legend('ML',...
        sprintf('CP (A=%.3f, B=%.3f)',a(1),b(1)),...
        sprintf('CP (A=%.3f, B=%.3f)',a(2),b(2)),...
        sprintf('CP (A=%.3f, B=%.3f)',a(3),b(3)),...
        sprintf('CP (A=%.3f, B=%.3f)',a(4),b(4)))
xlabel('N (No. of observations)')
ylabel('Mean-squared Error for Probability of Success')
hold off