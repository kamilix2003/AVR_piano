close all, clear all

fs = 48e3; N = 16;
n = (0:N-1)/N;
clock_f = 16e6;
range = 2^8;
x = range/2 * sin(2 * pi * (1:fs)/fs) + range/2;
x1 = range/2 * sin(2*pi*n) + range/2;
x2 = round(x1, 0);
x3 = resamp(x2, fs);

freq = 1:20e3;
res = 2.^(1:6);
dt = 1./(res)' .* 1./freq;

figure;
loglog(freq, 1./dt); grid on;
yline(16e6, "r-")
yline(160e3, "b-.")
yline(16e3, "g-.")
legs = ["2", "4", "8", "16", "32", "64"]; legend(legs)
ylabel("timer frequency")
xlabel("output frequency")
title("timer frequency depending on output frequency and sample count")

% figure;
% subplot(2, 1, 1)
%     plot(x/range); hold on; grid on;
%     plot(x3/range)
% subplot(2, 1, 2)
%     plot(abs(x3-x)/range); hold on; grid on;

figure;
err = [];
for k = 1:8
    N = 2^k;
    n = (0:N-1)/N;
    x1 = range/2 * sin(2*pi*n) + range/2;
    x2 = round(x1, 0);
    x3 = resamp(x2, fs);
    err(end+1) = max(abs(x3-x));
end    
plot(2.^(1:8), err/range); grid on;
title("quantization error")
ylabel("error")
xlabel("sample count")

function out = resamp(x, fs)
    
    steps = ceil(fs / length(x));

    for k = 0:length(x)-1
        out(k * steps + 1 : (k + 1) * steps) = x(k+1) .* ones(1, steps);
    end
    
    out = out(1:fs);

end