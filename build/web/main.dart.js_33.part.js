((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,D,E,F,A={auR:function auR(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},auS:function auS(){},auT:function auT(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},auQ:function auQ(){},G4:function G4(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},xM:function xM(d,e,f){var _=this
_.b=_.w=null
_.c=!1
_.tN$=d
_.cV$=e
_.aJ$=f
_.a=null},Wv:function Wv(d,e,f,g,h,i,j){var _=this
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
return new A.le(d,new F.G3(e,f,!0,!0,!0,D.b2n(),x),g,C.av,!1,x,x,E.i1,!1,x,f,C.ai,x,x,C.C,C.aS,x)},
le:function le(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
XE:function XE(d,e,f){this.f=d
this.d=e
this.a=f}}
B=c[0]
C=c[2]
D=c[30]
E=c[35]
F=c[29]
A=a.updateHolder(c[11],A)
A.auR.prototype={
a4_(d){var x=this.c
return d.BK(this.d,x,x)},
k(d){var x=this
return"SliverGridGeometry("+C.b.bM(B.b(["scrollOffset: "+B.j(x.a),"crossAxisOffset: "+B.j(x.b),"mainAxisExtent: "+B.j(x.c),"crossAxisExtent: "+B.j(x.d)],y.x),", ")+")"}}
A.auS.prototype={}
A.auT.prototype={
a4a(d){var x=this.b
if(x>0)return Math.max(0,this.a*C.d.ln(d/x)-1)
return 0},
afs(d){var x,w,v=this
if(v.f){x=v.c
w=v.e
return v.a*x-d-w-(x-w)}return d},
F_(d){var x=this,w=x.a,v=C.e.bS(d,w)
return new A.auR(C.e.j3(d,w)*x.b,x.afs(v*x.c),x.d,x.e)},
ZM(d){var x
if(d===0)return 0
x=this.b
return x*(C.e.j3(d-1,this.a)+1)-(x-this.d)}}
A.auQ.prototype={}
A.G4.prototype={
OT(d){var x=this,w=x.c,v=x.a,u=Math.max(0,d.w-w*(v-1))/v,t=u/x.d
return new A.auT(v,t+x.b,u+w,t,u,B.A6(d.x))}}
A.xM.prototype={
k(d){return"crossAxisOffset="+B.j(this.w)+"; "+this.a7U(0)}}
A.Wv.prototype={
f3(d){if(!(d.b instanceof A.xM))d.b=new A.xM(!1,null,null)},
sa4m(d){var x,w,v=this
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
r=isFinite(v)?u.a4a(v):a7
if(a6.af$!=null){q=a6.asX(s)
a6.wP(q,r!=null?a6.at0(r):0)}else a6.wP(0,0)
p=u.F_(s)
if(a6.af$==null)if(!a6.YU(s,p.a)){o=u.ZM(a9.gwO())
a6.dy=D.ni(a7,!1,a7,a7,o,0,0,o,a7)
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
for(;k>=s;--k){i=u.F_(k)
h=i.c
g=a6.ayl(a8.BK(i.d,h,h))
f=g.b
f.toString
t.a(f)
e=i.a
f.a=e
f.w=i.b
if(j==null)j=g
m=Math.max(m,e+h)}if(j==null){h=a6.af$
h.toString
h.hI(p.a4_(a8))
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
break}i=u.F_(k)
e=i.c
a0=a8.BK(i.d,e,e)
a1=j.b
a1.toString
g=h.a(a1).aJ$
if(g!=null){a1=g.b
a1.toString
a1=l.a(a1).b
a1.toString
a1=a1!==k}else a1=!0
if(a1){g=a6.ayk(a0,j)
if(g==null){d=!0
break}}else g.hI(a0)
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
a3=d?m:a9.a_T(a8,s,t,n,m)
a4=a6.BU(a8,Math.min(x,n),m)
a5=a6.Ky(a8,n,m)
a6.dy=D.ni(a5,a3>a4||x>0||a8.f!==0,a7,a7,a3,a4,0,a3,a7)
if(a3===m)a9.R8=!0
a9.xa()}}
A.le.prototype={
Zl(d){return new A.XE(this.rx,this.ry,null)}}
A.XE.prototype={
b0(d){var x=new A.Wv(this.f,y.v.a(d),B.D(y.e,y.g),0,null,null,B.an())
x.b_()
return x},
bb(d,e){e.sa4m(this.f)},
LU(d,e,f,g,h){var x
this.a7V(d,e,f,g,h)
x=this.f.OT(d).ZM(this.d.gtH())
return x}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.E,[A.auR,A.auS,A.auQ])
w(A.auT,A.auS)
w(A.G4,A.auQ)
w(A.xM,D.fH)
w(A.Wv,D.pe)
w(A.le,D.AZ)
w(A.XE,D.nl)})()
B.dH(b.typeUniverse,JSON.parse('{"xM":{"fH":[],"nk":[],"dV":["y"],"k8":[],"cG":[]},"Wv":{"pe":[],"dg":[],"ai":["y","fH"],"B":[],"ap":[],"ai.1":"fH","ai.0":"y"},"le":{"ab":[],"f":[]},"XE":{"nl":[],"ao":[],"f":[]}}'))
var y={x:B.R("n<m>"),g:B.R("y"),z:B.R("kn"),t:B.R("xM"),v:B.R("tM"),c:B.R("fH"),e:B.R("k")}};
(a=>{a["ypA87CaOU3uJmExa77qRfKfWTIM="]=a.current})($__dart_deferred_initializers__);