MusicianIDX = [1 2 3 9 10 13 17 18];
nonMuscianIDX = [4 5 6 7 8 11 12 14 15 16];

musMuData = MuData(MusicianIDX,:);
nonmusMuData = MuData(nonMuscianIDX,:);


splitMu = nan(10,8);

splitMu(1:8,1) = musMuData(:,1);
splitMu(1:8,3) = musMuData(:,2);
splitMu(1:8,5) = musMuData(:,3);
splitMu(1:8,7) = musMuData(:,4);
splitMu(1:10,2) = nonmusMuData(:,1);
splitMu(1:10,4) = nonmusMuData(:,2);
splitMu(1:10,6) = nonmusMuData(:,3);
splitMu(1:10,8) = nonmusMuData(:,4);

figure;
set(gcf,'Position',[100 100 450 300])
bh = boxplot(splitMu,'Notch','on','positions',[1,2,4,5,7,8,10,11],'Widths',0.6);
title('All Mu Power', 'FontSize', 16, 'FontWeight','bold','FontName','Helvetica');
color = ['r','b','r','b','r','b','r','b'];
bx = findobj('Tag','boxplot');
set(bx.Children(17:56),'Color','k','LineWidth',1.5);
set(bx.Children(9:16),'Color','k','LineWidth',2.5); % sets median lines thicker
ylim([-5 81]);
h = findobj(gca,'Tag','Box');
for j=1:length(h)
%    %set(h(j),'Color',color(j), 'LineWidth',2);
     patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',.3,'LineStyle','none');

end


set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
set(gcf,'color','w');
ylabel('Power', 'FontSize',14,'FontName','Helvetica','FontWeight', 'bold');
set(gca,'xtick',[1.5, 4.5, 7.5, 10.5], 'xticklabel',{'Aud Con', 'Aud Tap','Vis Con', 'Vis Tap'});