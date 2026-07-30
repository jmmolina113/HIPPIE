function shot_data = Mirror(data,flip_number)

if flip_number==1

    %Y axis
    shot_data=flip(data,2);
    
elseif flip_number==2
    
  %X axis and Y Axis
  shot_data=flip(data,2);
  shot_data=flip(data,1);

  
elseif flip_number==3

   % just x Axis
   
    shot_data=flip(data,1);

   
end

end

