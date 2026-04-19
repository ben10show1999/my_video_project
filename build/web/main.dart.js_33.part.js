((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,D,E,F,A={av6:function av6(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},av7:function av7(){},av8:function av8(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},av5:function av5(){},Gb:function Gb(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},xN:function xN(d,e,f){var _=this
_.b=_.w=null
_.c=!1
_.tU$=d
_.cV$=e
_.aJ$=f
_.a=null},WF:function WF(d,e,f,g,h,i,j){var _=this
_.e2=d
_.y1=e
_.y2=f
_.cH$=g
_.af$=h
_.cZ$=i
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
aSd(d,e,f,g){var x=null
return new A.lf(d,new F.Ga(e,f,!0,!0,!0,D.b2M(),x),g,C.av,!1,x,x,E.i0,!1,x,f,C.ai,x,x,C.C,C.aS,x)},
lf:function lf(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
XO:function XO(d,e,f){this.f=d
this.d=e
this.a=f}}
B=c[0]
C=c[2]
D=c[30]
E=c[35]
F=c[29]
A=a.updateHolder(c[11],A)
A.av6.prototype={
a49(d){var x=this.c
return d.BO(this.d,x,x)},
k(d){var x=this
return"SliverGridGeometry("+C.b.bN(B.b(["scrollOffset: "+B.j(x.a),"crossAxisOffset: "+B.j(x.b),"mainAxisExtent: "+B.j(x.c),"crossAxisExtent: "+B.j(x.d)],y.x),", ")+")"}}
A.av7.prototype={}
A.av8.prototype={
a4k(d){var x=this.b
if(x>0)return Math.max(0,this.a*C.d.lq(d/x)-1)
return 0},
afE(d){var x,w,v=this
if(v.f){x=v.c
w=v.e
return v.a*x-d-w-(x-w)}return d},
F4(d){var x=this,w=x.a,v=C.e.bV(d,w)
return new A.av6(C.e.j6(d,w)*x.b,x.afE(v*x.c),x.d,x.e)},
ZW(d){var x
if(d===0)return 0
x=this.b
return x*(C.e.j6(d-1,this.a)+1)-(x-this.d)}}
A.av5.prototype={}
A.Gb.prototype={
P0(d){var x=this,w=x.c,v=x.a,u=Math.max(0,d.w-w*(v-1))/v,t=u/x.d
return new A.av8(v,t+x.b,u+w,t,u,B.A9(d.x))}}
A.xN.prototype={
k(d){return"crossAxisOffset="+B.j(this.w)+"; "+this.a83(0)}}
A.WF.prototype={
f6(d){if(!(d.b instanceof A.xN))d.b=new A.xN(!1,null,null)},
sa4w(d){var x,w,v=this
if(v.e2===d)return
x=!0
if(B.A(d)===B.A(v.e2)){w=v.e2
if(w.a===d.a)if(w.b===d.b)if(w.c===d.c)x=w.d!==d.d}if(x)v.a7()
v.e2=d},
tu(d){var x=d.b
x.toString
x=y.t.a(x).w
x.toString
return x},
bT(){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5,a6=this,a7=null,a8=y.z.a(B.B.prototype.ga6.call(a6)),a9=a6.y1
a9.R8=!1
x=a8.d
w=x+a8.z
v=w+a8.Q
u=a6.e2.P0(a8)
t=u.b
s=t>1e-10?u.a*C.d.j6(w,t):0
r=isFinite(v)?u.a4k(v):a7
if(a6.af$!=null){q=a6.at9(s)
a6.wW(q,r!=null?a6.atd(r):0)}else a6.wW(0,0)
p=u.F4(s)
if(a6.af$==null)if(!a6.Z3(s,p.a)){o=u.ZW(a9.gwV())
a6.dy=D.nn(a7,!1,a7,a7,o,0,0,o,a7)
a9.xg()
return}n=p.a
m=n+p.c
t=a6.af$
t.toString
t=t.b
t.toString
l=y.c
t=l.a(t).b
t.toString
k=t-1
t=y.t
j=a7
for(;k>=s;--k){i=u.F4(k)
h=i.c
g=a6.ayx(a8.BO(i.d,h,h))
f=g.b
f.toString
t.a(f)
e=i.a
f.a=e
f.w=i.b
if(j==null)j=g
m=Math.max(m,e+h)}if(j==null){h=a6.af$
h.toString
h.fZ(p.a49(a8))
j=a6.af$
h=j.b
h.toString
t.a(h)
h.a=n
h.w=p.b}h=j.b
h.toString
h=l.a(h).b
h.toString
k=h+1
h=B.l(a6).h("ai.1")
f=r!=null
for(;;){if(!(!f||k<=r)){d=!1
break}i=u.F4(k)
e=i.c
a0=a8.BO(i.d,e,e)
a1=j.b
a1.toString
g=h.a(a1).aJ$
if(g!=null){a1=g.b
a1.toString
a1=l.a(a1).b
a1.toString
a1=a1!==k}else a1=!0
if(a1){g=a6.ayw(a0,j)
if(g==null){d=!0
break}}else g.fZ(a0)
a1=g.b
a1.toString
t.a(a1)
a2=i.a
a1.a=a2
a1.w=i.b
m=Math.max(m,a2+e);++k
j=g}t=a6.cZ$
t.toString
t=t.b
t.toString
t=l.a(t).b
t.toString
a3=d?m:a9.a02(a8,s,t,n,m)
a4=a6.BY(a8,Math.min(x,n),m)
a5=a6.KE(a8,n,m)
a6.dy=D.nn(a5,a3>a4||x>0||a8.f!==0,a7,a7,a3,a4,0,a3,a7)
if(a3===m)a9.R8=!0
a9.xg()}}
A.lf.prototype={
Zv(d){return new A.XO(this.rx,this.ry,null)}}
A.XO.prototype={
b_(d){var x=new A.WF(this.f,y.v.a(d),B.E(y.e,y.g),0,null,null,B.an())
x.aX()
return x},
ba(d,e){e.sa4w(this.f)},
M0(d,e,f,g,h){var x
this.a84(d,e,f,g,h)
x=this.f.P0(d).ZW(this.d.gtO())
return x}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.D,[A.av6,A.av7,A.av5])
w(A.av8,A.av7)
w(A.Gb,A.av5)
w(A.xN,D.fK)
w(A.WF,D.pj)
w(A.lf,D.B3)
w(A.XO,D.nq)})()
B.dH(b.typeUniverse,JSON.parse('{"xN":{"fK":[],"np":[],"dW":["y"],"kb":[],"cG":[]},"WF":{"pj":[],"dg":[],"ai":["y","fK"],"B":[],"ap":[],"ai.1":"fK","ai.0":"y"},"lf":{"aa":[],"f":[]},"XO":{"nq":[],"ao":[],"f":[]}}'))
var y={x:B.R("p<m>"),g:B.R("y"),z:B.R("kq"),t:B.R("xN"),v:B.R("tM"),c:B.R("fK"),e:B.R("k")}};
(a=>{a["EINpCVGGYJMf8ytSR9f64tPQEE4="]=a.current})($__dart_deferred_initializers__);