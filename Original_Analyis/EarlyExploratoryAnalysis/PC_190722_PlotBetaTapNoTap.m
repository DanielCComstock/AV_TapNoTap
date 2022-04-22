%% Script to plot Freq Band Plots wide & Narrow Theta & Beta, and save output for slope measurements
 % For theta beta plots load data for beta (TF_data) and data for theta (TF_dataTheta)
 

%% Load data sets
clear
newgreen = [0, 0.7, 0]; % NoTap Color
purple = [0.8, 0, 0.8]; % Tap Color

for i = 1:2 % 1 = channel 2 = cluster
    
    loadpathstart = 'H:\Data\AV_TapNoTap\';
    if i==1
        loadkey = '06a_TF_Chan\';
    else
        loadkey = '06b_TF_Clus\';
    end
    
    loadpathbeta = [loadpathstart loadkey];
    
    figsavepath = 'H:\Data\AV_TapNoTap\07_Figures\BetaPlots\';


    allFiles = dir([loadpathbeta,'*.mat']);
    af={allFiles.name};
    
    % get only single modality files files
    Mod = strfind(af,'NoTap');

    ModInd = find(~cellfun('isempty',Mod));
    ModFiles = af(ModInd);

    

    for j = 1:length(ModFiles)

        loadFile = ModFiles{j};
        savename = loadFile(1:end-9);
        

        % Load data
        NoTaploadname = [loadpathbeta loadFile];
        Taploadname = [loadpathbeta loadFile(1:end-9) 'Tap.mat'];
        
        
        
        titlename = loadFile(1:end-10);
        titlename = strrep(titlename, '_',' ');
        

 
     %% Transform Beta activity NoTap

        load(NoTaploadname);
        % get number of TF sets
        cnsets = size(TF_data,2);

        % get freqs & times
        cbfreqs = TF_data(1).freqs;
        cbtimes = TF_data(1).times; 

        % concatenate ersp
        for k = 1:cnsets
            cb_ersp(:,:,k)=TF_data(k).ersp;
        end


        % average ERSP accross components/subjects
        % avg_b_ersp = mean(b_ersp,3);

        % get beta indicies
        cbetaIndices = find (cbfreqs <= 28 & cbfreqs >= 15);

        % Get just beta power for all subjects/components. This is used for
        % plotting standard error as well as for slope data
        callBetaPower = mean(cb_ersp([cbetaIndices],:,:));
        callBetaPower = squeeze(callBetaPower);

        % Compute average beta power accross all subjects/components
        cmeanBetaPower = mean(callBetaPower,2);

        % Compute standard error for beta
        cbetaErrorBar = std(callBetaPower.')/sqrt(size(callBetaPower,2));
        
        %% Transform Beta activity Tap
        
        load(Taploadname);
        
        % get number of TF sets
        onsets = size(TF_data,2);

        % get freqs & times
        obfreqs = TF_data(1).freqs;
        obtimes = TF_data(1).times; 

        % concatenate ersp
        for k = 1:onsets
            ob_ersp(:,:,k)=TF_data(k).ersp;
        end


        % average ERSP accross components/subjects
        % avg_b_ersp = mean(b_ersp,3);

        % get beta indicies
        obetaIndices = find (obfreqs <= 28 & obfreqs >= 15);

        % Get just beta power for all subjects/components. This is used for
        % plotting standard error as well as for slope data
        oallBetaPower = mean(ob_ersp([obetaIndices],:,:));
        oallBetaPower = squeeze(oallBetaPower);

        % Compute average beta power accross all subjects/components
        omeanBetaPower = mean(oallBetaPower,2);

        % Compute standard error for beta
        obetaErrorBar = std(oallBetaPower.')/sqrt(size(oallBetaPower,2));
  




        %% Plot Beta & Theta Error bar plot


        figure;
        % Control Plot
        shadedErrorBar2(cbtimes, cmeanBetaPower, cbetaErrorBar,...
            'lineprops',{'--', 'Color',newgreen, 'LineWidth', 3,'markerfacecolor',newgreen});
        hold on;
        % Omit Plot
        shadedErrorBar2(obtimes, omeanBetaPower, obetaErrorBar,...
            'lineprops',{'-', 'Color',purple, 'LineWidth', 3,'markerfacecolor',purple});
        hold off;

        % Plot parameters
        set(gca, 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth',1.5);
        set(gcf, 'color','w');
        box on;
        ax = gca;
        ax.XTick = [ -600 -300 0 300 600 900 1200];
        ax.XTickLabel = {'-600', '-300', '0', '300', '600', '900', '1200'};
         xlim([-900 1500]);
        yl = ylim;
        yl= yl*1.1;
        ylim([yl]);
        xl = xlim;
        % add lines at stimulus onset
        line([0 0],[yl],'color','k', 'LineWidth', 2, 'LineStyle',':');
        line([600 600],[yl],'color','k', 'LineWidth', 2, 'LineStyle',':');
        line([1200 1200],[yl],'color','k', 'LineWidth', 2, 'LineStyle',':');
        line([-600 -600],[yl],'color','k', 'LineWidth', 2, 'LineStyle',':');

        xlabel('Time (ms)', 'FontSize',12, 'FontWeight', 'bold'); % x axis label
        ylabel('dB', 'FontSize',12, 'FontWeight', 'bold'); % y axis label
        title(titlename, 'FontSize', 12, 'FontWeight','bold'); % add title
        
        
        fullsave = [figsavepath 'BetaTapNoTap_' savename];
        savefig(fullsave)
        close;

       
    end
end
    