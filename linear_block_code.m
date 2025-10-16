% Minimal Hamming (7,4)

G = [1 0 0 0 1 1 0;
     0 1 0 0 1 0 1;
     0 0 1 0 0 1 1;
     0 0 0 1 1 1 1];

P = G(:,5:7);
H = [P' eye(3)];

% Example message & codeword
msg = [1 0 1 1];
code = mod(msg * G, 2);

% Received word (introduce single-bit error)
r = code;
r(3) = mod(r(3)+1,2);

% Syndrome
s = mod(H * r', 2);

fprintf('Received word: '); disp(r);
fprintf('Syndrome: '); disp(s');

% Find error position by matching syndrome to columns of H
err_pos = 0;
for j = 1:size(H,2)
    if isequal(H(:,j), s)
        err_pos = j;
        break;
    end
end

if err_pos == 0
    if all(s==0)
        disp('No error detected.');
    else
        disp('Syndrome nonzero but no single-bit match found (multi-bit or unknown).');
    end
else
    fprintf('Error detected at bit position: %d\n', err_pos);
    r(err_pos) = mod(r(err_pos)+1,2);    % correct
    fprintf('Corrected codeword: '); disp(r);
end
