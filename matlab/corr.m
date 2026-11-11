%  CORR(X,Y)  Computes the correlation
%    of X and Y.

function c=corr(x,y)
x=x(:);
y=y(:);
n=length(x);
if n~=length(y)
   error('Inputs must have same length.')
end

c=sum(x.*y)-sum(x)*sum(y)/n;
c=c/sqrt(((x-mean(x))'*(x-mean(x)))*(y-mean(y))'*(y-mean(y)));
