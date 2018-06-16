function BER = run_program4_ASCII_COMM(H, H0, SNR, n)
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

[A, S, X, O, h] = HMM_ENTRY(T, H, Nvar, A_bin);
[L_Y_vector, H_vector, Nvar_vector, H_est, h_est, H_est_A, H_est_B, Nvar_est_A, Nvar_est_B, Nvar_est, L_funct_s_test] = hmmparameter_scaling1_reestimate_L1(O, T, H0, Nvar0, tr, n);
[A_est, accuracy] = MESSAGE_RECEIVER(T, L_funct_s_test, A);
BER = 1-accuracy;

%output data and decoding
decoding_bin2text(A_est);
