%%Project 1%%
%%Gaussian Known Mean%%

clc; clear all; close all;

X = randn(100); 
N = 1:1:100;
a = [0.1; 1; 2; 8]; 
b = [0.1; 1; 3; 4];
a_n = zeros(1,100);
b_n = zeros(1,100); 
var_ml = zeros(100);
sigma_cp = zeros(100);
mse_ml = zeros(1, 100);
mse_cp = [];
mu = 0;
sigma = 1; 
a_o = [0.1, 1, 2, 4];
b_o = sqrt([0.1, 1, 2, 4]);
nTrials = 100;


for i = 1:size(X, 1)
    var_ml(i, :) = sum((X(1:i, :)-mu).^2, 1)/i;
    mse_ml(i) = mean((var_ml(i,:) - sigma^2).^2, 2);
end


figure
plot(N, mse_ml)
hold on;
%a_n = a_o + N/2;
%b_n = b_o + 1/2(sum(x_n-mu)^2 = b_o + N/2*sigma^2

for i = 1:size(a_o, 2)
    a_N = a_o(i) + N/2;
    % We use bsxfun here again because N is a row vec and sigma_sq is a
    % matrix with N rows
    % We transpose it to get N cols
    b_N = b_o(i) + bsxfun(@times,N/2,var_ml');
    % Right divide b_N/a_N, which are different sizes so use bsxfun
    sigma_cp = bsxfun(@rdivide,b_N,a_N);
    % Mean squared error, average the trials (rows, dim=1)
    MSE_CP_norm_i = mean((sigma_cp-sigma^2).^2,1);
    % Store in vector
    mse_cp = [mse_cp; MSE_CP_norm_i];
end 

for i = 1:size(a_o, 2)
    plot(N, mse_cp(i,:))
    hold on
end

