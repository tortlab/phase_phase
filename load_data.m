%% Load or generate data according to caller
% arguments are passed by main_caller

function [Data] = load_data(Data,file,path,I_string_signal_type)

I_str = find(I_string_signal_type == 1);
switch(I_str)
    case 1 % Real data: ask for input
         
        load([path file]);
        Data.LFP = LFP;
        if size(Data.LFP,1) > size(Data.LFP,2)
            Data.signal.LFP = Data.LFP';
        end
        
    case 2
        
        T = input('Signal duration (in seconds)\n');
        Data.LFP = randn(1,T*Data.par.sampling_rate);
        
        
end





