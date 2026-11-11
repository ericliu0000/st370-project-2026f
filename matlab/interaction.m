% INTERACTION(X1,X2,X3,X4,X5)
%
%     This function creates a new class variable that represents
%   the levels of the interaction of x1 x2 x3 x4 and x5.
%   Only the first two inputs are required.
%

function x=interaction(x1,x2,x3,x4,x5)

x=intter(x1,x2);
if nargin>2
   x=intter(x,x3);
end
if nargin>3
   x=intter(x,x4);
end
if nargin>4
   x=intter(x,x5);
end


function x=intter(x1,x2)

n=length(x1);

if ~iscell(x1)
   for k=1:n
      tempx{k}=num2str(x1(k));
   end
   x1=tempx;
end

if ~iscell(x2)
   for k=1:n
      tempx{k}=num2str(x2(k));
   end
   x2=tempx;
end

for k=1:n
   x{k,1}=[x1{k},'_',x2{k}];
end
