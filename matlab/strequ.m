%   This function is true if the two inputs are identical strings

function tv=strequ(x,y);
if (~ischar(x))|(~ischar(y))
   tv=0;
end

if length(x)~=length(y)
   tv=0;
end

if ischar(x)&ischar(y)&(length(x)==length(y))
   tv=1;
   for n=1:length(x)
      tv=tv*(x(n)==y(n));
   end
end

