
% DatapixxDoutBasicDemo()
%
% Demonstrates the basic functions of the DATAPixx TTL digital outputs.
% Prints the number of TTL outputs in the system,
% then waits for keypresses to:
%   -Set digital output 0 high
%   -Set all digital outputs high
%   -Bring all digital outputs back low
%
% Also see: DatapixxDoutTriggerDemo
%
% History:
%
% Oct 1, 2009  paa     Written
% Oct 29, 2014 dml     Revised

AssertOpenGL;   % We use PTB-3

% Open Datapixx, and stop any schedules which might already be running
Datapixx('Open');
Datapixx('StopAllSchedules');
Datapixx('RegWrRd');    % Synchronize DATAPixx registers to local register cache

Datapixx('DisablePixelMode');
Datapixx('RegWr');

% Show how many TTL output bits are in the Datapixx
nBits = Datapixx('GetDoutNumBits');
fprintf('\nDATAPixx has %d TTL output bits\n\n', nBits);

Datapixx('SetDoutValues', 0);
Datapixx('RegWrRd');
WaitSecs(4);





%%
for i=0:1:(nBits-1)
    Datapixx('SetDoutValues', bitshift(2^(nBits-1),-i));
    Datapixx('RegWrRd');
    WaitSecs(0.25);
end

% Bring all the outputs low
Datapixx('SetDoutValues', 0);
Datapixx('RegWrRd');
WaitSecs(0.5);

% Bring all the outputs high
Datapixx('SetDoutValues', (2^nBits) - 1);
Datapixx('RegWrRd');
WaitSecs(0.5);

%%
% Job done
Datapixx('Close');
fprintf('\n\nDemo completed\n\n');