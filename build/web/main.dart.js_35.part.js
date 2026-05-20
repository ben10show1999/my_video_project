((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,D,E,F,A={ayw:function ayw(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},ayx:function ayx(){},ayy:function ayy(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},ayv:function ayv(){},HU:function HU(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},ze:function ze(d,e,f){var _=this
_.b=_.w=null
_.c=!1
_.uj$=d
_.cZ$=e
_.au$=f
_.a=null},YG:function YG(d,e,f,g,h,i,j){var _=this
_.eb=d
_.y1=e
_.y2=f
_.cO$=g
_.ae$=h
_.d_$=i
_.b=_.dy=null
_.c=0
_.y=_.d=null
_.z=!0
_.Q=null
_.as=!1
_.at=null
_.ay=$
_.ch=j
_.CW=!1
_.cx=$
_.cy=!0
_.db=!1
_.dx=$},
aWm(d,e,f,g){var x=null
return new A.lL(d,new F.HT(e,f,!0,!0,!0,D.b7Q(),x),g,C.at,!1,x,x,E.i6,!1,x,f,C.ag,x,x,C.D,C.aX,x)},
lL:function lL(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
_.rx=d
_.ry=e
_.db=f
_.c=g
_.d=h
_.e=i
_.f=j
_.r=k
_.x=l
_.Q=m
_.as=n
_.ax=o
_.ay=p
_.ch=q
_.CW=r
_.cx=s
_.a=t},
ZP:function ZP(d,e,f){this.f=d
this.d=e
this.a=f}}
B=c[0]
C=c[2]
D=c[29]
E=c[35]
F=c[27]
A=a.updateHolder(c[12],A)
A.ayw.prototype={
a5p(d){var x=this.c
return d.Cr(this.d,x,x)},
k(d){var x=this
return"SliverGridGeometry("+C.b.bn(B.b(["scrollOffset: "+B.j(x.a),"crossAxisOffset: "+B.j(x.b),"mainAxisExtent: "+B.j(x.c),"crossAxisExtent: "+B.j(x.d)],y.x),", ")+")"}}
A.ayx.prototype={}
A.ayy.prototype={
a5A(d){var x=this.b
if(x>0)return Math.max(0,this.a*C.d.kY(d/x)-1)
return 0},
ah5(d){var x,w,v=this
if(v.f){x=v.c
w=v.e
return v.a*x-d-w-(x-w)}return d},
FO(d){var x=this,w=x.a,v=C.e.c_(d,w)
return new A.ayw(C.e.jh(d,w)*x.b,x.ah5(v*x.c),x.d,x.e)},
a02(d){var x
if(d===0)return 0
x=this.b
return x*(C.e.jh(d-1,this.a)+1)-(x-this.d)}}
A.ayv.prototype={}
A.HU.prototype={
PU(d){var x=this,w=x.c,v=x.a,u=Math.max(0,d.w-w*(v-1))/v,t=u/x.d
return new A.ayy(v,t+x.b,u+w,t,u,B.BB(d.x))}}
A.ze.prototype={
k(d){return"crossAxisOffset="+B.j(this.w)+"; "+this.a9t(0)}}
A.YG.prototype={
f_(d){if(!(d.b instanceof A.ze))d.b=new A.ze(!1,null,null)},
sa5P(d){var x,w,v=this
if(v.eb===d)return
x=!0
if(B.u(d)===B.u(v.eb)){w=v.eb
if(w.a===d.a)if(w.b===d.b)if(w.c===d.c)x=w.d!==d.d}if(x)v.ac()
v.eb=d},
tT(d){var x=d.b
x.toString
x=y.t.a(x).w
x.toString
return x},
bV(){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5,a6=this,a7=null,a8=y.z.a(B.C.prototype.ga6.call(a6)),a9=a6.y1
a9.R8=!1
x=a8.d
w=x+a8.z
v=w+a8.Q
u=a6.eb.PU(a8)
t=u.b
s=t>1e-10?u.a*C.d.jh(w,t):0
r=isFinite(v)?u.a5A(v):a7
if(a6.ae$!=null){q=a6.auL(s)
a6.xj(q,r!=null?a6.auP(r):0)}else a6.xj(0,0)
p=u.FO(s)
if(a6.ae$==null)if(!a6.a_7(s,p.a)){o=u.a02(a9.gxi())
a6.dy=D.o_(a7,!1,a7,a7,o,0,0,o,a7)
a9.xF()
return}n=p.a
m=n+p.c
t=a6.ae$
t.toString
t=t.b
t.toString
l=y.c
t=l.a(t).b
t.toString
k=t-1
t=y.t
j=a7
for(;k>=s;--k){i=u.FO(k)
h=i.c
g=a6.aAd(a8.Cr(i.d,h,h))
f=g.b
f.toString
t.a(f)
e=i.a
f.a=e
f.w=i.b
if(j==null)j=g
m=Math.max(m,e+h)}if(j==null){h=a6.ae$
h.toString
h.i0(p.a5p(a8))
j=a6.ae$
h=j.b
h.toString
t.a(h)
h.a=n
h.w=p.b}h=j.b
h.toString
h=l.a(h).b
h.toString
k=h+1
h=B.t(a6).i("af.1")
f=r!=null
for(;;){if(!(!f||k<=r)){d=!1
break}i=u.FO(k)
e=i.c
a0=a8.Cr(i.d,e,e)
a1=j.b
a1.toString
g=h.a(a1).au$
if(g!=null){a1=g.b
a1.toString
a1=l.a(a1).b
a1.toString
a1=a1!==k}else a1=!0
if(a1){g=a6.aAc(a0,j)
if(g==null){d=!0
break}}else g.i0(a0)
a1=g.b
a1.toString
t.a(a1)
a2=i.a
a1.a=a2
a1.w=i.b
m=Math.max(m,a2+e);++k
j=g}t=a6.d_$
t.toString
t=t.b
t.toString
t=l.a(t).b
t.toString
a3=d?m:a9.a1b(a8,s,t,n,m)
a4=a6.Cz(a8,Math.min(x,n),m)
a5=a6.Lq(a8,n,m)
a6.dy=D.o_(a5,a3>a4||x>0||a8.f!==0,a7,a7,a3,a4,0,a3,a7)
if(a3===m)a9.R8=!0
a9.xF()}}
A.lL.prototype={
a_A(d){return new A.ZP(this.rx,this.ry,null)}}
A.ZP.prototype={
aX(d){var x=new A.YG(this.f,y.v.a(d),B.D(y.e,y.g),0,null,null,B.ao())
x.aW()
return x},
bd(d,e){e.sa5P(this.f)},
MO(d,e,f,g,h){var x
this.a9u(d,e,f,g,h)
x=this.f.PU(d).a02(this.d.guc())
return x}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.x,[A.ayw,A.ayx,A.ayv])
w(A.ayy,A.ayx)
w(A.HU,A.ayv)
w(A.ze,D.h0)
w(A.YG,D.q2)
w(A.lL,D.Cz)
w(A.ZP,D.o2)})()
B.dB(b.typeUniverse,JSON.parse('{"ze":{"h0":[],"o1":[],"dX":["z"],"kz":[],"cK":[]},"YG":{"q2":[],"dt":[],"af":["z","h0"],"C":[],"aq":[],"af.1":"h0","af.0":"z"},"lL":{"ad":[],"f":[]},"ZP":{"o2":[],"ap":[],"f":[]}}'))
var y={x:B.R("v<k>"),g:B.R("z"),z:B.R("kO"),t:B.R("ze"),v:B.R("uQ"),c:B.R("h0"),e:B.R("m")}};
(a=>{a["S9MViWWEK+9iexXbljRYUOrHE/M="]=a.current})($__dart_deferred_initializers__);