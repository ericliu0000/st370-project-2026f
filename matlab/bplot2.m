% BPLOT(Y,X) Creates a boxplot of the variable Y
%   by the levels contained in X.  If a single
%   boxplot is desired simply type bplot(Y).
%   BPLOT calls the Matlab function BOXPLOT  				       
%   to do all its drawing.
%








function bplot(y,x)

if nargin==1
   boxplot(y)
   set(gca,'XLabel',text(0,0,''));
   set(gca,'XTickLabel','');
end
if nargin==2
   nmax=0;
   for k=1:max(stdrd(x))
       boxcol{k}=y(find(stdrd(x)==k));
       n(k)=length(boxcol{k});
       nmax=max(nmax,n(k));
   end
   for k=1:max(stdrd(x))
       box(:,k)=[boxcol{k}',ones(1,nmax-n(k))*nan]';
   end
   boxplot(box);
   xnames=levels(x);
   maxname=0;
   for k=1:length(xnames)
      maxname=max(maxname,length(xnames{k}));
   end
   xticker=[xnames{1},blanks(maxname-length(xnames{1}))];
   if length(xnames)>1
      for k=2:length(xnames)
         xticker=[xticker;...
            [xnames{k},blanks(maxname-length(xnames{k}))]];
      end
   end
   set(gca,'XLabel',text(0,0,'X Level'));
  set(gca,'XTick',1:1:k+1);
   set(gca,'XTickLabel',xticker);
end






