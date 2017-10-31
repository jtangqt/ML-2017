%%Jasmine Tang Project 3

close all; clear; clc; 

N1 = 1000; 
N2 = 1000;
N = N1+N2; 
mu1 = [1 1];
mu2 = [-1 -1];
sigma = eye(2); 

d1 = mvnrnd(mu1, sigma, N1); 
d2 = mvnrnd(mu2, sigma, N2);

pi = N1/N; 
mu1_ml = 1/N1*sum(d1);
mu2_ml = 1/N2*sum(d2);
s1 = 1/N1*(d1 - repmat(mu1_ml, N1, 1))'*(d1 - repmat(mu1_ml, N1, 1)); 
s2 = 1/N2*(d2 - repmat(mu2_ml, N1, 1))'*(d2 - repmat(mu2_ml, N1, 1)); 
S = N1/N*s1 + N2/N*s2; 
w = S^(-1)*(mu1_ml - mu2_ml)'; 
w0 = -1/2*mu1_ml*S^(-1)*mu1_ml' + 1/2*mu2_ml*S^(-1)*mu2_ml'+log(N1/N2); 

sig_1 = sigmoid(d1*w+w0);
sig_2 = sigmoid(d2*w+w0);

y1 = sig_1 > 0.5;
y2 = sig_2 > 0.5;
y_pred1 = y1 == 1;
y_pred2 = y2 == 0;
error = (sum(y_pred1)+sum(y_pred2))/N; 