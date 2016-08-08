%% Data architecture

% This routine calls the main methods used in the paper of
% Scheffer-Teixeira & Tort (2016) published in eLife.
% Analysis can be performed using real signals, sawtooth waves or
% Kuramoto model for coupled oscillators.

% Define signals and methods
function Data = data_architecture(DataInput)

Data.signal_type{1} = 'real_lfp';
Data.signal_type{2} = 'white_noise';

% this surrogates can be employed with the 'phase_phase' method. They are
% described in figure 2.
Data.surrogates{1} = 'permutation';
Data.surrogates{2} = 'shift';
Data.surrogates{3} = 'scramble';

% Parameters
Data.par.sampling_rate          = DataInput.par.sampling_rate;
Data.par.slow_freq_lower_limit  = DataInput.par.slow_freq_lower_limit;
Data.par.slow_freq_upper_limit  = DataInput.par.slow_freq_upper_limit;
Data.par.fast_freq_lower_limit  = DataInput.par.fast_freq_lower_limit;
Data.par.fast_freq_upper_limit  = DataInput.par.fast_freq_upper_limit;
Data.par.nmcurve                = DataInput.par.nmcurve;
Data.par.total_samples          = DataInput.par.total_samples;
Data.par.time_window            = DataInput.par.time_window;
Data.par.total_surr             = DataInput.par.total_surr;

end

