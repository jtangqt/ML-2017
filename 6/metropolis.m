%%Jasmine Tang Project 6 Part 2

close all; clc; clear all; 
N = 20; 
x = 2*rand(1,N)-1;
a0 = -0.3;
a1 = 0.5;  
a = [a0 a1];
n_sigma = 0.2;
noise = n_sigma*randn(1,N); %generates noise with standard deviation of 0.2
beta = 1/(n_sigma)^2; %precision parameter
alpha = 2; %hyperparameter for prior
phi = zeros(N, 2); 
m0 = zeros(length(a), 1);
S0 = alpha^(-1)*eye(length(a));
matrix = zeros(2*N, 6); 
lse = zeros(2*N, 1);
prior = mvnrnd(m0, S0, 6)';

phi = [ones(N, 1) x'];
    
y = linear_reg(x, a0, a1); %creates the linear regression line
y = y + noise; %adds noise to create randomness 

%likelihood and posterior
for i = 1:N
    SN = pinv(pinv(S0) + beta*phi(1:i, :)'*phi(1:i, :));
    mN = SN*(pinv(S0)*m0 + beta*phi(1:i, :)'*y(1:i)');
    matrix(2*i-1:2*i,:) = mvnrnd(mN, SN, 6)'; 
    mN_lse(2*i-1:2*i) = pinv(alpha/beta*eye(length(a))+phi(1:i, :)'*phi(1:i, :))*phi(1:i, :)'*y(1:i)';
end