function [accuracy, accuracy_mean, h_est, time] = run_program2_SNR_accuracy(T, h, SNR, h0, n)
%This function is used to complie all the subrountines(functions) in order
%to get the simulation results. Although some variables are unused in this 
%particular function, we still keep those variables since it is more
%convinent for us when we need to check those variables inside the whole
%system.

Nvar = 1/10^(SNR/10);
Nvar0 = 2.1;

tr = [1/2,0,1/2,0;1/2,0,1/2,0;0,1/2,0,1/2;0,1/2,0,1/2];
tr = tr.';

%performance evaluation
accuracy = zeros(1,100);
accuracy_mean = 0;
time = 0;

for m = 1:1
    tic;
    [A, S, X, O] = hmmgen_L1(T, h, Nvar);
    [L_Y_vector, h_vector, Nvar_vector, h_est, h_est_A, h_est_B, Nvar_est_A, Nvar_est_B, Nvar_est, L_funct_s_test] = hmmparameter_scaling1_reestimate_L1(O, T, h0, Nvar0, tr, n);
    [A_est, accuracy(m)] = Map_estimate_L1(T, L_funct_s_test, A);
    time1 = toc;
    time = time + time1;
    accuracy_mean = accuracy_mean + accuracy(m);
end
accuracy_mean = accuracy_mean / 100;
time = time / 100;

Make_plot_L1(A, A_est, O, T, h, h_vector, L_Y_vector, n);