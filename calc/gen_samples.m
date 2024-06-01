clear all, close all,

N = 24e3; Nx = 4*N;
fs = 48e3;
f0 = fs/Nx
res = 2^8 - 1;

samples = res/2 .* cos(2 * pi * f0 * (0:N-1)/fs) + res/2;
samples = round(samples, 0);
file = fopen("samples.txt", 'w');
fprintf(file, ".DB 0x%X, 0x%X, 0x%X, 0x%X, 0x%X, 0x%X, 0x%X, 0x%X, 0x%X, 0x%X, 0x%X, 0x%X, 0x%X, 0x%X, 0x%X, 0x%X\n", samples);
fclose(file);
