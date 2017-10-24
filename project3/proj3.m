%%Jasmine Tang Project 3

close all; clear; clc; 

N1 = 100; 
N2 = 100;
N = N1+N2; 
mu1 = [1 1];
mu2 = [-1 -1];
sigma = eye(2); 

d1 = mvnrnd(mu1, sigma, N1); 
d2 = mvnrnd(mu2, sigma, N2); 

pi = N1/N; 
mu1_ml = 1/N1*sum(d1); 
mu2_ml = 1/N2*sum(d2); 
s1 = 1/N1*(d1 - mu1_ml)'*(d1 - mu1_ml); 
s2 = 1/N2*(d2 - mu2_ml)'*(d2 - mu2_ml); 
S = N1/N*s1 + N2/N*s2; 
w = S^(-1)*(mu1_ml - mu2_ml)'; 
w0 = -1/2*mu1_ml*S^(-1)*mu1_ml' + 1/2*mu2_ml*S^(-1)*mu2_ml'+log(N1/N2); 

sig_1 = sigmoid(d1*w+w0);
sig_2 = sigmoid(d2*w+w0);

sum1 = 0;
sum2 = 0; 

for i = 1:N1
    if sig_1(i) >= 0.5
        pred_1 = 1;
    else
        pred_1 = 0;
    end
    sum1 = sum1 + pred_1;
end
for i = 1:N2
    if sig_2(i) <= 0.5
        pred_2 = 1;
    else
        pred_2 = 0;
    end
    sum2 = sum2 + pred_2; 
end

acc = (sum1+sum2)/N;