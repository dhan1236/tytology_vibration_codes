%% plot raw waveform data

Fs = 48828.125;
data_n = length(curveresp{1,1});
time = 1000*[1:data_n]/Fs;

figure ('Position', [334 313 560 217]);
Y = curveresp{7,4}(:,1);
plot(time,Y);
xlabel('Time (ms)');
ylabel('Voltage (V)');
%ylim ([-0.05 0.05]);
yticks([-0.05 0.05]);
set(gca, 'box', 'off');
clear all;