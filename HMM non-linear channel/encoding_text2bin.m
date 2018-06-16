function A_bin = encoding_text2bin(text)

% Now encode:
A_bin = reshape(dec2bin(double(text),7).',[],1);
