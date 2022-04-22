
%for Channel Study
for j= 4:7
[STUDY ALLEEG customRes] = std_precomp(STUDY, ALLEEG, 'channels', 'design', j, 'interp', 'on', 'rmicacomps', 'on', 'erp','on',  'spec', 'on', 'ersp', 'on','itc','on', ...
    'erpimparams',{'rmbase', [-100 -50]},'erspparams', {'cycles', [3 0.7], 'nfreqs', 94, 'ntimesout', 200, 'baseline', [-1000 1998], 'freqs', [3 50], 'freqscale', 'linear'});
STUDY = pop_savestudy( STUDY, EEG, 'savemode','resave');
end

for j= 8:9
[STUDY ALLEEG customRes] = std_precomp(STUDY, ALLEEG, 'channels', 'design', j, 'interp', 'on', 'rmicacomps', 'on', 'erp','on',  'spec', 'on', 'ersp', 'on','itc','on', ...
    'erpimparams',{'rmbase', [-100 -50]},'erspparams', {'cycles', [3 0.7], 'nfreqs', 94, 'ntimesout', 200, 'baseline', [-1000 1998], 'freqs', [3 50], 'freqscale', ...
    'linear','alpha',.05, 'pcontour', 'on','trialbase','full'});
STUDY = pop_savestudy( STUDY, EEG, 'savemode','resave');
end


for j= 4:5
[STUDY ALLEEG customRes] = std_precomp(STUDY, ALLEEG, 'channels', 'design', j, 'interp', 'on', 'rmicacomps', 'on', 'erp','on',  'spec', 'on', 'ersp', 'on','itc','on', ...
    'erpimparams',{'rmbase', [-100 -50]},'erspparams', {'cycles', [3 0.7], 'nfreqs', 94, 'ntimesout', 200, 'baseline', [-1000 1998], 'freqs', [3 50], 'freqscale', 'linear'});
STUDY = pop_savestudy( STUDY, EEG, 'savemode','resave');
end

%for component study
for j= 1:5
[STUDY ALLEEG customRes] = std_precomp(STUDY, ALLEEG, 'components', 'design', j, 'allcomps', 'off', 'scalp','on', 'spec', 'on', 'ersp', 'on','itc','on', ...
    'erspparams', {'cycles', [3 0.7], 'nfreqs', 94, 'ntimesout', 200, 'baseline', [-1000 1998], 'freqs', [3 50], 'freqscale', 'linear', });
STUDY = pop_savestudy( STUDY, EEG, 'savemode','resave');
end

%for component study 2
for j= 6:7
[STUDY ALLEEG customRes] = std_precomp(STUDY, ALLEEG, 'components', 'design', j, 'allcomps', 'off', 'scalp','on', 'spec', 'on', 'ersp', 'on','itc','on','erp','on', ...
    'erpimparams',{'rmbase', [-100 -50]},'erspparams', {'cycles', [3 0.7], 'nfreqs', 94, 'ntimesout', 200, 'baseline', [-1000 1998], 'freqs', [3 50], 'freqscale', 'linear', });
STUDY = pop_savestudy( STUDY, EEG, 'savemode','resave');
end


for j= 6:9
[STUDY ALLEEG customRes] = std_precomp(STUDY, ALLEEG, 'channels', 'design', j, 'interp', 'on', 'rmicacomps', 'on', 'erp','on',  'spec', 'on', 'ersp', 'on','itc','on', ...
    'erpimparams',{'rmbase', [-100 -50]},'erspparams', {'cycles', [3 0.7], 'nfreqs', 120, 'ntimesout', 300, 'baseline', [-1000 1998], 'freqs', [3 43],'trialbase', 'full' });
STUDY = pop_savestudy( STUDY, EEG, 'savemode','resave');
end


[STUDY ALLEEG customRes] = std_precomp(STUDY, ALLEEG, 'components', 'design', 1, 'allcomps', 'off', 'scalp','on', 'erp','on', 'spec', 'on','erpimparams',{'rmbase', [-100 -50]});
STUDY = pop_savestudy( STUDY, EEG, 'savemode','resave');   
for j= 2:5
[STUDY ALLEEG customRes] = std_precomp(STUDY, ALLEEG, 'components', 'design', j, 'allcomps', 'off', 'scalp','on', 'erp','on',  'spec', 'on', 'ersp', 'on','itc','on', ...
    'erpimparams',{'rmbase', [-100 -50]},'erspparams', {'cycles', [3 0.7], 'nfreqs', 120, 'ntimesout', 300, 'baseline', [-1000 1998], 'freqs', [3 43],'trialbase', 'full' });
STUDY = pop_savestudy( STUDY, EEG, 'savemode','resave');
end



'cycles', [3 0.7], 'nfreqs', 120, 'ntimesout', 300, 'baseline', [-1000 1998], 'freqs', [3 43],  'trialbase', 'full'

for j = 6:11

    if j == 6 || j == 7
        Fr = [3 10];
        nFR = 28;  
    elseif j == 8 || j == 9
        Fr = [4 10];
        nFR = 24;
    elseif j == 10 || j==11
        Fr = [5 10];
        nFR = 20;
    else
        end
    [STUDY ALLEEG customRes] = std_precomp(STUDY, ALLEEG, 'components', 'design', j, 'allcomps', 'off', 'scalp','on', 'ersp', 'on','itc','on', ...
    'erspparams', {'cycles', [3 0.5], 'nfreqs', nFR, 'ntimesout', 200, 'baseline', [-1000 1998], 'freqs', Fr, 'freqscale', 'linear', });
    STUDY = pop_savestudy( STUDY, EEG, 'savemode','resave');

            
   
end


'cycles', [3 0.5],'freqs',[3 8] 'nfreqs', 20, 'freqscale', 'linear', 'ntimesout', 200