close all; clear all;

% read .mp3 file
[x, fs] = audioread('vocode.mp3');

% play audio file
player = audioplayer(x,fs);
play(player);
pause(4);
pause(player);

% plot signal
figure()
plot(x); title('Input Sound File');
xlabel('samples');
ylabel('amplitude');