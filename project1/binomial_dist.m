%%Project 1 %%
%%Binomial Distribution%% 

clc; close all; 

X = rand(100); 
N = 1:1:100;
m = zeros(100); 
l = zeros(100); 
a = [0.1; 1; 2; 8]; 
b = [0.1; 1; 3; 4];
mu_ml = zeros(100); 
mu_cp = zeros(100); 
mse_ml = zeros(1, 100); 
mse_cp = zeros(size(a,1), 100);

for i = 1:size(X, 1)
    m(i, :) = sum(X(1:i, :), 1); 
    l(i, :) = i - m(i,:); 
    mu_ml(i, :) = m(i, :)/i; 
    mse_ml(i) = sum((mu_ml(i,:) - 0.5).^2)/100; 
end

figure
plot(N, mse_ml); 
hold on; 

for i = 1:size(a, 1)
    mu_cp = (m+a(i))./(m+l+a(i)+b(i)); 
    mse_cp(i,:) = sum((mu_cp -0.5).^2, 2)/100; 
    plot(N, mse_cp(i,:)); 
    hold on; 
end

title('Mean-Squared Error Comparison of ML and CP Estimates for Binomial Distribution')
legend('ML',...
        sprintf('CP (A=%.3f, B=%.3f)',a(1),b(1)),...
        sprintf('CP (A=%.3f, B=%.3f)',a(2),b(2)),...
        sprintf('CP (A=%.3f, B=%.3f)',a(3),b(3)),...
        sprintf('CP (A=%.3f, B=%.3f)',a(4),b(4)))
xlabel('N (No. of observations)')
ylabel('Mean-squared Error for Probability of Success')

% Plotting Beta %
b_x = rand([1,1000]);
p = 0:0.01:1;
figure 
subplot(2,2,1); update_plot_beta(1, b_x, p, a(1), b(1));
subplot(2,2,2); update_plot_beta(10, b_x, p, a(1), b(1));
subplot(2,2,3); update_plot_beta(100, b_x, p, a(1), b(1));
subplot(2,2,4); update_plot_beta(1000, b_x, p, a(1), b(1));