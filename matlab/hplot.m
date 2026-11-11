% hplot(y,n) makes a histogram of y with n bins.
% The left scale is constructed so that the
% area in the bars sums to 1.

function hplot(y,n)

if nargin==1
   [n,x] = hist(y);
   n=n/(sum(n)*(x(2)-x(1)));
   bar(x,n,1,'w')
end
if nargin==2
   [n,x] = hist(y,n);
   n=n/(sum(n)*(x(2)-x(1)));
   bar(x,n,1,'w')
   end
