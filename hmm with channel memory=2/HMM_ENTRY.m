function [A, S, X, O, h] = HMM_ENTRY(T, H, Nvar, A_bin)

%O is the observation sequence. T is the
%length of the HMM. L is the length of the channel memory(L=1 in this case). H is the column vector
%which has linear channel coefficients as its elements. Nvar is the noise variance
%for Gaussian distribution.

A = 2*(bin2dec(A_bin).')-1;  %%%%S(1) is initilized
S = zeros(T+1, 2);   %%%%%specify S(2) to S(T+1)
O = zeros(T, 1);
for j = 1:2
S(1,j) = 2 * randi([0 1],1,1) - 1;
end

for i = 2:T+1
    S(i,1) = A(i-1);
    S(i,2) = S(i-1,1);
end

X = zeros(T, 3);
for i = 1:T              %%%%%specify transition branch
    X(i,1) = A(i);
    X(i,2:3) = S(i,:);
end

X_space = [-1,-1,-1;-1,-1,1;-1,1,-1;-1,1,1;1,-1,-1;1,-1,1;1,1,-1;1,1,1];
X_space = X_space.';
h = zeros(1,8);

for k = 1:8    %%%%%output of the linear channel 
h(k) = H.'*X_space(:,k);
end

for i = 1:T                                 %output received by the receiver
    hco = H.'*X(i,:).';
    O(i) = normrnd(hco,Nvar);
end