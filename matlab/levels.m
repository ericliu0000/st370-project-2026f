function names=levels(x)

if iscell(x)
   xs=stdrd(x);
   for k=1:max(xs)
      findk=find(xs==k);
      names{k}=x{findk(1)};
   end
else
   xs=stdrd(x);
   for k=1:max(xs)
      findk=find(xs==k);
      names{k}=num2str(x((findk(1))));
   end   
end
