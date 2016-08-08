function [r_pp] = phase_phase(Data,ch,ses)

low_filtered = eegfilt(Data.LFP(ch,:),Data.par.sampling_rate,Data.par.slow_freq_lower_limit,Data.par.slow_freq_upper_limit);
high_filtered = eegfilt(Data.LFP(ch,:),Data.par.sampling_rate,Data.par.fast_freq_lower_limit,Data.par.fast_freq_upper_limit);

phase1 = angle(hilbert(low_filtered));
phase2 = angle(hilbert(high_filtered));

r_pp = [];
for sample = 1:Data.par.total_samples
    fprintf('Progress: %d%%; Animal %d; Channel %d\n',round(100*(sample/Data.par.total_samples)),ses,ch)
    
    upper_range = length(phase1) - Data.par.time_window*Data.par.sampling_rate;
    lower_range = 1;
    
    I_rand = (upper_range-lower_range).*rand(1,1) + lower_range;
    timewindow = round(I_rand):round(I_rand+Data.par.time_window*Data.par.sampling_rate);
    
    r_sample = [];
    counter = 0;
    for mm = Data.par.nmcurve
        counter = counter + 1;
        r_sample(:,counter) = phase_phase_core(phase1(timewindow),phase2(timewindow),mm);
    end
    
    r_pp(sample,:) = abs(r_sample);
end

end
