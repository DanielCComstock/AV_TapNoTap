% transform f0 Power data to be stats and plot ready

clear

% filePaths
loadPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/05g_Spectra_f0StimTrains/';
savePath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/06g_f0Power_StatsPlotsTransformed/';

% loadname lists
loadFileNames = ["StimTrainCorrectedSpectra_Aud_Con.mat", "StimTrainCorrectedSpectra_Aud_Tap.mat",...
    "StimTrainCorrectedSpectra_Vis_Con.mat", "StimTrainCorrectedSpectra_Vis_Tap.mat"];
% binTypes = ["2Bin", "2BinOff1", "2BinOff2", "3Bin", "3BinOff1"];
% dataTypes = ["LMuCompCorSpectra", "RMuCompCorSpectra", "ChanCorSpectra"];
% 
% 
% 
% lableNames = ["Aud_Con","Aud_Tap","Vis_Con","Vis_Tap"];

%Load data

for condIDX = 1:length(loadFileNames)
    
    loadName = [loadPath char(loadFileNames(condIDX))];

    load(loadName);

    LM_Pow_2Bin(:,:,condIDX) = spectraData.LMuCompCorSpectra2Bin;
    LM_Pow_2BinOff1(:,:,condIDX) = spectraData.LMuCompCorSpectra2BinOff1;
    LM_Pow_2BinOff2(:,:,condIDX) = spectraData.LMuCompCorSpectra2BinOff2;
    LM_Pow_3Bin(:,:,condIDX) = spectraData.LMuCompCorSpectra3Bin;
    LM_Pow_3BinOff1(:,:,condIDX) = spectraData.LMuCompCorSpectra3BinOff1;
    LM_Pow_Raw(:,:,condIDX) = spectraData.LMuCompRawSpecta;

    RM_Pow_2Bin(:,:,condIDX) = spectraData.RMuCompCorSpectra2Bin;
    RM_Pow_2BinOff1(:,:,condIDX) = spectraData.RMuCompCorSpectra2BinOff1;
    RM_Pow_2BinOff2(:,:,condIDX) = spectraData.RMuCompCorSpectra2BinOff2;
    RM_Pow_3Bin(:,:,condIDX) = spectraData.RMuCompCorSpectra3Bin;
    RM_Pow_3BinOff1(:,:,condIDX) = spectraData.RMuCompCorSpectra3BinOff1;
    RM_Pow_Raw(:,:,condIDX) = spectraData.RMuCompRawSpecta;

    ChanAvg_Pow_2Bin(:,:,condIDX) = mean(spectraData.ChanCorSpectra2Bin,2);
    ChanAvg_Pow_2BinOff1(:,:,condIDX) = mean(spectraData.ChanCorSpectra2BinOff1,2);
    ChanAvg_Pow_2BinOff2(:,:,condIDX) = mean(spectraData.ChanCorSpectra2BinOff2,2);
    ChanAvg_Pow_3Bin(:,:,condIDX) = mean(spectraData.ChanCorSpectra3Bin,2);
    ChanAvg_Pow_3BinOff1(:,:,condIDX) = mean(spectraData.ChanCorSpectra3BinOff1,2);
    ChanAvg_Pow_Raw(:,:,condIDX) = mean(spectraData.ChanAllRawSpectra,2);

    ChanTopo_Pow_2Bin(:,:,condIDX) = mean(spectraData.ChanCorSpectra2Bin,1);
    ChanTopo_Pow_2BinOff1(:,:,condIDX) = mean(spectraData.ChanCorSpectra2BinOff1,1);
    ChanTopo_Pow_2BinOff2(:,:,condIDX) = mean(spectraData.ChanCorSpectra2BinOff2,1);
    ChanTopo_Pow_3Bin(:,:,condIDX) = mean(spectraData.ChanCorSpectra3Bin,1);
    ChanTopo_Pow_3BinOff1(:,:,condIDX) = mean(spectraData.ChanCorSpectra3BinOff1,1);

    freqs = spectraData.freqs;

    chanList = spectraData.subj(1).chanlist;


end


    fullsave_LM_data = [savePath 'LM_f0CorrectedPower'];
    fullsave_RM_data = [savePath 'RM_f0CorrectedPower'];
    fullsave_ChanAvg_data = [savePath 'ChanAvg_f0CorrectedPower'];
    fullsave_ChanTopo_data = [savePath 'ChanTopo_f0CorrectedPower'];

    save(fullsave_LM_data, 'LM_Pow_2Bin', 'LM_Pow_2BinOff1', 'LM_Pow_2BinOff2', 'LM_Pow_3Bin', 'LM_Pow_3BinOff1', 'LM_Pow_Raw', 'freqs');
    save(fullsave_RM_data, 'RM_Pow_2Bin', 'RM_Pow_2BinOff1', 'RM_Pow_2BinOff2', 'RM_Pow_3Bin', 'RM_Pow_3BinOff1', 'RM_Pow_Raw', 'freqs');
    save(fullsave_ChanAvg_data, 'ChanAvg_Pow_2Bin', 'ChanAvg_Pow_2BinOff1', 'ChanAvg_Pow_2BinOff2', 'ChanAvg_Pow_3Bin', 'ChanAvg_Pow_3BinOff1', 'ChanAvg_Pow_Raw', 'freqs');
    save(fullsave_ChanTopo_data, 'ChanTopo_Pow_2Bin', 'ChanTopo_Pow_2BinOff1', 'ChanTopo_Pow_2BinOff2', 'ChanTopo_Pow_3Bin', 'ChanTopo_Pow_3BinOff1', 'freqs', 'chanList');

        

        
     