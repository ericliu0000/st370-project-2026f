function mmplot(y,x1,x2,ord)
set(gca,'XLabel',text(0,0,[ord{1},' Level']));
if isnumeric(x1)
   [xa xb]=sort(x1);
   clear xa
   x1=x1(xb);
   x2=x2(xb);
   y=y(xb);
end;
names1=levels(x1);
names2=levels(x2);

x1=stdrd(x1);
x2=stdrd(x2);
set(gca,'Xtick',1:length(names1))
for l=1:max(x2);
   for k=1:max(x1);
      tempmean(k)=sum(y((x1==k)&(x2==l)))/length(y((x1==k)&(x2==l)));
   end
   if l==1
      means=tempmean;
   else
      means=[means;tempmean];
   end
end
hold on
for n=1:l
   if mod(n,4)==1
      lintype='k-';
   elseif mod(n,4)==2
      lintype='k--';
   elseif mod(n,4)==3
      lintype='k-.';
   elseif mod(n,4)==0
      lintype='k:';
   end
   plot(1:k,means(n,:),lintype)
end
hold off
maxlen=0;
for l=1:length(names1)
   maxlen=max(maxlen,length(names1{l}));
end
bl=blanks(maxlen) ;
minmeans=min(min(means));
maxmeans=max(max(means));
rmeans=maxmeans-minmeans;
%low= minmeans-.1*rmeans;
%high=maxmeans+.2*rmeans;
low=min(y);
high=max(y) + .2*rmeans
axis([.5 k+.5 low high]);
xtold=get(gca,'XTick');
xtick='';
xx=1:max(x1);
xx=[xx,NaN];
for l=1:length(xtold)
   if xtold(l)~=xx(1)
      xtick=[xtick;bl];
   else
      xtick=[xtick;names1{xx(1)},blanks(maxlen-length(names1{xx(1)}))];

      xx(1)='';
   end
end
set(gca,'XTickLabel',xtick);

maxlen=0;
for l=1:length(names2)
   maxlen=max(maxlen,length(names2{l}));
end
M='';
for l=1:max(x2)
  M=[M;[ord{2},'=',names2{l},blanks(maxlen-length(names2{l}))]] ;
end
legend(M,1)


function trash(a,s,d)
if nargin==3
   names1=levels(x1);
   names2=levels(x2);
   x1=stdrd(x1);
   x2=stdrd(x2);
   n1=max(x1);
   n2=max(x2);
   total=n1*n2*(n1-1)*(n2-1)/4;
   if total==1
      p=1;
      q=1;
      legfix=.1;
   elseif total==6
      p=3;
      q=2;
      legfix=.25;
   elseif total==3
      p=2;
      q=2;
      legfix=.25;
   else
      p=3;
      q=3;
      legfix=.45;
   end
   k=1;
   for x11=1:(n1-1)
      for x12=(x11+1):n1
         for x21=1:(n2-1)
            for x22=(x21+1):n2
               m11=length(y((x1==x11)&(x2==x21)));
               m12=length(y((x1==x11)&(x2==x22)));
               m21=length(y((x1==x12)&(x2==x21)));
               m22=length(y((x1==x12)&(x2==x22)));
               if (m11~=0)&(m12~=0)&(m21~=0)&(m22~=0)
                  mean11=sum(y((x1==x11)&(x2==x21)))/m11;
                  mean12=sum(y((x1==x11)&(x2==x22)))/m12;
                  mean21=sum(y((x1==x12)&(x2==x21)))/m21;
                  mean22=sum(y((x1==x12)&(x2==x22)))/m22;
                  subplot(p,q,mod(k,p*q)+p*q*(mod(k,p*q)==0));
                  plot([1 3],[mean11 mean21],'k-')
                  hold on
                  plot([1 3],[mean12 mean22],'k:')
                  x11name=names1{x11};
                  x12name=names1{x12};
                  x21name=names2{x21};
                  x22name=names2{x22};
                  l1=length(x11name);
                  l2=length(x12name);
                  ml=max(l1,l2);
                  bl=blanks(ml);
                  x11name=[x11name,blanks(ml-l1)];
                  x12name=[x12name,blanks(ml-l2)];
                  set(gca,'XLabel',text(0,0,'X1 Level'));
                  ax=axis;
                  axis([.5 3.5 ax(3)*.9 ax(4)+(ax(4)-ax(3)*.9)*legfix])
                  xtold=get(gca,'XTick');
                  for l=1:length(xtold)
                     if l==1
                        if xtold(l)~=1
                           xtick=bl;
                        else
                           xtick=x11name;
                        end
                     else
                        if xtold(l)==1
                           xtick=[xtick;x11name];
                        elseif xtold(l)==3
                           xtick=[xtick;x12name];
                        else
                           xtick=[xtick;bl];
                        end
                     end
                  end
                  legend(['X2='x21name],['X2=',x22name],1)
                  set(gca,'XTickLabel',xtick);
                  hold off
                  if (total~=1)&(p*q~=1)
                     if mod(k,p*q)+p*q*(mod(k,p*q)==0)==p*q
                        figure
                        k=0;
                     end
                  end
                  k=k+1;
               end
            end
         end
      end
   end
end
