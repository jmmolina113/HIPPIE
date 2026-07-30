function [normalized_lineout]=normalize(lineout)

normalized_lineout=(1/max(lineout(300:600)))*lineout;

end