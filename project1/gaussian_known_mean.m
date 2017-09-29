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
mse_cp = zeros(4,100);
mu = 0;
sigma = 1; 
a_o = [0.1, 1, 2, 4];
b_o = sqrt([0.1, 1, 2, 4]);

for i = 1:size(X, 1)
    mu_ml = sum(X(1,i,:),1)/i;
    var_ml(i, :) = sum((X(1:i, :)-mu).^2, 1)/i;
    mse_ml(i) = mean((var_ml(i,:) - sigma^2).^2, 2);
end

figure
plot(N, mse_ml)
hold on;

for i = 1:size(a_o, 2)
    a_N = a_o(i) + N/2;
    b_N = b_o(i) + bsxfun(@times,N/2,var_ml');
    sigma_cp = bsxfun(@rdivide,b_N,a_N);
    mse_cp(i,:) = mean((sigma_cp-sigma^2).^2,1); 
    plot(N, mse_cp(i,:))
    hold on
end

title(['Mean-Squared Error Comparison of ML and CP Estimates '...
        'of Variance for Gaussian Distribution with Known Mean ',...
        sprintf('(No. Trials = %d)',100)])
    xlabel('N (No. of observations)')
legend('ML',...
        sprintf('CP (a_{0}=%.3f, b_{0}=%.3f)',a_o(1),b_o(1)),...
        sprintf('CP (a_{0}=%.3f, b_{0}=%.3f)',a_o(2),b_o(2)),...
        sprintf('CP (a_{0}=%.3f, b_{0}=%.3f)',a_o(3),b_o(3)),....
        sprintf('CP (a_{0}=%.3f, b_{0}=%.3f)',a_o(4),b_o(4)))
xlabel('N (No. of observations)')
ylabel('Mean-squared Error for Variance')
hold off

s = 1; 
prec_vec = 0:0.01:5;

figure 
subplot(1,2,1); update_plot_gamma(length(N),N,prec_vec,s,var_ml,a_o,b_o);
subplot(1,2,2); update_plot_gamma(1,N,prec_vec,s,var_ml,a_o,b_o);


