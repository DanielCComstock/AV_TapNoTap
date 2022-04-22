%% Plot ERSP & ITC Figures from AV_Omit


clear
eeglab

for i =1:2
    
    loadpathstart = 'H:\Data\AV_TapNoTap\';
    if i==1
        loadkey = '06a_TF_Chan\';
    else
        loadkey = '06b_TF_Clus\';
    end
    
    loadpath = [loadpathstart loadkey];
    savepath = [loadpathstart '07_Figures\'];

    allFiles = dir([loadpath,'*.mat']);
    for j = 1:length(allFiles)
        %% Load ERSP Data
        
        
        loadFile = allFiles(j).name;
        savename = loadFile(1:end-4);
        

        % Load data
        loadname = [loadpath loadFile];
        load(loadname);
        
        titlename = loadFile(1:end-4);
        titlename = strrep(titlename, '_',' ');
        titlename = ['ERSP - ' titlename];
        
        %% Format data for plots      
        
        % get number of TF sets
        nsets = size(TF_data,2);

        % get freqs & times
        freqs = TF_data(1).freqs;
        times = TF_data(1).times; 

        % concatenate ersp
        for k = 1:nsets
            ersp(:,:,k)=TF_data(k).ersp;
            itc(:,:,k)=TF_data(k).itc;
        end


        % average ERSP accross components/subjects
        avgersp = mean(ersp,3); 

        % Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
        erspmax = [max(max(abs(avgersp)))];

        % convert absolute highest ERSP values for symetrical scale
        erspminmax = [-erspmax erspmax]; 
        
        % Calculate absolute values for itc
        absITC = abs(itc);
        
        % average itc accross components
        avgITC = mean(absITC,3); 

        % Compute absolute highest itc values in the Average itc for symetrical scalling
        itcmax = [max(max(avgersp))];

        % convert absolute highest itc values for symetrical scale
        itcminmax = [-itcmax itcmax]; 
        
        

        %% ERSP Plot
        
        
        
        figure; imagesc(times, freqs, avgersp, erspminmax); % main plot function
        set(gca, 'ydir', 'normal'); % sets scaling direction
        set(gca, 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth',1);
        set(gcf, 'color','w');
        ax = gca;
        ax.XTick = [-600 -300 0 300 600 900 1200];
        ax.XTickLabel = {'-600', '-300', '0', '300', '600', '900', '1200'};
        xlim([-900 1500]);
        ylim([6 35]);
        
%         hold on
%         [tmpc tmph] = contour(times, freqs, tmpersp05, 'levels', 1); % computes contours around p05 signinicant areas
%         set(tmph, 'linecolor', 'k', 'LineWidth', 1.5,'LineStyle','--'); % adds black dotted contour lines around P05 areas
%         [tmpc2 tmph2] = contour(times, freqs, tmpersp01, 'levels', 1); % computes contours around P01 signinicant areas
%         set(tmph2, 'linecolor', 'k', 'LineWidth', 1.5,'LineStyle','-'); % adds black solid contour lines around P01 areas
%         hold off
        xlabel('Time (ms)', 'FontSize',12, 'FontWeight', 'bold'); % x axis label
        ylabel('Frequencies (Hz)', 'FontSize',12, 'FontWeight', 'bold'); % y axis label
        
        title(titlename, 'FontSize', 12, 'FontWeight','bold');
        c=colorbar;% adds colorbar to side showing color scale. Scale determined by erspminma
        c.Label.String = 'dB';
        c.Label.Position = [.5 erspmax*1.1];
        c.Label.Rotation = 0;
        %add lines at stimulus onset
        line([0 0],[6 35],'color','k', 'LineWidth', 2, 'LineStyle',':');
        line([600 600],[6 35],'color','k', 'LineWidth', 2, 'LineStyle',':');
        line([1200 1200],[6 35],'color','k', 'LineWidth', 2, 'LineStyle',':');
        line([-600 -600],[6 35],'color','k', 'LineWidth', 2, 'LineStyle',':');
        
        colormap jet;
        
        %% Save Figure %%
        
        fullsave = [savepath 'ERSP_' savename];
        savefig(fullsave);
        close;
        
        %% Plot ITC 
        
        titlename = loadFile(1:end-4);
        titlename = strrep(titlename, '_',' ');
        titlename = ['ITC - ' titlename];
        
        % Calculate absolute values for itc
        absITC = abs(itc);
        % average itc accross components
        avgITC = mean(absITC,3); 

        % Compute absolute highest itc values in the Average itc for symetrical scalling
        itcmax = [max(max(avgersp))];

        % convert absolute highest itc values for symetrical scale
        itcminmax = [-itcmax itcmax]; 
               
        figure; imagesc(times, freqs, avgITC, itcminmax); % main plot function
        set(gca, 'ydir', 'normal'); % sets scaling direction
        set(gca, 'FontSize', 12, 'FontWeight', 'bold', 'LineWidth',1);
        set(gcf, 'color','w');
        ax = gca;
        ax.XTick = [-600 -300 0 300 600 900 1200];
        ax.XTickLabel = {'-600', '-300', '0', '300', '600', '900', '1200'};
        xlim([-900 1500]);
        ylim([6 35]);
        xlabel('Time (ms)', 'FontSize',12, 'FontWeight', 'bold'); % x axis label
        ylabel('Frequencies (Hz)', 'FontSize',12, 'FontWeight', 'bold'); % y axis label        
        title(titlename, 'FontSize', 12, 'FontWeight','bold');
        c=colorbar;% adds colorbar to side showing color scale. Scale determined by erspminma
        c.Label.String = 'ITC';
        c.Label.Position = [.5 itcmax*1.05];
        c.Label.Rotation = 0;
        set(c,'Ylim',[0 itcmax])
        %add lines at stimulus onset
        line([0 0],[6 35],'color','k', 'LineWidth', 2, 'LineStyle',':');
        line([600 600],[6 35],'color','k', 'LineWidth', 2, 'LineStyle',':');
        line([1200 1200],[6 35],'color','k', 'LineWidth', 2, 'LineStyle',':');
        line([-600 -600],[6 35],'color','k', 'LineWidth', 2, 'LineStyle',':');
        
        colormap jet;
        
        %% Save Figure %%
        
        fullsave = [savepath 'ITC_' savename];
        savefig(fullsave);
        close;

        clear nsets freqs times ersp itc avgersp erspmax erspminmax pvals tmpersp05 tmpersp01;
        
        
    end;
end;
