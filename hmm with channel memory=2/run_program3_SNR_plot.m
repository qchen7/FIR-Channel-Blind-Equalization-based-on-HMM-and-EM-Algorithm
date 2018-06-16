function run_program3_SNR_plot(T, H, H0, n)

SNR = 0:10;
Nvar = zeros(1,11);
for i = 1:11
    Nvar(i) = 1/10^(SNR(i)/10);
end
Nvar0 = Nvar;
   
tr = [1/2,0,1/2,0;1/2,0,1/2,0;0,1/2,0,1/2;0,1/2,0,1/2];
tr = tr.';
accuracy_mean = zeros(1,11);

for j = 1:11
    for m = 1:100
        [A, ~, ~, O, ~] = hmmgen_L1(T, H, Nvar(j));
        [~, ~, ~, ~, ~, ~, ~, ~, ~, ~, L_funct_s_test] = hmmparameter_scaling1_reestimate_L1(O, T, H0, Nvar0(j), tr, n);
        [~, accuracy] = Map_estimate_L1(T, L_funct_s_test, A);
        accuracy_mean(j) = accuracy_mean(j) + accuracy;
    end
end
accuracy_mean = accuracy_mean / 100;

Hundred_percent(SNR+1) = 1;
plot(SNR,Hundred_percent(SNR+1),'--k');
hold on;
plot(SNR,accuracy_mean(SNR+1),'r');
axis([0 10 0.65 1.05]);
title('Accuracy-SNR');
xlabel('SNR(dB)');
ylabel('Accuracy');
ylabel('Accuracy');