clc;clear;

[x,fs]=audioread(".\test.wav");
x=x(:,1);
figure(1);
subplot(2,1,1);
plot(x);

a=0.8;        %衰减系数
delay=0.1;    %延时
N=fs*delay;
times=1:1:100;
impulse=zeros(length(x),1);
for time=times
    impulse((time-1)*N+1,1)=a^(time-1);
end
y=conv(x,impulse,'full');

subplot(2,1,2);
plot(y);
sound(y,fs);
audiowrite("out.wav",y,fs);

cor=xcorr(y,y);
figure(2);
subplot(2,1,1);
plot(cor);
title("自相关分析");
[h1,h1_loc]=max(cor);
cor(h1_loc-fs*0.1:h1_loc+fs*0.1)=zeros(fs*0.2+1,1);
subplot(2,1,2);
plot(cor);
title("次极大分析");
[h2,h2_loc]=max(cor);

N_delay=abs(h1_loc-h2_loc);
t_delay=N_delay/fs;
% c=h1/h2;
% a_est=(c-sqrt(c*c-4))/2;

% num=[1;zeros(N_delay,1);a_est];
% voice_decho=filter(1,num,y);
% %sound(voice_decho,fs);
% metric=corrcoef([x;z]+a*[z;x],voice_decho);
% 
% theta=0:pi/99:2*pi;
% resp=(1+a_est*exp(-theta*1i*N_delay)).^-1;
% a_resp=abs(resp);
% p_resp=angle(resp);
% figure(3);
% subplot(2,1,1);
% plot(theta,a_resp);
% title("幅频响应");
% subplot(2,1,2);
% plot(theta,p_resp);
% title("相频响应");