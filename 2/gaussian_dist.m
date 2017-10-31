function y = gaussian_dist(x, u, s) %x -> data, u -> mean, s -> std dev
    y = exp(-(x-u).^2/(2*s^2)); 
end