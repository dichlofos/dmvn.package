% ==================================
%     DMVN MetaPost Macro Library
%            dmvn@mccme.ru
%     http://www.dmvn.mexmat.net/
% (C) 2004-2005, All rights reserved
%      Last Edition: 18.03.2005
% ==================================

def xp = redpart enddef;
def yp = greenpart enddef;
def zp = bluepart enddef;

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
def zpr(expr c) = (xp c, -(yp c) * sind(zangle) + (zp c) * cosd(zangle) ) enddef;

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
   (vcp(b-a,c-a))
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

% "Left" Half of Arc
def lharc(expr a, b) = draw plharc(a,b); enddef;

% "Right" Half of Arc
def rharc(expr a, b) = draw prharc(a,b); enddef;

% Left Tangent Point
vardef ltanend(expr a, c, r) =
   save p,q,v;
   path p,q;
   pair v;
   p := plharc(a,c);
   q = fullcircle scaled (2*r) shifted c;
   v = p intersectionpoint q;
   (v)
enddef;

% Right Tangent End
vardef rtanend(expr a, c, r) =
   save p,q,v;
   path p,q;
   pair v;
   p = prharc(a,c);
   q = fullcircle scaled (2*r) shifted c;
   v = p intersectionpoint q;
   (v)
enddef;

% Path of Tangents
def pltan(expr a, c, r) = (a--ltanend(a,c,r)); enddef;
def prtan(expr a, c, r) = (a--rtanend(a,c,r)); enddef;

% Draw Tangents
def ltan(expr a, c, r) = draw pltan(a,c,r); enddef;
def rtan(expr a, c, r) = draw prtan(a,c,r); enddef;

% Rectangular Angle
newinternal rangsize; rangsize := .2;

vardef rang(expr c, p, q)=
   save v, w; pair v, w;
   v = p-c; w = q-c;
   v := unitvector(v)*rangsize*u; w := unitvector(w)*rangsize*u;
   draw c+v--c+v+w--c+w;
enddef;

% Marked Side
newinternal sidesize; sidesize := .075;
newinternal sidestep; sidestep := .05;
newinternal sideesize; sideesize := .6pt;

vardef side(expr a, b, count)=
   save v, w, fs, z; pair v, w, fs, z;
   v = (unitvector(b-a) rotated 90) * sidesize * u;
   w = (unitvector(b-a)) * sidestep*u;
   z = .5[a,b];
   fs = w*(count-1)/2;
   for i = 0 upto count-1: draw z+v-fs+i*w--z-v-fs+i*w; endfor
enddef;

vardef eside(expr a, b, count)=
   save v, w, fs, z, vs; pair v, w, fs, z, vs;
   vs = (sideesize,0);
   v = (unitvector(b-a) rotated 90) * sidesize * u;
   w = (unitvector(b-a)) * sidestep*u;
   z = .5[a,b];
   fs = w*(count-1)/2;
   for i = 0 upto count-1:
      for j = 0 step 10 until 360:
         draw (z+v-fs+i*w--z-v-fs+i*w) shifted (vs rotated j) withcolor white;
      endfor;
   endfor
enddef;

vardef sside(expr a, b, count, r)=
   save v, w, fs, z; pair v, w, fs, z;
   v = (unitvector(b-a) rotated 90) * sidesize * u;
   w = (unitvector(b-a)) * sidestep*u;
   z = r[a,b];
   fs = w*(count-1)/2;
   for i = 0 upto count-1: draw z+v-fs+i*w--z-v-fs+i*w; endfor
enddef;

vardef esside(expr a, b, count, r)=
   save v, w, fs, z, vs; pair v, w, fs, z, vs;
   vs = (sideesize,0);
   v = (unitvector(b-a) rotated 90) * sidesize * u;
   w = (unitvector(b-a)) * sidestep*u;
   z = r[a,b];
   fs = w*(count-1)/2;
   for i = 0 upto count-1:
      for j = 0 step 10 until 360:
         draw (z+v-fs+i*w--z-v-fs+i*w) shifted (vs rotated j) withcolor white;
      endfor;
   endfor
enddef;

vardef sideroman(expr a, b, count)=
   save v, w, fs, z; pair v, w, fs, z;
   v = (unitvector(b-a) rotated 90) * sidesize * u;
   w = (unitvector(b-a)) * sidestep*u;
   z = .5[a,b];
   fs = 2w*(count-1);
   for i = 0 step 3 until 3*(count-1): draw z+v-fs+i*w--z-v-fs+(i+1)*w--z+v-fs+(i+2)*w; endfor
enddef;

vardef ssideroman(expr a, b, count, r)=
   save v, w, fs, z; pair v, w, fs, z;
   v = (unitvector(b-a) rotated 90) * sidesize * u;
   w = (unitvector(b-a)) * sidestep*u;
   z = r[a,b];
   fs = 2w*(count-1);
   for i = 0 step 3 until 3*(count-1): draw z+v-fs+i*w--z-v-fs+(i+1)*w--z+v-fs+(i+2)*w; endfor
enddef;

% Marked Dollar Side
newinternal dollarsize; dollarsize := .04;

vardef dollarside(expr a, b)=
   save v, w, z; pair v, w, z;
   v = (unitvector(b-a) rotated 90) * dollarsize * u;
   w = (unitvector(b-a)) * 3*dollarsize*u;
   z = .5[a,b];
   draw z-v+w{v}..z+w{v}..{-v}z..{v}z-w..{v}z-w+v;
enddef;

% Circular Angle
newinternal cangsize; cangsize := .2;

vardef cang(expr c, p, q, count)=
   save v, w; pair v, w;
   for i = 1 upto count:
      v := unitvector(p-c)*cangsize*u * (1 + i/5);
      w := unitvector(q-c)*cangsize*u * (1 + i/5);
      draw c+v{v rotated -90}..c+w;
   endfor
enddef;

% Draw Circle on the Diameter
def dcir(expr a,b) = draw fullcircle scaled length(a-b) shifted .5[a,b]; enddef;

% Circle on the Diameter
def pdcir(expr a,b) = (fullcircle scaled length(a-b) shifted .5[a,b]) enddef;

% Path of Escribed Circle
vardef pecir(expr a,b,c) =
   save v,w,z; pair v,w,z;
   v = (b-a) rotated 90; w = (c-a) rotated 90;
   .5[a,b] + v*whatever = z = .5[a,c] + w*whatever;
   (fullcircle scaled (2length(z-a)) shifted z)
enddef;

% Escribed Circle
vardef ecir(expr a,b,c) =
   draw pecir(a,b,c);
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
   save p; path p;
   p = (r, 0)..(0,r)..(-r,0);
   (p)
enddef;

% Bisector vector from point 'a' in the triangle 'a'b'c'
vardef bvec(expr a,b,c) =
  unitvector(b-a) + unitvector(c-a)
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

% Inscribed circle
vardef icir(expr a,b,c) =
  draw picir(a,b,c);
enddef;

% Path of Inscribed external circle
vardef picirext(expr a,b,c) =
  save r, i; numeric r; pair i;
  i = b + whatever*bvec(b,2[a,b],c) = c + whatever*bvec(c,2[a,c],b);
  r = length(i - perend(i,b,c));
  (fullcircle scaled 2r shifted i)
enddef;

% Center of Inscribed circle
def icirpoint(expr a,b,c) =
  bispoint(a,b,c)
enddef;

% Orthocenter
vardef perpoint(expr a, b, c) =
   save z; pair z;
   z = whatever[a,perend(a,b,c)] = whatever[b,perend(a,b,c)];
   (z)
enddef;

% Draw Perpendicular
vardef per(expr a, b, c) =
   save z; pair z;
   z = whatever[b,c] = a + whatever*((c-b) rotated 90);
   draw a--z;
enddef;

% Draw All Perpendiculars
def aper(expr a, b, c) =
   per(a,b,c);
   per(b,c,a);
   per(c,a,b);
enddef;

% Path of Perpendicular
vardef pper(expr a, b, c) =
   save z; pair z;
   z = whatever[b,c] = a + whatever*((c-b) rotated 90);
   (a--z)
enddef;

% Draw Perpendicular with Angle
vardef mper(expr a, b, c) =
   save z; pair z;
   z = whatever[b,c] = a + whatever*((c-b) rotated 90);
   draw a--z;
   rang(z, b, a);
enddef;

% Draw All Marked Perpendiculars
vardef amper(expr a, b, c) =
   mper(a,b,c);
   mper(b,c,a);
   mper(c,a,b);
enddef;

vardef medpoint(expr a,b,c) =
   (2/3)[a,.5[b,c]]
enddef;

% Draw Bisector
vardef bis(expr a, b, c) =
   save v,w,z; pair v,w,z;
   v = unitvector(b-a); w = unitvector(c-a);
   z = whatever[b,c] = a + whatever*(v+w);
   draw a--z;
enddef;

% Path of Bisector
vardef pbis(expr a, b, c) =
   save v,w,z; pair v,w,z;
   v = unitvector(b-a); w = unitvector(c-a);
   z = whatever[b,c] = a + whatever*(v+w);
   (a--z);
enddef;

% Draw All Bisectors
vardef abis(expr a, b, c) =
   bis(a,b,c);
   bis(b,c,a);
   bis(c,a,b);
enddef;

% Bisector EndPoint
vardef bisend(expr a, b, c) =
   save z; pair z;
   z = whatever[b,c] = a + whatever*bvec(a,b,c);
   (z)
enddef;

% Draw Marked Bisector
vardef mbis(expr a, b, c, count) =
   draw a--bisend(a,b,c);
   cang(a,b,z,count);
   cangsize := cangsize +.05;
   cang(a,z,c,count);
   cangsize := cangsize -.05;
enddef;

% Draw All Bisectors
vardef ambis(expr a, b, c) =
   mbis(a,b,c,1);
   mbis(b,c,a,2);
   mbis(c,a,b,3);
enddef;

% Bisector Point
vardef bispoint(expr a, b, c) =
   save z; pair z;
   z = whatever[a,bisend(a,b,c)] = whatever[b,bisend(b,a,c)];
   (z)
enddef;

% External Bisector Point
vardef bispointext(expr a, b, c) =
  save i; pair i;
  i = b + whatever*bvec(b,2[a,b],c) = c + whatever*bvec(c,2[a,c],b);
  (i)
enddef;

% Intersection point of lines
def ip(expr a,b,c,d) =
   whatever[a,b] = whatever[c,d]
enddef;

% Draw Line Cycle z[s]..z[e]
vardef dp(expr s, e) =
   save i; numeric i;
   draw z[s]
   for i := s+1 upto e: --z[i] endfor --cycle;
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

% Cells
def cells(expr count) =
   for i = 0 upto count:
      draw (0,i*u)--(count*u,i*u);
      draw (i*u,0)--(i*u,count*u);
   endfor;
enddef;

% For filling cells in chessboards
def fillcell(expr x,y,c) =
   fill (x*u,y*u)--((x+1)*u,y*u)--((x+1)*u,(y+1)*u)--(x*u,(y+1)*u)--cycle withcolor c;
enddef;

% For typing in cells in chessboards
def printcell(expr x,y,s) =
   label(s, ((x+.5)*u,(y+.5)*u));
enddef;

% Marking points
def mp(expr s,e) =
   for i = s upto e: draw z[i] withpen pencircle scaled 2pt; endfor
enddef;

% Draw square with UL-corner A and side S
def square(expr a, s) =
   draw a--(a + (0,s))--(a + (s,s))--(a + (s,0))--cycle;
enddef;

% Perspective projection of points z[s]..z[e]
def ppp(expr s,e) = for i = s upto e: z[i] = ppr(c[i]); endfor enddef;

% Dimetric projection of points z[s]..z[e]
def dpp(expr s,e) = for i = s upto e: z[i] = dpr(c[i]); endfor enddef;

% Turn standard arrows drawing on and off
def arrowon = linejoin := mitered; ahangle := 20; enddef;
def arrowoff = linejoin := rounded; enddef;

% Label that should be pdraws the text withcolor white
newinternal labelesize; labelesize := 1pt;
vardef elabel@#(expr t, p) =
  save v; pair v; v = (labelesize,0);
  for i = 0 step 5 until 360: draw thelabel@#(t, p shifted (v rotated i)) withcolor white; endfor
  draw thelabel@#(t, p);
enddef;
