function [L_Y_vector, H_vector, Nvar_vector, H_est, h_est, H_est_A, H_est_B, Nvar_est_A, Nvar_est_B, Nvar_est, L_funct_s_test] = hmmparameter_scaling1_reestimate_L1(O, T, H0, Nvar0, tr, n)
%H_est_A is akin to the symbol autocorrelation matrix and H_est_B is akin
%to the cross-correlation of observations and symbols.

H_vector = zeros(3,n+1);
Nvar_vector = zeros(1,n+1);
H_vector(:,1) = H0;
Nvar_vector(1) = Nvar0;

L_Y_vector = zeros(1,n+1);
[~, L_Y_vector(1)] = Lfunction_scaling1_L1(O, H0, Nvar0, tr, T);

for m = 1:n
    [L_funct_s, ~] = Lfunction_scaling1_L1(O, H0, Nvar0, tr, T);
    X_space = [-1,-1,-1;-1,-1,1;-1,1,-1;-1,1,1;1,-1,-1;1,-1,1;1,1,-1;1,1,1];
    X_space = X_space.';
    H_est_A = zeros(3,3);
    H_est_B = zeros(3,1);
    Nvar_est_A = 0;
    Nvar_est_B = 0;
    for t = 1:T
        for k = 1:8
            H_est_A = H_est_A + L_funct_s(t,k)*X_space(:,k)*X_space(:,k).';
            H_est_B = H_est_B + L_funct_s(t,k)*O(t)*X_space(:,k);
        end
    end
    H_est = H_est_A\H_est_B;
    
    h_est = zeros(1,8);
    for k = 1:8    %%%%%output of the linear channel 
        h_est(k) = H_est.'*X_space(:,k);
    end

    for t = 1:T
        for k = 1:8
            Nvar_est_A =  Nvar_est_A + L_funct_s(t,k)*(O(t)-h_est(k))^2;
            Nvar_est_B =  Nvar_est_B + L_funct_s(t,k);
        end
    end
    Nvar_est = Nvar_est_A / Nvar_est_B;
%     Nvar_est = Nvar0;
    H_vector(:,m+1) = H_est;
    Nvar_vector(m+1) = Nvar_est;
    
    [L_funct_s_test, L_Y_test] = Lfunction_scaling1_L1(O, H_est, Nvar_est, tr, T);
    L_Y_vector(m+1) = L_Y_test;  
    H0 = H_est;
    Nvar0 = Nvar_est;
end


    
    
