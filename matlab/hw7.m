%% Define transformed variables
jet.sqrtforce = sqrt(jet.force);
jet.logforce = log(jet.force);

%% ORIGINAL FORCE

stats(jet.force,jet.act)
stats(jet.force,jet.press)

means(jet.force,jet.press,jet.act)

figure
mplot(jet.force,jet.press,jet.act)

mfit(jet.force,jet.press,jet.act)


%% SQUARE ROOT FORCE

stats(jet.sqrtforce,jet.act)
stats(jet.sqrtforce,jet.press)

means(jet.sqrtforce,jet.press,jet.act)

figure
mplot(jet.sqrtforce,jet.press,jet.act)

mfit(jet.sqrtforce,jet.press,jet.act)


%% LOG FORCE

stats(jet.logforce,jet.act)
stats(jet.logforce,jet.press)

means(jet.logforce,jet.press,jet.act)

figure
mplot(jet.logforce,jet.press,jet.act)

mfit(jet.logforce,jet.press,jet.act)

%% Problem 2 - Magnet

means(magnet.force,magnet.turns,magnet.volt)

figure
mplot(magnet.force,magnet.turns,magnet.volt)

mfit(magnet.force,magnet.turns,magnet.volt)


%% Problem 3 - Salt

salt.hours = salt.time/3600;

means(salt.hours,salt.amount,salt.type)

figure
mplot(salt.hours,salt.amount,salt.type)

mfit(salt.hours,salt.amount,salt.type)

%% Problem 4

mfit(b.time,b.surface,b.distance)

figure
mplot2(b.time,b.surface,b.distance)

figure
mplot2(b.time,b.distance,b.surface)


%% Problem 5A - log(time)

mfit(log(b.time),b.surface,b.distance)

figure
mplot2(log(b.time),b.surface,b.distance)

figure
mplot2(log(b.time),b.distance,b.surface)


%% Problem 5B - sqrt(time)

mfit(sqrt(b.time),b.surface,b.distance)

figure
mplot2(sqrt(b.time),b.surface,b.distance)

figure
mplot2(sqrt(b.time),b.distance,b.surface)

