
%  LM(S) Perform Analysis of Variance on stucture S
%
%    LM(S) is essentially a group of commands used for describing, analysing 
%  and graphing linear statistical models.  These commands are:
%
%  CLASS
%  MODEL
%  OUTPUT
%  PPLOT
%  RPLOT  
%
%
%  THE CLASS STATEMENT
%
%  syntax:  class x1 x2 x3 ....
%
%       The CLASS statement declares the variables x1, x2, x3, ... as factors
%    or categorical variables.  If all the dependant variables in your model  
%    are categorical simply type:
%
%   class all 
%
%   at the lm>> prompt.  
%
%   In multiple regression cases, however, the class statement may be omitted.   
%   If a class statement is going to be used, however, it must be given as the 
%   first command following the lm(s) command.
%
%  Examples:
%
%   class act press line nozzle
%   class age sex location
%
%
%  THE MODEL STATEMENT  
%
%  syntax: model y=x1+x2+x1*x2 ... 
%
%       The model statement defines the linear model used to analyze the data
%    contained in S.  The model statement must be given as the first command    
%    following the lm(S) command, or immediately following a CLASS statement.
%    Dependant and regression variables may be transformed by taking powers,
%    logarithms, or exp(x).  Interactions are indicated by *, so the three 
%    way interaction between x1, x2, and x3 is denoted by x1*x2*x3. 
%    Multiple model statements may be used during one call of LM.
%
%
%  Examples:
%
%  model log(speed)=time+time^2+weight+weight^2+weight*time+weight*time^2
%
%  model yield=fert+pesticide+seed+fert*seed+fert*pesticide+pesticide*seed+pesticide*seed+fert
%
%       The second model statement could be placed on two lines rather than one 
%    by placing a ~ at the end if the first line.
%
%  model yield=fert+pesticide+seed+fert*seed+fert*pesticide~
%     +pesticide*seed+pesticide*seed+fert
%
%
%  THE OUTPUT STATEMENT
%
%  syntax: output <output quantity>=<outputname>
%
%      The OUTPUT statement places residuals, parameter solutions,
%    design matrices (not using full rank reparameterization) , or predicted
%    values into the base workspace under name <outputname>.
%
%  Examples:
%
%  output r=x1
%  output s=x1
%  output d=x1
%  output p=x1
%
%  From top to bottom, these commands place a variable named x1 into 
%  the main workspace that contains the residuals, parameter solution, 
%  design matrix, and predicted values, respectively.  
%
%  
%  THE RPLOT STATEMENT
%
%  syntax:  rplot by <variable1>
%
%       The RPLOT command draws a a scatter plot of the residuals 
%     from the most recent model statement, by the variable given    
%     in the command, <variable1>.  The by variable may be either a 
%     regression variable, or a factor in an ANOVA.  
%
%  Example:
%
%    For a plot of residuals by a variable called pesticide:
%
%  rplot by pesticide
%
%  THE PPLOT STATEMENT
%
%  syntax:  pplot by <variable1> 
%           pplot by <variable1> lines=<variable2>
%
%       Without the lines= option, the PPLOT command draws a scatter plot of 
%     the of the data, and a scatter plot of the predicted values, as a function 
%     of <variable1>.  The original data points appear as black +'s, and the predicted 
%     values appear as red o's.
%
%       The lines= option tells pplot to draw a line through the predicted values
%     for each values of <variable2>.  When this option is used, <variable1> must
%     be a regression variable, and <variable2> must be indicated as a factor in 
%     a preceding class statement.  To simply put one line through the predicted
%     values, averaging over all other effects, put lines=1.
%
%
%  Examples: 
%
%  pplot by resistance lines=1
%  pplot by weight lines=sex
%
%
%  OTHER PLOTTING FEATURES
%
%       The Matlab graphics functions, XLABEL, YLABEL, TITLE, SUBPLOT, CLF, and 
%    FIGURE all operate within LM as they normally do.  For more information on these   
%    commands see the relevant help pages.
%
%  LM was developed at North Carolina State University by Chris Gotwalt.
%  For any questions or bug reports contact him at cmgotwal@stat.ncsu.edu
%
%  










function lm(in)
if ~isstruct(in)
   error('Expecting a structure datatype')
end
names=fieldnames(in);
for k=1:length(names)-1
   for l=k+1:length(names)
      if length(findstr(names{k},names{l}))>0
  	      if length(names{k})<length(names{l})
  		     name1=names{k};
  	      	 name2=names{l};
  	      else
	   	     name1=names{l};
	   		  name2=names{k};
	   	  end
	      fprintf(['\nWARNING!!!\nThe variable name, ',name1, ',  is a subset of the name, ',name2,'.\nCertain plotting features may not work.'...
	   	  '\nYou may want to change ',name1,' so that this is no longer the case. \n\n'] ) 
	   	  end
	   end
   end
for k=1:length(names)
   lennames(k)=length(names{k});
end
[trash1 trash2]=sort(lennames);
names=names(trash2);
clear trash1 trash2 lennames



fprintf('\nVariable Names in Input Dataset\n\n')
for k=1:length(names)
   fprintf(['  ',names{k},'\n']);
end
fprintf('\nEnter class or model statement or type ex for examples\n\n');

curr=input('lm>> ','s');
if isempty(curr)
  return
end
curr=[curr,blanks(15)];
if ~((strequ(curr(1:2),'ex'))|(strequ(curr(1:5),'class'))|(strequ(curr(1:5),'model'))|(strequ(curr(1:4),'help')))
  error('Improper Command.')
end
fac=0;
classes={};
hadclas=0;
if strequ(strrep(curr,' ',''),'ex')
   examples=['\nclass x1 x2\nclass all\nmodel y=x1+x2\nmodel y=x1+x2+x1*x2\nmodel log(y)=x1+x2\n',...
         'model y=x1+x1^2+x2+x2^2+x1*x2+x1^2*x2^2+log(x3)\n\nEnter class or model statement\n\n'];
   fprintf(examples)
   curr=input('lm>> ','s');
end
if strequ(curr(1:6),'class ')
   classes={};
   hadclas=1;
   isreg=0;
   curr(1:6)='';
   if ~strequ(strrep(curr,' ',''),'all')&~strequ(strrep(curr,' ',''),'none')&~isempty(strrep(curr,' ',''))
      while length(findstr('  ',curr))>0
         curr=strrep(curr,'  ',' ');
      end
      if curr(1)==' '
         curr(1)='';
      end
      curr=[curr,' '];
      counter=1;
      while length(curr)~=0
         where=findstr(' ',curr);
         where=where(1);
         classes{counter}=curr(1:where-1);
         curr(1:where)='';
         counter=counter+1;
      end
      counter=1;
      fac=1;
   elseif isempty(strrep(curr,' ',''))|strequ(strrep(curr,' ',''),'none')
      isreg=1;
      classes={};
      fact=0;
   elseif strequ(strrep(curr,' ',''),'all')
      classes=names;
      isreg=0;
      fac=1;
   end
else 
   classes={};
   isreg=1;
   fac=0;
end
   %%%%%%%%%%%%%%%%%%%%%%%%
if hadclas

   fprintf('\nEnter model statement\n\n')   
   curr=input('lm>> ','s');
end
hadmod=0;

while ~isempty(strrep(curr,' ',''))
if ~strequ(curr(1:6),'model ')&~hadmod
   error('Expecting a model statement')
end
if strequ(curr(1:6),'model ')
   prewho=who;
%clear  df ms ss scale xx p1 p0 findplus tempx out dx esttxt stderr 
%clear settxt l k mse mstxt sstxt ftxt ptxt maxsou maxdf f p
%clear aa design hadclas predict where bb  df0  hadmod r2 xtxi dftxt 
%clear errors  sourceloc  counter   fac model0   ss0 sse source
%clear count1 count2 errordf findequ model solution

clear y predict design errors source sourceloc solution df 
hadmod=1;
curr(1:6)='';
curr=deblank(curr);
if curr(length(curr))=='~'
   curr(length(curr))='';
   curr1='~';
   while curr1(length(curr1))=='~'
      curr1(length(curr1))='';
      curr=[curr,curr1];
      curr1=input(blanks(7),'s');
   end
   curr=[curr,curr1];
end
curr=strrep(curr,' ','');
findequ=findstr('=',curr);
if length(findequ)==0
   error('No dependent variable given, model statement is missing a =')
end
if findequ==1
   error('Improper location for a =');
end
%%  Indicate which elements of names refer to class variables
for count1=1:length(names)
   names{count1,2}=0;
   for count2=1:length(classes)
      if strequ(classes{count2},names{count1,1})|(names{count1,2}==1)
         names{count1,2}=1;
      end
   end
end
ytext=curr(1:findequ-1);
if findname(ytext,names)>0
   names{findname(ytext,names),2}=2;
end
y=trans(in,ytext);
curr(1:findequ)='';
model=curr;
model0=curr;
% Compute intercept sum of squares
xx=ones(length(y),1);
design=xx;
p0=proj(xx);
ss(1)=y'*p0*y;
ss0=ss(1);
source{1}='Intercept';
df(1)=1;
df0=1;
ms(1)=ss(1)/df(1);
k=1;
scale(1)=1;

%Read and interpret model statement
k=1;
sourceloc='';
model=strrep(model, ' ','');
findplus=findstr(model, '+');
findp1=findstr(model,'(');
findp2=findstr(model,')');


for count1=1:length(findp1)
   for count2=1:length(findplus)
      if (findplus(count2)>findp1(count1))&(findplus(count2)<findp2(count1))
         model(findplus(count2))='$';
      end
   end
end


while length(model)>0
   k=k+1;
   if model(1)=='+';
      error('Misplaced +')
   end;
   findplus=findstr('+',model);
   if length(findplus)==0
      source{k}=strrep(model,'$','+');
      model='';
   else
      if findplus(1)==1
         error('Misplaced +, or improper model statement')
      end 
      source{k}=strrep(model(1:findplus(1)-1),'$','+');
      model(1:findplus(1))='';
   end
   tempx=buildx(source{k},names,in);
   scale(k)=max(max(abs(tempx)));
   [aa bb]=size(design);
   design=[design,tempx];
   sourceloc=[sourceloc,bb+1];
   tempx=tempx/scale(k);%Rescale to avoid major problems
   xx=[xx,tempx];
   p1=proj(xx);
   df(k)=round(trace((p1-p0)));
   if df(k)>0
      ss(k)=y'*(p1-p0)*y;
   else
      ss(k)=0;
   end
   if ss(k)<0
      ss(k)=0;
   end
   if df(k)>0  
      ms(k)=ss(k)/df(k);
   else
      ms(k)=NaN;
   end
   p0=p1;
end
ss=real(ss);
ms=real(ms);
% Compute error sum of squares and related quantities
errors=(eye(length(y))-p0)*y;
predict=p0*y;
sse=real(max(y'*y-y'*p0*y,0));
errordf=length(y)-round(trace((p0)));

if errordf>0
   mse=sse/errordf;
else
   mse=NaN;
end
% Format numeric output quantities
maxsou=6;
maxdf=1;
for l = 1:k
   if (mse>0)&(errordf>0)
      f(l)=ms(l)/mse ;
      p(l)=1-fcdf(ms(l)/mse,df(l),errordf);
   else
      f(l)=NaN;
      p(l)=NaN;
   end
   sstxt{l}=num2str(ss(l));   
   mstxt{l}=num2str(ms(l));
   dftxt{l}=num2str(df(l));
   ftxt{l}=num2str(f(l));
   ptxt{l}=num2str(p(l)) ;   
   maxdf=max(maxdf,length(dftxt{l}));
   maxsou=max(maxsou,length(source{l}));
end
k=k+1;
dftxt{k}=num2str(errordf);
sstxt{k}=num2str(sse);
mstxt{k}=num2str(mse);
ftxt{k}='';
ptxt{k}='';
source{k}='Error';
maxdf=max(maxdf,length(dftxt{k}));
maxsou=max(maxsou,length(source{k}));

dx=4;
sstxt=fixnum(sstxt);
mstxt=fixnum(mstxt);
ftxt=fixnum(ftxt);
ptxt=fixnum(ptxt);
out=['\nSequential Sums of Squares ANOVA Table\n\nSource',blanks(maxsou-6+dx)];
out=[out,blanks(maxdf-2),'df',blanks(dx)];
out=[out,blanks(length(sstxt{1})-2),'SS',blanks(dx)];
out=[out,blanks(length(mstxt{1})-2),'MS',blanks(dx)];
out=[out,blanks(length(ftxt{1})-1),'F',blanks(dx)];
out=[out,blanks(length(ptxt{1})-5),'P-val','\n\n'];
for l=(isreg+2*(~isreg)):k
   out=[out,source{l},blanks(maxsou-length(source{l})+dx)];
   out=[out,blanks(maxdf-length(dftxt{l})),dftxt{l},blanks(dx)];
   out=[out,sstxt{l},blanks(dx)];
   out=[out,mstxt{l},blanks(dx)];
   out=[out,ftxt{l},blanks(dx)];
   out=[out,ptxt{l},blanks(dx),'\n'];
end
r2=real((y'*p0*y-(sum(y)^2)/length(y))/(y'*y-(sum(y)^2)/length(y)));
out=[out,'\nR-square  ',num2str(r2),'\n\n','Standard Error  ',num2str(sqrt(mse)),'\n\n'];

xtxi=pinv(design'*design);
solution=real(xtxi*design'*y);


if isreg
   if min(df)==0&isreg
      out=[out,'!!!Parameter estimates cannot be made because one of \n'];
      out=[out,'   the regression variables is a linear combination\n'];
      out=[out,'   of preceding factors.  In the anova table above\n'];
      out=[out,'   these variables have df=0.\n\n'];
   else
      out=[out,'Parameter Estimates\n\n'];
      for l=1:k-1          %  return design matrix to original scale
         xxret(:,l)=xx(:,l).*(scale(l));
         xtxi=inv(xxret'*xxret);
      end
      b=xtxi*xxret'*y;
      solution=b;
      if mse~=0
         stderr=sqrt(diag(mse*xtxi));
         T=solution./stderr;
      else
         stderr=Inf*ones(1,k)';
         T=stderr
         out=[out,'Parameter Std. Errors not available.\nOverfit model.\n\n'];
      end
      for l = 1:k-1
         esttxt{l}=num2str(b(l));   
         setxt{l}=num2str(stderr(l));
         Ttxt{l}=num2str(T(l));
         p2txt{l}=num2str(2*(1-tcdf(abs(T(l)),errordf)));
      end
      esttxt=fixnum(esttxt);
      setxt=fixnum(setxt);
      p2txt=fixnum(p2txt);
      Ttxt=fixnum(Ttxt);
      out=[out,'Source',blanks(maxsou-6+dx)];
      out=[out,blanks(max(0,length(esttxt{1})-18)),'Parameter Estimate',blanks(dx)];
      out=[out,blanks(max(0,length(setxt{1})-10)),'Std. Error',blanks(length(Ttxt{1})-1+dx),'t',blanks(dx+length(p2txt{1})-5),'p-val\n\n'];
      for l=1:k-1
         out=[out,source{l},blanks(maxsou-length(source{l})+dx)];
         out=[out,blanks(max(0,-1*(length(esttxt{1})-18))),esttxt{l},blanks(dx)];
         out=[out,blanks(max(0,-1*(length(setxt{1})-10))),setxt{l},blanks(dx)];  %,'\n'];
         out=[out,blanks(max(0,-1*(length(Ttxt{1})-1))),Ttxt{l},blanks(dx)];
         out=[out,blanks(max(0,-1*(length(p2txt{1})-5))),p2txt{l},blanks(dx),'\n'];

      end
   end
end
out=[out,'\n'];
fprintf(out);
%clear  ms ss scale xx p1 p0 p2txt T findplus tempx out dx esttxt stderr ;
%clear settxt l k mse mstxt sstxt ftxt ptxt maxsou maxdf f p ;
postwho=who;
for k1=1:length(postwho)
   tf=0;
   for k2=1:length(prewho);
      if strequ(postwho{k1},prewho{k2})
         tf=1;
      end
   end
   if (~tf)&~(strequ('prewho',postwho{k1}))&~(strequ('solution',postwho{k1}))&~(strequ('design',postwho{k1}))...
      &~(strequ('predict',postwho{k1}))&~(strequ('errors',postwho{k1}))&~(strequ('source',postwho{k1})) ...
      &~(strequ('sourceloc',postwho{k1}))&~(strequ('df',postwho{k1}))&~(strequ('y',postwho{k1}))&~(strequ('ytext',postwho{k1}))
      eval(['clear ', postwho{k1}])
   end
   
end




elseif strequ(curr(1:7),'output ')
   %%%% Assign output variables
   curr(1:7)='';
   curr=[curr,blanks(15)];
   findequ=findstr(curr,'=');

   if length(findequ)~=1
      error('Improper output statement.  Expecting a =')
   end
   if curr(1)=='r'
      curr(1:findequ)='';
      curr=strrep(curr,' ','');
      assignin('base',curr,errors);
   elseif curr(1)=='p';
      curr(1:findequ)='';
      curr=strrep(curr,' ','');
      assignin('base',curr,predict);
   elseif curr(1)=='d';
      curr(1:findequ)='';
      curr=strrep(curr,' ','');
      assignin('base',curr,design);
   elseif curr(1)=='s'
      curr(1:findequ)='';
      curr=strrep(curr,' ','');
      assignin('base',curr,solution);
   end
elseif strequ(curr(1:9),'rplot by ') 
   curr(1:9)='';
   curr=strrep(curr,' ','');
   if strequ('pred',curr)|strequ('predict',curr)|strequ('predicted',curr)
      xvar=predict;
   end
   [n trash]=size(names);
   xvarisfact=0;
   tf=0;
   for k=1:n
      if strequ(curr,names{k,1})
         xvar=eval(['in.',curr]);
         tf=1;
         if names{k,2}==1
            xvarisfact=1;
         end
      end
   end
   if  tf==0
      curr1=strrep(curr,'^','.^');
      curr1=strrep(curr1,'*','.*');
      for k=1:n
         curr1=strrep(curr1,strcat('in.',names{k,1}),names{k,1});
         curr1=strrep(curr1,names{k,1},strcat('in.',names{k,1}));
      end
      xvar=eval(curr1);
      clear curr1
   end
   clear tf l k             
   if xvarisfact
      lplot(xvar,errors,'k+')
      ax=axis;
      hold on
      plot([ax(1) ax(2)],[0 0],'k-')
      lplot(xvar,errors,'k+')
      hold off
   else 
      plot(xvar,errors,'k+')
      ax=axis;
      hold on
      plot([ax(1) ax(2)],[0 0],'k-')
      plot(xvar,errors,'k+')
      axis([ax(1)-.1*abs(ax(2)-ax(1)) ax(2)+.1*abs(ax(2)-ax(1)) ax(3) ax(4)])
      hold off
   end
   xlabel(curr)
   ylabel('residual')
   title(['Plot of Residuals By ',curr])
   


%%%%%%%%%%%PPLOT 
   
elseif strequ(curr(1:9),'pplot by ')
   if min(df)==0
      fprintf(['\n\nBecause the model is overparameterized and has ',...
         'effects with 0 degrees of freedom\nplotting features are ',...
         'unavailable.  Redo the model statement without the 0 degree \n',...
         'of freedom effects and try again\n\n'])
   else
   curr(1:9)='';
   finlines=findstr(curr,'lines=');
   if length(finlines)==1
      lintxt=curr(finlines(1)+6:length(curr));
      curr(finlines:length(curr))='';
   else
      lintxt='';
   end
   curr=strrep(curr,' ','');
   xvarname=curr;
   [n trash]=size(names);
   xvarisfact=0;
   tf=0;
   for k=1:n
      if strequ(curr,names{k,1})
         %xvar=eval(['in.',curr]);
         tf=1;
         if names{k,2}==1
            xvarisfact=1;
         end
      end
   end
   xvar=trans(in,curr);
   %  There is some concern over whether or not lplot
   %  will not break down if any of the plotting variables
   %  are not a part of the original input structure
   %  That is there may be trouble with transformed explanatory 
   %  variables.
   
   %if  tf==0
   %  error('The by variable in pplot must be a part of the original input structure.')
   %end
   if length(lintxt)==0
      havleg=0;
	   if xvarisfact
	         lplot(xvar,y,'k+')
            ax=axis;
            hold on
            lplot(xvar,predict,'ro')
            hold off
       else 
            plot(xvar,y,'k+')
            ax=axis;
            hold on
            plot(xvar,predict,'ro')
            axis([ax(1)-.1*abs(ax(2)-ax(1)) ax(2)+.1*abs(ax(2)-ax(1)) ax(3) ax(4)])
            hold off   
       end   
      xlabel(curr)
      ylabel(ytext)
      title(['Plot of Predicted Values By ',curr])
      
   else   % HERE IS THE CODE FOR THE LINES= OPTION FOR LPLOT
      
      if xvarisfact
         error('When there is a lines= variable the by variable cannot be categorical.')
      end
      lvarisfact=0;
      tf=0;
      lintxt=strrep(lintxt,' ','');
      if ~strequ(lintxt,'1')
         for k=1:n
            if strequ(lintxt,names{k,1})
               lvar=eval(strcat('in.',lintxt));
               tf=1;
               if names{k,2}==1
                  lvarisfact=1;
               else
                  error('The lines= variable must be declared categorical by a class statement.')
               end
            end
         end
      else
         %error('The lines=1 option has been disabled.')
         lvar=ones(length(y),1);
      end       
      plot(xvar,y,'k+')
      hold on
      ltype={'k-','k:','k-.','k--','b-','b:','b-.','b--'};
      if ~strequ(lintxt,'1')
         havleg=1;
	   else
		   havleg=0;
		end	
      
         %source0=source;   %I think there was a bug in these commented out commands
         %source0=source0(2:length(source0)-1);
         source0=source(2:(length(source)-1));
         sourceloc0=sourceloc;
         I='';
			[aa bb]=size(design);
         for l=1:length(sourceloc0)
         %   trash4=0;
         %   trash1=findstr(source0{l},xvarname);
         %   trash2=length(xvarname);
         %   keyboard
         %   if (length(trash(1))>0)
         %      for trash5=1:length(trash1)
         %         if trash1(trash5)==1
         %            if length(source0{l})==trash2
         %               trash4=trash4|(strequ(xvarname, source0{l}));
         %            elseif length(source0{l})>length(xvarname)
         %               trash4=trash4|(prod(isletter(source0{l}(1:(trash2+1)))));            
         %            end
         %         else
         %            if trash1(trash5)+trash2>length(source0{l})
         %               trash4=trash4|~((isletter(source0{l}(trash1(trash5)-1)))|(source0{l}(trash1(trash5)-1)=='.')) ;
         %            else
         %               trash4=trash4|~((isletter(source0{l}(trash1(trash5)-1)))|(source0{l}(trash1(trash5)-1)=='.')|(isletter(source0{l}(trash1(trash5)+trash2)))|(source0{l}(trash1(trash5)+trash2)=='.'));
         %            end
         %         end
         %      end
         %   end
         %   tf2=trash4;
         %   clear trash1 trash2 trash3 trash4 trash5
            
            
            if (l<length(sourceloc0))
               if (sourceloc0(l+1)-sourceloc0(l)==1)...
                     &(length(findstr(source0{l},xvarname))~=0) 
                  I=[I,l];
               end
            else
               if (bb-sourceloc0(l)==0)&(length(findstr(source0{l},xvarname))~=0)
                  I=[I,l];
               end
            end
         end
         source0=source0(I);
         sourceloc0=sourceloc0(I);

         levelnames=levels(lvar);
         lvar=stdrd(lvar);
			numknots=20;
         for k=1:max(lvar)
				ppred='';
		    	xvarplot='';
			   minxvar=min(xvar(lvar==k));
				maxxvar=max(xvar(lvar==k));
				dxvar=(maxxvar-minxvar)/numknots;
            lenlvar0=sum(lvar==k);
				for l=0:numknots
				   aatxt=num2str(aa);
				   thevalue=['(',num2str(minxvar+l*dxvar),'*ones(',aatxt,',1)',')'];
					design0=design(lvar==k,:)  ;
				   for j=1:length(sourceloc0)
				   	tempcol=trans(in,strrep(source0{j},xvarname,thevalue));  

			         design0(:,sourceloc0(j))=tempcol(lvar==k);
				   end
				  	ppred=[ppred',(1/lenlvar0)*ones(1,lenlvar0)*design0*solution]';
				   xvarplot=[xvarplot',minxvar+l*dxvar]';
			   end
				plot(xvarplot,ppred,ltype{mod(k,8)+8*(mod(k,8)==0)})
		   end


         maxlen=length(ytext);
         for k=1:length(levelnames)
            maxlen=max(maxlen,length(levelnames{k}));
         end
         legnd=[blanks(maxlen-length(ytext)+length(lintxt)+1),ytext];
         for k=1:k
            legnd=[legnd;lintxt,'=',levelnames{k},blanks(maxlen-length(levelnames{k}))];
         end
%%%%%%%%%%%
          hold off
   end
      
      ax=axis;
      xsh=.1*(ax(2)-ax(1));
      ysh=.25*(ax(4)-ax(3))*~(strequ(lintxt,'1'));
      axis([ax(1)-xsh ax(2)+xsh ax(3) ax(4)+ysh])
      xlabel(curr)
      ylabel(ytext)
      if havleg
         legend(legnd)
      end
   end
elseif curr(1)=='k'
   fprintf('\nType dbquit to exit K mode\n')
   keyboard
elseif strequ(curr(1:3),'clf')
   clf
elseif strequ(curr(1:7),'subplot')|strequ(curr(1:6),'figure')|strequ(curr(1:5),'title')|...
         strequ(curr(1:8),'xlabel')|strequ(curr(1:8),'ylabel');
   eval(curr)
end
curr=input('lm>> ','s');
curr=[curr,blanks(15)];
end

