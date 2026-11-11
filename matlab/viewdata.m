%  VIEWDATA(X) Prints the data contained in X
%    in a table.  X must be a structured dataset.
%    Only variables in X that have the same number 
%    of rows as the first variable in X will be printed.
%
%  VIEWDATA(X,n) Same as VIEWDATA(X), except that
%    it prints only the first n entries of X.
function viewdata(x,nrow)
if ~isstruct(x)
   error('Expecting a structured dataset')
end
names=fieldnames(x);
xx=struct2cell(x);
[m n]=size(xx{1});
xx0=xx{1};
purge=[0];
for k=1:length(xx);
   [m0 n0]=size(xx{k});
   if ~((m0==m)&(n0==1))
      purge=[purge, k];
   end
end
purge(1)='';
while ~isempty(purge);
   xx(purge(1))='';
   names(purge(1))='';
   purge(1)='';
   if ~isempty(purge);
      purge=purge-1;
   end
end
if nargin==2
   m=min(nrow,m);
end
n=length(xx);
for j=1:length(xx);
   tempx=xx{j};
   if strequ(class(xx{j}),'double')
      for i=1:m
         xtxt{i,j}=num2str(tempx(i));
      end
      xtxt(:,j)=fixnum(xtxt(:,j))';
      maxlength(j)=max(length(names{j}),length(xtxt{1,j}));
      for i=1:m
         xtxt{i,j}=[blanks(maxlength(j)-length(xtxt{i,j})),xtxt{i,j}];
      end
   elseif strequ(class(xx{j}),'cell')
      maxlength(j)=length(names{j});
      for i=1:m
         maxlength(j)=max(maxlength(j),length(tempx{i}));
      end
      for i=1:m
         xtxt{i,j}=[blanks(maxlength(j)-length(tempx{i})),tempx{i}];
      end
   end
end
mtxt=num2str(m);
obsmax=max(3,length(mtxt));
dx=3;
out='';
toprow=['\nObs'];
for k=1:n
   toprow=[toprow,blanks(dx+maxlength(k)-length(names{k})),names{k}];
end
toprow=[toprow,'\n\n'];
rtop=50;
for i=1:m
   if mod(i-1,rtop)==0
      out=[out,toprow];
   end
   out=[out,blanks(obsmax-length(num2str(i))),num2str(i)];
   for j=1:n
      out=[out,blanks(dx),xtxt{i,j}];
   end
   
   out=[out,'\n'];
end
out=[out,'\n'];
fprintf(out);


         
      
      
   
   