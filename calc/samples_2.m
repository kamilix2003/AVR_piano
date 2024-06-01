close all, clear all

fs = 48e3; N = 48e3;
n = (0:N-1)/N;

range = 2^8;
x1 = range/2 * sin(2*pi*n) + range/2;

figure;
x2 = round(x1, 0);
plot(x2);

err = [];
for k = 1:20e3
    x3 = x2(1:k:end);
    x3 = resamp(x3, fs);
    % plot(resamp(x3, fs)) 
    err(end+1) = max(abs(x3-x1));
end

a = 20 * log10(err/range);
plot(1:20e3, a)
grid on;
title("quantization error")
xlabel("output frequency")
ylabel("error [dB]")


function out = resamp(x, fs)
    
    steps = ceil(fs / length(x));

    for k = 0:length(x)-1
        out(k * steps + 1 : (k + 1) * steps) = x(k+1) .* ones(1, steps);
    end
    
    out = out(1:fs);

end