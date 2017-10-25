clear all; clc; 

N1 = 100;
N2 = 100; 
N = N1 + N2; 
mu1 = [1 1];
mu2 = [-1 -1];
sigma = eye(2); 

x1 = mvnrnd(mu1, sigma, N1); 
x2 = mvnrnd(mu2, sigma, N2); 

phi = [x1; x2];
phi = [ones(N, 1) phi];

t = [ones(N1, 1); zeros(N2, 1)];

R = eye(N);
y = zeros(N, 1); 
w = zeros(length(mu1)+1, 1);

j = 0;
sq_err = 1; 

while j < 1000 && sq_err > 0.1
    tmp_w = w; 
    z = phi*w - R^(-1)*(y - t); 
    w = (phi'*R*phi)^(-1)*phi'*R*z;
    y = 1./(1+exp(-phi*w)); 
    for k = 1:N
        R(k, k) = y(k)*(1-y(k)); 
    end
    sq_err = norm(tmp_w - w);
    j = j+1; 
end 

y = y > 0.5;
y_pred = y == t;
error = sum(y_pred)/N; 