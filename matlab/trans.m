function x=trans(in,instr)
names=fieldnames(in);
for k=1:length(names)
   findit=findstr(instr,names{k});
   if (length(names{k})<=length(instr))&length(findit)>0
      for kk=1:length(findit)
         if findit(kk)==1
            instr=['in.',instr];
            findit=findit+3;
         else
            if ~(isletter(instr(findit(kk)-1))|(instr(findit(kk)-1)=='.'))
               instr=[instr(1:(findit(kk))-1),'in.',instr(findit(kk):length(instr))];
               findit=findit+3;
            end
         end
      end
   end
end
instr=strrep(instr,'^','.^');
%%% This is a modification made 4/4/2000
instr=strrep(instr,'/','./');
instr=strrep(instr,'*','.*');
%%%%%  End of modification 



x=eval(instr);


 







% Old stuff

%t=0;
%for n=1:length(names)
%   fname=findstr(str,names{n});
%   if length(fname)>1
%      error([instr ,'is an improper expression.'])
%   end
%   if length(fname)==1
%      if t==1
%         error([instr,'is an improper expression'])
%      end 
%      str=strrep(str,strcat('in.',names{n}),names{n});
%      str=strrep(str,names{n},strcat('in.',names{n}));
%      t=1;
%   end
%end
%x=eval(str);
      
   
   
      
      

      
      
      



      