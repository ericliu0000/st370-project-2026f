function F = longfig
S = get(0,'ScreenSize');
P = [360, 25 , (S(4)-150)/1.3 (S(4)-150)];
if (nargout == 0)
	figure('Position',P);
else
	F = figure('Position',P);
end
