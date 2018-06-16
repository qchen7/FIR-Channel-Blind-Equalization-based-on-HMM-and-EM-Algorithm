function [Nvar_vector, accuracy, accuracy_mean, H_est, time] = run_program2_SNR_accuracy(T, H, SNR, H0, n)
%This function is used to complie all the subrountines(functions) in order
%to get the simulation results. Although some variables are unused in this 
%particular function, we still keep those variables since it is more
%convinent for us when we need to check those variables inside the whole
%system.

Nvar = 1/10^(SNR/10);
Nvar0 = 0.7;

tr = [1/2,0,1/2,0;1/2,0,1/2,0;0,1/2,0,1/2;0,1/2,0,1/2];
tr = tr.';

%performance evaluation
accuracy = zeros(1,100);
accuracy_mean = 0;
time = 0;

for m = 1:1
    [A, S, X, O, h] = hmmgen_L1(T, H, Nvar);
    tic;
    [L_Y_vector, H_vector, Nvar_vector, H_est, h_est, H_est_A, H_est_B, Nvar_est_A, Nvar_est_B, Nvar_est, L_funct_s_test] = hmmparameter_scaling1_reestimate_L1(O, T, H0, Nvar0, tr, n);
    [A_est, accuracy(m)] = Map_estimate_L1(T, L_funct_s_test, A);
    time1 = toc;
    time = time + time1;
    accuracy_mean = accuracy_mean + accuracy(m);
end
accuracy_mean = accuracy_mean / 100;
time = time / 100;

Make_plot_L1(A, A_est, O, T, H, h, H_vector, L_Y_vector, n)