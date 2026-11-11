function out=fixnum(in)
mp=0;
ms=0;
nop=1;
maxlen=0;
n=length(in);
for k=1:n
   if length(findstr('.',in{k}))>0
      nop=0;
   end
   maxlen=max(maxlen,length(in{k}));
end
if nop
   for k=1:n
      test=length(findstr('Inf',in{k}))+length(findstr('NaN',in{k}));
      if test==0;
         out{k}=[blanks(maxlen-length(in{k})),in{k}];
      else  
         out{k}=[blanks(maxlen-1),'.'];
      end
   end
else
   for l=1:n
      if (length(findstr('.',in{l}))==0)&~(strequ('NaN',in{l})|strequ('Inf',in{l})|strequ('-Inf',in{l}))&~isempty(in{l})
         pfx{l}=[in{l},'.'];
         in{l}=[in{l},'.0'];
      elseif ~(strequ('NaN',in{l})|strequ('Inf',in{l})|strequ('-Inf',in{l}))
         pfx{l}=in{l}(1:findstr('.',in{l}));
      elseif strequ('NaN',in{l})|strequ('Inf',in{l})|strequ('-Inf',in{l})
         pfx{l}=['.'];
      elseif isempty(in{l})
         pfx='';
      end
      mp=max(mp,length(pfx{l}));
   end
   for l=1:n
      if length(findstr('.',in{l}))==0
         sfx{l}='';
      else
         sfx{l}=in{l}(findstr('.',in{l})+1:length(in{l}));
      end
      ms=max(ms,length(sfx{l}));
   end
   for l=1:n
      if (strequ('NaN',in{l})|strequ('Inf',in{l})|strequ('-Inf',in{l})|strequ('.',pfx{l}))|(length(findstr('e',in{l}))~=0);
         back=blanks(ms-length(sfx{l}));
      else
         back='';
         for k=1:(ms-length(sfx{l}))
            back=[back,'0']; 
         end
      end
      
      if ~isempty(in{l})
         out{l}=[blanks(mp-length(pfx{l})),pfx{l},sfx{l},back];
      else
         out{l}=blanks(ms+mp);
      end
   end
end
