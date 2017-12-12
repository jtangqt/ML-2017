function plotsfor1d(x_n, N, totalpdf, totalpdf2, p)

    yl = ylim;
    xl = xlim;
    xplot = linspace(xl(1),xl(2),N);
    
    figure
    histogram(x_n,24)
    yyaxis left;
    xlabel('Observation Values')
    ylabel('Frequency of Data in Bin')
    hold on
    
    yyaxis right;
    ylabel('Value of Total PDF')
    h1 = plot(xplot,totalpdf,'r');
    hold on
        
    h2 = plot(xplot,totalpdf2,'g');

    title(['Histogram of Data & PDF at Iteration ',num2str(p)])
 
    legend([h1 h2],'Initial','Actual')
    hold off
        
end
