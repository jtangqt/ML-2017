%%Jasmine Tang Project 6 Part 2

close all; clc; clear all; 
N = 25; 
x = 2*rand(1,N)-1;
a0 = -0.3;
a1 = 0.5;  
a = [a0 a1];
n_sigma = 0.2;
noise = n_sigma*randn(1,N); %generates noise with standard deviation of 0.2
y = linear_reg(x, a0, a1); %creates the linear regression line
y = y + noise; %adds noise to create randomness 

phi = [ones(N, 1) x'];

prior_mu = [0, 0];
prior_sigma = eye(2)*0.2;

q_mu = [0, 0];
q_sigma = eye(2)*0.2;

s_N = 1000;
burn = 100; %Samples to burn 
s_burn = 0;
pz_T = 0;
new_data = zeros(2,s_N);
z_T = mvnrnd(q_mu,q_sigma);

i = 1; 
while(i < s_N)
    z_star = mvnrnd(z_T, q_sigma);  
    
    pz_T = sum(log(normpdf(y', phi*z_T', n_sigma)));
    pz_T = pz_T + log(mvnpdf(z_T, prior_mu, prior_sigma)); 
    
    pz_star = sum(log(normpdf(y', phi*z_T', n_sigma))); 
    pz_star = pz_star + log(mvnpdf(z_star, prior_mu, prior_sigma)); 
    
    p_accept = min(0, pz_star - pz_T); 
    rand_val = log(rand()); 
    
    if p_accept > rand_val        
        s_burn = s_burn + 1;
        z_T = z_star;
        if s_burn > burn
            i = i+1; 
            new_data(:, i) = z_star; 
        end
    end
    
end

figure
scatter(new_data(1,:),new_data(2,:))
title('Scatter Plot of Generated Weights (true values: -0.3, 0.5)')
xlabel('Weight 0')
ylabel('Weight 1')
disp(['Mean of generated weight 0: ', num2str(mean(new_data(1,:),2))])
disp(['Mean of generated weight 1: ', num2str(mean(new_data(2,:),2))])
