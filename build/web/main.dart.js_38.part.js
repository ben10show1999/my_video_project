((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,D,E,F,A={azS:function azS(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},azT:function azT(){},azU:function azU(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},azR:function azR(){},Iq:function Iq(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},zt:function zt(d,e,f){var _=this
_.b=_.w=null
_.c=!1
_.ux$=d
_.d_$=e
_.au$=f
_.a=null},Zi:function Zi(d,e,f,g,h,i,j){var _=this
_.aD=d
_.y1=e
_.y2=f
_.cO$=g
_.ac$=h
_.d0$=i
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
aYz(d,e,f,g){var x=null
return new A.lQ(d,new F.Ip(e,f,!0,!0,!0,D.bag(),x),g,C.at,!1,x,x,E.ic,!1,x,x,f,C.aj,x,x,C.D,C.aY,x)},
lQ:function lQ(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u){var _=this
_.to=d
_.x1=e
_.dx=f
_.c=g
_.d=h
_.e=i
_.f=j
_.r=k
_.x=l
_.Q=m
_.as=n
_.at=o
_.ay=p
_.ch=q
_.CW=r
_.cx=s
_.cy=t
_.a=u},
a_q:function a_q(d,e,f){this.f=d
this.d=e
this.a=f}}
B=c[0]
C=c[2]
D=c[31]
E=c[37]
F=c[29]
A=a.updateHolder(c[13],A)
A.azS.prototype={
a5Z(d){var x=this.c
return d.CX(this.d,x,x)},
k(d){var x=this
return"SliverGridGeometry("+C.b.bj(B.b(["scrollOffset: "+B.j(x.a),"crossAxisOffset: "+B.j(x.b),"mainAxisExtent: "+B.j(x.c),"crossAxisExtent: "+B.j(x.d)],y.x),", ")+")"}}
A.azT.prototype={}
A.azU.prototype={
a69(d){var x=this.b
if(x>0)return Math.max(0,this.a*C.d.jy(d/x)-1)
return 0},
ahP(d){var x,w,v=this
if(v.f){x=v.c
w=v.e
return v.a*x-d-w-(x-w)}return d},
Gk(d){var x=this,w=x.a,v=C.e.c_(d,w)
return new A.azS(C.e.jk(d,w)*x.b,x.ahP(v*x.c),x.d,x.e)},
a0y(d){var x
if(d===0)return 0
x=this.b
return x*(C.e.jk(d-1,this.a)+1)-(x-this.d)}}
A.azR.prototype={}
A.Iq.prototype={
Qm(d){var x=this,w=x.c,v=x.a,u=Math.max(0,d.w-w*(v-1))/v,t=u/x.d
return new A.azU(v,t+x.b,u+w,t,u,B.BY(d.x))}}
A.zt.prototype={
k(d){return"crossAxisOffset="+B.j(this.w)+"; "+this.aa2(0)}}
A.Zi.prototype={
f5(d){if(!(d.b instanceof A.zt))d.b=new A.zt(!1,null,null)},
sa6r(d){var x,w,v=this
if(v.aD===d)return
x=!0
if(B.u(d)===B.u(v.aD)){w=v.aD
if(w.a===d.a)if(w.b===d.b)if(w.c===d.c)x=w.d!==d.d}if(x)v.ab()
v.aD=d},
u5(d){var x=d.b
x.toString
x=y.t.a(x).w
x.toString
return x},
bX(){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5,a6=this,a7=null,a8=y.z.a(B.D.prototype.ga7.call(a6)),a9=a6.y1
a9.R8=!1
x=a8.d
w=x+a8.z
v=w+a8.Q
u=a6.aD.Qm(a8)
t=u.b
s=t>1e-10?u.a*C.d.jk(w,t):0
r=isFinite(v)?u.a69(v):a7
if(a6.ac$!=null){q=a6.avF(s)
a6.xx(q,r!=null?a6.avK(r):0)}else a6.xx(0,0)
p=u.Gk(s)
if(a6.ac$==null)if(!a6.a_E(s,p.a)){o=u.a0y(a9.gxw())
a6.dy=D.o9(a7,!1,a7,a7,o,0,0,o,a7)
a9.xU()
return}n=p.a
m=n+p.c
t=a6.ac$
t.toString
t=t.b
t.toString
l=y.c
t=l.a(t).b
t.toString
k=t-1
t=y.t
j=a7
for(;k>=s;--k){i=u.Gk(k)
h=i.c
g=a6.aB9(a8.CX(i.d,h,h))
f=g.b
f.toString
t.a(f)
e=i.a
f.a=e
f.w=i.b
if(j==null)j=g
m=Math.max(m,e+h)}if(j==null){h=a6.ac$
h.toString
h.i6(p.a5Z(a8))
j=a6.ac$
h=j.b
h.toString
t.a(h)
h.a=n
h.w=p.b}h=j.b
h.toString
h=l.a(h).b
h.toString
k=h+1
h=B.t(a6).i("ah.1")
f=r!=null
for(;;){if(!(!f||k<=r)){d=!1
break}i=u.Gk(k)
e=i.c
a0=a8.CX(i.d,e,e)
a1=j.b
a1.toString
g=h.a(a1).au$
if(g!=null){a1=g.b
a1.toString
a1=l.a(a1).b
a1.toString
a1=a1!==k}else a1=!0
if(a1){g=a6.aB8(a0,j)
if(g==null){d=!0
break}}else g.i6(a0)
a1=g.b
a1.toString
t.a(a1)
a2=i.a
a1.a=a2
a1.w=i.b
m=Math.max(m,a2+e);++k
j=g}t=a6.d0$
t.toString
t=t.b
t.toString
t=l.a(t).b
t.toString
a3=d?m:a9.a1G(a8,s,t,n,m)
a4=a6.D4(a8,Math.min(x,n),m)
a5=a6.LX(a8,n,m)
a6.dy=D.o9(a5,a3>a4||x>0||a8.f!==0,a7,a7,a3,a4,0,a3,a7)
if(a3===m)a9.R8=!0
a9.xU()}}
A.lQ.prototype={
a05(d){return new A.a_q(this.to,this.x1,null)}}
A.a_q.prototype={
aX(d){var x=new A.Zi(this.f,y.v.a(d),B.A(y.e,y.g),0,null,null,B.ao())
x.aW()
return x},
bd(d,e){e.sa6r(this.f)},
Nk(d,e,f,g,h){var x
this.aa3(d,e,f,g,h)
x=this.f.Qm(d).a0y(this.d.gur())
return x}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.x,[A.azS,A.azT,A.azR])
w(A.azU,A.azT)
w(A.Iq,A.azR)
w(A.zt,D.h9)
w(A.Zi,D.qb)
w(A.lQ,D.CZ)
w(A.a_q,D.oc)})()
B.dy(b.typeUniverse,JSON.parse('{"zt":{"h9":[],"ob":[],"e5":["y"],"kH":[],"cP":[]},"Zi":{"qb":[],"dv":[],"ah":["y","h9"],"D":[],"as":[],"ah.1":"h9","ah.0":"y"},"lQ":{"a9":[],"f":[]},"a_q":{"oc":[],"ar":[],"f":[]}}'))
var y={x:B.P("v<q>"),g:B.P("y"),z:B.P("kV"),t:B.P("zt"),v:B.P("v6"),c:B.P("h9"),e:B.P("r")}};
(a=>{a["zpyPR+sGA04xawpZFmpdXR77Qag="]=a.current})($__dart_deferred_initializers__);