function [A, S, X, O] = HMM_ENTRY(T, h, Nvar, A_bin)

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

for i = 1:T                                 %output received by the receiver
    index = (X(i,1)+1)/2*4 + (X(i,2)+1)/2*2 + (X(i,3)+1)/2 + 1;
    O(i) = normrnd(h(index),Nvar);
end