function M = decoding_bin2text(A_est)
A_est = dec2bin(A_est);

% Now decode:
M = char(bin2dec(reshape(A_est,7,[]).').');

M1 = ['receiving: ', M];
disp(M1);