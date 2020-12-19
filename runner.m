clc
close all

% Input signal, x[n]
x = [0 1+1i 1 0 0 0 1+2i 1];
y = zeros(1, 8);
sum1 = 0;
sum2 = 0;
% Length of DFT Signal, N-point.
N = 8;
% X is a vector to hold the DFT values
X = zeros(1, N);
% Loop to compute twiddle factors using CORDIC Algorithm
for k = 0:N-1
    for n = 0:N-1
        % Angle computation
        angle = (2*180*k*n)/N;
        % (x0, y0) --> Co-ordinates of the vector to be rotated by CORDIC Algorithm
        x0 = x(n+1);
        y0 = y(n+1);
        % Function call to CORDIC Algorithm
        [xnew, ynew] = cordicdft(x0, y0, angle);
        % Accumulating the new co-ordinates till n = N-1
        sum1 = sum1 + xnew;
        sum2 = sum2 + ynew;
    end
    % X(k) --> DFT Signal
    X(k+1) = sum1 - (1i*sum2);
    sum1 = 0;
    sum2 = 0;
end
        
        
        
