function data_Pow = calculatePSD(fiffname)

cfg = [];
cfg.dataset = fiffname; 
data_org        = ft_preprocessing(cfg);


% data_org = fx_applySSP(data_org,fiffname);

cfg = [];
cfg.length               = 5; % lenght of time window = 5 s => 0.2 Hz resolution
data_ref                 = ft_redefinetrial(cfg, data_org);

cfg              = [];
cfg.output       = 'pow';
cfg.channel      = 'MEG';
cfg.method       = 'mtmfft';
cfg.taper        = 'hanning';
cfg.keeptrials   = 'no'; 

data_Pow = ft_freqanalysis(cfg, data_ref);



