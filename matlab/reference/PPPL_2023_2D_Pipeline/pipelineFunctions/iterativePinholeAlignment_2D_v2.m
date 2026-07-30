function [pinhole1Aligned,pinhole2Aligned,keepGoing,shiftHorz,shiftVert,targetEdge]=iterativePinholeAlignment_2D_v2(inputPinhole1,inputPinhole2,whereToLook,averageRange,maximaCoords,stuck,manualShift)

%This function will align pinhole 2 wrt to pinhole 1 both vertically and horizontally
%and return the aligned pinholes, as well as the shifts that were required
%both vertically and horizontally

    
    %% Alignment of pinhole 2 wrt pinhole 1
    [inputPinhole2_v,shiftVert,targetEdge]=verticallyAlignPinholes_2D_v2(inputPinhole1,inputPinhole2,averageRange,maximaCoords(1),maximaCoords(2),stuck(1),manualShift(1)); %vertical alignment of pinhole 2
    [inputPinhole2_hv,shiftHorz]=horizontallyAlignPinholes_2D_v2(inputPinhole1,inputPinhole2_v,whereToLook,maximaCoords(2),maximaCoords(1),stuck(2),manualShift(2)); %horizontal alignment of pinhole 2
  
    pinhole1Aligned=inputPinhole1; %pinhole 1 does not change so this is ouput as is
    pinhole2Aligned=inputPinhole2_hv; %the output for pinhole 2 is the version that has been vertically and horizontally aligned.
    

    %% Logical error analysis
    didShiftVert=(shiftHorz~=0); %Did we shift pinhole 2 vertically, yes or no?
    didShiftHorz=(shiftVert~=0); %Did we shift pinhole 2 horizontally, yes or no?
    keepGoing=(didShiftVert || didShiftHorz); %If we shifted in either direction, then keepGoing=1. If we did not then keepGoing=0 and we are done.
    keepGoing=(stuck(1) ~= 1 && stuck(2) ~= 1);
    

    %% N.B.
    %The two lines below consititue my attempts to get a quantitative way
    %to calculate the error, in hopes of getting a way to bound this
    %process and allow the code to stop once it satisfies this conditions.
    %This prooved difficult because the fit changes so much in every case
    %and it can be difficult to know the proper value for the bound a
    %priori



    %error=calculateEnclosedArea(normalize(lineoutPinhole1),normalize(lineoutPinhole2));
    %error=calculateRMSdiff(normalize(lineoutPinhole1),normalize(lineoutPinhole2));

end