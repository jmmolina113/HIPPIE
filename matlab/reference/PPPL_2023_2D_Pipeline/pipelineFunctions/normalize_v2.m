function [normalized_lineout]=normalize_v2(lineout,whereToLook)

[~,firstNanIndex]=min(isnan(lineout));
firstNanIndex=firstNanIndex-1;

sectionConstant=round(length(lineout)/3);

switch whereToLook
    case -1
        range=[firstNanIndex:sectionConstant];
  
    case 0

        range=[sectionConstant:2*sectionConstant];

    case 1
        range=[2*sectionConstant:3*sectionConstant];


end

norm=max(lineout(range));
normalized_lineout=lineout/norm;
end