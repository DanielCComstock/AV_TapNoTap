


MusicianIDX = [1 2 3 9 10 13 17 18];
nonMuscianIDX = [4 5 6 7 8 11 12 14 15 16];


musicLeftMotorITCData = f0ITC_LMotor(MusicianIDX,:);
nonMusicLeftMotorITCData = f0ITC_LMotor(nonMuscianIDX,:);

splitTotalITC = nan(10,16);

splitTotalITC(1:8,1) = musicLeftMotorITCData(:,1);
splitTotalITC(1:8,3) = musicLeftMotorITCData(:,2);
splitTotalITC(1:8,5) = musicLeftMotorITCData(:,3);
splitTotalITC(1:8,7) = musicLeftMotorITCData(:,4);
splitTotalITC(1:10,2) = nonMusicLeftMotorITCData(:,1);
splitTotalITC(1:10,4) = nonMusicLeftMotorITCData(:,2);
splitTotalITC(1:10,6) = nonMusicLeftMotorITCData(:,3);
splitTotalITC(1:10,8) = nonMusicLeftMotorITCData(:,4);

musicGrandAvgITCData = f0ITC_avg(MusicianIDX,:);
nonMusicGrandAvgITCData = f0ITC_avg(nonMuscianIDX,:);

splitTotalITC(1:8,1+8) = musicGrandAvgITCData(:,1);
splitTotalITC(1:8,3+8) = musicGrandAvgITCData(:,2);
splitTotalITC(1:8,5+8) = musicGrandAvgITCData(:,3);
splitTotalITC(1:8,7+8) = musicGrandAvgITCData(:,4);
splitTotalITC(1:10,2+8) = nonMusicGrandAvgITCData(:,1);
splitTotalITC(1:10,4+8) = nonMusicGrandAvgITCData(:,2);
splitTotalITC(1:10,6+8) = nonMusicGrandAvgITCData(:,3);
splitTotalITC(1:10,8+8) = nonMusicGrandAvgITCData(:,4);

%13,14, 16,17, 19,20, 22,23

figure;
% subplot(2,1,1)
set(gcf,'Position',[100 100 450 300])
bh = boxplot(splitTotalITC,'Notch','on','positions',[1,2, 4,5, 7,8, 10,11, 14,15, 17,18, 20,21, 23,24],'Widths',0.6);
title('ITC at f0', 'FontSize', 16, 'FontWeight','bold','FontName','Helvetica');
color = ['r','b','r','b','r','b','r','b','r','b','r','b','r','b','r','b'];
bx = findobj('Tag','boxplot');
set(bx.Children(33:112),'Color','k','LineWidth',1);
set(bx.Children(17:32),'Color','k','LineWidth',2); % sets median lines thicker
% %ylim([-5 81]);
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    set(h(j),'Color',color(j), 'LineWidth',2);
    patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',.3,'LineStyle','none');
 
 end


set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
set(gcf,'color','w');
ylabel('ITC', 'FontSize',14,'FontName','Helvetica','FontWeight', 'bold');
set(gca,'xtick',[1.5, 4.5, 7.5, 10.5, 14.5, 17.5, 20.5, 23.5], 'xticklabel',{'Aud Still', 'Aud Tap','Vis Still', 'Vis Tap','Aud Still', 'Aud Tap','Vis Still', 'Vis Tap'});





