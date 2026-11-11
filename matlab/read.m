%  X=READ Creates a data structure named X.
%    After typing X=READ the user is prompted to
%    enter the names of the variables in structure X.
%    Following that the user is asked to type or
%    paste the data into the Matlab window.  When 
%    the data is entered there should be one observation 
%    per line, and the variables should be tab or space delimited.
%    The variables may be numeric or character.  When
%    you are finished entering data, hit return twice.
%
%  Example: Create a dataset named labdata with variables
%    named color, weight, and volume.
%
%    labdata=read
%
%      Type the names of the variables 
%      as they appear from left to right.
%
%    >>color weight volume
%
%      Enter or cut and paste the data below:
%
%    red   4.3  .0021
%    red   4.2  .0045
%    blue  5.6  .0037
%    blue  4.7  .0019
%
%
function out=read(names)
if nargin==0
   names=input('\n  Type the names of the variables \n  as they appear from left to right.\n\n>> ','s');
end
namesold=[names,' '];
while ~strequ(namesold,names)
   namesold=names;
   names=strrep(names,'  ',' ');     
end
if names(1)==' ';
   names(1)='';
end
if names(length(names))==' '
   names(length(names))='';
end
numnames=length(findstr(names,' '))+1;
for k=1:numnames;
   findsp=findstr(names,' ');
   if ~isempty(findsp)
     findsp=findsp(length(findsp));
     name{numnames+1-k}=names(findsp+1:length(names));
     names(findsp:length(names))='';
  else
     name{numnames+1-k}=names;
     names='';
  end
end
data{1}='';
k=1;
fprintf('\n  Enter or cut and paste the data below:\n\n')
while 1
   data{k}=input(' ','s');
   data{k}=strrep(data{k},'	',' ');
   if (isempty(data{k})&(k~=1))
      data(k)='';
      break
   else
      dataold=[data{k},' '];
      while ~strequ(dataold,data{k})
         dataold=data{k};
         data{k}=strrep(data{k},'  ',' ');     
      end
      if dataold(1)==' ';
         dataold(1)='';
         data{k}=dataold;
      end
      if dataold(length(dataold))==' '
         dataold(length(dataold))='';
         data{k}=dataold;
      end 
      data{k}=[' ',data{k}];
      k=k+1;
   end
end
n=length(data);
fprintf('\n')
%for k=1:n
%   fprintf([data{k},'\n'])
%end


%%%%  Now Build the data structure

for i=1:length(name)
   findsp=findstr(data{1},' ');
   findsp=findsp(length(findsp));
   if isnum(data{1}((findsp+1):length(data{1})))
      tempx='';
      for j=1:n
         tempy=data{j};
         findsp=findstr(data{j},' ');
         findsp=findsp(length(findsp));         
         tempx=[tempx',...
            str2num(tempy((findsp+1):length(tempy)))]' ;
         tempy((findsp):length(tempy))='';
         data{j}=tempy;
      end
   else
      tempx='';
      for j=1:n
         tempy=data{j};
         findsp=findstr(data{j},' ');
         findsp=findsp(length(findsp));
         tempx{j,1}=tempy((findsp+1):length(tempy));
         tempy((findsp):length(tempy))='';
         data{j}=tempy;
      end
   end
   data1{length(name)+1-i}=tempx;
end
for i=1:length(name)
   tname=['out.',name{i}];
   eval([tname,'=','data1{',num2str(i),'};']);
end

         
   

