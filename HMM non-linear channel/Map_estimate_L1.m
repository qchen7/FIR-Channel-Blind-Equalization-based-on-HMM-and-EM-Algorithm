function [A_est, accuracy] = Map_estimate_L1(T, L_funct_s_test, A)

A_est = zeros(1,T);
accuracy = 0;

for t = 1:T
    if(L_funct_s_test(t,1)+L_funct_s_test(t,2)+L_funct_s_test(t,3)+L_funct_s_test(t,4) >= L_funct_s_test(t,5)+L_funct_s_test(t,6)+L_funct_s_test(t,7)+L_funct_s_test(t,8))
        A_est(t) = -1;
    else
        A_est(t) = 1;
    end
    if A_est(t) == A(t)
        accuracy = accuracy + 1;
    end
end

accuracy = accuracy / T;