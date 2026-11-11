% LPLOT(X,Y)  Plot Y by category given in X. 
%   LPLOT is very similar to the PLOT command,
%   except that it accepts X if it is a cell
%   array and also if it is a numeric vector.  
%   
% LPLOT(X,Y,S) This is the same as above, except
%   the third input is a string that indicates
%   the color of the plot, whether or not points
%   are connected, and the character used for 
%   indicating points.  Type Help plot for
%   more details.
%
% LPLOT(X,Y,Z) If Z is a cell array or a vector
%   of the same size as X and Y, LPLOT will
%   give a plot of Y vs. X with the corresponding
%   values of Z indicating the data points
%   
function lplot(x,y,in3)

if isnumeric(x)
   if nargin==2
      tplot(x,y)
      return
   else
      tplot(x,y,in3)
      return
   end
end

names=levels(x);

if nargin==2
   haveby=0;
   s='k+';
end

if nargin==3
   if ischar(in3)
      s=in3;
      haveby=0;
   else
      z=in3;
      s='w+';
      haveby=1;
   end
end
%if strequ(class(x),'double')
%   if haveby
%     z=z(si);
%  end  
%end
llplot(x,y,names,s)
if haveby
   maxlen=0;
%   for k=1:length(z)
%      maxlen=max(maxlen,length(z{k}));
%  end
%   tempz='';
%   for k=1:length(z)
%      tempz=[tempz;blanks(maxlen-length(z{k})),z{k}];
%   end
%   z=tempz; 
%   keyboard
%  [x si]=sort(x);
%  y=y(si);
   x=stdrd(x);
   if haveby
     z=z(si);
   end 


   if iscell(z)
      text(stdrd(x)+.000001,y,z)
   else
      text(stdrd(x)+.000001,y,num2str(z))
   end
end
      
function llplot(x,y,names,s)

[x si]=sort(x);
y=y(si);
x=stdrd(x);
maxlen=0;
for k=1:length(names)
  maxlen=max((maxlen),length(names{k}));
end
bl=blanks(maxlen);
for k=1:length(names)
  names{k}=[names{k},blanks(maxlen-length(names{k}))];
end

if nargin>=3
  plot(x,y,s)
else
  plot(x,y,'k+')
end
axs=axis;
rg=axs(4)-axs(3);
axis([axs(1)-.5,axs(2)+.5,axs(3)-.10*rg,axs(4)+.10*rg])
xtold=1:max(x);
set(gca,'XTick',xtold);
xtold=get(gca,'XTick');
xtick='';
xx=1:max(x);
xx=[xx,NaN];
l=0;
while l<length(xtold)&~(strequ(num2str(xx(1)),'NaN'))
  l=l+1;
   if (xtold(l)~=xx(1))&~(strequ(num2str(xx(1)),'NaN'))
      xtick=[xtick;bl];
   else
      xtick=[xtick;names{xx(1)},blanks(maxlen-length(names{xx(1)}))];
      xx(1)='';
   end
end
set(gca,'XTickLabel',xtick);



function tplot(x,y,z)

if ~isnumeric(x)
   error('Expecting a Numeric Vector.  lplot handles non-numeric X variables')
end
if nargin>2
	if isnumeric(z)
      z=num2str(z);
   end
   plot(x,y,'w+')   
else
   plot(x,y,'k+')
end
ax=axis;
dx=(ax(2)-ax(1))*.05;
dy=(ax(4)-ax(3))*.05;
axis([ax(1)-dx ax(2)+dx ax(3)-dy ax(4)+dy])
if nargin>2
   text(x,y,z)
end

