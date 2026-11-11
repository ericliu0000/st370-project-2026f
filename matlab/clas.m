function d = clas(x)
  lx = length(x);
   if lx ~= prod(size(x));
     error('Requires a vector first argument.')
   end
   x=x(:);
   m=max(x);
   d=[];
   for k = 1:m
      t=x;
      for l = 1:lx
         t(l) = (x(l)==k);
      end
      d=[d,t];
   end
   