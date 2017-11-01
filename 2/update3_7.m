function y = update3_7(i, n, x, y, a, beta, m0, S0, prior, matrix) 

    colormap('jet')
    w0 = -1:0.01:1;
    w1 = -1:0.01:1;
    [W0,W1] = meshgrid(w0,w1);
    %likelihood
    
    if i == 1
       subplot(4, 3, 1, 'replace') 
    else
        subplot(4, 3, 3*(i-1)+1); 
        phi0_l = 1; 
        phi1_l = x(n); 
        m_l = W0*phi0_l + W1*phi1_l;
        s_l = 1/beta; 
        dist_l = 1/(2*pi*s_l)^(1/2)*exp(-1/(2*s_l)*(y(n)-m_l).^2);
        imagesc(w0, w1, dist_l);
        set(gca, 'YDir', 'normal')
        hold on; 
        scatter(a(1), a(2), 'w+', 'lineWidth', 1); 
        axis([-1 1 -1 1]) 
        title(['likelihood (n = ',num2str(n),')'])
        xlabel('\it w_{0}')
        ylabel('\it w_{1}')

        hold off; 
    end
        
    %posterior/prior
    subplot(4, 3, 3*(i-1)+2); 
    if i == 1
       m_p = m0; 
       S_p = S0; 
    else
        phi = [ones(n,1) x(1:n)'];  
        S_p = pinv(pinv(S0) + beta*phi'*phi);
        m_p = S_p*(pinv(S0)*m0 + beta*phi'*y(1:n)');
    end
    dist_p = reshape(mvnpdf([W0(:) W1(:)],m_p',S_p),length(w1),length(w0));
    imagesc(w0, w1, dist_p);
    set(gca, 'YDir', 'normal')
    hold on; 
    scatter(a(1), a(2), 'w+', 'lineWidth', 1); 
    axis([-1 1 -1 1])        
    title(['prior/posterior (n = ',num2str(n),')'])
    xlabel('\it w_{0}')
    ylabel('\it w_{1}')
    
    %dataspace 
    subplot(4, 3, 3*(i-1)+3);        
    x_d = w0; 
    if i == 1 
       for sample = 1:6
           w0_e = prior(1, sample); 
           w1_e = prior(2, sample); 
           y_d = linear_reg(x_d, w0_e, w1_e);
           plot(x_d, y_d, 'r')
           hold on
       end
    else 
       scatter(x(1:n), y(1:n), 'b')
       hold on
       for sample = 1:6
           w0_e = matrix(n*2-1, sample); 
           w1_e = matrix(n*2, sample); 
           y_d = linear_reg(x_d, w0_e, w1_e);
           plot(x_d, y_d, 'r')
           hold on
       end
    end
    axis([-1 1 -1 1])
    title(['data space (n = ',num2str(n),')'])
    xlabel('\it w_{0}')
    ylabel('\it w_{1}')
    
end