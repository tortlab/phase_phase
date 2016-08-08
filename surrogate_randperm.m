function [r_pp_surr_randperm_single r_pp_surr_randperm_pool] = surrogate_randperm(Data,ch,ses)

low_filtered = eegfilt(Data.LFP(ch,:),Data.par.sampling_rate,Data.par.slow_freq_lower_limit,Data.par.slow_freq_upper_limit);
high_filtered = eegfilt(Data.LFP(ch,:),Data.par.sampling_rate,Data.par.fast_freq_lower_limit,Data.par.fast_freq_upper_limit);

phase1 = angle(hilbert(low_filtered));
phase2 = angle(hilbert(high_filtered));

r_pp_surr_randperm_single = [];
r_pp_surr_randperm_pool = [];

% random permutation
for sample = 1:Data.par.total_samples
    fprintf('Progress: %d%%; File %d; Channel %d\n',round(100*(sample/Data.par.total_samples)),ses,ch)
    
    upper_range = length(phase1) - Data.par.time_window*Data.par.sampling_rate;
    lower_range = 1;
    
    I_rand1 = (upper_range-lower_range).*rand(1,1) + lower_range;
    timewindow1 = round(I_rand1):round((I_rand1+Data.par.time_window*Data.par.sampling_rate));
    
    r_sample_single = [];
    r_sample_pool = [];
    for ss = 1:Data.par.total_surr
        counter = 0;
      
        I_rand2 = (upper_range-lower_range).*rand(1,1) + lower_range;
        timewindow2 = round(I_rand2):round((I_rand2+Data.par.time_window*Data.par.sampling_rate));
        
        for mm = Data.par.nmcurve
            counter = counter + 1;
            r_sample_single(ss,counter) = abs(phase_phase_core(phase1(timewindow1),phase2(timewindow2),mm));
            r_sample_pool(ss,counter) = phase_phase_core(phase1(timewindow1),phase2(timewindow2),mm);
        end
    end
    
    
    r_pp_surr_randperm_single(sample,:) = mean(r_sample_single,1);
    r_pp_surr_randperm_pool(sample,:) = abs(mean(r_sample_pool,1));
end

end