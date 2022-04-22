%% Plot Cluster ERSP with Sig Contours %%

% loads in ERSP data computed with computeTFClusters & plots ERSP and ITC
% plots, performs sig contours with p<0.05 & p<0.01 and saves data plots


%% load & Prep Data
% 
% loadpath = '/Users/dcc/EEG_Data/AV_Omit/09a_Cluster_tf_data/';
% savepath = '/Users/dcc/EEG_Data/AV_Omit/10a_TF_figs/';
% % loop for all clusters
% for j = 2:11
%     
%     % for loop to capture the 4 conditions
%     for k = 1:4
%         
%         % Set modality 
%         if k==1 || k==2 
%             modality = 'Aud';
%         else
%             modality = 'Vis';
%         end
%         
%         % Set Condition & Load data
%         if k==1 || k== 3
%             cond = 'Cont';
%             
%             % Load data
%             loadname = [loadpath 'Clust_' num2str(j) '_' modality '_' cond '.mat'];
%             load(loadname);

           A = exist('dataNoTap');
                
            if A == 1
                TF_data = dataNoTap;
            else
                TF_data = dataTap;
            end
            
            % get number of components
            ncomp = size(TF_data,2);
            
            % get dimensions of ersp
            nfreqs = size(TF_data(1).ersp,1);
            ntimes = size(TF_data(1).ersp,2);
            
            % get freqs & times
            freqs = TF_data(1).freqs;
            times = TF_data(1).times; 
            
            % create ersp matrix
            ersp = zeros(nfreqs,ntimes,ncomp);

            % concatenate ersp
            for i = 1:ncomp
                ersp(:,:,i)=TF_data(i).ersp;
            end
            
%         else
%             cond = 'Omit';
%             
%             % Load data
%             loadname = [loadpath 'Clust_' num2str(j) '_' modality '_' cond '.mat'];
%             load(loadname);
%             
%             % get number of components
%             ncomp = size(dataO,2);
%             
%             % get dimensions of ersp
%             nfreqs = size(dataO(1).ersp,1);
%             ntimes = size(dataO(1).ersp,2);
%             
%             % get freqs & times
%             freqs = dataO(1).freqs;
%             times = dataO(1).times;
%             
%             % create ersp matrix
%             ersp = zeros(nfreqs,ntimes,ncomp);
% 
%             % concatenate ersp
%             for i = 1:ncomp
%                 ersp(:,:,i)=dataO(i).ersp;
%             end
%         end

        % average ERSP accross components
        avgersp = mean(ersp,3); 

        % Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
        erspmax = [max(max(abs(avgersp)))];

        % convert absolute highest ERSP values for symetrical scale
        erspminmax = [-erspmax erspmax]; 


%         %% Permutation Stats with FDR correction %%
% 
%         % permutation statistics with FDR correction
%         pvals = std_stat({ ersp zeros(size(ersp)) }', 'method', 'permutation', 'condstats', 'on', 'correctm', 'fdr'); 
% 
%         % save values for stat contouring
%         tmpersp05 = avgersp;
%         tmpersp01 = avgersp;
% 
%         % Mask any ERSP values with less than p.05 sig
%         tmpersp05(pvals{1} > 0.05) = 1;
% 
%         % Mask any ERSP values with less than p.01 sig
%         tmpersp01(pvals{1} > 0.01) = 1;
% 
%         % Make all significant values = 2, for only single contour line
%         tmpersp05(tmpersp05 ~= 1) = 2; 
%         tmpersp01(tmpersp01 ~= 1) = 2; 


        %% Plot ERSP %%
        figure; imagesc(times, freqs, avgersp, erspminmax); % main plot function
        set(gca, 'ydir', 'normal'); % sets scaling direction
        set(gca, 'FontSize', 16, 'FontWeight', 'bold');
%         xlim([-2300 2300]);
%         ylim([3 35]);
%         hold on
%         [tmpc tmph] = contour(times, freqs, tmpersp05, 'levels', 1); % computes contours around p05 signinicant areas
%         set(tmph, 'linecolor', 'k', 'LineWidth', 2,'LineStyle',':'); % adds white dotted contour lines around P05 areas
%         [tmpc2 tmph2] = contour(times, freqs, tmpersp01, 'levels', 1); % computes contours around P01 signinicant areas
%         set(tmph2, 'linecolor', 'k', 'LineWidth', 2,'LineStyle','-'); % adds white solid contour lines around P01 areas
%         hold off
        xlabel('Time (ms)', 'FontSize',20, 'FontWeight', 'bold'); % x axis label
        ylabel('Frequencies (Hz)', 'FontSize',20, 'FontWeight', 'bold'); % y axis label
%         titlename = ['ERSP - Cluster ' num2str(j) ' ' modality ' ' cond];
%         title(titlename, 'FontSize', 25, 'FontWeight','bold');
        c=colorbar;% adds colorbar to side showing color scale. Scale determined by erspminma
        c.Label.String = 'dB';
        c.Label.Position = [.5 erspmax*1.13];
        c.Label.Rotation = 0;
%         line([0 0],[3 35],'color','k', 'LineWidth', 2, 'LineStyle','--');
%         line([600 600],[3 35],'color','k', 'LineWidth', 1, 'LineStyle',':');
%         line([1200 1200],[3 35],'color','k', 'LineWidth', 1, 'LineStyle',':');
%         line([1800 1800],[3 35],'color','k', 'LineWidth', 1, 'LineStyle',':');
%         line([-600 -600],[3 35],'color','k', 'LineWidth', 1, 'LineStyle',':');
%         line([-1200 -1200],[3 35],'color','k', 'LineWidth', 1, 'LineStyle',':');
%         line([-1800 -1800],[3 35],'color','k', 'LineWidth', 1, 'LineStyle',':');
        colormap jet;
        
%         %% Save Figure %%
%         
%         fullsave = [savepath 'Cluster_' num2str(j) '_' modality '_' cond '_stats'];
%         savefig(fullsave);
%         close;
%     end
% end