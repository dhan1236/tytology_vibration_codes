close all;
Fs = 48828.125;
T = 1/Fs;
L = 29783-485+1;
data_n = length(rawdata.resp{3,1});
time_total = [1:data_n]/Fs;
time = time_total(485:29783); %use 600ms
freqs= [10	20	30	50	80	100	125	160	200	250	300];
octave_lower = [7.071067812	14.14213562	21.21320344	35.35533906	56.56854249	70.71067812	88.38834765	113.137085	141.4213562	176.7766953	212.1320344];
octave_upper = [14.14213562	28.28427125	42.42640687	70.71067812	113.137085	141.4213562	176.7766953	226.27417	282.8427125	353.5533906	424.2640687];
Voltage_total = rawdata.resp(:);
Voltage = {};
window = tukeywin(L,0.1);
for n_reps = 1:length(Voltage_total)
    Voltage {n_reps}= Voltage_total{n_reps}(1,485:29783);
    windowed_voltage{n_reps}= window.*Voltage {n_reps}';
end


%%
rms_all = [];
for n_freqs = 1:length(freqs)
    for trialn = 1: length(windowed_voltage)
        filtereddata = filterdata(windowed_voltage{trialn},Fs, octave_lower(n_freqs), octave_upper(n_freqs));
        NFFT = 2^nextpow2(L);
        Y = abs(fft(filtereddata,NFFT))/L;
        f = Fs/2*linspace(0,1,NFFT/2+1);
        plot(f,2*abs(Y(1:NFFT/2+1)));
        rmsval = rms(Y);
        rms_all (n_freqs, trialn)=rmsval;
    end
end

