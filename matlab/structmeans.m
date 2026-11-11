%STRUCTMEANS(data,yvariables,xvariables) creates a STRUCT containing the 
%	means of the variables listed in yvariables computed for each combination
% 	of the levels of the variables listed in xvariables.
%
%
%  data   must be a struct dataset containing at least 2 variables
%     y   must be a character string containing the comma delimited names
%         of numerical variables contained in 'data'
%     x   must be a character string containing the comma delimited names
%         of numeric or cell array variables contained in 'data'
%         
%
% Examples:
%
%   >> actmeans = structmeans(actuator,'force','act')
%
%   >> actmeans = structmeans(actuator,'force','act,press')
%
%   >> capacmeans = structmeans(capac,'capac,perim','shape')
%
%   >> yarnmeans = structmeans(yarn,'count,tensile','type')
%
%


function out=structmeans(data,yin,xin)
if (nargin ~= 3);
   error('STRUCTMEANS requires three arguments')
end
if (~ischar(yin))|(~ischar(xin));
   error('The second and third arguments to STRUCTMEANS must be enclosed in quotes')
end
if (~isstruct(data))
   error('The first argument to STRUCTMEANS must be a STRUCT')
end
dataname=inputname(1);
yin=[yin,','];
xin=[xin,','];
yin=strrep(yin,' ','');
xin=strrep(xin,' ','');


numcov=length(findstr(',',yin));
numfac=length(findstr(',',xin));
for i=1:numcov
   currcomma=findstr(',',yin);
   covnames{i}=yin(1:(currcomma(1)-1));
   yin(1:currcomma(1))='';
end
for i=1:numfac
   currcomma=findstr(',',xin);
   facnames{i}=xin(1:(currcomma(1)-1));
   xin(1:currcomma(1))='';
end

for i=1:numcov
   covs{i}=eval(['data.',covnames{i}]);
   if ~isnumeric(covs{i})
      error('The variables listed in the second argument must all be numeric.')
	end      
end
for i=1:numfac
   facs{i}=eval(['data.',facnames{i}]);
   if isnumeric(facs{i})
      isanum(i)=1;
   else 
      isanum(i)=0;
   end    
end
n=length(covs{1});
for i=1:n
   dummyvar{i,1}='';
   for j=1:numfac
      if isanum(j)
         dummyvar{i}=[dummyvar{i},num2str(facs{j}(i))];
      else
         dummyvar{i}=[dummyvar{i},strrep(facs{j}{i},' ','')];
      end
      dummyvar{i}=[dummyvar{i},' '];
   end
end

stdx=stdrd(dummyvar);
numlevel=max(stdx);

for j=1:numlevel
   curr1=(stdx==j);
   curr2=sum(sum(curr1));
   for i=1:numcov;
      outcovs{i}(j,1)=sum((covs{i}(curr1)))/curr2;
   end
end
j=1;
for i=1:n
   if j==stdx(i)
      for k=1:numfac
         if isanum(k)
            eval(['out.',facnames{k},'(j,1)=data.',facnames{k},'(i);']);
         else
            eval(['out.',facnames{k},'{j,1}=data.',facnames{k},'{i};']);
         end
      end
      j=j+1;
   end
end
for k=1:numcov
   eval(['out.',covnames{k},'=outcovs{k};']);
end


return


   




