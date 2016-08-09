%% Caller routine

% This routine calls the main methods used in Scheffer-Teixeira & Tort, eLife 2016.

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


% Define surrogate methods; you can choose more than one. 
% Comment out the line to skip a given method.
DataInput.surrogates{1} = 'permutation';
DataInput.surrogates{2} = 'shift';
DataInput.surrogates{3} = 'scramble';

% Define analysis parameters

% lower band of the slower signal (in Hz)
DataInput.par.slow_freq_lower_limit = 4;

% upper band of the slower signal (for real signals,
% we used 20 Hz; for white noise, we used 12 Hz)
DataInput.par.slow_freq_upper_limit = 20;

% lower band of the faster signal (in Hz)
DataInput.par.fast_freq_lower_limit = 30; 

% upper band of the faster signal (in Hz)
DataInput.par.fast_freq_upper_limit = 50; 

% define n:m ratios for the Rnm curve
DataInput.par.nmcurve               = 1:20; 

% sampling rate (in Hz)
DataInput.par.sampling_rate         = 1000; 

% number of samples to be extracted from the signal
DataInput.par.total_samples         = 300;    

% length of each sample (in seconds; consecutive points are analyzed)
DataInput.par.time_window           = 1;

% number of surrogate runs per original run (in our paper we used 100)
DataInput.par.total_surr            = 10;    


% Analyze and update Data
Data = main_caller(DataInput);


