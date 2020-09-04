close all; clear all;

% -------------- (ECE18183) Yashwanth's part begins here ------------------

% get device information
dev = audiodevinfo;
fs = 44100;

% create recorder object (y = audiorecorder(Fs,nbits,channels,id))
rec = audiorecorder(fs, 16, 1);

% start recording
f = waitbar(0, 'Please speak into your microphone.', 'Name', 'Recording...');
rec.record(5);

while rec.isrecording()
    waitbar(0.2, f);
    pause(1);

    waitbar(0.4, f);
    pause(1);

    waitbar(0.6, f);
    pause(1);

    waitbar(0.8, f);
    pause(1);

    waitbar(1, f);
    pause(2)
end
close(f)

% stop recording
m1 = msgbox({'Voice recorded. Duration: 5 seconds.','Playing recorded speech: '} ,'Success!');

% Play recorded sound
play(rec);
pause(5);
close(m1);

% get audio data
y = getaudiodata(rec);
disp(y)

% plot the sound
figure(1);
plot(y);
ylabel('Amplitude y(t) [dB]');
xlabel('Time Duration t (nTs) [seconds]');
title('Recorded Audio Signal [Time Domain]')
grid on;

% --------------- (ECE18183) Yashwanth's part ends here -------------------

% --------------- (ECE18182) Yash's part begins here ----------------------

pause(2);

m2 = msgbox('Passing the recorded function through a differentiator, we obtain:','Running...');
dt = 1 / fs;
t = (0 : length(y) - 1) * dt;
pause(3);
close(m2);

dFilt = designfilt('differentiatorfir', 'FilterOrder', 16, 'PassbandFrequency', 2000, 'StopbandFrequency', 20000, 'SampleRate', fs);
hvt = fvtool(dFilt, 'MagnitudeDisplay', 'Zero-phase');
legend(hvt, '16th Order FIR Differentiator', 'Response of diff() function');

% Comparing output from diff() and an FIR Differentiator
v1 = diff(y) / dt;

v1 = [0; v1];

D = mean(grpdelay(dFilt)); % filter delay
v2 = filter(dFilt, [y; zeros(D, 1)]);
v2 = v2(D + 1 : end);
v2 = v2 / dt;

figure(2);
plot(t, v1);
hold on;

% figure(3);
plot(t, v2);
legend('Using diff()', 'Using differentiator filter');
xlabel('Time (t) [Seconds]');
ylabel('Amplitude');
title('Differentiated Signal [Time Domain]');
grid;

% ---------------- (ECE18182) Yash's part ends here ----------------------

% ---------------- (ECE18184) Vishnu's part starts here ------------------

N = 220500;
t = 0:1/fs:1-1/fs;
[Pxx,F] = periodogram(v2);
figure(4);
plot(F,10*log10(Pxx));
legend('Power Spectral Density Sy(f)');
xlabel('Normalized Frequency (pi rad/sample)');
ylabel('Power/frequency (dB/Hz)');
grid;

% ---------------- (ECE18184) Vishnu's part ends here ------------------