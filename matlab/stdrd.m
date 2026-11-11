function y = stdrd(x)
lx = length(x);
if lx ~= prod(size(x));
   error('Requires a vector first argument.')
end
x=x(:);
xx=x;
y=x;
k=1;
[a,b]=size(xx);
if strequ(class(x),'double')
   while b ~= 0
      name = xx(1);
      fx = find(x == name);
      for l = 1:length(fx)
         y(fx(l)) = k;
      end
      fxx = find(xx == name);
      for l = 1:length(fxx);
         xx(fxx(l)-l+1) = '';
      end
      k = k+1;
      [a,b]= size(xx);
   end
elseif strequ(class(x),'cell')
   if strequ(class(x{1}),'double')
      for l=1:lx
         x{l}=num2str(x{l});
      end
   end     
   if strequ(class(x{1}),'char')
      k=1;
      y=zeros(1,lx);
      while length(find(y==0))~=0
         f0=find(y==0);
         name=x{f0(1)};
         for l=1:length(f0)
            if strequ(name,x{f0(l)})
               y(f0(l))=k;
            end
         end
         k=k+1;
      end
   end
end
y=y(:);

   
   


   
   