%% Coupled Kuramoto Oscillators 

% Reproducing Figure 3A in Scheffer-Teixeira & Tort, eLife 2016

clear
dt = 0.001;
srate = 1/dt; % sampling rate
T = 600; % total simulation time
t = dt:dt:T; % time vector

theta_phase = zeros(1,round(T*srate)); % pre-allocation of memory
gamma_phase = zeros(1,round(T*srate)); % pre-allocation of memory

theta_phase(1) = 0; % initial theta phase
gamma_phase(1) = 0; % initial gamma phase
theta_freq = 8; % uncoupled ("natural") theta frequency in Hz 
gamma_freq = 40; % uncoupled ("natural") gamma frequency in Hz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
epsilon = 10; % coupling strength > change this parameter to 0 for no coupling
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
peakfreq_noise = 5; % standard deviation of white noise in peak frequency

% n:m phase-locking parameters
n = 1;
m = 5;

for j=1:round(T*srate)-1
    theta_phase(j+1) = mod(theta_phase(j)+dt*((theta_freq+peakfreq_noise*randn)*2*pi...
        +epsilon*sin(n*gamma_phase(j)-m*theta_phase(j))),2*pi);
    gamma_phase(j+1) = mod(gamma_phase(j)+dt*((gamma_freq+peakfreq_noise*randn)*2*pi...
        +epsilon*sin(m*theta_phase(j)-n*gamma_phase(j))),2*pi);
end

figure(1)
clf
h1 = subplot(211);
plot(t,rad2deg(theta_phase)-180,'b.')
box off
set(gca,'ytick',[-180:90:180])

h2 = subplot(212);
plot(t,rad2deg(gamma_phase)-180,'r.')
linkaxes([h1 h2])
axis tight
box off
xlim([10 10.5])
ylim([-190 190])
xlabel('Time (s)')
set(gca,'ytick',[-180:90:180])


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

figure(2)
plot_index = 0; if epsilon == 0, plot_index = 3; end % set subplot location

subplot(2,3,[1 2]+plot_index)
plot(mean(Roriginal),'g-o','markerfacecolor','g')
hold on
plot(mean(Rsurr),'r-o','markerfacecolor','r')
hold off
ylim([0 1])
xlim([0 25])
box off

subplot(2,3,3+plot_index)
m = 5;
boxplot([Roriginal(:,m),Rsurr(:,m)],'symbol','')
% Unpaired t-test to check if Original values are higher than Single Run Random
% Permutation Surrogates
[h p]=ttest2(Roriginal(:,m),Rsurr(:,m),'Tail','right','Alpha',0.01);

title(p)
ylim([0 1])
box off





