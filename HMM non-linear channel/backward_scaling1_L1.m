function beta_s = backward_scaling1_L1(O, h_est, Nvar_est, tr, T)

beta_s = zeros(T+1,4);
beta_numerator = zeros(T+1,4);
[~, c] = forward_scaling1_L1(O, h_est, Nvar_est, tr, T);

%initialization
for k = 1:4
beta_s(T+1,k) = 1;
end

overflow = log(1.79769313486231570E+308);
underflow = log(4.94065645841246544E-324);

%iteration
for t = T:-1:1
    for i = 1:4
        for j = 1:4
            if mod(j-1,2) ~= floor((i-1)/2)
                beta_numerator(t,i) = beta_numerator(t,i) + 0;
            else
                index = (i-1) + floor((j-1)/2)*4 + 1;
                beta_numerator_logterm = log(beta_s(t+1,j))+log(tr(j,i))-log(sqrt(2*pi*Nvar_est))-(O(t)-h_est(index))^2/(2*Nvar_est);
                if beta_numerator_logterm < underflow
                     beta_numerator_logterm = underflow;
                elseif beta_numerator_logterm > overflow
                     beta_numerator_logterm = overflow;
                end
                 beta_numerator_logterm = exp(beta_numerator_logterm);
                 beta_numerator(t,i) = beta_numerator(t,i) + beta_numerator_logterm;
            end
        end
        beta_s(t,i) = beta_numerator(t,i);      
    end
    beta_s(t,:) = beta_s(t,:)/c(t);
end


