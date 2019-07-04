function [p, alpha1] = compute_path(angle_min, angle_max, dangle, distance)

    alpha = angle_min:dangle:angle_max;
    b = angle_min:dangle:angle_max;

    len  = length(b);
    a = b(ceil(len/2)+1:end); 
    b = b(1:floor(len/2)+1);

    top = 0;
    for i = 1: len
        if (top == 1)
            alpha(i) = a(1);
            a(1) = [];
            top = 0;
        else
            alpha(i) = b(1);
            b(1) = [];
            top = 1;
        end
    end
    alpha1 = alpha;
    alpha = alpha/180*pi;

    p = [0 0; distance 0];
    alpha_old = 0;
    beta = 0;
    
    for i = 1 : length(alpha)
        beta = beta - (pi - alpha(i));
        beta/pi*180;
        p(end+1,:) = p(end,:) + [distance 0]*R(beta);

        alpha_old = beta;
        alpha_old = atan2(p(end,2) - p(end-1,2),p(end,1) - p(end-1,1));
    end
end