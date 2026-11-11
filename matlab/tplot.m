%   TPLOT(X,Y,Z) Plots Y vs. X with the corresponding
%     values of Z overlaid.
%





function tplot(x,y,z)

if ~isnumeric(x)
   error('Expecting a Numeric Vector.  lplot handles non-numeric X variables')
end

if isnumeric(z)
   z=num2str(z);
end
plot(x,y,'w+')
ax=axis;
dx=(ax(2)-ax(1))*.05;
dy=(ax(4)-ax(3))*.05;
axis([ax(1)-dx ax(2)+dx ax(3)-dy ax(4)+dy])
text(x,y,z)
