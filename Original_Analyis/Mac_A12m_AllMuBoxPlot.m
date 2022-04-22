
MusicianIDX = [1 2 3 9 10 13 17 18];
nonMuscianIDX = [4 5 6 7 8 11 12 14 15 16];

% musicLeftMotorMuData = mu_LeftMotorData(MusicianIDX,:);
% nonMusicLeftMotorMuData = mu_LeftMotorData(nonMuscianIDX,:);
% 
% 
%  splitLeftMotorMu = nan(10,8);
% 
% splitLeftMotorMu(1:8,1) = musicLeftMotorMuData(:,1);
% splitLeftMotorMu(1:8,3) = musicLeftMotorMuData(:,2);
% splitLeftMotorMu(1:8,5) = musicLeftMotorMuData(:,3);
% splitLeftMotorMu(1:8,7) = musicLeftMotorMuData(:,4);
% splitLeftMotorMu(1:10,2) = nonMusicLeftMotorMuData(:,1);
% splitLeftMotorMu(1:10,4) = nonMusicLeftMotorMuData(:,2);
% splitLeftMotorMu(1:10,6) = nonMusicLeftMotorMuData(:,3);
% splitLeftMotorMu(1:10,8) = nonMusicLeftMotorMuData(:,4);
% 
% musicGrandAvgMuData = mu_GrandAvgData(MusicianIDX,:);
% nonMusicGrandAvgMuData = mu_GrandAvgData(nonMuscianIDX,:);
% 
% 
% splitGrandAvgMu = nan(10,8);
% 
% splitGrandAvgMu(1:8,1) = musicGrandAvgMuData(:,1);
% splitGrandAvgMu(1:8,3) = musicGrandAvgMuData(:,2);
% splitGrandAvgMu(1:8,5) = musicGrandAvgMuData(:,3);
% splitGrandAvgMu(1:8,7) = musicGrandAvgMuData(:,4);
% splitGrandAvgMu(1:10,2) = nonMusicGrandAvgMuData(:,1);
% splitGrandAvgMu(1:10,4) = nonMusicGrandAvgMuData(:,2);
% splitGrandAvgMu(1:10,6) = nonMusicGrandAvgMuData(:,3);
% splitGrandAvgMu(1:10,8) = nonMusicGrandAvgMuData(:,4);

MusicianIDX = [1 2 3 9 10 13 17 18];
nonMuscianIDX = [4 5 6 7 8 11 12 14 15 16];

musicLeftMotorMuData = mu_LeftMotorData(MusicianIDX,:);
nonMusicLeftMotorMuData = mu_LeftMotorData(nonMuscianIDX,:);

splitTotalMu = nan(10,16);

splitTotalMu(1:8,1) = musicLeftMotorMuData(:,1);
splitTotalMu(1:8,3) = musicLeftMotorMuData(:,2);
splitTotalMu(1:8,5) = musicLeftMotorMuData(:,3);
splitTotalMu(1:8,7) = musicLeftMotorMuData(:,4);
splitTotalMu(1:10,2) = nonMusicLeftMotorMuData(:,1);
splitTotalMu(1:10,4) = nonMusicLeftMotorMuData(:,2);
splitTotalMu(1:10,6) = nonMusicLeftMotorMuData(:,3);
splitTotalMu(1:10,8) = nonMusicLeftMotorMuData(:,4);

musicGrandAvgMuData = mu_GrandAvgData(MusicianIDX,:);
nonMusicGrandAvgMuData = mu_GrandAvgData(nonMuscianIDX,:);

splitTotalMu(1:8,1+8) = musicGrandAvgMuData(:,1);
splitTotalMu(1:8,3+8) = musicGrandAvgMuData(:,2);
splitTotalMu(1:8,5+8) = musicGrandAvgMuData(:,3);
splitTotalMu(1:8,7+8) = musicGrandAvgMuData(:,4);
splitTotalMu(1:10,2+8) = nonMusicGrandAvgMuData(:,1);
splitTotalMu(1:10,4+8) = nonMusicGrandAvgMuData(:,2);
splitTotalMu(1:10,6+8) = nonMusicGrandAvgMuData(:,3);
splitTotalMu(1:10,8+8) = nonMusicGrandAvgMuData(:,4);

%13,14, 16,17, 19,20, 22,23

figure;
% subplot(2,1,1)
set(gcf,'Position',[100 100 450 300])
bh = boxplot(splitTotalMu,'Notch','on','positions',[1,2, 4,5, 7,8, 10,11, 14,15, 17,18, 20,21, 23,24],'Widths',0.6);
title('8 - 13 Hz Power', 'FontSize', 16, 'FontWeight','bold','FontName','Helvetica');
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
ylabel('Power', 'FontSize',14,'FontName','Helvetica','FontWeight', 'bold');
set(gca,'xtick',[1.5, 4.5, 7.5, 10.5, 13.5, 16.5, 19.5, 22.5], 'xticklabel',{'Aud Still', 'Aud Tap','Vis Still', 'Vis Tap','Aud Still', 'Aud Tap','Vis Still', 'Vis Tap'});





