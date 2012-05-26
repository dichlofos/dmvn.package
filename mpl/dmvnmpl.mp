% ==================================
%       DMVN MetaPost Library
%           dmvn@mccme.ru
%     http://www.dmvn.mexmat.net/
% (C) 2004-2006, All rights reserved
%            Version 1.01
%      Last Edition: 05.07.2006
%   Please change file name if you
%      wish to modify this file
% ==================================

% 3D-Parts of point
def xp = redpart enddef;
def yp = greenpart enddef;
def zp = bluepart enddef;

% To shorter our everyday speech
def wppc = withpen pencircle enddef;
def ppc = pickup pencircle enddef;
def wc = withcolor enddef;

% Line thickness
def etl = scaled .2pt enddef;
def tl = scaled .3333pt enddef;
def nl = scaled .6666pt enddef;
def bl = scaled 1.2pt enddef;

% IntVar .rangsize setting
def brs = .15 enddef;
% IntVar .sidesize setting
def bss = .07 enddef;

% For shadowing
def markcolor = white enddef;
def tshad = wppc scaled 2pt wc markcolor enddef;
def nshad = wppc scaled 2.5pt wc markcolor enddef;
def bshad = wppc scaled 3.5pt wc markcolor enddef;

% Default dashes
def etdash = dashed evenly scaled .3 enddef;
def tdash = dashed evenly scaled .4 enddef;
def ndash = dashed evenly scaled .5 enddef;
def bdash = dashed evenly scaled .65 enddef;

% Standard affixes for every stroke: solid
def sethin = wppc etl enddef;
def sthin = wppc tl enddef;
def snorm = wppc nl enddef;
def sbold = wppc bl enddef;

% Standard affixes for every stroke: dashed

def dethin = wppc etl etdash enddef;
def dthin = wppc tl tdash enddef;
def dnorm = wppc nl ndash enddef;
def dbold = wppc bl bdash enddef;

% Basic work with paths
vardef firstpoint(expr p, q) = xpart(p intersectiontimes q) enddef;
vardef lastpoint(expr p, q) = xpart(reverse p intersectiontimes q) enddef;

vardef tillfirst(expr p, q) = subpath (0, firstpoint(p,q)) of p enddef;
vardef afterlast(expr p, q) = reverse(subpath (0, lastpoint(p,q)) of reverse p) enddef;

vardef bop(expr p) = point 0 of p enddef;
vardef eop(expr p) = point 0 of reverse p enddef;

vardef subp(expr p, s, e) = subpath (s*length(p), e*length(p)) of p enddef;
vardef relpoint(expr p, t) = point (t*length(p)) of p enddef;
vardef reldir(expr p, t) = direction (t*length(p)) of p enddef;

% Thin paths
vardef subdrawt(expr p, s, e) =
  draw subp(p, s, e) tshad;
  draw p sthin;
enddef;

vardef subdrawtd(expr p, s, e) =
  draw subp(p, s, e) tshad;
  draw p dthin;
enddef;

% Normal paths
vardef subdrawn(expr p, s, e) =
  draw subp(p, s, e) nshad;
  draw p snorm;
enddef;

vardef subdrawnd(expr p, s, e) =
  draw subp(p, s, e) nshad;
  draw p dnorm;
enddef;

% Bold paths
vardef subdrawb(expr p, s, e) =
  draw subp(p, s, e) bshad;
  draw p sbold;
enddef;

vardef subdrawbd(expr p, s, e) =
  draw subp(p, s, e) bshad;
  draw p dbold;
enddef;

% Marking points
vardef bmp(expr s,e) =
  for i = s upto e:
    draw z[i] wppc scaled 3bp;
  endfor
enddef;

% Redefining standard arrows
% (C) Misha Panov (mpanov@mccme.ru)

% Say 'barrowon' if you want your arrows have sharp corners
def barrowon = ahangle := 15; linejoin := mitered; enddef;
% And don't forget say 'barrowoff' immediately after drawing
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

% Rectangular Projection
newinternal dprhorz; dprhorz := .5;
newinternal dprvert; dprvert := .25;
def dpr(expr c) = ((xp c) - dprhorz*(yp c), (zp c) - dprvert*(yp c)) enddef;

% Perspective Projection
newinternal cameradepth, cameraheight;
cameradepth := 10cm; cameraheight := -3cm;
def ppr(expr c) = (((-(xp c))/((yp c)-cameradepth))*cameradepth,(-((zp c)+ cameraheight)/((yp c)-cameradepth))*cameradepth) enddef;

% Isometric projectrion
newinternal isomangle; isomangle := 30;
def ipr(expr c) = (cosd(isomangle)*(xp c - yp c), (zp c)-sind(isomangle)*(xp c + yp c)) enddef;

% Z-projection
newinternal zangle; zangle := 30;
def zpr(expr c) = (xp c, -(yp c) * sind(zangle) + (zp c) * cosd(zangle)) enddef;

% Dot Product for 3D
def vdp(expr p,q) =
   ((xp p)*(xp q)+(yp p)*(yp q)+(zp p)*(zp q))
enddef;

% Length of 3D vector
def vlen(expr p) =
   sqrt(((xp p)*(xp p)+(yp p)*(yp p)+(zp p)*(zp p)))
enddef;

% 3D Angle
def vang(expr p,q) =
   vdp(p/vlen(p),q/vlen(q))
enddef;

% Cross Product for 3D
def vcp(expr p,q) =
   ((yp p)*(zp q)-(yp q)*(zp p),
    (zp p)*(xp q)-(zp q)*(xp p),
    (xp p)*(yp q)-(xp q)*(yp p))
enddef;

% Intersection point of plane and line in 3D
vardef vip(expr p, v, a,b,c) =
% line: from point "p" with dir "v"
% plane: through points "a", "b", "c"
   save r,e,f;
   color r,e,f;
   e = b-a;
   f = c-a;
   r = p + whatever*v = a + whatever*e + whatever*f;
   (r)
enddef;

% Normal to plane aff<a,b,c>
def vnorm(expr a,b,c) =
   vcp(b-a,c-a)
enddef;

% Perpendicular from "p" dropped to plane aff<a,b,c>
def vperend(expr p,a,b,c) =
   (vip(p,vnorm(a,b,c),a,b,c))
enddef;

% End of perpendicular from "p" dropped to line aff<a,b>
vardef vperlend(expr p, a, b) =
  save t, d; numeric t; color d;
  d = t[a,b];
  vdp(b-a, d-p) = 0;
  (d)
enddef;

% "Left" Half of Arc
vardef plharc(expr a, b) =
   save v, w; pair v, w;
   v = .5[a,b];
   w = v + ((v-a) rotated 90);
   (a..w..b)
enddef;

% "Right" Half of Arc
vardef prharc(expr a, b) =
   save v, w; pair v, w;
   v = .5[a,b];
   w = v + ((v-a) rotated -90);
   (a..w..b)
enddef;

% Left Tangent Point
vardef ltanend(expr a, c, r) =
   save p,q,v;
   path p,q;
   pair v;
   p := plharc(a,c);
   q = fullcircle scaled 2r shifted c;
   v = p intersectionpoint q;
   (v)
enddef;

% Right Tangent End
vardef rtanend(expr a, c, r) =
   save p,q,v;
   path p,q;
   pair v;
   p = prharc(a,c);
   q = fullcircle scaled 2r shifted c;
   v = p intersectionpoint q;
   (v)
enddef;

% Path of Tangents
def pltan(expr a, c, r) = (a--ltanend(a,c,r)); enddef;
def prtan(expr a, c, r) = (a--rtanend(a,c,r)); enddef;

% Rectangular Angle
newinternal rangsize; rangsize := .2;

vardef rang(expr c, p, q)=
   save v, w; pair v, w;
   v = p-c; w = q-c;
   v := unitvector(v)*rangsize*u; w := unitvector(w)*rangsize*u;
   draw c+v--c+v+w--c+w sthin;
enddef;

% Marked Side
newinternal sidesize; sidesize := .075;
newinternal sidestep; sidestep := .06;
newinternal sideesize; sideesize := .6pt;

vardef sside(expr a, b, count, r) =
   save v, w, fs, z; pair v, w, fs, z;
   v = (unitvector(b-a) rotated 90) * sidesize * u;
   w = (unitvector(b-a)) * sidestep*u;
   z = r[a,b];
   fs = .5w*(count-1);
   for i = 0 upto count-1: draw z+v-fs+i*w--z-v-fs+i*w sthin; endfor
enddef;

vardef side(expr a, b, count) =
  sside(a,b,count,.5);
enddef;

vardef esside(expr a, b, count, r) =
   save v, w, fs, z, vs; pair v, w, fs, z, vs;
   vs = (sideesize,0);
   v = (unitvector(b-a) rotated 90) * sidesize * u;
   w = (unitvector(b-a)) * sidestep*u;
   z = r[a,b];
   fs = w*(count-1)/2;
   for i = 0 upto count-1:
      for j = 0 step 10 until 360:
         draw (z+v-fs+i*w--z-v-fs+i*w) shifted (vs rotated j) wc white;
      endfor;
   endfor
enddef;

vardef eside(expr a, b, count) =
  esside(a,b,count,.5);
enddef;

vardef ssideroman(expr a, b, count, r) =
   save v, w, fs, z; pair v, w, fs, z;
   v = (unitvector(b-a) rotated 90) * sidesize * u;
   w = (unitvector(b-a)) * sidestep*u;
   z = r[a,b];
   fs = 2w*(count-1);
   for i = 0 step 3 until 3*(count-1): draw z+v-fs+i*w--z-v-fs+(i+1)*w--z+v-fs+(i+2)*w sthin; endfor
enddef;

vardef sideroman(expr a, b, count) =
  ssideroman(a,b,count,.5);
enddef;

% Marked Dollar Side
newinternal dollarsize; dollarsize := .04;

vardef dollarside(expr a, b)=
   save v, w, z; pair v, w, z;
   v = (unitvector(b-a) rotated 90) * dollarsize * u;
   w = (unitvector(b-a)) * 3*dollarsize*u;
   z = .5[a,b];
   draw z-v+w{v}..z+w{v}..{-v}z..{v}z-w..{v}z-w+v sthin;
enddef;

% Circular Angle
newinternal cangsize; cangsize := .2;

vardef cang(expr c, p, q, count)=
   save v, w; pair v, w;
   for i = 1 upto count:
      v := unitvector(p-c)*cangsize*u * (1 + i/5);
      w := unitvector(q-c)*cangsize*u * (1 + i/5);
      draw c+v{v rotated -90}..c+w sthin;
   endfor
enddef;

% Path of Circle on the Diameter
vardef pdcir(expr a,b) =
  (fullcircle scaled length(a-b) shifted .5[a,b])
enddef;

% Path of Escribed Circle
vardef pecir(expr a,b,c) =
   save v,w,z; pair v,w,z;
   v = (b-a) rotated 90; w = (c-a) rotated 90;
   .5[a,b] + v*whatever = z = .5[a,c] + w*whatever;
   (fullcircle scaled (2length(z-a)) shifted z)
enddef;

% Center of Escribed Circle
vardef ecirpoint(expr a,b,c) =
   save v,w,z; pair v,w,z;
   v = (b-a) rotated 90; w = (c-a) rotated 90;
   z = .5[a,b] + v*whatever = .5[a,c] + w*whatever;
   (z)
enddef;

% Half of Circle
vardef hcir(expr r) =
   ((r, 0)..(0,r)..(-r,0))
enddef;

% Path of Half of Circle
vardef phdcir(expr a,b) =
  (a..((0.5(b-a) rotated 90) shifted .5[a,b])..b)
enddef;

% Perpendicular
vardef perend(expr a, b, c) =
   save z; pair z;
   z = whatever[b,c] = a + whatever*((c-b) rotated 90);
   (z)
enddef;

% Path of Inscribed circle
vardef picir(expr a,b,c) =
  save r, i; numeric r; pair i;
  i = a + whatever*bvec(a,b,c) = b + whatever*bvec(b,a,c);
  r = length(i - perend(i,a,b));
  (fullcircle scaled 2r shifted i)
enddef;

% Path of Inscribed external circle
vardef picirext(expr a,b,c) =
  save r, i; numeric r; pair i;
  i = b + whatever*bvec(b,2[a,b],c) = c + whatever*bvec(c,2[a,c],b);
  r = length(i - perend(i,b,c));
  (fullcircle scaled 2r shifted i)
enddef;

% Bisector Point
vardef bispoint(expr a, b, c) =
   save z; pair z;
   z = whatever[a,bisend(a,b,c)] = whatever[b,bisend(b,a,c)];
   (z)
enddef;

% Center of Inscribed circle
def icirpoint(expr a,b,c) =
  bispoint(a,b,c)
enddef;

% External Bisector Point
vardef bispointext(expr a, b, c) =
  save i; pair i;
  i = b + whatever*bvec(b,2[a,b],c) = c + whatever*bvec(c,2[a,c],b);
  (i)
enddef;

% Orthocenter
vardef perpoint(expr a, b, c) =
   save z; pair z;
   z = whatever[a,perend(a,b,c)] = whatever[b,perend(b,a,c)];
   (z)
enddef;

% Mass center
vardef medpoint(expr a,b,c) =
   (2/3)[a,.5[b,c]]
enddef;

% Path of Perpendicular
vardef pper(expr a, b, c) =
   save z; pair z;
   z = whatever[b,c] = a + whatever*((c-b) rotated 90);
   (a--z)
enddef;

% Bisector vector from point 'a' in the triangle 'a'b'c'
vardef bvec(expr a,b,c) =
  unitvector(b-a) + unitvector(c-a)
enddef;

% Bisector EndPoint
vardef bisend(expr a, b, c) =
   save z; pair z;
   z = whatever[b,c] = a + whatever*bvec(a,b,c);
   (z)
enddef;

% Path of Bisector
vardef pbis(expr a, b, c) =
   (a--bisend(a,b,c));
enddef;


% Intersection point of lines
def ip(expr a,b,c,d) =
   whatever[a,b] = whatever[c,d]
enddef;

% Chartable
vardef chartable =
   for i = 0 upto 255:
     label(char(i) infont "scbr10", (1*(i div 16)*.5u, -(i mod 16)*.5u));
   endfor
enddef;

% Rotation around Z axis to 'a' degrees
vardef rotz(expr s,e,a) =
   save r,g;
   numeric r,g;
   for i = s upto e:
      r := (  xp c[i]) * cosd(a) + (yp c[i]) * sind(a);
      g := (- xp c[i]) * sind(a) + (yp c[i]) * cosd(a);
      c[i] := (r,g, zp c[i]);
   endfor
enddef;

% Rotation around Z axis to 'a' degrees
vardef vecrotz(expr c, a) =
   save r,g,b;
   numeric r,g,b;
   r := (  xp c) * cosd(a) + (yp c) * sind(a);
   g := (- xp c) * sind(a) + (yp c) * cosd(a);
   b := zp c;
   (r,g,b)
enddef;

% Rotation around X axis to 'a' degrees
vardef vecrotx(expr c, a) =
   save r,g,b;
   numeric r,g,b;
   r := xp c;
   g := (  yp c) * cosd(a) + (zp c) * sind(a);
   b := (- yp c) * sind(a) + (zp c) * cosd(a);
   (r,g,b)
enddef;

% Rotation around Y axis to 'a' degrees
vardef vecroty(expr c, a) =
   save r,g,b;
   numeric r,g,b;
   r := (xp c) * cosd(a) - (zp c) * sind(a);
   g := yp c;
   b := (xp c) * sind(a) + (zp c) * cosd(a);
   (r,g,b)
enddef;


% Marking points
def mp(expr s,e) =
   for i = s upto e: draw z[i] withpen pencircle scaled 2pt; endfor
enddef;

% Perspective projection of points z[s]..z[e]
def ppp(expr s,e) = for i = s upto e: z[i] = ppr(c[i]); endfor enddef;

% Dimetric projection of points z[s]..z[e]
def dpp(expr s,e) = for i = s upto e: z[i] = dpr(c[i]); endfor enddef;

% Turn standard arrows drawing on and off
def arrowon = linejoin := mitered; ahangle := 20; enddef;
def arrowoff = linejoin := rounded; enddef;

% Label that should erase some space around the letters
newinternal labelesize; labelesize := 1pt;

% The-version of label that should erase some space around the letters
vardef theelabel@#(expr t, p) =
  save v; pair v; v = (labelesize,0);
  save pict; picture pict; pict := nullpicture;
  for i = 0 step 5 until 360: addto pict also thelabel@#(t, p shifted (v rotated i)) withcolor white; endfor
  addto pict also thelabel@#(t, p);
  (pict)
enddef;

vardef elabel@#(expr t, p) =
  save v; pair v; v = (labelesize,0);
  for i = 0 step 5 until 360: draw thelabel@#(t, p shifted (v rotated i)) withcolor white; endfor
  draw thelabel@#(t, p);
enddef;

% Extension of the segment
def eseg(expr a,b,s,e) =
  (s[a,b]--e[a,b])
enddef;

% Big individual point marking 
vardef mpt(expr p) =
  draw p withpen pencircle scaled 3bp;
enddef;

% Intersection Point (for shortness)
vardef ipt(expr p,q) = 
  (p intersectionpoint q)
enddef;
