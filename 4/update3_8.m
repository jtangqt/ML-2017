function y = update3_8(i, n, x, y, beta, s)

    
    subplot(2, 2, i)
    
    x_t = 0:0.01:1; 
        
    k_n = [];
    for i = 1:n
        k = kernel(x(1:n, :), x(i,:), s);
        k_n = [k_n k];
    end
    
    C_n = k_n + eye(n)*beta^(-1); 
    
    m_p = [];
    S_p = [];
    for i = 1:size(x_t,2) 
         k_new = kernel(x(1:n,:), x_t(i), s);
         c = kernel(x_t(i), x_t(i), s) + beta^(-1); 
         m = k_new'*C_n^(-1)*y(1:n);
         sigma = c - k_new'*C_n^(-1)*k_new; 
         m_p = [m_p m]; 
         S_p = [S_p sigma];
    end
    
    %need S_p and m_p
    plot(x_t, sin(2*pi*x_t), 'g') %green line for the truth
    hold on
    
    scatter(x(1:n), y(1:n))
    hold on;
    
    plot(x_t, m_p', 'r')
    hold on;
    
    bot = m_p - sqrt(S_p);
    top = m_p + sqrt(S_p); 
    
    color = [1 0.4 0.6];
    X = [x_t'; flipud(x_t')];
    Y = [bot'; flipud(top')];
    h = fill(X, Y, color);
    set(h,'EdgeColor','none') % remove edges/borders from fill
    alpha(0.3)
    
    % Plot labels
    title(sprintf('n = %d',n))
    xlabel('\it x')
    ylabel('\it t')
    axis([0 1 -1.5 1.5])

end