%  proj(X) gives the projection matrix of X.

function p=proj(x)
p=x*pinv(x'*x)*x';
