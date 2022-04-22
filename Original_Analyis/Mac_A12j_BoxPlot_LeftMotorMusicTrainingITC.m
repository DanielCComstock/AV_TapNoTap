



MusicianIDX = [1 2 3 9 10 13 17 18];
nonMuscianIDX = [4 5 6 7 8 11 12 14 15 16];

splitTotalf0ITC = nan(10,8);

musicleftMotorITCData = f0ITC_LMotor(MusicianIDX,:);
nonMusicleftMotorITCData = f0ITC_LMotor(nonMuscianIDX,:);

splitTotalf0ITC(1:8,1) = musicleftMotorITCData(:,1);
splitTotalf0ITC(1:8,2) = musicleftMotorITCData(:,2);
splitTotalf0ITC(1:8,3) = musicleftMotorITCData(:,3);
splitTotalf0ITC(1:8,4) = musicleftMotorITCData(:,4);
splitTotalf0ITC(1:10,5) = nonMusicleftMotorITCData(:,1);
splitTotalf0ITC(1:10,6) = nonMusicleftMotorITCData(:,2);
splitTotalf0ITC(1:10,7) = nonMusicleftMotorITCData(:,3);
splitTotalf0ITC(1:10,8) = nonMusicleftMotorITCData(:,4);

%13,14, 16,17, 19,20, 22,23

figure;
% subplot(2,1,1)
set(gcf,'Position',[100 100 450 300])
bh = boxplot(splitTotalf0ITC,'Notch','on','positions',[1,2, 4,5, 8,9 11,12],'Widths',0.6);
title('Music Training Left Motor ITC at f0', 'FontSize', 16, 'FontWeight','bold','FontName','Helvetica');
color = ['r','b','r','b','r','b','r','b'];
bx = findobj('Tag','boxplot');
set(bx.Children(17:56),'Color','k','LineWidth',1);
set(bx.Children(9:17),'Color','k','LineWidth',2.5); % sets median lines thicker
ylim([0 1.2]);
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    set(h(j),'Color',color(j), 'LineWidth',2);
    patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',.3,'LineStyle','none');
 
 end
set(bx.Children(17:56),'Color','k','LineWidth',1);

set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
set(gcf,'color','w');
ylabel('ITC', 'FontSize',14,'FontName','Helvetica','FontWeight', 'bold');
set(gca,'xtick',[1.5, 4.5, 8.5, 11.5], 'xticklabel',{'Auditory', 'Visual','Auditory', 'Visual'});
set(gca,'ytick',[0, 0.2, 0.4, 0.6, 0.8, 1], 'yticklabel',{'0', '0.2','0.4', '0.6','0.8', '1'});





