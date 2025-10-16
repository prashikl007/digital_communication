% Linear Block Code (7,4) with Error Detection and Correction

G = [1 0 0 0 1 1 0;
     0 1 0 0 1 0 1;
     0 0 1 0 0 1 1;
     0 0 0 1 1 1 1];

P = G(:,5:7);
H = [P' eye(3)];

% Example message and received word (1-bit error introduced)
msg = [1 0 1 1];
code = mod(msg * G, 2);
r = code; 
r(3) = mod(r(3)+1,2);   % introduce error

fprintf('Received word: '); disp(r);

% Calculate Syndrome
s = mod(H * r', 2);
fprintf('Syndrome: '); disp(s');

% Check for errors
if all(s == 0)
    disp('No error detected.');
else
    % Find error bit position
    for j = 1:size(H,2)
        if isequal(H(:,j), s)
            err_pos = j;
            break;
        end
    end
    fprintf('Error detected at bit position: %d\n', err_pos);

    % Display error vector
    e = zeros(1, size(H,2));
    e(err_pos) = 1;
    fprintf('Error vector: '); disp(e);

    % Correct codeword
    r_corr = mod(r + e, 2);
    fprintf('Corrected codeword: '); disp(r_corr);
end

