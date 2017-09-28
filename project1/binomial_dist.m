%%Problem Set 1 %%
%%Binomial Distribution%% 

clc; close all; 

X = rand(100); 
N = 1:1:100;
m = zeros(100); 
l = zeros(100); 
mu_ml = zeros(100); 
mu_cp = zeros(100); 
mse_ml = zeros(1, 100); 
mse_cp = zeros(size(a,1), 100);
a = [0.1; 1; 2; 8]; 
b = [0.1; 1; 3; 4];

for i = 1:size(X, 1);
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