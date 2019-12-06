function analyseTriux(fiffname)

D = calculatePSD(fiffname); 
figure(1)
analyseGradiometers(D,fiffname); 
figure(2)
analyseMagnetometers(D,fiffname); 
