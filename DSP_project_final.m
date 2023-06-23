clc;
close all;
clear all;
[x, Fs] = audioread("NInput_audio.wav");


% Display the original audio signal
figure;
subplot(3, 1, 1);
plot(x);
title('Original Audio Signal');
xlabel('Samples');
ylabel('Amplitude');

% Add high-frequency noise to the audio signal
noiseFrequency = 20000;
t = (0:length(x)-1)'/Fs;
noise = sin(2*pi*noiseFrequency*t);
noisyAudio= x + noise;

% Display the noisy audio signal
subplot(3, 1, 2);
plot(noisyAudio);
title('Noisy Audio Signal');
xlabel('Samples');
ylabel('Amplitude');%%done


% Apply the wavelet transform to find the high-frequency coefficients
wname = 'db4';  % Choose the desired wavelet (e.g., Daubechies 4)
level = 5;  % Choose the desired decomposition level

% Perform the wavelet decomposition
[c, l] = wavedec(noisyAudio, level, wname);

% Identify the index of the high-frequency coefficients
highFreqCoeffIdx = length(x) / 2 + 1 : length(x);%approx
% Set the high-frequency coefficients to zero
c(highFreqCoeffIdx) = 0;

% Reconstruct the denoised audio signal
denoisedAudio = waverec(c, l, wname);

subplot(3, 1, 3);
plot(denoisedAudio);
title('Denoised Audio Signal');
xlabel('Samples');
ylabel('Amplitude');

% Play the original, noisy, and denoised audio signals
disp('Playing the original audio signal...');
sound(x, Fs);
pause(length(x)/Fs + 1);
disp('Playing the noisy audio signal...');
sound(noisyAudio, Fs);
pause(length(noisyAudio)/Fs + 1);
disp('Playing the denoised audio signal...');
sound(denoisedAudio, Fs);
