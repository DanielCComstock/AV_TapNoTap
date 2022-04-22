% transform data to ready for statistical analysis and boxplots

clear

ITCPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/08b_Avgf02Plots/data/ITC_AvgAll_.mat';
PowerPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/08c_Indf02Plots/data/Pow_AvgAll_.mat';


plotSavePath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/09_f02Mu_BoxPlots/';
statsSavePath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/10_f02Mu_Stats/';

% Load ITC data

load(ITCPath);

% extract f0 ITC

for conIDX = 1:4
    tempITCdata = mean(statsData.data(conIDX).tfData(7,:,:),2); % avg across trials at 1.666 hz
    ITCData(:,conIDX) = squeeze(tempITCdata);
    clear tempITCdata
end

clear statsData 


% Load PowerData

load(PowerPath);

% extract Mu and f0 power data

for conIDX = 1:4
    tempMuData = mean(statsData.muData(:,:,conIDX),1); % avg across mu freqs
    tempf0Data = statsData.neighborCorrectedData(7,:,conIDX); % extract power at 1.666Hz
    MuData(:,conIDX) = squeeze(tempMuData);
    f0PowData(:,conIDX) = squeeze(tempf0Data);
    clear tempMuData tempf0Data
end

clear statsData


%% Plot ITC data
figure;
set(gcf,'Position',[100 100 450 300])
bh = boxplot(ITCData,'Notch','on','positions',[1,2,3,4],'Widths',0.6);
title('All Components f0 ITC', 'FontSize', 16, 'FontWeight','bold','FontName','Helvetica');
color = ['r','r','b','b',];
bx = findobj('Tag','boxplot');
set(bx.Children(9:28),'Color','k','LineWidth',1.5);
set(bx.Children(5:8),'Color','k','LineWidth',2.5); % sets median lines thicker
 
h = findobj(gca,'Tag','Box');
for j=1:length(h)
%    %set(h(j),'Color',color(j), 'LineWidth',2);
     patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',.3,'LineStyle','none');

end


set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
set(gcf,'color','w');
ylabel('ITC', 'FontSize',14,'FontName','Helvetica','FontWeight', 'bold');
set(gca,'xtick',[1,2,3,4], 'xticklabel',{'Aud Con','Aud Tap', 'Vis Con', 'Vis Tap'});

figSave = [plotSavePath 'fig/ITC_AllComp'];
pngSave = [plotSavePath 'png/ITC_AllComp'];
dataSave = [plotSavePath 'data/ITC_AllComp'];

savefig(figSave);
saveas(gcf,pngSave,'png');
save(dataSave, 'ITCData');

close;

%% Plot Mu data
figure;
set(gcf,'Position',[100 100 450 300])
bh = boxplot(MuData,'Notch','on','positions',[1,2,3,4],'Widths',0.6);
title('All Components Mu Power', 'FontSize', 16, 'FontWeight','bold','FontName','Helvetica');
color = ['r','r','b','b',];
bx = findobj('Tag','boxplot');
set(bx.Children(9:28),'Color','k','LineWidth',1.5);
set(bx.Children(5:8),'Color','k','LineWidth',2.5); % sets median lines thicker
% ylim([-5 81]);
h = findobj(gca,'Tag','Box');
for j=1:length(h)
%    %set(h(j),'Color',color(j), 'LineWidth',2);
     patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',.3,'LineStyle','none');

end


set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
set(gcf,'color','w');
ylabel('Power', 'FontSize',14,'FontName','Helvetica','FontWeight', 'bold');
set(gca,'xtick',[1,2,3,4], 'xticklabel',{'Aud Con','Aud Tap', 'Vis Con', 'Vis Tap'});

figSave = [plotSavePath 'fig/Mu_AllComp'];
pngSave = [plotSavePath 'png/Mu_AllComp'];
dataSave = [plotSavePath 'data/Mu_AllComp'];

savefig(figSave);
saveas(gcf,pngSave,'png');
save(dataSave, 'MuData');

close;


%% Plot f0 Power data
figure;
set(gcf,'Position',[100 100 450 300])
bh = boxplot(f0PowData,'Notch','on','positions',[1,2,3,4],'Widths',0.6);
title('All Components f0 Power', 'FontSize', 16, 'FontWeight','bold','FontName','Helvetica');
color = ['r','r','b','b',];
bx = findobj('Tag','boxplot');
set(bx.Children(9:28),'Color','k','LineWidth',1.5);
set(bx.Children(5:8),'Color','k','LineWidth',2.5); % sets median lines thicker
% ylim([-10 20]);
h = findobj(gca,'Tag','Box');
for j=1:length(h)
%    %set(h(j),'Color',color(j), 'LineWidth',2);
     patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',.3,'LineStyle','none');

end


set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
set(gcf,'color','w');
ylabel('Power', 'FontSize',14,'FontName','Helvetica','FontWeight', 'bold');
set(gca,'xtick',[1,2,3,4], 'xticklabel',{'Aud Con','Aud Tap', 'Vis Con', 'Vis Tap'});

figSave = [plotSavePath 'fig/Pow_AllComp'];
pngSave = [plotSavePath 'png/Pow_AllComp'];
dataSave = [plotSavePath 'data/Pow_AllComp'];

savefig(figSave);
saveas(gcf,pngSave,'png');
save(dataSave, 'f0PowData');

close;
clear
    
	