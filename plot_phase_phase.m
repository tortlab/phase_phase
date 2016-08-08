%% Plot nm curve and boxplots for maximum nm

function plot_phase_phase(Data)

fprintf('All sessions x channels will be joined.\n')

r_original          = [];
r_perm_single       = [];
r_perm_pool         = [];
r_shift_single      = [];
r_shift_pool        = [];
r_scramble_single   = [];
r_scramble_pool     = [];

for sss = 1:size(Data.results.session,2)
    for ccc = 1:size(Data.results.session(sss).channel,2)
        if isfield(Data.results.session.channel,'r')
            r_original        = [r_original; Data.results.session(sss).channel(ccc).r];
        end
        
        if isfield(Data.results.session.channel,'r_surr_randperm')
            
            if isfield(Data.results.session.channel.r_surr_randperm,'single')
                r_perm_single     = [r_perm_single; Data.results.session(sss).channel(ccc).r_surr_randperm.single];
            end
            
            if isfield(Data.results.session.channel.r_surr_randperm,'pooled')
                r_perm_pool       = [r_perm_pool; Data.results.session(sss).channel(ccc).r_surr_randperm.pooled];
            end
        end
        
        
        if isfield(Data.results.session.channel,'r_surr_shift')
            
            if isfield(Data.results.session.channel.r_surr_shift,'single')
                r_shift_single    = [r_shift_single; Data.results.session(sss).channel(ccc).r_surr_shift.single];
            end
            
            if isfield(Data.results.session.channel.r_surr_shift,'pooled')
                r_shift_pool      = [r_shift_pool; Data.results.session(sss).channel(ccc).r_surr_shift.pooled];
            end
            
        end
        
        
        
        if isfield(Data.results.session.channel,'r_surr_scramble')
            
            if isfield(Data.results.session.channel.r_surr_scramble,'single')
                r_scramble_single = [r_scramble_single; Data.results.session(sss).channel(ccc).r_surr_scramble.single];
            end
            
            if isfield(Data.results.session.channel.r_surr_scramble,'pooled')
                r_scramble_pool   = [r_scramble_pool; Data.results.session(sss).channel(ccc).r_surr_scramble.pooled];
            end
        end
        
        
    end
end

[val I_max_nm] = max(mean(r_original,1));
AllData = [];

color_string = {'k','r','b','g','y','m','c'};
figure

hold on
clear legend_info h
keep_count = 0;
if ~isempty(r_original)
    keep_count = keep_count + 1;
    AllData(:,keep_count) = r_original(:,I_max_nm);
    legend_info{keep_count} = ['Original'];
    h(keep_count) = plot(Data.par.nmcurve,mean(r_original,1),color_string{keep_count})
end

if ~isempty(r_perm_single)
    keep_count = keep_count + 1;
    AllData(:,keep_count) = r_perm_single(:,I_max_nm);
    legend_info{keep_count} = ['Rand. Perm. Single'];
    h(keep_count) = plot(Data.par.nmcurve,mean(r_perm_single,1),color_string{keep_count})
end

if ~isempty(r_perm_pool)
    keep_count = keep_count + 1;
    AllData(:,keep_count) = r_perm_pool(:,I_max_nm);
    legend_info{keep_count} = ['Rand. Perm. Pooled'];
    h(keep_count) = plot(Data.par.nmcurve,mean(r_perm_pool,1),color_string{keep_count})
end

if ~isempty(r_shift_single)
    keep_count = keep_count + 1;
    AllData(:,keep_count) = r_shift_single(:,I_max_nm);
    legend_info{keep_count} = ['Shift Single'];
    h(keep_count) = plot(Data.par.nmcurve,mean(r_shift_single,1),color_string{keep_count})
end

if ~isempty(r_shift_pool)
    keep_count = keep_count + 1;
    AllData(:,keep_count) = r_shift_pool(:,I_max_nm);
    legend_info{keep_count} = ['Shift Pooled'];
    h(keep_count) = plot(Data.par.nmcurve,mean(r_shift_pool,1),color_string{keep_count})
end

if ~isempty(r_scramble_single)
    keep_count = keep_count + 1;
    AllData(:,keep_count) = r_scramble_single(:,I_max_nm);
    legend_info{keep_count} = ['Scramble Single'];
    h(keep_count) = plot(Data.par.nmcurve,mean(r_scramble_single,1),color_string{keep_count})
end


if ~isempty(r_scramble_pool)
    keep_count = keep_count + 1;
    AllData(:,keep_count) = r_scramble_pool(:,I_max_nm);
    legend_info{keep_count} = ['Scramble Pooled'];
    h(keep_count) = plot(Data.par.nmcurve,mean(r_scramble_pool,1),color_string{keep_count});
end


xlabel('n:m')
ylabel('Mean Vector Length (r)')
set(gcf,'color','w')
legend(h,legend_info)
hold off

figure
h = boxplot(AllData,'labels',legend_info);
set(gcf,'color','w')
set(h(7,:),'Visible','off')


end


