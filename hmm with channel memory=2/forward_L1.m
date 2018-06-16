function alpha = forward_L1(O, H_est, Nvar_est, tr, T)

alpha = zeros(T+1,4);

%initialization
for i = 1:4
alpha(1,i) = 1/4;
end

X_space = [-1,-1,-1;-1,-1,1;-1,1,-1;-1,1,1;1,-1,-1;1,-1,1;1,1,-1;1,1,1];
X_space = X_space.';
h = zeros(1,8);

for k = 1:8    %%%%%output of the linear channel 
h(k) = H_est.'*X_space(:,k);
end

overflow = log(1.79769313486231570E+308);
underflow = log(4.94065645841246544E-324);

%iteration
for t = 2:T+1
    for j = 1:4
        for i = 1:4
            if mod(j-1,2) ~= floor((i-1)/2)
                alpha(t,j) = alpha(t,j) + 0;
            else
                index = (i-1) + floor((j-1)/2)*4 + 1;
                alpha_logterm = log(alpha(t-1,i))+log(tr(j,i))-log(sqrt(2*pi*Nvar_est))-(O(t-1)-h(index))^2/(2*Nvar_est);
                    if  alpha_logterm < underflow
                        alpha_logterm = underflow;
                    elseif  alpha_logterm > overflow
                        alpha_logterm = overflow;
                    end
                alpha_logterm = exp(alpha_logterm);
                alpha(t,j) = alpha(t,j) + alpha_logterm;
            end
        end
    end
end