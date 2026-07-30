function [x; y] = Rotation(x0,y0,angle)

ang=(2*pi/360)*(angle); %Defining angle of rotation = 180 to make the plasma point down + ang in xray-params
Rot=[cos(ang) -sin(ang); sin(ang) cos(ang)]; %Defining Rotation matrix

xy=[x0; y0];
xy=Rot*xy;

x=xy(1,:);
y=xy(2,:);

[x; y];

end

