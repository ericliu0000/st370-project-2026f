function means(y,x1,x2,x3,x4,x5)
% means(Y,X1,X2) produces the means of Y broken down by factors X1 and X2
% separately and then by all combinations of levels of X1 and X2.
%
% means(Y,X1,X2,X3,X4) produces the means of Y for each factor X1, X2, X3, X4,
% and then by all two-way combinations of these factors.
%


for k=1:nargin
   if ~isempty(inputname(k))
      names{k}=inputname(k);
   else
      if k==1
         names{k}='y';
      else
         names{k}=['x',num2str(k-1)];
      end
   end
end



respname=names{1};
if nargin==2
   factname=names{2};
   oneway(y,x1,respname,factname)
end

if nargin==3
   factname{1}=names{2};
   factname{2}=names{3};
   oneway(y,x1,respname,factname{1})
   oneway(y,x2,respname,factname{2})
   twoway(y,x1,x2,respname,factname)
end

if nargin==4
   factname{1}=names{2};
   factname{2}=names{3};
   factname{3}=names{4};
   oneway(y,x1,respname,factname{1})
   oneway(y,x2,respname,factname{2})
   oneway(y,x3,respname,factname{3})
   twoway(y,x1,x2,respname,{factname{1},factname{2}})
   twoway(y,x1,x3,respname,{factname{1},factname{3}})
   twoway(y,x2,x3,respname,{factname{2},factname{3}})
end

if nargin==5
   factname{1}=names{2};
   factname{2}=names{3};
   factname{3}=names{4};
   factname{4}=names{5};
   oneway(y,x1,respname,factname{1})
   oneway(y,x2,respname,factname{2})
   oneway(y,x3,respname,factname{3})
   oneway(y,x4,respname,factname{4})
   twoway(y,x1,x2,respname,{factname{1},factname{2}})
   twoway(y,x1,x3,respname,{factname{1},factname{3}})
   twoway(y,x1,x4,respname,{factname{1},factname{4}})
   twoway(y,x2,x3,respname,{factname{2},factname{3}})
   twoway(y,x2,x4,respname,{factname{2},factname{4}})
   twoway(y,x3,x4,respname,{factname{3},factname{4}})
end
if nargin==6
   factname{1}=names{2};
   factname{2}=names{3};
   factname{3}=names{4};
   factname{4}=names{5};
   factname{5}=names{6};
   oneway(y,x1,respname,factname{1})
   oneway(y,x2,respname,factname{2})
   oneway(y,x3,respname,factname{3})
   oneway(y,x4,respname,factname{4})
   oneway(y,x5,respname,factname{5})
   twoway(y,x1,x2,respname,{factname{1},factname{2}})
   twoway(y,x1,x3,respname,{factname{1},factname{3}})
   twoway(y,x1,x4,respname,{factname{1},factname{4}})
   twoway(y,x1,x5,respname,{factname{1},factname{5}})
   twoway(y,x2,x3,respname,{factname{2},factname{3}})
   twoway(y,x2,x4,respname,{factname{2},factname{4}})
   twoway(y,x2,x5,respname,{factname{2},factname{5}})
   twoway(y,x3,x4,respname,{factname{3},factname{4}})
   twoway(y,x3,x5,respname,{factname{3},factname{5}})
   twoway(y,x4,x5,respname,{factname{4},factname{5}})
end







function oneway(y,x1,respname,factname,nums)
   if iscell(x1)
      name{1}=x1{1};
      for n=2:length(y)
         t=0;
         for s=1:length(name);
            t=t+strequ(name{s},x1{n});
         end
         if t==0
            name{length(name)+1}=x1{n};
         end
      end
   else
      name{1,1}=num2str(x1(1));
      for n=2:length(y)
         t=0;
         for s=1:length(name);
            t=t+(strequ(name{s,1},num2str(x1(n))));
         end
         if t==0
            name{length(name)+1,1}=num2str(x1(n));
         end
      end
   end
   x1=stdrd(x1);
   nmeans=max(x1);
   maxnumelem=0;
   for k=1:nmeans
      mean(k)=sum(y(find(x1==k)))/length(find(x1==k));
      numelem{k}=num2str(length(find(x1==k)));
      meantxt{k}=num2str(mean(k));
      maxnumelem=max(maxnumelem,length(numelem{k}));
   end
   meantxt=fixnum(meantxt);
   maxmeantxt=max(length(meantxt{1}),4);
   maxsou=6;
   for k=1:length(name)
      maxsou=max(maxsou,length(name{k}));
   end
   out=['\nMeans of Y variable '];
   if ~isempty(respname)
      tempout=[', ',respname,', '];
   else
      tempout='';
   end
   out=[out,tempout,'by X variable'];
   if ~isempty(factname)
      tempout=[', ',factname];
   else
      tempout='';
   end
   dx=4;
   out=[out,tempout,'\n'];
   out=[out,'Source',blanks(maxsou-6+dx),blanks(maxnumelem-1),'N',blanks(maxmeantxt-4+dx),'Mean\n'];
   for k=1:length(name)
      out=[out,name{k},blanks(maxsou-length(name{k})+dx)];
      out=[out,blanks(maxnumelem-length(numelem{k})),numelem{k},blanks(dx)];
      out=[out,blanks(maxmeantxt-length(meantxt{1})),meantxt{k},'\n'];
   end
   out=[out,'\n'];
   fprintf(out)
   return
   %%%%%%%%%%%%%%%%%%%%%%%

   function twoway(y,x1,x2,respname,factname)

   if iscell(x1)
      name1{1}=x1{1};
      for n=2:length(y)
         t=0;
         for s=1:length(name1);
            t=t+strequ(name1{s},x1{n});
         end
         if t==0
            name1{length(name1)+1}=x1{n};
         end
      end
   else
      name1{1,1}=num2str(x1(1));
      for n=2:length(y)
         t=0;
         for s=1:length(name1);
            t=t+(strequ(name1{s,1},num2str(x1(n))));
         end
         if t==0
            name1{length(name1)+1,1}=num2str(x1(n));
         end
      end
   end
   %%%%  Set up the second independant variable
   if iscell(x2)
      name2{1}=x2{1};
      for n=2:length(y)
         t=0;
         for s=1:length(name2);
            t=t+strequ(name2{s},x2{n});
         end
         if t==0
            name2{length(name2)+1}=x2{n};
         end
      end
   else
      name2{1,1}=num2str(x2(1));
      for n=2:length(y)
         t=0;
         for s=1:length(name2);
            t=t+(strequ(name2{s,1},num2str(x2(n))));
         end
         if t==0
            name2{length(name2)+1,1}=num2str(x2(n));
         end
      end
   end
   %%%%  Compute means
   x1=stdrd(x1);
   x2=stdrd(x2);
   for k=1:max(x1)
      mean1(k)=sum(y(find(x1==k)))/length(find(x1==k));
      numelem1{k}=num2str(length(find(x1==k)));
      meantxt1{k}=num2str(mean1(k));
   end
   for k=1:max(x2)
      mean2(k)=sum(y(find(x2==k)))/length(find(x2==k));
      numelem2{k}=num2str(length(find(x2==k)));
      meantxt2{k}=num2str(mean2(k));
   end
   meantxt1=fixnum(meantxt1);
   meantxt2=fixnum(meantxt2);
   for n=1:max(x1)
      x1temp=x1(find(x1==n));
      x2temp=x2(find(x1==n));
      ytemp=y(find(x1==n));
      for m=1:max(x2)
         subx2=find(x2temp==m);
         if isempty(subx2)
            mean{m,n}='.';
         else
            meantxt{m,n}=num2str(sum(ytemp(find(x2temp==m)))/length(find(x2temp==m)));
         end
      end
   end
   for n=1:max(x1)
      meantxt(:,n)=fixnum(meantxt(:,n));
   end
   dx=4;
   if isempty(factname{1})
      factname{1}='x1';
   end
   if isempty(factname{2})
      factname{2}='x2';
   end
   col1length=length(factname{2});
   for k=1:length(name1)
      if k~=1
         maxmeantxt(k)=max(length(meantxt{1,k}),length(name1{k}));
      else
         maxmeantxt(k)=max(length(meantxt{1,k}),length(name1{k}));
         maxmeantxt(k)=max(maxmeantxt(k),length(factname{1}));
      end
   end
   col2length=0;
   for k=1:length(name2)
      col2length=max(col2length,length(name2{k}));
   end
   out=['\nTable of means of Y variable ',respname,' by X variables ',factname{1},' and ',factname{2},'\n'];
   out=[out,blanks(col1length+dx+col2length+dx+maxmeantxt(1)-length(factname{1})),factname{1},'\n'];
   out=[out,blanks(col1length+dx+col2length+dx)];
   for k=1:length(name1)
      out=[out,blanks(maxmeantxt(k)-length(name1{k})),name1{k},blanks(dx)];
   end
   out=[out,'\n',factname{2},blanks(dx),name2{1},blanks(col2length-length(name2{1})+dx)];
   for k=1:length(name1)
      out=[out,blanks(maxmeantxt(k)-length(meantxt{1,k})),meantxt{1,k},blanks(dx)];
   end
   out=[out,'\n'];
   for m=2:length(name2)
      out=[out,blanks(col1length+dx),name2{m},blanks(col2length-length(name2{m})+dx)];
      for n=1:length(name1)
         out=[out,blanks(maxmeantxt(n)-length(meantxt{m,n})),meantxt{m,n},blanks(dx)];
      end
      out=[out,'\n'];
   end
   fprintf(out)
return
