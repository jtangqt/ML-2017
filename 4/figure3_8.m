%% Plots Figure 3.8

close all, clc, clear all; 

N = 25; 
sigma = 0.2;
beta = 1/sigma^2; 
noise = randn(N,1)*sigma; 
no_w = 9;
alpha = 2; 
x = rand(N, 1); 
y = sin(2*pi*x) + noise; %sin2*pi*x is the original function (green line)

S0 = alpha^(-1)*eye(no_w);
m0 = zeros(no_w,1);

s = 0.2; %spatial 

update3_8(1, 1, x, y, beta, s);
update3_8(2, 2, x, y, beta, s);
update3_8(3, 4, x, y, beta, s);
update3_8(4, 25, x, y, beta, s);

hL = legend('truth','observations','predictive mean','predictive std. dev');
newPosition = [0.8 0.8 0.1 0.1];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);  

hold off