%Jasmine Tang Project 5
%% One Dimensional Case
close all; clear all; clc;

mu = [-6,0,6];
sigma = [1,1,1];
PItrue = [0.4,0.2,0.4];
P = 25;
muk = [-10,2,10];
sigmak = [1,1,1];
PIk = [1/4,1/2,1/4];

N = 500;
truth = zeros(3,N);
%Data Generation
for ii = 1:N
    poop = rand();
    if poop <= PItrue(1)
        xn(ii) = normrnd(mu(1),sqrt(sigma(1)));
        truth(1,ii) = 1;
    elseif poop <= (PItrue(1) + PItrue(2))
        xn(ii) = normrnd(mu(2),sqrt(sigma(2)));
        truth(2,ii) = 1;
    else
        xn(ii) = normrnd(mu(3),sqrt(sigma(3)));
        truth(3,ii) = 1;
    end
end

for jj = 1:3
    NKtrue(jj) = sum(truth(jj,:));
end

figure
histogram(xn,24)
yyaxis left;
xlabel('Observation Values')
ylabel('Frequency of Data in Bin')
hold on
yl = ylim;
xl = xlim;
xplot = linspace(xl(1),xl(2),N);
totalpdf = zeros(1,N);
for ii = 1:3
   totalpdf = totalpdf + PIk(ii)*normpdf(xplot,muk(ii),sqrt(sigmak(ii))); 
end
yyaxis right;
ylabel('Value of Total PDF')
h1 = plot(xplot,totalpdf,'r');
totalpdf2 = 0;
for ii = 1:3
   totalpdf2 = totalpdf2 + PItrue(ii)*normpdf(xplot,mu(ii),sqrt(sigma(ii))); 
end
hold on
h2 = plot(xplot,totalpdf2,'g');
legend([h1 h2],'Initial','Actual')
title('Histogram of Data, Initial PDF, and True PDF')

%I didn't check for convergence, and just ran it for a fixed number
%of iterations instead.
for pp = 1:P
    denominator = zeros(3,N);
    for jj = 1:3
        denominator(jj,:) = PIk(jj)*normpdf(xn,muk(jj),sqrt(sigmak(jj)));
    end
    for k = 1:3
        %E step
        gamma(k,:) = denominator(k,:)./sum(denominator);
        %M step
        Nk(k) = sum(gamma(k,:));
        muk(k) = sum(gamma(k,:).*xn)/Nk(k);
        PIk(k) = Nk(k)/N;
        sigmak(k) = sum(gamma(k,:).*((xn - muk(k)).^2))/Nk(k); %For the 1D Case, this formula works
    end
    if (pp == 1 || pp == 3 || pp == 10 || pp == 25)
        figure
        histogram(xn,24)
        yyaxis left;
        xlabel('Observation Values')
        ylabel('Frequency of Data in Bin')
        hold on
        yl = ylim;
        xl = xlim;
        xplot = linspace(xl(1),xl(2),N);
        totalpdf = zeros(1,N);
        for ii = 1:3
           totalpdf = totalpdf + PIk(ii)*normpdf(xplot,muk(ii),sqrt(sigmak(ii))); 
        end
        yyaxis right;
        ylabel('Value of Total PDF')
        title(['Histogram of Data & PDF at Iteration ',num2str(pp)])
        plot(xplot,totalpdf,'r')
        hold on
        plot(xplot,totalpdf2,'g');
        hold off
    end    
end
