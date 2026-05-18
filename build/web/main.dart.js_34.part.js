((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,D,E,F,A={ayu:function ayu(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},ayv:function ayv(){},ayw:function ayw(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},ayt:function ayt(){},HS:function HS(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},zd:function zd(d,e,f){var _=this
_.b=_.w=null
_.c=!1
_.uf$=d
_.cZ$=e
_.ar$=f
_.a=null},YD:function YD(d,e,f,g,h,i,j){var _=this
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
aWh(d,e,f,g){var x=null
return new A.lH(d,new F.HR(e,f,!0,!0,!0,D.b7I(),x),g,C.at,!1,x,x,E.i6,!1,x,f,C.ag,x,x,C.D,C.aX,x)},
lH:function lH(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
ZM:function ZM(d,e,f){this.f=d
this.d=e
this.a=f}}
B=c[0]
C=c[2]
D=c[29]
E=c[35]
F=c[27]
A=a.updateHolder(c[12],A)
A.ayu.prototype={
a5l(d){var x=this.c
return d.Co(this.d,x,x)},
k(d){var x=this
return"SliverGridGeometry("+C.b.bn(B.b(["scrollOffset: "+B.j(x.a),"crossAxisOffset: "+B.j(x.b),"mainAxisExtent: "+B.j(x.c),"crossAxisExtent: "+B.j(x.d)],y.x),", ")+")"}}
A.ayv.prototype={}
A.ayw.prototype={
a5w(d){var x=this.b
if(x>0)return Math.max(0,this.a*C.d.kY(d/x)-1)
return 0},
ah1(d){var x,w,v=this
if(v.f){x=v.c
w=v.e
return v.a*x-d-w-(x-w)}return d},
FK(d){var x=this,w=x.a,v=C.e.c_(d,w)
return new A.ayu(C.e.jh(d,w)*x.b,x.ah1(v*x.c),x.d,x.e)},
a_Z(d){var x
if(d===0)return 0
x=this.b
return x*(C.e.jh(d-1,this.a)+1)-(x-this.d)}}
A.ayt.prototype={}
A.HS.prototype={
PQ(d){var x=this,w=x.c,v=x.a,u=Math.max(0,d.w-w*(v-1))/v,t=u/x.d
return new A.ayw(v,t+x.b,u+w,t,u,B.Bz(d.x))}}
A.zd.prototype={
k(d){return"crossAxisOffset="+B.j(this.w)+"; "+this.a9p(0)}}
A.YD.prototype={
eZ(d){if(!(d.b instanceof A.zd))d.b=new A.zd(!1,null,null)},
sa5L(d){var x,w,v=this
if(v.eb===d)return
x=!0
if(B.u(d)===B.u(v.eb)){w=v.eb
if(w.a===d.a)if(w.b===d.b)if(w.c===d.c)x=w.d!==d.d}if(x)v.ac()
v.eb=d},
tP(d){var x=d.b
x.toString
x=y.t.a(x).w
x.toString
return x},
bV(){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5,a6=this,a7=null,a8=y.z.a(B.C.prototype.ga6.call(a6)),a9=a6.y1
a9.R8=!1
x=a8.d
w=x+a8.z
v=w+a8.Q
u=a6.eb.PQ(a8)
t=u.b
s=t>1e-10?u.a*C.d.jh(w,t):0
r=isFinite(v)?u.a5w(v):a7
if(a6.ae$!=null){q=a6.auF(s)
a6.xi(q,r!=null?a6.auJ(r):0)}else a6.xi(0,0)
p=u.FK(s)
if(a6.ae$==null)if(!a6.a_3(s,p.a)){o=u.a_Z(a9.gxh())
a6.dy=D.nX(a7,!1,a7,a7,o,0,0,o,a7)
a9.xE()
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
for(;k>=s;--k){i=u.FK(k)
h=i.c
g=a6.aA7(a8.Co(i.d,h,h))
f=g.b
f.toString
t.a(f)
e=i.a
f.a=e
f.w=i.b
if(j==null)j=g
m=Math.max(m,e+h)}if(j==null){h=a6.ae$
h.toString
h.i_(p.a5l(a8))
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
break}i=u.FK(k)
e=i.c
a0=a8.Co(i.d,e,e)
a1=j.b
a1.toString
g=h.a(a1).ar$
if(g!=null){a1=g.b
a1.toString
a1=l.a(a1).b
a1.toString
a1=a1!==k}else a1=!0
if(a1){g=a6.aA6(a0,j)
if(g==null){d=!0
break}}else g.i_(a0)
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
a3=d?m:a9.a17(a8,s,t,n,m)
a4=a6.Cw(a8,Math.min(x,n),m)
a5=a6.Lm(a8,n,m)
a6.dy=D.nX(a5,a3>a4||x>0||a8.f!==0,a7,a7,a3,a4,0,a3,a7)
if(a3===m)a9.R8=!0
a9.xE()}}
A.lH.prototype={
a_w(d){return new A.ZM(this.rx,this.ry,null)}}
A.ZM.prototype={
aX(d){var x=new A.YD(this.f,y.v.a(d),B.D(y.e,y.g),0,null,null,B.ao())
x.aW()
return x},
bd(d,e){e.sa5L(this.f)},
MK(d,e,f,g,h){var x
this.a9q(d,e,f,g,h)
x=this.f.PQ(d).a_Z(this.d.gu7())
return x}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.x,[A.ayu,A.ayv,A.ayt])
w(A.ayw,A.ayv)
w(A.HS,A.ayt)
w(A.zd,D.fY)
w(A.YD,D.q1)
w(A.lH,D.Cx)
w(A.ZM,D.o_)})()
B.dB(b.typeUniverse,JSON.parse('{"zd":{"fY":[],"nZ":[],"dX":["z"],"kz":[],"cK":[]},"YD":{"q1":[],"ds":[],"af":["z","fY"],"C":[],"aq":[],"af.1":"fY","af.0":"z"},"lH":{"ad":[],"f":[]},"ZM":{"o_":[],"ap":[],"f":[]}}'))
var y={x:B.R("v<l>"),g:B.R("z"),z:B.R("kM"),t:B.R("zd"),v:B.R("uO"),c:B.R("fY"),e:B.R("k")}};
(a=>{a["2zHMqxnnUPIxqh8G+Xwp5g8M5h8="]=a.current})($__dart_deferred_initializers__);