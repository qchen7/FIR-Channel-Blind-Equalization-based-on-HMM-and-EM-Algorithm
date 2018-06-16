function [h_est, A_est, accuracy] = run_program1_original(T, h, Nvar, h0, Nvar0, n)
%This function is used to complie all the subrountines(functions) in order
%to get the simulation results. Although some variables are unused in this 
%particular function, we still keep those variables since it is more
%convinent for us when we need to check those variables inside the whole
%system.

tr = [1/2,0,1/2,0;1/2,0,1/2,0;0,1/2,0,1/2;0,1/2,0,1/2];
tr = tr.';
[A, S, X, O] = hmmgen_L1(T, h, Nvar);
[L_Y_vector, h_vector, Nvar_vector, h_est, h_est_A, h_est_B, Nvar_est_A, Nvar_est_B, Nvar_est, L_funct_s_test] = hmmparameter_scaling1_reestimate_L1(O, T, h0, Nvar0, tr, n);
[A_est, accuracy] = Map_estimate_L1(T, L_funct_s_test, A);
Make_plot_L1(A, A_est, O, T, h, h_vector, L_Y_vector, n);