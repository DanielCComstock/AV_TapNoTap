figpath = 'H:\Data\AV_TapNoTap\06_Figures\Component_Figs\';
figDataPath='H:\Data\AV_TapNoTap\06_Figures\Component_Figs\FigData\';

clusts = [3 9 12 13];

names = ['Aud Control'; 'Aud Tapping'; 'Vis Control'; 'Vis Tapping'];
name = cellstr(names);

for i = 2:5
    % Select Study design  
    STUDY = std_selectdesign(STUDY, ALLEEG, i);
    % set name for figs and study design
    tempname = char(name(i-1));
    for m = 1:4
        
        %Set name for channel
        tempchan = num2str(clusts(m));
        
        % Save ERSP values. Note that specific channel will have to be specified.
       
        [STUDY itc times freqs ] = std_erspplot(STUDY,ALLEEG,'clusters',clusts(m),'datatype', 'itc','plotmode','none'); % ERSP plot for cluster 13, and saves the ersp, times, and freqs output as variables
        % Save Normal ERSP
        ftitle = ['ITC ' tempname ' - ' tempchan];
       
        avgersp = mean(itc{1},3); % average ERSP for all subjects
        avgersp = abs(avgersp);
        erspmax = [max(max(avgersp))]; % Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
        erspminmax = [-erspmax erspmax];
        cbarminmax = [0 erspmax];
        figure; imagesc(times, freqs, avgersp,erspminmax); % main plot function
        set(gca, 'ydir', 'normal'); % sets scaling direction
        set(gcf, 'color','w'); %sets background color to white
        xlim([-300 1250]); %define x axis limits
        ylim([3 43]); % define y axis limits
        set(gca, 'FontSize', 13, 'FontWeight', 'bold'); % set axis font
        title(ftitle, 'FontSize', 18, 'FontWeight','bold'); % add title
        xlabel('Time (ms)', 'FontSize',15, 'FontWeight', 'bold'); % x axis label
        ylabel('Frequencies (Hz)', 'FontSize',15, 'FontWeight', 'bold'); % y axis label
        c=colorbar;% adds colorbar to side showing color scale. Scale determined by erspminma
        c.Label.String = 'ITC'; % add dB label to color bar
        c.Label.Position = [.5 erspmax*1.07]; % place dB at top of bar
        c.Label.Rotation = 0; % have dB be horizontal
        c.Limits = cbarminmax;
        colormap jet; % set color scheme
        line([0 0],[3 43],'color','k', 'LineWidth',1, 'LineStyle','--'); % add dashed line at 0 on x axis
        line([600 600],[3 43],'color','k', 'LineWidth',1, 'LineStyle','--'); % add dashed line at 600 on x axis
        line([1200 1200],[3 43],'color','k', 'LineWidth',1, 'LineStyle','--'); % add dashed line at 600 on x axis
        % next 4 lines add line around plot
        line([-300 -300],[3 43],'color','k', 'LineWidth',1);
        line([1250 1250],[3 43],'color','k', 'LineWidth',1);
        line([-300 1250],[3 3],'color','k', 'LineWidth',1);
        line([-300 1250],[43 43],'color','k', 'LineWidth',1);
        
        % Save Stats ERSP
        fullpath = [figpath tempchan '_' tempname '_ITC'];
        savefig(fullpath);
        close;
        
        

        
        
        
    end
end