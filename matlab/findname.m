%  This function determines whether a string is 
%   an element of the name cell array used in lm.m
function tv=findname(str,names)
[nrow rcol]=size(names);
tv=0;
for k=1:nrow
   if strequ(str,names{k,1})
      tv=k;
   end
end

   