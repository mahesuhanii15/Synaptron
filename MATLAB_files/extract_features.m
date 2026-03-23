function feat = extract_features(emg_norm, fs)

win = round(0.2 * fs);
step = round(0.05 * fs);

idx = 1;
k = 1;
feat = [];

while (idx + win - 1) <= size(emg_norm,1)

    seg = emg_norm(idx:idx+win-1,:);

    MAV = mean(seg);
    RMS = sqrt(mean(seg.^2));

    feat(k,:) = [MAV RMS];

    idx = idx + step;
    k = k + 1;
end

end