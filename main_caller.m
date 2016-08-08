%% Receive data from caller and distribute

function Data = main_caller(DataInput)

% Load data format
Data = data_architecture(DataInput);

% interpret desired data
fprintf('Loading data\n')
I_string_signal_type = strcmp(Data.signal_type,DataInput.signal_type);

clear FileName PathName
if(strcmp('real_lfp',DataInput.signal_type))
    
    fprintf('Select all sessions (animals) to load in ''.mat'' format)\n')
    [FileName,PathName,FilterIndex] = uigetfile('*.mat','Select all sessions (animals) to load in ''.mat'' format)','MultiSelect','on');
    
    if(~iscell(FileName))
        FileName = {FileName};
    end
    
else
    
    FileName{1} = 'simulated_signal';
    PathName{1} = 'Local_Path';
end




fprintf('Initialize analyses\n')

count_ses = 0;
for ses = 1:size(FileName,2)
    count_ses = count_ses + 1;
    
    [Data] = load_data(Data,FileName{ses},PathName,I_string_signal_type);
    
    count_ch = 0;
    for ch = 1:size(Data.LFP,1)
        count_ch = count_ch + 1;
        
        
        fprintf('Phase phase analysis\n')
        
        [Data.results.session(count_ses).channel(count_ch).r] = phase_phase(Data,ch,count_ses);
        [Data.results.session(count_ses).channel(count_ch).PhaseCounts Data.results.session(count_ses).channel(count_ch).PhaseBin] = phase_phase_histogram(Data,ch);
        
        if isfield(DataInput,'surrogates')
            
            
            % organizing different input formats
            I_string_surr = [];
            con2 = 0;
            for uu = 1:size(DataInput.surrogates,2)
                I_string = find(strcmp(Data.surrogates,DataInput.surrogates{uu}));
                if(~isempty(I_string))
                    con2 = con2 + 1;
                    I_string_surr(con2,:) = I_string;
                end
            end
            I_string_surr = sort(I_string_surr)';
            
            
            for ss = I_string_surr
                
                switch(ss)
                    case 1
                        fprintf('Random Permutation phase analysis\n')
                        [Data.results.session(count_ses).channel(count_ch).r_surr_randperm.single Data.results.session(count_ses).channel(count_ch).r_surr_randperm.pooled] = surrogate_randperm(Data,ch,count_ses);
                        
                    case 2
                        fprintf('Shift phase analysis\n')
                        [Data.results.session(count_ses).channel(count_ch).r_surr_shift.single Data.results.session(count_ses).channel(count_ch).r_surr_shift.pooled] = surrogate_shift(Data,ch,count_ses);
                        
                    case 3
                        fprintf('Scramble phase analysis\n')
                        [Data.results.session(count_ses).channel(count_ch).r_surr_scramble.single Data.results.session(count_ses).channel(count_ch).r_surr_scramble.pooled] = surrogate_scramble(Data,ch,count_ses);
                end
                
            end
            
        end

         plot_phase_histogram(Data,ch,ses)
         
    end
    Data = rmfield(Data,'LFP');
end

plot_phase_phase(Data)


end

