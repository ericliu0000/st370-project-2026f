% sample(N) gives a random permutation of 1, 2, ..., N
% sample(N,n) gives a random sample of size n
%             without replacement from 1, 2, ..., N
% sample(N,n,1) gives a random sample of size n
%             with replacement from 1, 2, ..., N
% any numerical third argument invokes sampling with replacement

function sample(N,n,t)

if nargin==1
   randperm(N)
end
if nargin==2
if n>N
   error('n must be less than or equal to N.')
end
   z=randperm(N);
   z(1:n)
end
if nargin==3
   floor(rand(1,n)*N)+1
end
