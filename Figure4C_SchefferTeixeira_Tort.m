

%% Sawtooth example:

clear
dt = 0.001;
srate = 1/dt; % sampling rate
T = 600; % total simulation time
t = dt:dt:T; % time vector

theta_freq = 8; % theta frequency in Hz 
peakfreq_noise = 5; % standard deviation of white noise in peak frequency
noise = 0.1; % standard deviation of white noise in the simulated LFP

thetasawtooth = sawtooth(cumsum(dt*((theta_freq+peakfreq_noise*randn(1,round(T*srate)))*2*pi)));
thetasawtooth = thetasawtooth+noise*randn(size(thetasawtooth));

theta = eegfilt(thetasawtooth,srate,4,12);
gamma = eegfilt(thetasawtooth,srate,30,50);

theta_phase = angle(hilbert(theta));
gamma_phase = angle(hilbert(gamma));


%% Surrogate Analysis

EpochLength = 30;

N_sample = 300;
nm = 1:25;

Roriginal = zeros(N_sample,length(nm));
Rsurr = zeros(N_sample,length(nm));

for n_sample = 1:N_sample

    display(n_sample)
    
temp = randi(round((T-EpochLength)*srate));
I=temp:temp+round(EpochLength*srate);

temp2 = randi(round((T-EpochLength)*srate));
I2= temp2:temp2+round(EpochLength*srate);

       for m = nm
Roriginal(n_sample,m) = abs(mean(exp(1i*(unwrap(gamma_phase(I))-m*unwrap(theta_phase(I))))));
Rsurr(n_sample,m) = abs(mean(exp(1i*(gamma_phase(I)-m*theta_phase(I2)))));
       end
end


%%
figure(3)
subplot(221)
plot(t,thetasawtooth','k')
hold on
plot(t,theta-2,'b')
plot(t,gamma-4,'r')
% plot(t,0.25*theta_phase/pi-5.5,'b.')
% plot(t,0.25*gamma_phase/pi-7,'r.')
hold off
xlim([10 10.5])
axis off

subplot(222)
plot(t,theta_phase,'b.')
hold on
plot(t,gamma_phase-9,'r.')
hold off
xlim([10 10.5])
axis off

subplot(2,3,[4 5])
plot(mean(Roriginal),'g-o','markerfacecolor','g')%,'markersize',10)
hold on
plot(mean(Rsurr),'r-o','markerfacecolor','r') %,'markersize',10)
hold off
ylim([0 1])
xlim([0 25])
box off

subplot(2,3,6)
m = 5;
boxplot([Roriginal(:,m),Rsurr(:,m)],'symbol','')

% Unpaired t-test to check if Original values are higher than Single Run Random
% Permutation Surrogates
[h p]=ttest2(Roriginal(:,m),Rsurr(:,m),'Tail','right','Alpha',0.01);
% title(p)
ylim([0 0.7])
set(gca,'ytick',[0:0.35:0.7])
box off
