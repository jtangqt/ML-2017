%%Project 1%%
%%Gaussian Known Variance%%

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
mu_o = [0.1, 1, 2, 5];
sigma_o = sqrt([0.1, 1, 3, 10]);

for i = 1:size(X, 1)
    mu_ml = sum(X(1:i,:), 1)/i;
    mse_ml(i, :) = mean(sum((mu_ml-mu).^2, 1));
end

figure
plot(N, mse_ml)
hold on;

for i = 1:size(mu_o, 2)
   temp1 = sigma^2./(N*sigma_o(i)^2)*mu_o(i);
   temp2 = N*sigma_o(i)^2./(N*sigma_o(i)^2+sigma^2);
   temp2 = bsxfun(@times, temp2, mu_ml');
   mu_cp = temp1+temp2;
   mse_cp(i,:) = mean((mu_cp - mu).^2,1);
   plot(N, mse_cp)
   hold on
end

title(['Mean-Squared Error Comparison of ML and CP Estimates '...
        'of Mean for Gaussian Distribution with Known Variance ',...
        sprintf('(No. Trials = %d)',length(N))])
    xlabel('N (No. of observations)')
legend('ML',...
        sprintf('CP (\\mu_{0}=%.3f, \\sigma_{0}^{2}=%.3f)',mu_o(1),sigma_o(1)^2),...
        sprintf('CP (\\mu_{0}=%.3f, \\sigma_{0}^{2}=%.3f)',mu_o(2),sigma_o(2)^2),...
        sprintf('CP (\\mu_{0}=%.3f, \\sigma_{0}^{2}=%.3f)',mu_o(3),sigma_o(3)^2),....
        sprintf('CP (\\mu_{0}=%.3f, \\sigma_{0}^{2}=%.3f)',mu_o(4),sigma_o(4)^2))
xlabel('N (No. of observations)')
ylabel('Mean-squared Error for Mean')
hold off

s = 1;
mean_vec = -1:0.01:1;

subplot(2,2,1); update_plot_gaussian(1,N,mean_vec,s,mu_ml,sigma,mu_o,sigma_o)
subplot(2,2,2); update_plot_gaussian(10,N,mean_vec,s,mu_ml,sigma,mu_o,sigma_o)
subplot(2,2,3); update_plot_gaussian(length(N),N,mean_vec,s,mu_ml,sigma,mu_o,sigma_o)
