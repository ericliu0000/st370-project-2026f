%  STRUCT2FILE(STRUCT,FILENAME) Save data in STRUCT as an ASCII file
%     named FILENAME.  STRUCT must be a structured dataset that contains
%     only vectors (including cell-array text vectors).  Also,
%     FILENAME must be contained in quotes.
%
%     FILENAME may be omitted, in which case the program will prompt
%     user for the name of the file.
%
%  Example:
%
%     To save the actuator dataset in a file called actuator.dat type:
%
%     >> struct2file(actuator,'actuator.dat')
%




function struct2file(S,fname)

if nargin==1;
   fprintf('\nEnter the name of the file you wish to save the struct in\n\n')
   fname=input('>> ','s');
end
fname=strrep(fname,' ','');
names=fieldnames(S);
S=struct2cell(S);
dx=2;
[p,n]=size(S);
n=length(S{1});
for k=1:p
   outcell{1,k}=names{k};
   maxlen(k)=length(names{k});
end
for k=1:n
   for m=1:p
      if isnumeric(S{m})
         outcell{k+1,m}=num2str(S{m}(k));
         maxlen(m)=max(length(outcell{k+1,m}),maxlen(m));
      else
         outcell{k+1,m}=S{m}{k};
         maxlen(m)=max(length(outcell{k+1,m}),maxlen(m));
      end
   end
end
out='@  ';
for k=1:(n+1)
   for m=1:p
      out=[out,blanks(maxlen(m)-length(outcell{k,m})),outcell{k,m},blanks(dx)];
   end
   out=[out,'\n  '];
end
fid=fopen(fname,'wt+');
fprintf(fid,out);
fclose(fid);
