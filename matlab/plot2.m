% plot2 is a version of plot that
% 1. puts on axis labels.
% 2. puts in '*' for mode, so the default is to get points.
%    (Thus use '-' as a 3rd argument to get line mode.)
% 4. makes xlim and ylim slightly larger than min and max.

function plot2(x,y,info)
if nargin<3
   info='*';
end

if nargin==1
   type=1;
elseif ((nargin==2) & (ischar(y)))
   info=y;
   type=1;
else
   type=2;
end

if type==1
   [x_row x_col]=size(x);
   if ((x_row>1)&(x_col>1))
      error('Input must be a vector');
   end
   plot((1:length(x))',x(:),info)
   ylabel(inputname(1))
   xlabel('Order of Values')
   axis([0 length(x)+1 min(x)-.1*range(x) max(x)+.1*range(x)])
   if isempty(inputname(1))
        ylabel('y')
   end
else

   [x_row x_col]=size(x);
   if ((x_row>1)&(x_col>1))
      error('Input must be a vector');
   end
   [y_row y_col]=size(y);
   if ((y_row>1)&(y_col>1))
      error('Input must be a vector');
   end
   if ((x_row ~= y_row) | (x_col ~= y_col))
      error('Inputs must be the same size');
   end
   plot(x,y,info)
   xlabel(inputname(1))
   ylabel(inputname(2))
   axis([min(x)-.1*range(x) max(x)+.1*range(x) min(y)-.1*range(y) max(y)+.1*range(y)])
   if isempty(inputname(1))
        xlabel('x')
   end
   if isempty(inputname(2))
        ylabel('y')
   end
end
