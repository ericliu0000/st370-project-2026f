% rdemo(n,seed) makes plots of randomly generated
% bivariate normal data with different correlations
% n=100 is the default

function rdemo(n,seed)

if nargin==0
  n1=200;
  seed1=560;
  end
if nargin==1
  n1=n;
  seed1=560;
  end
if nargin==2
  n1=n;
  seed1=seed;
  end
randn('state',seed1)
mu = [1 2];
sigma = [1 .9; .9 1];
r = mvnrnd(mu,sigma,n1);
subplot(4,2,1)
plot(r(:,1),r(:,2),'+')
axis([-3 5 -2 6])
co=corr(r(:,1),r(:,2));
title(['\rho =0.90, r = ', num2str(co,2)],'FontSize',12)'
sigma = [1 .7; .7 1];
r = mvnrnd(mu,sigma,n1);
subplot(4,2,2)
plot(r(:,1),r(:,2),'+')
axis([-3 5 -2 6])
co=corr(r(:,1),r(:,2));
title(['\rho =0.70, r = ', num2str(co,2)],'FontSize',12)
sigma = [1 .5; .5 1];
r = mvnrnd(mu,sigma,n1);
subplot(4,2,3)
plot(r(:,1),r(:,2),'+')
axis([-3 5 -2 6])
co=corr(r(:,1),r(:,2));
title(['\rho =0.50, r = ', num2str(co,2)],'FontSize',12)
sigma = [1 .3; .3 1];
r = mvnrnd(mu,sigma,n1);
subplot(4,2,4)
plot(r(:,1),r(:,2),'+')
axis([-3 5 -2 6])
co=corr(r(:,1),r(:,2));
title(['\rho =0.30, r = ', num2str(co,2)],'FontSize',12)
sigma = [1 .1; .1 1];
r = mvnrnd(mu,sigma,n1);
subplot(4,2,5)
plot(r(:,1),r(:,2),'+')
axis([-3 5 -2 6])
co=corr(r(:,1),r(:,2));
title(['\rho =0.10, r = ', num2str(co,2)],'FontSize',12)
sigma = [1 -.3; -.3 1];
r = mvnrnd(mu,sigma,n1);
subplot(4,2,6)
plot(r(:,1),r(:,2),'+')
axis([-3 5 -2 6])
co=corr(r(:,1),r(:,2));
title(['\rho =-0.30, r = ', num2str(co,2)],'FontSize',12)
sigma = [1 -.5; -.5 1];
r = mvnrnd(mu,sigma,n1);
subplot(4,2,7)
plot(r(:,1),r(:,2),'+')
axis([-3 5 -2 6])
co=corr(r(:,1),r(:,2));
title(['\rho =-0.50, r = ', num2str(co,2)],'FontSize',12)
sigma = [1 -.95; -.95 1];
r = mvnrnd(mu,sigma,n1);
subplot(4,2,8)
plot(r(:,1),r(:,2),'+')
axis([-3 5 -2 6])
co=corr(r(:,1),r(:,2));
title(['\rho =-0.95, r = ', num2str(co,2)],'FontSize',12)
