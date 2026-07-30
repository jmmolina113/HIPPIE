close all

x=[1:1051];
y=[1050:2100];
% pre_cal=pre_cal(y,x);
% RawData=RawData(y,x);

range=(1.5/175)*[0:1:175];
[~,lineout_y]=GenerateLineouts(max_x,max_y-diff_y,50,pre_cal); %Pre-Cal
[~,lineout_y2]=GenerateLineouts(max_x,max_y-diff_y,50,RawData); %Post-Cal
[~,lineout_y4]=GenerateLineouts(max_x,max_y,50,Final); %Smoothed, Max-Aligned
[~,lineout_y3]=GenerateLineouts(max_x,max_y,50,Aligned1); %Area-Aligned



lineout_y=normalize(lineout_y);
lineout_y2=normalize(lineout_y2);
lineout_y3=normalize(lineout_y3);
lineout_y4=normalize(lineout_y4);


[~,location]=max(lineout_y(300:600));
[~,location2]=max(lineout_y2(300:600));
[~,location3]=max(lineout_y3(300:600));
[~,location4]=max(lineout_y4(300:600));

location=location+299;
location2=location2+299;
location3=location3+299;
location4=location4+299;

figure()
plot(range,lineout_y((location):-1:(location-175)))
hold on
plot(range,lineout_y2((location2):-1:(location2-175)))
hold on
plot(range,lineout_y3((location3):-1:(location3-175)))
hold on
plot(range,lineout_y4((location4):-1:(location4-175)))
hold on
plot(Z,Three_um)
hold on
plot(Z3,Three_um_2)
legend('Pre-Calibration','Post-Calibration, Pre-Smooth','Post-Smooth + Max Aligned','Area-Aligned','Paper Data for 3um - Second Take','First Take Paper Data for 3um - First Take')