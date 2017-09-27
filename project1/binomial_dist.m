%%Problem Set 1 %%
%%Binomial Distribution%% 

clc; clear all; close all; 


N = 1:1:100;
p = 0.5; 
noTrials =100; 

X = cell(size(N,2),1); % can just use length(N) for vectors
for i = 1:size(N,2)
    for j = 1:noTrials
        X{i,1} = (rand(1,N(i))<=p)';
    end
end

a = [0.1, 1, 2, 8];
b = [0.1, 1, 3, 4];

mse_cp = zeros(size(a,2), size(N,2)); 
m = zeros(size(N,2), 1);
l = zeros(size(N,2), 1);

for i = 1:size(N,2)
    m_i = sum(X{i, 1}, 1); 
    mu_ML = m_i/N(i);
    mse(i) = mean((mu_ML - 0.5).^2, 2); 
    m(i, :) = m_i;
    l(i, :) = N(i) - m_i; 
end

figure
plot(N, mse)
hold on; 

for i = 1:size(a,2)
    mu_cp = (m+a(i))./(m+a(i)+l+b(i)); 
    mse_cp(i, :) = mean((mu_cp-0.5).^2,2); 
    plot(N, mse_cp(i,:))
    hold on
end

title('Mean-Squared Error Comparison of ML and CP Estimates for Binomial Distribution')
legend('ML',...
        sprintf('CP (A=%.3f, B=%.3f)',a(1),b(1)),...
        sprintf('CP (A=%.3f, B=%.3f)',a(2),b(2)),...
        sprintf('CP (A=%.3f, B=%.3f)',a(3),b(3)),...
        sprintf('CP (A=%.3f, B=%.3f)',a(4),b(4)))
xlabel('N (No. of observations)')
ylabel('Mean-squared Error for Probability of Success')

p_vec = 0:0.01:1;
s = 1;

figure;
subplot(2,2,1); update_plot_beta(1, N, p_vec, s, m, l, a, b); 
subplot(2,2,2); update_plot_beta(10, N, p_vec, s, m, l, a, b); 
subplot(2,2,3); update_plot_beta(100, N, p_vec, s, m, l, a, b); 

