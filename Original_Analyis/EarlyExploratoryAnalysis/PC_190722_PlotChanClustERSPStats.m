%% Plot ERSP & ITC Figures from AV_Omit


clear
eeglab



    
loadpath = 'H:\Data\AV_TapNoTap\07_Figures\ERSP_Stats_Data\';
savepath = 'H:\Data\AV_TapNoTap\07_Figures\ERSP_Stats_Figures\';

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

    hold on
    [tmpc tmph] = contour(times, freqs, tmpersp05, 'levels', 1); % computes contours around p05 signinicant areas
    set(tmph, 'linecolor', 'k', 'LineWidth', 1.5,'LineStyle','--'); % adds black dotted contour lines around P05 areas
    [tmpc2 tmph2] = contour(times, freqs, tmpersp01, 'levels', 1); % computes contours around P01 signinicant areas
    set(tmph2, 'linecolor', 'k', 'LineWidth', 1.5,'LineStyle','-'); % adds black solid contour lines around P01 areas
    hold off
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


    clear nsets freqs times ersp itc avgersp erspmax erspminmax pvals tmpersp05 tmpersp01;


end;

