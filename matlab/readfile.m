%  READFILE(<filename>,<varnames>) Create struct dataset from file.
%     <filename> is a string containing the name of the file conataining the data.
%     <varnames> is a string containing the names of the variables in the file.
%     
%     It is improtant to note that all the variables in the file
%     must take have the same number of entries, and there can 
%     be no missing values unless they are denoted by a NaN.
%
%
%     Example:    
%
%     >> data=readfile('data.txt','x1 x2 x3')
%     
%     This creates a struct named data with variables x1, x2, and x3
%     from the file data.txt.
%
%     Note that <filename> and <varnames> are contained in single
%     quotes.
%
%  READFILE can be used with no passed parameters, in which case
%      it will interactively ask for the filename and variable names.
%      If it is used in this manner, do not place quotes around
%      information passed to the program.
%
%      The following example does the same thing as the previous
%      one using file2struct without passing parameters. 
%
%  Example
%
%       >> data=readfile
%
%       Enter name of the datafile
%
%       >> data.txt
%
%       Enter names of the variables in the datafile by column
%
%       >> x1 x2 x3
%
%
%	If the first line of the file begins with an '@' then file2struct will
%	  interpret the first line as the list of names of the variables
%	  contained in the file, and the user will not be prompted to enter
%    the names.


function S=readfile(fname,names)

if nargin==0
   fprintf('\n')
   fprintf('Enter name of the datafile\n\n')
   fname=input('>> ','s');
   fname=strrep(fname,' ','');
   fid=fopen(fname,'rt');
   if fid<=0
      error(['The file ',fname,' does not exist'])
   end
   
   %fprintf('\n\n')
   %fprintf('Enter names of the variables in the datafile by column\n\n')
   %names=input('>> ','s');
else
   fname=strrep(fname,' ','');
   fid=fopen(fname,'rt');
   if fid<=0
      error(['The file ',fname,' does not exist'])
   end
end


txt=fread(fid)';
fclose(fid);
if nargin<2
	if strcmp(char(txt(1)),'@');
	   txt(1)='';
	   end1stline=find(txt==10);
	   end1stline=end1stline(1);
	   names=char(txt(1:(end1stline-1)));
	   txt(1:end1stline)='';
	else
	   fprintf('\n\n')
	   fprintf('Enter names of the variables in the datafile by column\n\n')
	   names=input('>> ','s');
	end
end


txt=txt+22*(txt==10);% convert returns to spaces
txt=txt+23*(txt==9);% convert tabs to spaces
for k=1:length(txt)
   if txt(length(txt))==32
      txt(length(txt))='';
   else
      break
   end
end
for k=1:length(txt)
   if txt(1)==32
      txt(1)='';
   else
      break
   end
end
txt=char(txt);
txt=killdupsp(txt);
txt=[txt,' '];
names=killdupsp(names);
names=deblank(names);
names=rot90(deblank(rot90(names,2)),2);
names=[names,' '];
clear txt2 names2
locnames=findstr(names,' ');
locdpoints=findstr(txt,' ');
numnames=length(locnames);
numdpoints=length(locdpoints);
if mod(numdpoints,numnames)~=0
   fprintf('\n\nIMPROPER DATAFILE!!!\n\n')
   error('Incorrect number of variables entered, or one variable has more values than another')
end
locnames=[0,locnames];
locdpoints=[0,locdpoints];
for k=1:(numnames)
   name{k}=names((locnames(k)+1):(locnames(k+1)-1));
end
clear names
firstrow=txt(1:(locdpoints(numnames)));
for k=1:numnames
   temptxt=txt((locdpoints(k)+1):(locdpoints(k+1)-1));
   temptxt=strrep(temptxt,'0','');
   temptxt=strrep(temptxt,'1','');
   temptxt=strrep(temptxt,'2','');
   temptxt=strrep(temptxt,'3','');
   temptxt=strrep(temptxt,'4','');  
   temptxt=strrep(temptxt,'5',''); 
   temptxt=strrep(temptxt,'6','');
   temptxt=strrep(temptxt,'7','');
   temptxt=strrep(temptxt,'8','');
   temptxt=strrep(temptxt,'9','');
   temptxt=strrep(temptxt,'+','');
   temptxt=strrep(temptxt,'-','');
   temptxt=strrep(temptxt,'e','');
   temptxt=strrep(temptxt,'.','');
   temptxt=strrep(temptxt,'NaN','');
   temptxt=strrep(temptxt,'Inf','');
   if isempty(temptxt)
      iscat(k)=0;
   else 
      iscat(k)=1;
   end
end
clear firstrow
for i=1:(numdpoints/numnames)
   for j=1:numnames
      currdata=txt((locdpoints((i-1)*numnames+j)+1):(locdpoints((i-1)*numnames+j+1)-1));
      if iscat(j)
         eval(['S.',name{j},'{i,1}=',char(39),currdata,char(39),';']);
      else
         eval(['S.',name{j},'(i,1)=','str2num(',char(39),currdata,char(39),');']);
      end
   end
end


   

function txt0=killdupsp(txt)
if ~isnumeric(txt) 
   txt=double(txt);
   wasnumeric=0;
else 
   wasnumeric=1;
end
k=1;
while k<=length(txt)
   if txt(k)==32
      k=k+1;
      while (k<=length(txt))
         if txt(k)==32
            txt(k)='';
         else 
            break
         end
      end
   else 
      k=k+1;
   end
end


txt0=txt;
if ~wasnumeric
   txt0=char(txt0);
end
clear txt; 
   
   
   
   
