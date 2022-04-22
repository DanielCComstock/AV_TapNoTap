



MusicianIDX = [1 2 3 9 10 13 17 18];
nonMuscianIDX = [4 5 6 7 8 11 12 14 15 16];

splitTotalf0Pow = nan(10,8);

musicGrandAvgf0PowData = f0Pow_GrandAvgData(MusicianIDX,:);
nonMusicGrandAvgf0PowData = f0Pow_GrandAvgData(nonMuscianIDX,:);

splitTotalf0Pow(1:8,1) = musicGrandAvgf0PowData(:,1);
splitTotalf0Pow(1:8,2) = musicGrandAvgf0PowData(:,2);
splitTotalf0Pow(1:8,3) = musicGrandAvgf0PowData(:,3);
splitTotalf0Pow(1:8,4) = musicGrandAvgf0PowData(:,4);
splitTotalf0Pow(1:10,5) = nonMusicGrandAvgf0PowData(:,1);
splitTotalf0Pow(1:10,6) = nonMusicGrandAvgf0PowData(:,2);
splitTotalf0Pow(1:10,7) = nonMusicGrandAvgf0PowData(:,3);
splitTotalf0Pow(1:10,8) = nonMusicGrandAvgf0PowData(:,4);

%13,14, 16,17, 19,20, 22,23

figure;
% subplot(2,1,1)
set(gcf,'Position',[100 100 450 300])
bh = boxplot(splitTotalf0Pow,'Notch','on','positions',[1,2, 4,5, 8,9 11,12],'Widths',0.6);
title('Music Training Grand Average Noise Corrected Power at f0', 'FontSize', 16, 'FontWeight','bold','FontName','Helvetica');
color = ['r','b','r','b','r','b','r','b'];
bx = findobj('Tag','boxplot');
set(bx.Children(17:56),'Color','k','LineWidth',1);
set(bx.Children(9:17),'Color','k','LineWidth',2.5); % sets median lines thicker
ylim([-2.2 10]);
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    set(h(j),'Color',color(j), 'LineWidth',2);
    patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',.3,'LineStyle','none');
 
 end
set(bx.Children(17:56),'Color','k','LineWidth',1);

set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
set(gcf,'color','w');
ylabel('Power', 'FontSize',14,'FontName','Helvetica','FontWeight', 'bold');
set(gca,'xtick',[1.5, 4.5, 8.5, 11.5], 'xticklabel',{'Auditory', 'Visual','Auditory', 'Visual'});
set(gca,'ytick',[-2 0, 2, 4, 6, 8], 'yticklabel',{'-2','0', '2','4', '6','8'});




