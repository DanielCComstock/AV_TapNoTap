% transform data to ready for statistical analysis and boxplots

clear

ITCLeftMotorPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/08b_Avgf02Plots/data/ITC_LeftMotor_.mat';
PowerLeftMotorPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/08c_Indf02Plots/data/Pow_LeftMotor_.mat';

plotSavePath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/09_f02Mu_BoxPlots/';
statsSavePath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/10_f02Mu_Stats/';

% Load ITC Averaged Comp data

load(ITCLeftMotorPath);

% extract f0 ITC

for conIDX = 1:4
    tempITCdata = mean(statsData.data(conIDX).tfData(7,:,:),2); % avg across trials at 1.666 hz
    ITCData(:,conIDX) = squeeze(tempITCdata);
    clear tempITCdata
end

clear statsData tempdata

% load(ITCRightMotorPath);
% 
% for conIDX = 1:4
%     tempITCdata = mean(statsData.data(conIDX).tfData(7,:,:),2); % avg across trials at 1.666 hz
%     ITCData(:,conIDX+4) = squeeze(tempITCdata);
%     clear tempITCdata
% end
% 
% clear statsData 


% Load Power Left Motor Data

load(PowerLeftMotorPath);

% extract Mu and f0 power data

for conIDX = 1:4
    tempMuData = mean(statsData.muData(:,:,conIDX),1); % avg across mu freqs
    tempf0Data = statsData.neighborCorrectedData(7,:,conIDX); % extract power at 1.666Hz
    MuData(:,conIDX) = squeeze(tempMuData);
    f0PowData(:,conIDX) = squeeze(tempf0Data);
    clear tempMuData tempf0Data
end

clear statsData

% Load Power avg comp Data

% load(PowerRightMotorPath);
% 
% % extract Mu and f0 power data
% 
% for conIDX = 1:4
%     tempMuData = mean(statsData.muData(:,:,conIDX),1); % avg across mu freqs
%     tempf0Data = statsData.neighborCorrectedData(7,:,conIDX); % extract power at 1.666Hz
%     MuData(:,conIDX+4) = squeeze(tempMuData);
%     f0PowData(:,conIDX+4) = squeeze(tempf0Data);
%     clear tempMuData tempf0Data
% end
% 
% clear statsData

%% Plot ITC data
figure;
set(gcf,'Position',[100 100 450 300])
bh = boxplot(ITCData,'Notch','on','positions',[1,2,3,4],'Widths',0.6);
title('Left Motor f0 ITC', 'FontSize', 16, 'FontWeight','bold','FontName','Helvetica');
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

figSave = [plotSavePath 'fig/ITC_LeftMotor'];
pngSave = [plotSavePath 'png/ITC_LeftMotor'];
dataSave = [plotSavePath 'data/ITC_LeftMotor'];

savefig(figSave);
saveas(gcf,pngSave,'png');
save(dataSave, 'ITCData');

close;

%% Plot Mu data
figure;
set(gcf,'Position',[100 100 450 300])
bh = boxplot(MuData,'Notch','on','positions',[1,2,3,4],'Widths',0.6);
title('Left Motor Mu Power', 'FontSize', 16, 'FontWeight','bold','FontName','Helvetica');
color = ['r','r','b','b',];
bx = findobj('Tag','boxplot');
set(bx.Children(9:28),'Color','k','LineWidth',1.5);
set(bx.Children(5:8),'Color','k','LineWidth',2.5); % sets median lines thicker
ylim([-5 81]);
h = findobj(gca,'Tag','Box');
for j=1:length(h)
%    %set(h(j),'Color',color(j), 'LineWidth',2);
     patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',.3,'LineStyle','none');

end


set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
set(gcf,'color','w');
ylabel('Power', 'FontSize',14,'FontName','Helvetica','FontWeight', 'bold');
set(gca,'xtick',[1,2,3,4], 'xticklabel',{'Aud Con','Aud Tap', 'Vis Con', 'Vis Tap'});

figSave = [plotSavePath 'fig/Mu_LeftMotor'];
pngSave = [plotSavePath 'png/Mu_LeftMotor'];
dataSave = [plotSavePath 'data/Mu_LeftMotor'];

savefig(figSave);
saveas(gcf,pngSave,'png');
save(dataSave, 'MuData');

close;


%% Plot f0 Power data
figure;
set(gcf,'Position',[100 100 450 300])
bh = boxplot(f0PowData,'Notch','on','positions',[1,2,3,4],'Widths',0.6);
title('Left Motor f0 Power', 'FontSize', 16, 'FontWeight','bold','FontName','Helvetica');
color = ['r','r','b','b',];
bx = findobj('Tag','boxplot');
set(bx.Children(9:28),'Color','k','LineWidth',1.5);
set(bx.Children(5:8),'Color','k','LineWidth',2.5); % sets median lines thicker
ylim([-10 20]);
h = findobj(gca,'Tag','Box');
for j=1:length(h)
%    %set(h(j),'Color',color(j), 'LineWidth',2);
     patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',.3,'LineStyle','none');

end


set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
set(gcf,'color','w');
ylabel('Power', 'FontSize',14,'FontName','Helvetica','FontWeight', 'bold');
set(gca,'xtick',[1,2,3,4], 'xticklabel',{'Aud Con','Aud Tap', 'Vis Con', 'Vis Tap'});

figSave = [plotSavePath 'fig/Pow_LeftMotor'];
pngSave = [plotSavePath 'png/Pow_LeftMotor'];
dataSave = [plotSavePath 'data/Pow_LeftMotor'];

savefig(figSave);
saveas(gcf,pngSave,'png');
save(dataSave, 'f0PowData');

close;
clear
    
	