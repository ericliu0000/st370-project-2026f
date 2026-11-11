function q=quantile(x,p)
% quantile(x,p) gives interpolated sample pth quantile of x
% (same as 100pth percentile)
%
% type quantile
%
% shows the code
%

x=sort(x);
n=length(x);
k=floor((n+1)*p);
if k==0
   q=x(1);
elseif k==n
   q=x(n);
else
  q=x(k)+((n+1)*p-k)*(x(k+1)-x(k));
end
