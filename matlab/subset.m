% SUBSET(STRUCT,EXPRESSION) Forms a structured data set
%   that is a subset of the input structure, STRUCT.  
%
%    EXPRESSION is a logical expression enclosed in 
%    single quotes.  
%
%  Example:
%
%  >>subset(data, '((a>=7)&(a<55))|(name=="Jones")')
%  
%    This call of the function will form a subset of the
%    struct, data, that consists of all the points where 
%    the numeric variable data.a is between 7 and 56 or the 
%    character variable data.name is equal to Jones.  Note the 
%    use of double quotations.
%
%    As another illustration, the following call will
%    have the same effect as the one above:
%
%    >>subset(data,'~(((a<7)|(a>=55))&(name~="Jones"))')
%
%    Some transformations are supported, such as:
%
%    >>subset(data,'abs(a)>1')
%    
%    There is a special syntax for selecting observations:
%
%    >>subset(data,'obs#>=15')
%
%    This selects the 15th to the last observation and
%
%    >>subset(data,'(obs#>=5)&(obs#<50)')
%
%    selects the 5th to the 49th observations.
%
% SUBSET(STRUCT, STRING, N) Where STRING is either
%    'head' or 'tail' will select the first N observations
%    or the last N observations, depending on the value 
%    of STRING.
%
% SUBSET(STRUCT, INDEX) This forms a dataset containing
%    the observations specified by index.  For example:
%
%    >>subset(data, [1 1 1 2 2 7 7 3 8])
%
%    creates a struct consisting of 3 copies of the 1st
%    observation, 2 copies of the 2nd and 7th observations,
%    and 1 copy each of the 3rd and 8th observation.  This 
%    form of subset is useful for bootstapping analyses.
%
%





function out=subset(S,txt,k)




if isstr(txt)
   names=fieldnames(S);
   n=length(eval(['S.',names{1}]));
   numnames=length(names);
   Scell=struct2cell(S);
   siscell=eval(['iscell(S.',names{1},')']);
   obs_=(1:n)';
   txt=strrep(txt,'obs#','obs_');
   if (2*length(findstr(txt,'=='))+length(findstr(txt,'~='))+...
         length(findstr(txt,'<='))+length(findstr(txt,'>=')))<length(findstr(txt,'='))
      fprintf('\n\nImproper second input.\n')
      fprintf('Logical equals is given by "==" not "="\n')
      fprintf('Replace the "=" by "==" and try again.\n\n')
      error('  ' )
   end

      
   for i=2:numnames
      siscell(i)=eval(['iscell(S.',names{i},')']);
      [a1 a2]=size(eval(['S.',names{i}]));
      if (a1~=n)
         fprintf('\n\nInvalid Input Struct !!!\n\n')
         error('All data vectors in input struct must have same length');
      elseif (a2~=1)
         fprintf('\n\nInvalid Input Struct !!!\n\n')
         error('Input Struct may only contain 1-dimensional arrays');
      end
   end


   if nargin==3
      if (k<1)|(k>n)
         error('The third input must be >=1 or <=n')
      end
      if strcmp(txt,'head')|strcmp(txt,'HEAD')
         for i=1:numnames
            temp=Scell{i}(1:k);
            eval(['out.',names{i},'=','temp;']);
         end
      elseif strcmp(txt,'tail')|strcmp(txt,'TAIL')
         for i=1:numnames
            temp=Scell{i}(n-k+1:n);
            eval(['out.',names{i},'=','temp;']);
         end
      else 
         error(['Improper Input'])
      end
      return
   end

   names=fieldnames(S);
   numnames=length(names);
   Scell=struct2cell(S);




   for i=1:numnames;
      siznames(i)=length(names{i});
   end
   [siznames sorter]=sort(siznames);
   snames=names(sorter);
   siscell=siscell(sorter);
   maxlennames=siznames(numnames);
   poiter=1;
   txt2='';
   
   while ~isempty(txt)
      
      pointer=length(txt)+1;
      for i=1:numnames
         if length(txt)>=siznames(i);
            temp=findstr(snames{i},txt);
            if ~isempty(temp)
               if temp(1)<=pointer
                  pointer=temp(1);
                  minname=i;
               end
            end
         end
      end
      if pointer==(length(txt)+1)
         txt2=[txt2,txt];
         txt='';
         break
      end
      if pointer>1
         txt2=[txt2,txt(1:(pointer-1))];
         txt(1:(pointer-1))='';
      end
      
      if length(txt)==siznames(minname)
         txt2=[txt2,'S.',txt];
         txt='';
         break
      end
      temp=siznames(minname)+1;
      if (txt(temp)=='<')|(txt(temp)=='>')|(txt(temp)=='=')|(txt(temp)=='~')|(txt(temp)==')')
         if siscell(minname)
            if (~strcmp(txt(temp:(temp+1)),'=='))&(~strcmp(txt(temp:(temp+1)),'~='))
               fprintf('\nImproper second argument.\n\n')
               fprintf('The only logical operators on text variables\n\n')
               fprintf('are == and ~=\n\n')
               error(' ')
            end
            if strcmp(txt(temp:(temp+1)),'~=')
               neg=1;
            else
               neg=0;
            end
            
            findquo=findstr('"',txt);
            if length(findquo)<2
               error('Expecting double quotes ""')
            end
            if findquo(1)==(findquo(2)-1)
               error('Quotation marks may not immediately follow one another')
            end
            txt2=[txt2,'locincell(S.',snames{minname},',',char(39),txt((findquo(1)+1):(findquo(2)-1)),char(39),',',num2str(neg),')'];
            txt(1:findquo(2))='';
         else
            txt2=[txt2,'S.',txt(1:(siznames(minname)))];
            txt(1:(siznames(minname)))='';
         end
      elseif isletter(txt(temp))
         txt2=[txt2,txt(1:temp)];
         txt(1:temp)='';
         for i=1:length(txt)
            if ~isempty(txt)
               if isletter(txt(1))
                  txt2=[txt2,txt(1)];
                  txt(1)='';
               else
                  break
               end
            else
               break
            end
         end
      end
   end
   
   expn=eval(txt2);
   expn=find(expn==1);
   for i=1:numnames
      Scell{i}=Scell{i}(expn);
   end
   out=cell2struct(Scell,names);
elseif isnumeric(txt)
   txt=txt(:);
   names=fieldnames(S);
   Scell=struct2cell(S);
   for i=1:length(names)
      Scell{i}=Scell{i}(txt);
   end
   out=cell2struct(Scell,names);
else
   error('Improper Input')
end


   
   
   
      


function out=locincell(in, txt, neg)

n=length(in);
for i=1:n
   if strcmp(txt,in{i})
      out(i,1)=1;
   else
      out(i,1)=0;
   end
end
if neg==1
   out=~out;
end


      
   
   
   
   
   
   
   
   
   

      
   
      
