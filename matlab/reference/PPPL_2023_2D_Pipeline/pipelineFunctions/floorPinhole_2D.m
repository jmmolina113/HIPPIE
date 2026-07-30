function floored_pinhole=floorPinhole_2D(pinhole,floorValue)

%This function will loop through all values in a supplied pinhole and floor the image by setting all signal values below 10
%to a NaN value

 for i=1:size(pinhole,1)
     for j=1:size(pinhole,2)

        if (pinhole(i,j) < floorValue)
            
            pinhole(i,j)=nan;

        end

     end
 end

 
 floored_pinhole=pinhole;


end