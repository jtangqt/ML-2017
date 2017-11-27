%% Two Dimensional Case
close all; clear all; clc;

K = 3;
mu = [-6 0 9; -6 0 9];
sigma = cat(3,[1,0.5;0.5,1],[1,0;0,1],[1 0;0 1]);
pi_true = [0.4,0.2,0.4];

mu_k = [-10 3 9; 5 -4 -4];
sigma_k = cat(3,3*eye(2),3*eye(2),3*eye(2));
pi_k = [1/3 1/3 1/3];

N = 200;
x_n = zeros(2,N);

P = 50;

%Data Generation
for i = 1:N
    tmp = randn();
    if tmp <= pi_true(1)
        x_n(:,i) = mvnrnd(mu(:,1),sigma(:,:,1))';
    elseif tmp <= (pi_true(1) + pi_true(2))
        x_n(:,i) = mvnrnd(mu(:,2),sigma(:,:,2))';
    else
        x_n(:,i) = mvnrnd(mu(:,3),sigma(:,:,3))';
    end
end

plotsfor2d(x_n, mu, sigma, mu_k, sigma, 0);

Nk = zeros(1, 3); 
gamma = zeros(3, N);
for p = 1:P
    denominator = zeros(3,N);
    for j = 1:3
        denominator(j,:) = pi_k(j)*mvnpdf(x_n',mu_k(:,j)',sigma_k(:,:,j));
    end
    gamma = denominator./sum(denominator);
    Nk = sum(gamma, 2)';
    mu_k = (gamma*x_n'./Nk')';
    pi_k = Nk/N; 
    for k = 1:3
        total = zeros(2,2);
        for nn = 1:N
            total = total + gamma(k,nn)*(x_n(:,nn) - mu_k(:,k))*((x_n(:,nn) - mu_k(:,k))');
        end
        sigma_k(:,:,k) = total/Nk(k);
    end
    
    if (p == 1 || p == 2 || p == 3 || p == 10 || p == 50)
       plotsfor2d(x_n, mu, sigma, mu_k, sigma_k, p)
    end
end
