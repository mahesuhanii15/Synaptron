function motor_cmd = prosthetic_control_5finger(emg_env, fs, t, TH, send_to_arduino)

%% NORMALIZE
emg_norm = emg_env ./ max(emg_env + eps);

%% SMOOTHING
emg_smooth = movmean(emg_norm, round(0.15*fs));
emg_smooth = movmean(emg_smooth, round(0.25*fs));

%% THRESHOLD
motor_cmd = zeros(size(emg_smooth));
motor_cmd(emg_smooth > TH) = 1;

%% STABILITY FILTER
motor_cmd = movmean(motor_cmd, round(0.2*fs));
motor_cmd = motor_cmd > 0.5;

%% PLOT
figure;
subplot(2,1,1)
plot(t,emg_norm)
hold on
yline(TH,'r--')
title('Normalized EMG')

subplot(2,1,2)
plot(t,motor_cmd)
title('Motor Command')

%% SEND TO ARDUINO
if send_to_arduino
    s = serialport("COM14",115200);
    pause(2);

    for i = 1:length(motor_cmd)
        writeline(s, sprintf("%d", motor_cmd(i)));
        pause(1/fs);
    end

    clear s
end

end