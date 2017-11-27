function plotsfor2d(x_n, mu, sigma, mu_k, sigma_k, p)
    figure
    scatter(x_n(1,:),x_n(2,:))  
    hold on
    
    plot_gaussian_ellipsoid(mu_k(:,1),sigma_k(:,:,1),1);
    plot_gaussian_ellipsoid(mu_k(:,2),sigma_k(:,:,2),1);
    plot_gaussian_ellipsoid(mu_k(:,3),sigma_k(:,:,3),1);
    
    plot_gaussian_ellipsoid(mu(:,1),sigma(:,:,1),1);
    plot_gaussian_ellipsoid(mu(:,2),sigma(:,:,2),1);
    plot_gaussian_ellipsoid(mu(:,3),sigma(:,:,3),1);   
    xlabel('Feature 1')
    ylabel('Feature 2')
    if (p == 0)
        title('Data & Initial PDFs')
    else
        title(['Data & PDFs at Iteration ',num2str(p)])
    end
    legend('Data', 'PDF1 est','PDF2 est','PDF3 est','PDF1 actual','PDF2 actual','PDF3 actual','Location','best')
end