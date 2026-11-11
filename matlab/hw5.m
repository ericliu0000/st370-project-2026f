%% College Problem

%% Part 1 - Boxplot of fees by region

figure
bplot2(college.fees,college.loc)
title('Tuition and Fees by Region')


%% Part 2 - Mean fees by region

stats(college.fees,college.loc)


%% Part 3 - Relative price: fees / income

stats(college.fees./college.inc,college.loc)


%% Part 4 - Square root transformation

college.sqrtfees = sqrt(college.fees);

% Part 4a - Boxplot of sqrt(fees) by region

figure
bplot2(college.sqrtfees,college.loc)
title('Square Root of Tuition and Fees by Region')


% Part 4b - Mean sqrt(fees) by region

stats(college.sqrtfees,college.loc)


% Part 4c - Relative price using sqrt(fees)

stats(college.sqrtfees./college.inc,college.loc)

%% Airplane problem

figure
bplot(airplane.distance,airplane.treatment)
title('Flight Distance by Treatment')

stats(airplane.distance,airplane.treatment)


%% Etruscan skull widths

figure
bplot2(etruscan.width,etruscan.group)
title('Skull Width by Group')

stats(etruscan.width,etruscan.group)


%% Part 1 - Numerical summaries

stats(nerf.accuracy,nerf.distance)

stats(nerf.accuracy,nerf.hand)


%% Part 2 - Boxplots

figure
bplot2(nerf.accuracy,nerf.distance)
title('Nerf Accuracy by Distance')

figure
bplot2(nerf.accuracy,nerf.hand)
title('Nerf Accuracy by Hand Position')