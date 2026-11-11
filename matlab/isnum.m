%  This function is true if the input is a number 
%    (even if it is a string)

function tv=isnum(x)
if strequ(class(x),'double')
   tv=1;
end
if strequ(class(x),'char')
   if x(1)=='-'
      x(1)='';
   end
   if length(findstr('.',x))>1
      tv=0; 
   else 
      if length(findstr('.',x))==1
         x(findstr('.',x))='';
      end
      
      tv=1;
      for n=1:length(x)
         y=x(n);
         if (y=='1')|(y=='2')|(y=='3')|(y=='4')|(y=='5')|(y=='6')|(y=='7')|(y=='8')|(y=='9')|(y=='0')
            tv=tv*1;
         else
            tv=tv*0;
         end
      end
   end
end
if isempty(x)
   tv=0;
end


  
   