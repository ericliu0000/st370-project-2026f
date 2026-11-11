% MAPPLOT(MAPPTS,X,Y)  Plot the points X vs. Y
%   overlaid on a map defined by
%   the points in MAPPTS. X and Y should be
%   longitude and latitude values.
%   MAPPLOT is very similar to the PLOT command,
%   except that it prints a world map underneath.
%   
% MAPPLOT(MAPPTS,X,Y,S) This is the same as above, 
%   except the forth input is a string that indicates
%   the color of the plot, whether or not points
%   are connected, and the character used for 
%   indicating points.  Type Help plot for
%   more details. By default S = '*'.
%
% MAPPLOT(MAPPTS,X,Y,NAMES) This is the same as above,
%   except the forth input contains a vector the same
%   length as X and Y which has names to label the points.
%
% MAPPLOT(MAPPTS) Plots the map defined by MAPPTS.
%   
function mapplot(mappts,x,y,s)

   if nargin==1
      plot(mappts.x,mappts.y,'.','MarkerSize',3)
      return
   end

   if nargin==3
      plot(x,y,'*',mappts.x,mappts.y,'.','MarkerSize',3)
      return
   else 
      tests = size(s);
      if tests(1)==1
         plot(x,y,s,mappts.x,mappts.y,'.','MarkerSize',3)
         return
      else
         plot(mappts.x,mappts.y,'.','MarkerSize',3)
         if isnumeric(s)
            s=num2str(s);
         end
         text(x,y,s)
      end
   end
