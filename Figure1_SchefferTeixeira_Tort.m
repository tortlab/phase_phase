%% Coupled Kuramoto Oscillators 

% Reproducing Figure 1 in Scheffer-Teixeira & Tort, eLife 2016

clear
dt = 0.001;
srate = 1/dt; % sampling rate
T = 100; % total simulation time
t = dt:dt:T; % time vector

theta_phase = zeros(1,round(T*srate)); % pre-allocation of memory
gamma_phase = zeros(1,round(T*srate)); % pre-allocation of memory

theta_phase(1) = 0; % initial theta phase
gamma_phase(1) = 0; % initial gamma phase
theta_freq = 8; % uncoupled ("natural") theta frequency in Hz 
gamma_freq = 43; % uncoupled ("natural") gamma frequency in Hz
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

%% Computing the Rnm curve

figure(2)
clf

clear Rnm
for mmm=1:40
    Rnm(mmm)= abs(mean(exp(1i*(unwrap(gamma_phase)-mmm*unwrap(theta_phase)))));  
end

plot(1:40,Rnm,'k.-','markersize',12)
ylim([0 1])
xlabel('n:m')
ylabel('R_n_m')
box off


%% Measuring the peak frequency of the oscillators 

figure(3)
clf
[PxxTheta, F]=pwelch(sin(theta_phase),[],[],[],srate);
[PxxGamma, ~]=pwelch(sin(gamma_phase),[],[],[],srate);

plot(F,PxxTheta)
hold on
plot(F,PxxGamma,'r-')
hold off
xlim([0 60])
xlabel('Frequency (Hz)')
ylabel('Power')

[~, ii]=max(PxxGamma);
GammaPeakFreq=F(ii)

[~, ii]=max(PxxTheta);
ThetaPeakFreq=F(ii)

text(9,0.9,['Freq = ' num2str(ThetaPeakFreq) ' Hz'])
text(43.5,0.9,['Freq = ' num2str(GammaPeakFreq) ' Hz'])

% title([ThetaPeakFreq,GammaPeakFreq])

%% plotting circular histograms

figure(7)
clf

count = 0;
for m = [3, 5, 7]
    count = count+1;
    
    figure(3+count)
    clf
    phasediff = angle(exp(1i*(gamma_phase-m*theta_phase)));
    
    clear h

    h(1) = subplot(411);
    plot(t,rad2deg(theta_phase)-180,'b.')
    set(gca,'ytick',[-180,0,180],'xtick',[])
    box off
    
    h(2) = subplot(412);
    plot(t,rad2deg(gamma_phase)-180,'r.')
    set(gca,'ytick',[-180,0,180],'xtick',[])
    box off

    h(3) = subplot(413);
    plot(t,rad2deg(angle(exp(1i*(m*theta_phase)))),'g.')
    set(gca,'ytick',[-180,0,180],'xtick',[])
    box off

    h(4) = subplot(414);
    plot(t,rad2deg(phasediff),'k.')
    set(gca,'ytick',[-180,0,180],'xtick',[])
    box off

    linkaxes(h)
    ylim([-190 190])
    xlim([10 10.5])
    
    pause(0.5)
    
    figure(7)

    subplot(1,3,count)
    
    % just a trick to set the polar plot scale:
    axlim = 0.1; if count ==2, axlim = 0.25; end % change for the uncoupled case
    polar(0,axlim,'-k') 
    hold on
    
    [phi,r] = rose(phasediff,20);
    phi_prob = 2*r/sum(r);
    polar(phi,phi_prob)
          
    mean_angle = (angle(mean(exp(1i*(gamma_phase-m*theta_phase)))));
    r = (abs(mean(exp(1i*(gamma_phase-m*theta_phase)))));
      
    zm = r*exp(1i*mean_angle)*max(phi_prob); % just for aesthetics,
    hold on
    plot([0 real(zm)], [0, imag(zm)],'linewidth',2,'color','k')
    hold off
    title(['R = ' num2str(r)])
    

end

