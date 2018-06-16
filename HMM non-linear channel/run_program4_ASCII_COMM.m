function accuracy = run_program4_ASCII_COMM(h, h0, SNR, n)
%This function is used to complie all the subrountines(functions) in order
%to get the simulation results. Although some variables are unused in this 
%particular function, we still keep those variables since it is more
%convinent for us when we need to check those variables inside the whole
%system.

Nvar = 1/10^(SNR/10);
Nvar0 = Nvar;

tr = [1/2,0,1/2,0;1/2,0,1/2,0;0,1/2,0,1/2;0,1/2,0,1/2];
tr = tr.';

%input data and encoding
str = INPUT_TEXT;
A_bin = encoding_text2bin(str);
T = length(A_bin);

[A, S, X, O] = HMM_ENTRY(T, h, Nvar, A_bin);
[L_Y_vector, h_vector, Nvar_vector, h_est, h_est_A, h_est_B, Nvar_est_A, Nvar_est_B, Nvar_est, L_funct_s_test] = hmmparameter_scaling1_reestimate_L1(O, T, h0, Nvar0, tr, n);
[A_est, accuracy] = MESSAGE_RECEIVER(T, L_funct_s_test, A);

%output data and decoding
decoding_bin2text(A_est);
