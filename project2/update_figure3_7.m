function y = update_figure3_7(x, y, n, a, alpha, beta, i, other_parameters) 

    w0 = -1:0.01:1;
    w1 = -1:0.01:1;
    [W0,W1] = meshgrid(w0,w1);
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

    %dataspace 
    subplot(1, 3, 3*(i-1)+2); 
    
    
    hold off; 
end