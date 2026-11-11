

% STEMPLOT(y,nstepx,nstepy,unit,range,ldp,ifail)
%  
% Create stem and leaf plot for Y.
%
% STEMPLOT is essentially a renaming of the Nagware mfunction
% g01arf, except the prn parameter is always set to 'P'.
%   
% STEMPLOT produces a stem and leaf display for a single sample of n
% observations. The stem and leaf display shows data values
% seperated into the form of a 'stem' and a 'leaf'. For example, a
% value of 473 could be represented as 47 3 where the stem is 47
% and the leaf is 3. The data is scaled using a value known as the
% 'leaf digit unit'. In the above example the leaf digit unit would
% be 1.0.
%
% The following example illustrates a stem and leaf display.
%
% For the 10 observations:
%
%              1.8 2.3 2.1 1.9 2.1 2.4 2.0 2.0 1.9 2.1
%
% the stem and leaf display is:
%
%                              1 1 8
%                              3 1 99
%                              5 2 00
%                              5 2 111
%                              2 2
%                              2 2 3
%                              1 2 4
%
% where the leaf digit unit is 0.1 so that 1 8 represents 1.8
% (i.e., 18*0.1). The leaf digit unit distinguishes between the
% numbers 18.0, 1.8, 0.18 etc which may otherwise all be
% represented by 1 8.
%
% Included in the above display is an initial column specifying the
% cumulative count of values, up to and including that particular
% line, from either the top or bottom of the display, whichever is
% smaller. An exception to this is when the line on which the
% median lies is reached, in which case the actual count of values
% on that line is displayed, rather than a cumulative count, and
% this is highlighted by enclosing the count in parentheses. In
% this case the median is 2.05 and thus falls between the two lines
% at which the cumulative count has reached n/2 where n is the
% number of observations.
%
% Some of the other features of the stem and leaf display are
% illustrated by the following two examples;.
%
% For the 30 observations:
%
%         -19.0 -3.0 -1.0 0.0 1.0  2.0  2.0  3.0  3.0  3.0
%           4.0  4.0  4.0 4.0 4.0  5.0  5.0  5.0  5.0  6.0
%           6.0  6.0  7.0 7.0 8.0 10.0 11.0 11.0 13.0 31.0
%
% the stem and leaf display may be:
%
%
%                         1 1. 9
%                         1 1*
%                         1 -0.
%                         3 -0* 13
%                        15 +0* 012233344444
%                        15 +0. 55556667788
%                         5 1* 011
%                         2 1. 3
%                         1  2
%                         1 2.
%                         1  3 1
%
% In the above display all the data are plotted and the leaf digit
% unit is 1.0. Also in this display different leaves, that is
% different digits, may be plotted on a particular line. In this
% case we have 5 possible digits per line, that is 2 lines per
% stem, and these are represented as follows;
%
%      *   :  indicates that the line may contain the digits 0 to 4
%
%      .   :  indicates that the line may contain the digits 5 to 9
%
% Alternatively the stem and leaf display may look like:
%
%                              LO       -19
%                           2 -0*         3
%                           3 +0T         1
%                           5 +0*        01
%                          10 +0T     22333
%                         (9) +0F 444445555
%                          11 +0*     66677
%                           6 +0T         8
%                           5  1*       011
%                           2  1T         3
%                          HI  31         1
%
% Again the leaf digit unit is 1.0 but in this display just the
%                                                   1
% data between the fences, which are the hinges +-1 -* the inter-
%                                                   2
% hinge range, are plotted. Any data points that fall outside the
% fences are presented separately in the display under the headings
% LO for those points below the lower fence and HI for those points
% above the upper fence.
%
% Again in this display different leaves, that is different digits,
% may be plotted on a particular line. However in this case we have
% 2 possible digits per line, that is 5 lines per stem, and these
% are represented as follows;
%
%     *   :   indicates that the line may contain the digits 0 or 1
%
%     T   :   indicates that the line may contain the digits 2 or 3
%
%     F   :   indicates that the line may contain the digits 4 or 5
%
%     S   :   indicates that the line may contain the digits 6 or 7
%
%     .   :   indicates that the line may contain the digits 8 or 9
%
% A display may also allow 10 different digits (0 to 9) per line,
% that is 1 line per stem, or just 1 digit per line, that is 10
% lines per stem, as in the first of the three examples above.
%
% Note that the median here is 4.5. This falls between two lines in
% the first display but is highlighted on the second display since
% it lies on a particular line.
%
% Finally if there are positive and negative numbers on the display
% these are highlighted by a + or - sign where the distinction is
% required, that is near the zero point.
%
% If there are too many leaves to fit in the plot width allowed,
% STEMPLOT plots as many leaves as possible and places an asterisk to
% the right to indicate that some leaves are not displayed. If this
% occurs and the user wishes to be able to plot all the leaves then
% the width of the plot may be adjusted.
%
% Options also allow the leaf unit and the height of the display to
% be specified by the user or calculated by STEMPLOT. These
% parameters may be used to control the type of the display the
% user wishes to obtain. Fixing the unit and changing the height of
% the display may alter the number of lines used per stem, that is
% the number of different digits per line. STEMPLOT will choose a
% display for the fixed unit that attempts to make as much use of
% the available height as possible, thus increasing the height may
% allow for more lines per stem whereas decreasing the height may
% force the display to use fewer lines per stem. Similarly the user
% may wish to fix the height and vary the leaf digit unit used on
% the display.
%
% The display is returned in a character array with the option of
% printing the display.
%
%stemplot
%
%Required Input Arguments:
%
%y (:)                                 real
%
%Optional Input Arguments:                       <Default>
%
%nstepx                                integer  35
%nstepy                                integer  0
%unit                                  real     0
%range (1)                             string   'e'
%ldp                                   integer  40
%ifail                                 integer  -1
%
%
%             [NAGWare Gateway Generator ]
%
% Copyright (c) 1993-98 by the Numerical Algorithms Group Ltd. 1.3
% $Revision: 1.3 $  $Date: 1997/12/04 21:32:27 $
%
%Set default input values for optional arguments
%


function stemplot(y,nstepx,nstepy,unit,range,ldp,ifail)
fprintf('\n\n')
if nargin==1      
h=g01arf('P',y);
elseif nargin==2
h=g01arf('P',y,nstepx);
elseif nargin==3
h=g01arf('P',y,nstepx,nstepy);
elseif nargin==4
h=g01arf('P',y,nstepx,nstepy,unit);
elseif nargin==5
h=g01arf('P',y,nstepx,nstepy,unit,range);
elseif nargin==6
h=g01arf('P',y,nstepx,nstepy,unit,range,ldp);
elseif nargin==7
h=g01arf('P',y,nstepx,nstepy,unit,range,ldp,ifail);
end
fprintf('\n\n')
  
