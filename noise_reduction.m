clc;
clear;
close all;

%% Step 1: Load Default Audio (No error guaranteed)
load handel;   % Built-in MATLAB audio
x = y;         % Audio signal
fs = Fs;       % Sampling frequency

t = (0:length(x)-1)/fs;

%% Step 2: Add Noise
noise = 0.05 * randn(size(x));
noisy = x + noise;

%% Step 3: FIR Filter Design
order_fir = 50;
cutoff = 0.3;

fir_coeff = fir1(order_fir, cutoff, 'low');
fir_output = filter(fir_coeff, 1, noisy);

%% Step 4: IIR Filter Design (Butterworth)
order_iir = 4;

[b, a] = butter(order_iir, cutoff, 'low');
iir_output = filter(b, a, noisy);

%% Step 5: Plot Signals
figure;

subplot(4,1,1);
plot(t, x);
title('Original Signal');

subplot(4,1,2);
plot(t, noisy);
title('Noisy Signal');

subplot(4,1,3);
plot(t, fir_output);
title('FIR Filter Output');

subplot(4,1,4);
plot(t, iir_output);
title('IIR Filter Output');

%% Step 6: Frequency Response
figure;
freqz(fir_coeff, 1);
title('FIR Frequency Response');

figure;
freqz(b, a);
title('IIR Frequency Response');

%% Step 7: Play Audio
disp('Playing Original...');
sound(x, fs);
pause(3);

disp('Playing Noisy...');
sound(noisy, fs);
pause(3);

disp('Playing FIR Output...');
sound(fir_output, fs);
pause(3);

disp('Playing IIR Output...');
sound(iir_output, fs);

%% Step 8: Save Outputs
audiowrite('fir_output.wav', fir_output, fs);
audiowrite('iir_output.wav', iir_output, fs);

disp('Program Executed Successfully!');