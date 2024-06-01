close all, clear all

fs = 48e3; N = fs/4;
n = (0:N-1)/fs;

range = 2^8; f0 = 1;
x1 = range/2 * sin(2*pi*f0*n);

notes = 2.^(((0:127)-69)/12) * 440;

steps = round(f0 * notes)

f = [];
figure;
for k = 1:length(steps)
    x2 = x1(1:steps(k):end);
    x3 = x1(end:-steps(k):1);
    x = [x2, x3, -x2, -x3] + range/2;
    f(end + 1) = fs/length(x);
    plot(x); hold on;
end

figure;
plot(f)



function out = fill(x, N)
    Nx = length(x);
    out = [];
    for k = 1:N/Nx
        out((k-1)*Nx + 1 : k*Nx) = x;
    end
    out(end:N) = x(1:N - length(out) + 1);
end

function out = major_harm(x)
    X = fft(x)/length(x);
    X([1, end]) = 0;
    out = find(abs(X(1:end/2)) == max(abs(X)));
end