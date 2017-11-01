function y = kernel(x, u, s) %x -> data, u -> mean, s -> std dev
    y = exp(-sum((x-u).^2, 2)/(2*s^2)); 
end