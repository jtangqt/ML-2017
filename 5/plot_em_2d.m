%% Two Dimensional Case
close all; clear all; clc;
K = 3;
mu = [-6,0,6; -6,0,6];
sigma = cat(3,[1,0.5;0.5,1],[1,0;0,1],[1 0;0 1]);
PItrue = [0.4,0.2,0.4];
muk = [-10,3,9; 5,-4,-4];
sigmak = cat(3,3*eye(2),3*eye(2),3*eye(2));
PIk = [1/4,1/2,1/4];

N = 200;
truth = zeros(3,N);
xn = zeros(2,N);

P = 50;

%Data Generation
for ii = 1:N
    poop = rand();
    if poop <= PItrue(1)
        xn(:,ii) = mvnrnd(mu(:,1),sigma(:,:,1))';
        truth(1,ii) = 1;
    elseif poop <= (PItrue(1) + PItrue(2))
        xn(:,ii) = mvnrnd(mu(:,2),sigma(:,:,2))';
        truth(2,ii) = 1;
    else
        xn(:,ii) = mvnrnd(mu(:,3),sigma(:,:,3))';
        truth(3,ii) = 1;
    end
end

figure
scatter(xn(1,:),xn(2,:))

for jj = 1:3
    NKtrue(jj) = sum(truth(jj,:));
end
for ii = 1:3
    plot_gaussian_ellipsoid(muk(:,ii),sigmak(:,:,ii),1);
    hold on
end
hold off
title('Data & Initial PDFs')
xlabel('Feature 1')
ylabel('Feature 2')

for pp = 1:P
    %E step
    denominator = zeros(3,N);
    for jj = 1:3
        denominator(jj,:) = PIk(jj)*mvnpdf(xn',muk(:,jj)',sigmak(:,:,jj));
    end
    for kk = 1:3
        gamma(kk,:) = denominator(kk,:)./sum(denominator);
        %M step
        Nk(kk) = sum(gamma(kk,:));
        muk(:,kk) = sum(repmat(gamma(kk,:),2,1).*xn,2)/Nk(kk);
        thing = zeros(2,2);
        for nn = 1:N
            thing = thing + gamma(kk,nn)*(xn(:,nn) - muk(:,kk))*((xn(:,nn) - muk(:,kk))');
        end
        sigmak(:,:,kk) = thing/Nk(kk);
        PIk(kk) = Nk(kk)/N;
    end
    if (pp == 1 || pp == 3 || pp == 10 || pp == 50)
        figure
        scatter(xn(1,:),xn(2,:))
        hold on
        h1 = plot_gaussian_ellipsoid(muk(:,1),sigmak(:,:,1),1);
        h2 = plot_gaussian_ellipsoid(muk(:,2),sigmak(:,:,2),1);
        h3 = plot_gaussian_ellipsoid(muk(:,3),sigmak(:,:,3),1);
        xlabel('Feature 1')
        ylabel('Feature 2')
        h4 = plot_gaussian_ellipsoid(mu(:,1),sigma(:,:,1),1);
        h5 = plot_gaussian_ellipsoid(mu(:,2),sigma(:,:,2),1);
        h6 = plot_gaussian_ellipsoid(mu(:,3),sigma(:,:,3),1);        
        title(['Data & PDFs at Iteration ',num2str(pp)])
        legend([h1, h2, h3, h4, h5, h6],'PDF1 est','PDF2 est','PDF3 est','PDF1 actual','PDF2 actual','PDF3 actual','Location','best')
    end
end
