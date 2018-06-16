function [L_funct_s, L_Y] = Lfunction_scaling1_L1(O, h_est, Nvar_est, tr, T)

%choose tr(n) in tr matrix will be in column order. Since we number all
%possible transtion branches in a left-msb based method. tr(n) will
%exactly represent the nth transition brach probability. e.g we number xt =
%[st+1,st] = [0,1] as 2. 
%from 1->0 we should take tr(1,0) = tr(2).(Assume that tr(i,j) represents the transition probability Si -> Sj in state space)



%t = 1:T and k = 1:4 
%i = mod (k-1,2) + 1
%j = floor((k-1)/2) + 1

[alpha_s, ~] = forward_scaling1_L1(O, h_est, Nvar_est, tr, T);
beta_s = backward_scaling1_L1(O, h_est, Nvar_est, tr, T);

L_funct_s = zeros(T,8);
overflow = log(1.79769313486231570E+308);
underflow = log(4.94065645841246544E-324);

for t = 1:T
    for k = 1:8
        i = mod (k-1,4) + 1;
        j = floor((k-1)/2) + 1;
        L_funct_s(t,k) = -log(sqrt(2*pi*Nvar_est))-(O(t)-h_est(k))^2/(2*Nvar_est)+log(tr(j,i))+log(alpha_s(t,i))+log(beta_s(t+1,j));
        if L_funct_s(t,k) < underflow
            L_funct_s(t,k) = underflow;
        elseif L_funct_s(t,k) > overflow
            L_funct_s(t,k) = overflow;
        end
        L_funct_s(t,k) = exp(L_funct_s(t,k));
    end
end

alpha = forward_L1(O, h_est, Nvar_est, tr, T);
L_Y = 0;
for m = 1:4
L_Y = L_Y + alpha(T+1,m);
end


