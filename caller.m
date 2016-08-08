%% Routine caller

% This routine calls the main methods used in the paper of
% Scheffer-Teixeira & Tort (2016) published in eLife.


% Select folder where files are located and add path
path = uigetdir;
addpath(genpath(path))

%%

clear all
close all
clc

% Define desired signal type: choose one at a time

% DataInput.signal_type = 'white_noise';
DataInput.signal_type = 'real_lfp'; 


% Define desired surrogate methods: you can choose more than one
DataInput.surrogates{1} = 'permutation';
DataInput.surrogates{2} = 'shift';
DataInput.surrogates{3} = 'scramble';

% Define some parameters

% lower band of the slower signal
DataInput.par.slow_freq_lower_limit = 4;

% upper band of the slower signal (for real signals,
% the upper limit we used for theta was 20 instead of 12)
DataInput.par.slow_freq_upper_limit = 12;

% lower band of the faster signal
DataInput.par.fast_freq_lower_limit = 30; 

% upper band of the faster signal
DataInput.par.fast_freq_upper_limit = 50; 

% n:m curve plot
DataInput.par.nmcurve               = 1:20; 

% sampling rate
DataInput.par.sampling_rate         = 1000; 

% samples from the signal using the time window value
DataInput.par.total_samples         = 300;    

% time window for consecutive points (in seconds)
DataInput.par.time_window           = 1;

% quantity of subsurrogates (in our paper we used 100)
DataInput.par.total_surr            = 2;    


% Analyze and update Data
Data = main_caller(DataInput);


