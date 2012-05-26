% ==================================
% This file is the auxillary part of 
%       DMVN MetaPost Library
%           dmvn@mccme.ru
%     http://www.dmvn.mexmat.net/
% (C) 2004-2006, All rights reserved
%      Last Edition: 23.06.2006
%   Please change file name if you
%      wish to modify this file
% ==================================

% ====================================================
% The main part of this file is so-called line-pattern
% drawing device. Auxillary functions are random 'rnd'
% macro and 'obj' macro that also can be useful.
% ====================================================

% =================================
% To short 'addto' statement
% =================================

def obj(expr c) =
  doublepath c withpen currentpen
enddef;

% =================================
% Macro for R[0,1]
% =================================

def rnd = uniformdeviate(1) enddef;
def rndm = (rnd-.5) enddef;

% =================================
% Lines
% =================================

picture lines;
newinternal linescount; linescount := 200;

vardef makelines(expr lined, linel) =
  save l;
  path l;
  lines := nullpicture;
  l := (-linel,0)--(linel,0);
  for i = -linescount upto linescount: addto lines obj(l shifted (rnd, 1.5pt*i)); endfor
  lines := lines rotated lined;
enddef;
