function y = update_figure3_7(x, y, n, a, beta, i, m0, S0, phi, other_parameters) 


    n = 1; 
   
    colormap('jet') 
    %likelihood
    subplot(4, 3, 3*(i-1)+1); 
    phi0_l = 1; 
    phi1_l = x(n); 
    ml = W0*phi0_l + W1*phi1_l;
    sl = 1/beta; 
    prob_l = 1/(2*pi*sl)^(1/2)*exp(-1/(2*sl)*(y(n)-ml).^2);
    imagesc(w0, w1, prob_l);
    set(gca, 'YDir', 'normal')
    hold on; 
    scatter(a(1), a(2), 'w+', 'lineWidth', 3); 
    axis([-1 1 -1 1])
    hold off; 
    
    %posterior/prior
    subplot(1, 3, 3*(i-1)+2); 
    phi0_p = ones(n,1); 
    phi1_p = x(1:n); 
    
    
    %dataspace 
    subplot(1, 3, 3*(i-1)+2); 
    
    
    hold off; 
end