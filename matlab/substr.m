%  SUBSTR(S,instring)
%     The substr function takes a subset of a structured dataset.
%   S is a structure and instring is a string indicating what subset 
%   is to be taken.  instring is if the form:
%
%   'varname=level'
%
%   Where varname is a variable contained in S and level is the level 
%   of varname we are picking out.  Basically, substr picks out the 
%   'rows' of S that correspond to varname==level.
%
%   Examples
%
%   substr(jet,'act=A1')
%   substr(S,'weight=1.5')
%









function sout=substr(s,in)
if ~isstruct(s)
   error('First input must a be a struct')
end
if ~ischar(in)
   error('Second input must a be a string')
end
names=fieldnames(s);
in=strrep(in,' ','');
findequ=findstr(in,'=');
if length(findstr(in,'='))~=1
   error('Expecting an = in the second input, or too many =.')
end
varname=in(1:findequ-1);
level=in(findequ+1:length(in));
numnames=length(names);
t=0;
for k=1:numnames
   if strequ(names{k},varname)
      kk=k;
      t=1;
   end
end
if ~t
   error('The indicated varname in the second input is not a variable for the input structure')
end
cellstr=struct2cell(s);
levelvec=cellstr{kk};
cellstr2=cellstr;
clear cellstr;
names2=names;
clear names
l=1;
for k=1:numnames
   if k~=kk
      cellstr{l,1}=cellstr2{k};
      names{l}=names2{k};
      l=l+1;
   end
end
stdrdvec=stdrd(levelvec);

levnames=levels(levelvec);
t=0;
for k=1:length(levnames)
   if strequ(levnames{k},level)
      t=1;
      kk=k;
   end
end
if ~t 
   error('  ')
end

for k=1:length(names)

x0=cellstr{k};
%keyboard
   if strequ(class(cellstr{k}),'cell')
      j=1;
      for l=1:length(cellstr{k})
        if stdrdvec(l)==kk
	  temp{j,1}=x0{l};
	  j=j+1;
	end
      end
      cellstr{k}=temp;	  
   else
      cellstr{k}=x0(stdrdvec==kk) ;     
   end
end
sout=cell2struct(cellstr,names);


