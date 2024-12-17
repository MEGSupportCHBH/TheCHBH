% Clear the workspace and the screen
sca;
close all;
clear;





%% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Seed the random number generator. Here we use the an older way to be
% compatible with older systems.
rng('shuffle')

% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer. For help see: Screen Screens?
screens = Screen('Screens');

% Draw we select the maximum of these numbers. So in a situation where we
% have two screens attached to our monitor we will draw to the external
% screen. When only one screen is attached to the monitor we will draw to
% this. For help see: help max
screenNumber = max(screens);
%screenNumber = 0
% Define black and white (white will be 1 and black 0). This is because we
% are defining luminace values between 0 and 1 through the use of the PTB
% default setting call above.
% For help see: help WhiteIndex and help BlackIndex
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Open an on screen window and color it black.
% For help see: Screen OpenWindow?
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

% Get the size of the on screen window in pixels.
% For help see: Screen WindowSize?
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window in pixels
% For help see: help RectCenter
[xCenter, yCenter] = RectCenter(windowRect);

% Enable alpha blending for anti-aliasing
% For help see: Screen BlendFunction?
% Also see: Chapter 6 of the OpenGL programming guide
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

% Set the color of our dot to full red. Color is defined by red green
% and blue components (RGB). So we have three numbers which
% define our RGB values. The maximum number for each is 1 and the minimum
% 0. So, "full red" is [1 0 0]. "Full green" [0 1 0] and "full blue" [0 0
% 1]. Play around with these numbers and see the result.


Datapixx('Open');
Datapixx('RegWrRd');
WaitSecs(4);
%% Open Datapixx, and stop any schedules which might already be running
Datapixx('Open');
Datapixx('StopAllSchedules');
Datapixx('RegWrRd');    % Synchronize DATAPixx registers to local register cache

Datapixx('SetPropixxDlpSequenceProgram', 0);        %0, RGB mode
Datapixx('RegWrRd');                                %Push command to device register

Datapixx('EnablePixelMode',0);  %1, GreenBlueMode
Datapixx('RegWr');

%%
for i=0:1:24
    % Determine a random X and Y position for our dot. NOTE: As dot position is
    % randomised each time you run the script the output picture will show the
    % dot in a different position. Similarly, when you run the script the
    % position of the dot will be randomised each time. NOTE also, that if the
    % dot is drawn at the edge of the screen some of it might not be visible.
    dotXpos = 0;
    dotYpos = 0;

    % Dot size in pixels
    dotSizePix = 4;

    dotColor = ThreeBytes2RGB(bitshift(1,i));

    % Draw the dot to the screen. For information on the command used in
    % this line type "Screen DrawDots?" at the command line (without the
    % brackets) and press enter. Here we used good antialiasing to get nice
    % smooth edges
    Screen('DrawDots', window, [dotXpos dotYpos], dotSizePix, dotColor, [], 4); %use mode 4. Mode 0 fails when the dot is one-pixel sized.
    Screen('Flip', window);
    WaitSecs(0.25);
end

% j=4;
% 
% for i=0:1:(15-j)
%     dotXpos = 0;
%     dotYpos = 0;
%     dotSizePix = 1;
% 
%     dotColor = TwoBytes2RGB(bitshift(1,i));
%     dotColor = TwoBytes2RGB(bitshift(1,i)+bitshift(1,i+j)+bitshift(1,i+j-2));
%     Screen('DrawDots', window, [dotXpos dotYpos], dotSizePix, dotColor, [], 4); %use mode 4. Mode 0 fails when the dot is one-pixel sized.
%     Screen('Flip', window);
%     WaitSecs(0.5);
% end
WaitSecs(4);
theImage = imread('mistake1.png');
imageTexture = Screen('MakeTexture',window, theImage);

% imageWidth = 0.15 .* cfg.screenXpixels; % adjusted height * aspect ratio (of the left image)
% % Make the destination rectangles for our image.
% imageRectangle = CenterRectOnPointd([0 0 imageWidth imageWidth], cfg.xCenter, cfg.yCenter);

Screen('DrawTexture', window, imageTexture, [], windowRect);

% Flip to the screen. This command basically draws all of our previous
% commands onto the screen. See later demos in the animation section on more
% timing details. And how to demos in this section on how to draw multiple
% rects at once.
% For help see: Screen Flip?
Screen('Flip', window);
WaitSecs(1);

% Now we have drawn to the screen we wait for a keyboard button press (any
% key) to terminate the demo. For help see: help KbStrokeWait

%KbStrokeWait;

% Clear the screen. "sca" is short hand for "Screen CloseAll". This clears
% all features related to PTB. Note: we leave the variables in the
% workspace so you can have a look at them if you want.
% For help see: help sca
sca;

function rgb = ThreeBytes2RGB(tmp)
    %disp(tmp);
    maxValue = 255;
    HB = mod(bitshift(tmp,-16),256);
    MB = mod(bitshift(tmp,-8),256);
    LB = mod(tmp,256);
    disp(LB/maxValue);
    rgb = [LB/maxValue MB/maxValue HB/maxValue];
end

function rgb = TwoBytes2RGB(tmp)
    %disp(tmp);
    maxValue = 255;
    HB = mod(bitshift(tmp,-8),256);
    LB = mod(tmp,256);
    rgb = [0 LB/maxValue HB/maxValue];
end
