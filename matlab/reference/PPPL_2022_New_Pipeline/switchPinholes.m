function [pinhole1_new,pinhole2_new,didSwitch]=switchPinholes(pinhole1,pinhole2)
%This is function used to flip our data, as the way the pipeline is written
%pressposes that the left pinhole in the isoalted pair is the high-signal
%low-filtered pinhole, and that the right pinhole in the isolated pair is
%the low-signal high-filtered pinhole. 

    if mean(mean(pinhole2(475:525,475:575)))>mean(mean(pinhole1(475:525,475:575)))
       didSwitch=1;
       pinhole1_new=pinhole2;
       pinhole2_new=pinhole1;
       
    else
       didSwitch=0;
       pinhole1_new=pinhole1;
       pinhole2_new=pinhole2;

    end

end