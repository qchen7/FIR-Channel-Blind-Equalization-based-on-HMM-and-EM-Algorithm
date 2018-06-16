function [alpha_s, c] = forward_scaling1_L1(O, h_est, Nvar_est, tr, T)

alpha_s = zeros(T+1,4);
c = zeros(T+1,1);
alpha_numerator = zeros(T+1,4);

%initialization
for i = 1:4
alpha_s(1,i) = 1/4;
end


overflow = log(1.79769313486231570E+308);
underflow = log(4.94065645841246544E-324);


%iteration
for t = 2:T+1
    for j = 1:4
        for i = 1:4
            if mod(j-1,2) ~= floor((i-1)/2)
                alpha_numerator(t,j) = alpha_numerator(t,j) + 0;
            else
                index = (i-1) + floor((j-1)/2)*4 + 1;
                alpha_logterm = log(alpha_s(t-1,i))+log(tr(j,i))-log(sqrt(2*pi*Nvar_est))-(O(t-1)-h_est(index))^2/(2*Nvar_est);
                     if alpha_logterm < underflow
                         alpha_logterm = underflow;
                     elseif alpha_logterm > overflow
                         alpha_logterm = overflow;
                     end
                alpha_logterm = exp(alpha_logterm);
                alpha_numerator(t,j) = alpha_numerator(t,j) + alpha_logterm;
            end
        end
        alpha_s(t,j) = alpha_numerator(t,j);
        c(t) = c(t) + alpha_numerator(t,j) ;
    end
    alpha_s(t,:) = alpha_s(t,:)/c(t);
end


