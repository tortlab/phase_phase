function [PhaseCounts binn] = phase_phase_histogram(Data,ch)

low_filtered = eegfilt(Data.LFP(ch,:),Data.par.sampling_rate,Data.par.slow_freq_lower_limit,Data.par.slow_freq_upper_limit);
high_filtered = eegfilt(Data.LFP(ch,:),Data.par.sampling_rate,Data.par.fast_freq_lower_limit,Data.par.fast_freq_upper_limit);

phase1 = angle(hilbert(low_filtered));
phase2 = angle(hilbert(high_filtered));

binwidth = pi/60;
phasebin = -pi:binwidth:(pi-(binwidth));
PhaseCounts = [];
for j = 1:length(phasebin)
    I=find(phase1 >= phasebin(j) & phase1 < phasebin(j)+binwidth);
    [counts binn] = hist(phase2(I), phasebin+binwidth/2);
    PhaseCounts(j,:)=counts;
    
end

binn = phasebin+binwidth/2;
end
