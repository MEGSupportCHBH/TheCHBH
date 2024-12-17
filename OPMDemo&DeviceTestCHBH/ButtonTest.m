function DatapixxDoutButtonScheduleDemo()
% DatapixxDoutButtonScheduleDemo()
%
% Demonstrates the use of automatic digital output schedules when user presses digital input buttons.
%
% History:
%
% Apr 30, 2012  paa     Written
% Oct 29, 2014  dml     Revised
% Mar 26, 2020  dml		Updated
close all;
clearvars;

AssertOpenGL;   % We use PTB-3

% Open Datapixx, and stop any schedules which might already be running
Datapixx('Open');
Datapixx('StopAllSchedules');
Datapixx('RegWrRd');    % Synchronize DATAPixx registers to local register cache


Datapixx('EnablePixelMode',1);  %1, GreenBlueMode
Datapixx('RegWr');


doutBufferBaseAddr = 4096*24;

doutWaveform = [ 1, 1, 1, 1,0,0,0,0];
Datapixx('WriteDoutBuffer', doutWaveform, doutBufferBaseAddr + 4096*0); % RESPONSEPixx RED/Din0 Push 

doutWaveform = [ 1, 2, 4, 8,16,32,64,128];
Datapixx('WriteDoutBuffer', doutWaveform, doutBufferBaseAddr + 4096*2); % RESPONSEPixx Yellow/Din1 Push


Datapixx('SetDoutSchedule', 0, 5, 9, doutBufferBaseAddr); 

Datapixx('SetDinDataDirection', 0);
Datapixx('EnableDinDebounce');      % Filter out button bounce
Datapixx('EnableDoutButtonSchedules', 1); % This starts the schedules for MRI mode
Datapixx('RegWrRd');    % Synchronize DATAPixx registers to local register cache

% WaitSecs(0.5);
Datapixx('Close');
% WaitSecs(5);
fprintf('\n\nAutomatic buttons schedules running\n\n');