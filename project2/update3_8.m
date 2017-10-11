function y = update3_8(i, n, x, y, beta, S0, m0, phi, s)

    SN = pinv(pinv(S0) + beta*phi(1:n,:)'*phi(1:n,:));
    mN = SN*(pinv(S0)*m0 + beta*phi(1:n,:)'*y(1:n,:));
    x_t = 0:0.01:1; 
    phi_t = gaussian_dist(x_t', linspace(-1, 1, 9), s);
    
    subplot(2, 2, i)
    
    m_p = phi_t*mN;
    S_p = [];
    for i = 1:9
        S_1 = 1/beta + phi(1, :)*SN*phi(1,:)';
        S_p = [S_p S_1];
    end
    
    plot(x_t, sin(2*pi*x_t), 'g') %green line for the truth
    hold on
    
    scatter(x(1:n), y(1:n))
    hold on;
    
    plot(x_t, m_p', 'r')
    hold on;
    
    bot = m_p - sqrt(S_p);
    top = m_p + sqrt(S_p); 
    
    color = [1 0.4 0.6];
    X = [x_t' fliplr(x_t')];
    Y = [bot' fliplr(top')];
    p = fill(X, Y, color);
    set(h,'EdgeColor','none') % remove edges/borders from fill
    alpha(0.3)
    
    % Plot labels
    title(sprintf('n = %d',n))
    xlabel('\it x')
    ylabel('\it t')
    axis([0 1 -1.5 1.5])

end