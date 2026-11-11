%  BARPLOT(X) Creates barplot of frequencies of variable X.
%  X may be a numeric vector or a one dimensional cell array of strings
%

function barplot(x)
if strequ(class(x),'double')
   x=sort(x);
end
names=levels(x);
x=stdrd(x);
n=max(x);
numsinx='';
for k=1:n
   numsinx=[numsinx, sum(x==k)];
end
bar(numsinx)
ax=axis;
axis([ax(1) ax(2)+.2*(n==2) ax(3) ax(4)*1.5])
maxlen=0;
for k=1:n;
   maxlen=max(maxlen,length(names{k}));
end

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