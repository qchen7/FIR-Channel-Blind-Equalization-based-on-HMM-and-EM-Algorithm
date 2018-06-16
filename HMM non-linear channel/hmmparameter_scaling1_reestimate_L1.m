function [L_Y_vector, h_vector, Nvar_vector, h_est, h_est_A, h_est_B, Nvar_est_A, Nvar_est_B, Nvar_est, L_funct_s_test] = hmmparameter_scaling1_reestimate_L1(O, T, h0, Nvar0, tr, n)
%H_est_A is akin to the symbol autocorrelation matrix and H_est_B is akin
%to the cross-correlation of observations and symbols.

h_vector = zeros(8,n+1);
Nvar_vector = zeros(1,n+1);
h_vector(:,1) = h0;
Nvar_vector(1) = Nvar0;

L_Y_vector = zeros(1,n+1);
[~, L_Y_vector(1)] = Lfunction_scaling1_L1(O, h0, Nvar0, tr, T);

for m = 1:n
    [L_funct_s, ~] = Lfunction_scaling1_L1(O, h0, Nvar0, tr, T);
    h_est_A = zeros(8,1);
    h_est_B = zeros(8,1);
    h_est = zeros(8,1);
    Nvar_est_A = 0;
    Nvar_est_B = 0;
    for k = 1:8
        for t = 1:T
            h_est_A(k) = h_est_A(k) + L_funct_s(t,k)*O(t);
            h_est_B(k) = h_est_B(k) + L_funct_s(t,k);
        end
        h_est(k) = h_est_A(k) / h_est_B(k);
    end
    
    
    for t = 1:T
        for k = 1:8
            Nvar_est_A =  Nvar_est_A + L_funct_s(t,k)*(O(t)-h_est(k))^2;
            Nvar_est_B =  Nvar_est_B + L_funct_s(t,k);
        end
    end
    Nvar_est = Nvar_est_A / Nvar_est_B;
%     Nvar_est = Nvar0;
    h_vector(:,m+1) = h_est;
    Nvar_vector(m+1) = Nvar_est;
    
    [L_funct_s_test, L_Y_test] = Lfunction_scaling1_L1(O, h_est, Nvar_est, tr, T);
    L_Y_vector(m+1) = L_Y_test;  
    h0 = h_est;
    Nvar0 = Nvar_est;
end


    
    
