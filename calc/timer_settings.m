close all, clear all

bit16 = 0:2^16 - 1;
bit8 = 0:2^8 - 1;
pre_scal = [1, 8, 64, 256, 1024];
clk = 16e6;

legs = ["1", "8", "64", "256", "1024"];

timer8 = clk ./ (2 * (bit8)' * pre_scal);
figure;
loglog(bit8, timer8); grid on;
xlabel("Compare register")
ylabel("Timer frequency")
yline(160e3)
title("8-bit timer")
legend(legs)

timer16 = clk ./ (2 * (bit16)' * pre_scal);
figure;
loglog(bit16, timer16); grid on;
xlabel("Compare register")
ylabel("Timer frequency")
title("16-bit timer")
legend(legs)