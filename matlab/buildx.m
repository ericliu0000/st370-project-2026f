function tempx=buildx(source,name,in)
oldsou=source;
nrow=length(eval(strcat('in.',name{1,1})));
tempx=ones(nrow,1);
while ~isempty(source)
   tempsou='';
   if (~isletter(source(1)))&(~strequ(source(1),'('))
      error('Improper model statement')
   end
   findast=findstr('*',source);
   if isempty(findast)
      tempsou=source;
      source='';
   else
      if source(1)=='*'
         error('Improper location for a *')
      end
      tempsou=source(1:findast(1)-1);
      source(1:findast(1))='';
   end
   t=0;
   names=fieldnames(in);
   k=1;
   easy=0;
   for k=1:length(names)
      if strequ(name{k,1},tempsou)
         easy=1;
         k0=k;
      end  
   end
   if easy
      isfac=name{k0,2};
      if isfac
         tempx=inter(tempx,clas(stdrd(eval(['in.',tempsou]))));
      else
         tempx=inter(tempx,eval(['in.',tempsou]));
      end
      
   else  
      %for n=1:length(fieldnames(in))
      %   tempsou=strrep(tempsou,strcat('in.',name{n,1}),name{n,1});
      %   tempsou=strrep(tempsou,name{n,1},strcat('in.',name{n,1}));
      %end
         tempx=inter(tempx,trans(in,tempsou));
   end
end

   

