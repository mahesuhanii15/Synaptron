function [emg_env, fs, t] = preprocess_emg_live()

clear; clc; close all;

%% SERIAL CONNECTION
port = "COM14";
baud = 115200;

s = serialport(port,baud);
configureTerminator(s,"LF");
pause(2);

disp("Receiving live EMG data...");

%% PARAMETERS
fs = 250;
duration = 10;
N = fs * duration;

emg = zeros(N,1);

%% READ DATA
for i = 1:N
    val = readline(s);
    emg(i) = str2double(val);
end

clear s
t = (0:N-1)/fs;

%% ADC → mV
emg = (emg/1023)*5000;

%% DC REMOVAL
emg = emg - mean(emg);

%% BANDPASS
[b,a] = butter(4,[25 150]/(fs/2),'bandpass');
emg_bp = filtfilt(b,a,emg);

%% NOTCH 50 Hz
[bn,an] = iirnotch(50/(fs/2), (50/(fs/2))/35);
emg1 = filtfilt(bn,an,emg_bp);

%% NOTCH 100 Hz
[bn,an] = iirnotch(100/(fs/2), (100/(fs/2))/60);
emg_clean = filtfilt(bn,an,emg1);

%% RECTIFICATION
emg_rect = abs(emg_clean);

%% RMS
win = round(0.05*fs);
emg_env = sqrt(movmean(emg_rect.^2, win));

%% SAVE
save("emg_processed_live.mat","emg_env","fs","t")

end