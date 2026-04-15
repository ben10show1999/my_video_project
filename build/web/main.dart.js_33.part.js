((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,D,E,F,A={auT:function auT(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},auU:function auU(){},auV:function auV(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},auS:function auS(){},G6:function G6(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},xK:function xK(d,e,f){var _=this
_.b=_.w=null
_.c=!1
_.tN$=d
_.cV$=e
_.aJ$=f
_.a=null},WA:function WA(d,e,f,g,h,i,j){var _=this
_.e1=d
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
aRU(d,e,f,g){var x=null
return new A.lf(d,new F.G5(e,f,!0,!0,!0,D.b2n(),x),g,C.av,!1,x,x,E.i1,!1,x,f,C.ai,x,x,C.C,C.aS,x)},
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
XJ:function XJ(d,e,f){this.f=d
this.d=e
this.a=f}}
B=c[0]
C=c[2]
D=c[30]
E=c[35]
F=c[29]
A=a.updateHolder(c[11],A)
A.auT.prototype={
a40(d){var x=this.c
return d.BJ(this.d,x,x)},
k(d){var x=this
return"SliverGridGeometry("+C.b.bM(B.b(["scrollOffset: "+B.j(x.a),"crossAxisOffset: "+B.j(x.b),"mainAxisExtent: "+B.j(x.c),"crossAxisExtent: "+B.j(x.d)],y.x),", ")+")"}}
A.auU.prototype={}
A.auV.prototype={
a4b(d){var x=this.b
if(x>0)return Math.max(0,this.a*C.d.ln(d/x)-1)
return 0},
aft(d){var x,w,v=this
if(v.f){x=v.c
w=v.e
return v.a*x-d-w-(x-w)}return d},
EZ(d){var x=this,w=x.a,v=C.e.bS(d,w)
return new A.auT(C.e.j3(d,w)*x.b,x.aft(v*x.c),x.d,x.e)},
ZN(d){var x
if(d===0)return 0
x=this.b
return x*(C.e.j3(d-1,this.a)+1)-(x-this.d)}}
A.auS.prototype={}
A.G6.prototype={
OT(d){var x=this,w=x.c,v=x.a,u=Math.max(0,d.w-w*(v-1))/v,t=u/x.d
return new A.auV(v,t+x.b,u+w,t,u,B.A5(d.x))}}
A.xK.prototype={
k(d){return"crossAxisOffset="+B.j(this.w)+"; "+this.a7V(0)}}
A.WA.prototype={
f3(d){if(!(d.b instanceof A.xK))d.b=new A.xK(!1,null,null)},
sa4n(d){var x,w,v=this
if(v.e1===d)return
x=!0
if(B.A(d)===B.A(v.e1)){w=v.e1
if(w.a===d.a)if(w.b===d.b)if(w.c===d.c)x=w.d!==d.d}if(x)v.ad()
v.e1=d},
tn(d){var x=d.b
x.toString
x=y.t.a(x).w
x.toString
return x},
bT(){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5,a6=this,a7=null,a8=y.z.a(B.B.prototype.ga7.call(a6)),a9=a6.y1
a9.R8=!1
x=a8.d
w=x+a8.z
v=w+a8.Q
u=a6.e1.OT(a8)
t=u.b
s=t>1e-10?u.a*C.d.j3(w,t):0
r=isFinite(v)?u.a4b(v):a7
if(a6.af$!=null){q=a6.asY(s)
a6.wP(q,r!=null?a6.at1(r):0)}else a6.wP(0,0)
p=u.EZ(s)
if(a6.af$==null)if(!a6.YV(s,p.a)){o=u.ZN(a9.gwO())
a6.dy=D.nk(a7,!1,a7,a7,o,0,0,o,a7)
a9.xa()
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
for(;k>=s;--k){i=u.EZ(k)
h=i.c
g=a6.aym(a8.BJ(i.d,h,h))
f=g.b
f.toString
t.a(f)
e=i.a
f.a=e
f.w=i.b
if(j==null)j=g
m=Math.max(m,e+h)}if(j==null){h=a6.af$
h.toString
h.hH(p.a40(a8))
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
break}i=u.EZ(k)
e=i.c
a0=a8.BJ(i.d,e,e)
a1=j.b
a1.toString
g=h.a(a1).aJ$
if(g!=null){a1=g.b
a1.toString
a1=l.a(a1).b
a1.toString
a1=a1!==k}else a1=!0
if(a1){g=a6.ayl(a0,j)
if(g==null){d=!0
break}}else g.hH(a0)
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
a3=d?m:a9.a_U(a8,s,t,n,m)
a4=a6.BT(a8,Math.min(x,n),m)
a5=a6.Ky(a8,n,m)
a6.dy=D.nk(a5,a3>a4||x>0||a8.f!==0,a7,a7,a3,a4,0,a3,a7)
if(a3===m)a9.R8=!0
a9.xa()}}
A.lf.prototype={
Zm(d){return new A.XJ(this.rx,this.ry,null)}}
A.XJ.prototype={
b1(d){var x=new A.WA(this.f,y.v.a(d),B.D(y.e,y.g),0,null,null,B.an())
x.b0()
return x},
bb(d,e){e.sa4n(this.f)},
LU(d,e,f,g,h){var x
this.a7W(d,e,f,g,h)
x=this.f.OT(d).ZN(this.d.gtH())
return x}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.E,[A.auT,A.auU,A.auS])
w(A.auV,A.auU)
w(A.G6,A.auS)
w(A.xK,D.fH)
w(A.WA,D.pf)
w(A.lf,D.AZ)
w(A.XJ,D.nn)})()
B.dH(b.typeUniverse,JSON.parse('{"xK":{"fH":[],"nm":[],"dV":["y"],"k8":[],"cF":[]},"WA":{"pf":[],"dg":[],"ai":["y","fH"],"B":[],"ap":[],"ai.1":"fH","ai.0":"y"},"lf":{"ab":[],"f":[]},"XJ":{"nn":[],"ao":[],"f":[]}}'))
var y={x:B.S("n<m>"),g:B.S("y"),z:B.S("kn"),t:B.S("xK"),v:B.S("tM"),c:B.S("fH"),e:B.S("k")}};
(a=>{a["Ldzz0Y1i87jTc41XfKKLdge3sUs="]=a.current})($__dart_deferred_initializers__);