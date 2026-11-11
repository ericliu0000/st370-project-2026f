%  STATS(Y) prints summary statistics for the input vevtor Y.
%
%  STATS(Y,X)  prints the same statistics as STATS(Y) for each
%    value of X.
%


function stats(y,x,x1,x2,x3,x4)

if nargin<=2
if nargin==1
   x=ones(length(y),1);
   names{1}=' ';
   nlevels=1;
else
   names=levels(x); 
   x=stdrd(x); 
   nlevels=max(x);
   if length(max(x))>1
      error('Expecting vector inputs');
   end
end
fprintf(['\n'])

blanker=['  ';'  ';'  ';'  ';'  ';'  ';'  ';'  ';'  ';'  '];  
labels=['           ';'N          ';'Mean       ';'Std. Dev.  ';'Q1         ';'Median     '...
        ;'Q3         ';'Min        ';'Max        ';'Range      '];

for n=1:ceil(nlevels/6)
   i=(n*6)-5;
   if nlevels>=n*6
      j=n*6;
   else
      j=nlevels;
   end
   tstat=labels;

   for k=i:j
      tstat=[tstat,xstat(y(x==k),names{k}),blanker];
   end

   for k=1:10
      fprintf([tstat(k,:),'\n']);
      if (k==4)|(k==7)|(k==10)
        fprintf('\n')
      end  
   end
end
fprintf('\n')
return
end


if nargin>=3
   x{1}=x;
   x{2}=x1;
end
if nargin>=4
   x{3}=x2;
end
if nargin>=5
   x{4}=x3;
end
if nargin>=6;
   x{5}=x4;
end
for ll=1:nargin-1
  names=levels(x{ll}); 
  x{ll}=stdrd(x{ll}); 
  nlevels=max(x{ll});
  if length(max(x{ll}))>1
      error('Expecting vector inputs');
   end
 fprintf(['\n\nSummary statistics for Y by X',num2str(ll),'\n\n'])
  
  blanker=['  ';'  ';'  ';'  ';'  ';'  ';'  ';'  ';'  ';'  '];  
tstat=['           ';'N          ';'Mean       ';'Std. Dev.  ';'Q1         ';'Median     '...
      ;'Q3         ';'Min        ';'Max        ';'Range      '];

for k=1:nlevels
   tstat=[tstat,xstat(y(x{ll}==k),names{k}),blanker];
end


for k=1:10
   fprintf([tstat(k,:),'\n']);
   if (k==4)|(k==7)
     fprintf('\n')
   end  
end
fprintf('\n')

end
return
   
   
   
   
   
   
   
   
   
   
   



function stat=xstat(x,name)
x=x(:);

n=length(x);
mean=sum(x)/n;
STAT{1}=0;
STAT{2}=num2str(n);
STAT{3}=num2str(mean);
if n==1
   STAT{4}='0';
else
   STAT{4}=num2str(sqrt((x-mean)'*(x-mean)/(n-1)));
end
STAT{5}=num2str(quantile(x,.25));
STAT{6}=num2str(quantile(x,.5));
STAT{7}=num2str(quantile(x,.75));
STAT{8}=num2str(min(x));
STAT{9}=num2str(max(x));
STAT{10}=num2str(max(x)-min(x));
STAT=fixnum(STAT)';

if length(name)<=length(STAT{1})
   STAT{1}=[blanks(length(STAT{1})-length(name)),name];
else
   STAT{1}=name;
   for k=2:10;
      STAT{k}=[blanks(length(name)-length(STAT{k})),STAT{k}]; 
   end
end 


for k=1:10
   stat(k,1:length(STAT{k}))=STAT{k};
end
