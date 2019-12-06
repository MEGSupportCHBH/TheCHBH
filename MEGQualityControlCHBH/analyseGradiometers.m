function analyseGradiometers(D,fiffname)



mag = 1:3:306;
grad1 = 2:3:306; 
grad2 = 3:3:306; 
grad = sort([grad1 grad2]) ;
freqrange = [0 100];

for k = 1:length(grad)
    Slabel{k} = D.label{grad(k)};
end

Pgrad = 1e26*D.powspctrm(grad,:);  % (fT/cm)^2
Pmag  = 1e30*D.powspctrm(mag,:);   %  fT^2 

fidx = find(D.freq > freqrange(1) & D.freq <freqrange(2));

% ======================================
% Plot spectra

clf
subplot(221)

PgradL = log10(Pgrad);
m = 0; 
for k=1:size(PgradL,1)
    if isfinite(PgradL(k,1))
        m = m + 1; 
        PgradLC(m,:) = PgradL(k,:); 
    end
end
    
plot(D.freq,mean(PgradLC,1));
xlim(freqrange)
ylim([0 4])
title('Gradiometers mean')
xlabel('Frequency (Hz)')
ylabel('Power (fT/m)^2/Hz ')


subplot(222)
plot(D.freq,  PgradLC);
xlim(freqrange)
ylim([0 4])
title('Gradiometers mean')
xlabel('Frequency (Hz)')
ylabel('Power (fT/m)^2/Hz ')

%

%============================================


subplot(413) 
PgradTotal = mean(PgradLC(:,fidx),2);
[Psort,Pidx] = sort(PgradTotal,'descend');

bar(1:length(Psort), Psort')
title(strcat('Noise level:',{' '}, num2str(freqrange(1)), ' Hz to ',{' '} ,num2str(freqrange(2)), ' Hz'))
xlabel('sensors sorted by power')
ylabel('Power (fT/m)^2/Hz ')
ylim([0 4])



subplot(427)

xlim([0 100])
ylim([0 100]) 
text(0,100,sprintf('Mean power (all gradimeters) = %2.2f',mean(PgradTotal)))

for k=1:10
    text(0,100-k*10,sprintf('Sensor %s Power = %2.2f',Slabel{Pidx(k)},Psort(k)))    
end
axis off 



annotation('textbox', [0 0.9 1 0.1], ...
    'String', strcat(pwd,'\',fiffname), ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'left','Interpreter','none')

annotation('textbox', [0 0.9 1 0.1], ...
    'String', strcat('Analysed: ',date), ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'right','Interpreter','none')

pname = strcat(fiffname(1:end-4),'QTgrad_v2.pdf');

h=gcf;
set(h,'Position',[50 50 1200 800]);
set(h,'PaperOrientation','landscape');
print(gcf, '-dpdf','-bestfit', pname)









