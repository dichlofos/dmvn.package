% ====================================
% DMVN MetaPost Brochure Macro Library
%             dmvn@mccme.ru
%      http://www.dmvn.mexmat.net
%  (C) 2004-2005, All rights reserved
%       Last Edition: 21.02.2005
% ====================================

% Common prefix for macros that have
% conflicting names with dmvnmac: b

% To shorter our everyday speech
def wppc = withpen pencircle enddef;
def ppc = pickup pencircle enddef;
def wc = withcolor enddef;

% Line thickness
def tl = scaled .3333pt enddef;
def nl = scaled .6666pt enddef;
def bl = scaled 1.2pt enddef;

% IntVar .rangsize setting
def brs = .15 enddef;
% IntVar .sidesize setting
def bss = .08 enddef;

% For shadowing
def markcolor = white enddef;
def tshad = wppc scaled 2pt wc markcolor enddef;
def nshad = wppc scaled 2.5pt wc markcolor enddef;
def bshad = wppc scaled 3.5pt wc markcolor enddef;

% Default dashes
def tdash = dashed evenly scaled .4 enddef;
def ndash = dashed evenly scaled .5 enddef;
def bdash = dashed evenly scaled .65 enddef;

% Standard affixes for every stroke: solid
def sthin = wppc tl enddef;
def snorm = wppc nl enddef;
def sbold = wppc bl enddef;

% Standard affixes for every stroke: dashed
def dthin = wppc tl tdash enddef;
def dnorm = wppc nl ndash enddef;
def dbold = wppc bl bdash enddef;

% Basic work with paths
def firstpoint(expr p, q) = xpart(p intersectiontimes q) enddef;
def lastpoint(expr p, q) = xpart(reverse p intersectiontimes q) enddef;

def tillfirst(expr p, q) = subpath (0, firstpoint(p,q)) of p enddef;
def afterlast(expr p, q) = reverse(subpath (0, lastpoint(p,q)) of reverse p) enddef;

def bop(expr p) = point 0 of p enddef;
def eop(expr p) = point 0 of reverse p enddef;

def subp(expr p, s, e) = subpath (s*length(p), e*length(p)) of p enddef;
def relpoint(expr p, t) = point (t*length(p)) of p enddef;
def reldir(expr p, t) = direction (t*length(p)) of p enddef;

% Thin paths
def subdrawt(expr p, s, e) =
  draw subp(p, s, e) tshad;
  draw p sthin;
enddef;

def subdrawtd(expr p, s, e) =
  draw subp(p, s, e) tshad;
  draw p dthin;
enddef;

% Normal paths
def subdrawn(expr p, s, e) =
  draw subp(p, s, e) nshad;
  draw p snorm;
enddef;

def subdrawnd(expr p, s, e) =
  draw subp(p, s, e) nshad;
  draw p dnorm;
enddef;

% Bold paths
def subdrawb(expr p, s, e) =
  draw subp(p, s, e) bshad;
  draw p sbold;
enddef;

def subdrawbd(expr p, s, e) =
  draw subp(p, s, e) bshad;
  draw p dbold;
enddef;

% Marking points
def bmp(expr s,e) =
   for i = s upto e: draw z[i] withpen pencircle scaled 3bp; endfor
enddef;

def barrowon = ahangle := 15; linejoin := mitered; enddef;
def barrowoff = linejoin := rounded; enddef;

ahangle := 20;
numeric aratio; aratio = 7/12;

vardef arrowhead expr PATH =
  pair zendp,zendd,zendl,zendr,zends;
  zendp = point length PATH of PATH;
  pair direndp, direndd;
  direndp=direction length PATH of PATH;
  zendd=point (arctime ahlength of (reverse PATH)) of (reverse PATH);
  direndd=direction (arctime (ahlength*cosd ahangle) of (reverse PATH)) of (reverse PATH);
  zendl=zendd+ahlength*(sind ahangle)*dir(angle(direndd)-90);
  zendr=zendd+ahlength*(sind ahangle)*dir(angle(direndd)+90);
  zends=point (arctime (aratio*ahlength) of (reverse PATH)) of (reverse PATH);
  zendl..{dir(angle(direndp)-ahangle/2)}zendp{-dir(angle(direndp)+ahangle/2)}..zendr--zends--cycle
enddef;

% An auxillary macro for drawing box used while dotting
def framecolor = white enddef;
def framebox(expr l,r,t,b) = (u*r,u*b)--(u*r,u*t)--(u*l,u*t)--(u*l,u*b)--cycle enddef;
def dframebox(expr l,r,t,b) = draw framebox(l,r,t,b) wc framecolor snorm; enddef;
