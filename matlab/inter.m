%The inter statement returns the interaction matrix from two 
% input matrices.

function xy=inter(x,y)
   [nrowx ncolx]=size(x);
   [nrowy ncoly]=size(y);
   k=1;
   xy=[];   
   for n=1:ncolx
      for m=1:ncoly
         xy=[xy,x(:,n).*y(:,m)];
         k=k+1;
      end
   end
