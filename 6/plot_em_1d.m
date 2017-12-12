%Jasmine Tang Project 5
%% One Dimensional Case
close all; clear all; clc;

mu = [-6 0 9];
sigma = [1,1,1];
pi_true = [0.5,0.1,0.4];
P = 10000;

mu_k = [-10 6 10];
sigma_k = [1,1,1];
pi_k = [1/3,1/3,1/3];

N = 500;
truth = zeros(3,N);
x_n = zeros(1, N); 

%Data Generation
for i = 1:N
    tmp = rand();
    if tmp <= pi_true(1)
        x_n(i) = normrnd(mu(1),sqrt(sigma(1)));
        truth(1,i) = 1;
    elseif tmp <= (pi_true(1) + pi_true(2))
        x_n(i) = normrnd(mu(2),sqrt(sigma(2)));
        truth(2,i) = 1;
    else
        x_n(i) = normrnd(mu(3),sqrt(sigma(3)));
        truth(3,i) = 1;
    end
end

figure
histogram(x_n,24)
yyaxis left;
xlabel('Observation Values')
ylabel('Frequency of Data in Bin')
hold on

yl = ylim;
xl = xlim;
xplot = linspace(xl(1),xl(2),N);

totalpdf = pi_k*normpdf(xplot,mu_k',sqrt(sigma_k)'); 

yyaxis right;
ylabel('Value of Total PDF')
h1 = plot(xplot,totalpdf,'r');
hold on

totalpdf2 =  pi_true*normpdf(xplot,mu',sqrt(sigma)'); 

h2 = plot(xplot,totalpdf2,'g');
title('Histogram of Data, Initial PDF, and True PDF')
legend([h1 h2],'Initial','Actual')
hold off

Nk = zeros(1, 3); 
gamma = zeros(3, N);
convergence = 0;
log_l = 0; 
log_prev = 0; 
for p = 1:P
    denominator  = pi_k'.*normpdf(x_n,mu_k',sqrt(sigma_k)');
    
    gamma = denominator./sum(denominator);
    Nk = sum(gamma, 2)';
    mu_k = (gamma*x_n'./Nk')';
    pi_k = Nk/N; 
    sigma_k = (sum(gamma.*(x_n - mu_k').^2, 2)'./Nk);
    
    totalpdf = pi_k*normpdf(xplot,mu_k',sqrt(sigma_k)'); 
    
    log_l = sum(log(sum(denominator)));  
    
    if(abs(log_prev - log_l) <= 0.0001)
        convergence = 1;
    end 
    
    log_prev = log_l; 
        
    if (p == 1 || p == 3 || p == 10 || p == 25 || convergence == 1 || p == P)
        plotsfor1d(x_n, N, totalpdf, totalpdf2, p)
        
        if(convergence == 1)
            break;
        end
        
    end    
end
