% UNIQ returns at most one item from a repeating set of data, much like the
% 'uniq' command on Unix systems.
function [ret] = uniq(x)
i = 1;
j = 1;
k = 1;
last = x(1);
ret(j) = last;
n = size(x);
for i = 1:n(1)
  for j = 1:n(2)
    if(last ~= x(i, j))
      k = k + 1;
      ret(k) = x(i, j);
    end
    last = x(i, j);
  end
end
