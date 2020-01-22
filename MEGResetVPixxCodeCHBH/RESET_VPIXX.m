%-------------------------------------------------------------------------------
% Function RESET_VPIXX
% Written by a.zhigalov@bham.ac.uk
%-------------------------------------------------------------------------------
function RESET_VPIXX()

tag_setup_projector('open');
tag_setup_projector('reset');
tag_setup_projector('close');

end % end

%-------------------------------------------------------------------------------
% Function
%-------------------------------------------------------------------------------
function tag_setup_projector(command)

if strcmp(command, 'open')
  Datapixx('Open');
elseif strcmp(command, 'set')
  Datapixx('SetPropixxDlpSequenceProgram', 5); % 1440 Hz
  Datapixx('RegWrRd');
elseif strcmp(command, 'reset')
  Datapixx('SetPropixxDlpSequenceProgram', 0); % default
  Datapixx('RegWrRd');
elseif strcmp(command, 'close')
  Datapixx('Close');
else
  fprintf(1, 'Propixx command ''%s'' is not defined.\n', command);
  return
end
  
end % end

%-------------------------------------------------------------------------------