mu_All(:,:) = f0ITC_LMotor;
mu_All(:,5:8) = f0ITC_avg;

figure;
% subplot(2,1,1)
set(gcf,'Position',[100 100 450 300])
bh = boxplot(mu_All,'Notch','on','positions',[1,2, 4,5, 8,9, 11,12],'Widths',0.6);
title('ITC at f0', 'FontSize', 16, 'FontWeight','bold','FontName','Helvetica');
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