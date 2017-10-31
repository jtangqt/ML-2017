function update_plot_beta(i, x, p, a, b)
    % Update parameters
    
    m = sum(x(1:i)); 
    l = i - m;     
    
    A = m+a;
    B = l+b;
    % Update distribution
    b_pdf = pdf('beta',p,A,B);
    % "Plot" graph
    plot(p,b_pdf)
    title(sprintf('Beta Posterior Density (A_{prior}=%.3f, B_{prior}=%.3f)',a,b))
    xlabel('Probability of Success')
    ylabel('Density')
    axis([0 1 0 25])
    legend(['N = ' num2str(i)])
end