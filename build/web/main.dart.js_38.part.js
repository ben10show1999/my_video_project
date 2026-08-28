((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,D,E,F,A={aA9:function aA9(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},aAa:function aAa(){},aAb:function aAb(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},aA8:function aA8(){},Iq:function Iq(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},zy:function zy(d,e,f){var _=this
_.b=_.w=null
_.c=!1
_.uD$=d
_.d1$=e
_.au$=f
_.a=null},Zi:function Zi(d,e,f,g,h,i,j){var _=this
_.aB=d
_.y1=e
_.y2=f
_.cP$=g
_.ad$=h
_.d2$=i
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
aYS(d,e,f,g){var x=null
return new A.lU(d,new F.Ip(e,f,!0,!0,!0,D.baC(),x),g,C.av,!1,x,x,E.ig,!1,x,x,f,C.ak,x,x,C.D,C.aZ,x)},
lU:function lU(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u){var _=this
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
a_r:function a_r(d,e,f){this.f=d
this.d=e
this.a=f}}
B=c[0]
C=c[2]
D=c[31]
E=c[37]
F=c[29]
A=a.updateHolder(c[13],A)
A.aA9.prototype={
a6t(d){var x=this.c
return d.D8(this.d,x,x)},
k(d){var x=this
return"SliverGridGeometry("+C.b.bk(B.b(["scrollOffset: "+B.j(x.a),"crossAxisOffset: "+B.j(x.b),"mainAxisExtent: "+B.j(x.c),"crossAxisExtent: "+B.j(x.d)],y.x),", ")+")"}}
A.aAa.prototype={}
A.aAb.prototype={
a6E(d){var x=this.b
if(x>0)return Math.max(0,this.a*C.d.it(d/x)-1)
return 0},
aiu(d){var x,w,v=this
if(v.f){x=v.c
w=v.e
return v.a*x-d-w-(x-w)}return d},
Gu(d){var x=this,w=x.a,v=C.e.c3(d,w)
return new A.aA9(C.e.jT(d,w)*x.b,x.aiu(v*x.c),x.d,x.e)},
a0Z(d){var x
if(d===0)return 0
x=this.b
return x*(C.e.jT(d-1,this.a)+1)-(x-this.d)}}
A.aA8.prototype={}
A.Iq.prototype={
QF(d){var x=this,w=x.c,v=x.a,u=Math.max(0,d.w-w*(v-1))/v,t=u/x.d
return new A.aAb(v,t+x.b,u+w,t,u,B.C2(d.x))}}
A.zy.prototype={
k(d){return"crossAxisOffset="+B.j(this.w)+"; "+this.aaB(0)}}
A.Zi.prototype={
f4(d){if(!(d.b instanceof A.zy))d.b=new A.zy(!1,null,null)},
sa6W(d){var x,w,v=this
if(v.aB===d)return
x=!0
if(B.u(d)===B.u(v.aB)){w=v.aB
if(w.a===d.a)if(w.b===d.b)if(w.c===d.c)x=w.d!==d.d}if(x)v.ab()
v.aB=d},
ue(d){var x=d.b
x.toString
x=y.t.a(x).w
x.toString
return x},
bY(){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5,a6=this,a7=null,a8=y.z.a(B.D.prototype.ga6.call(a6)),a9=a6.y1
a9.R8=!1
x=a8.d
w=x+a8.z
v=w+a8.Q
u=a6.aB.QF(a8)
t=u.b
s=t>1e-10?u.a*C.d.jT(w,t):0
r=isFinite(v)?u.a6E(v):a7
if(a6.ad$!=null){q=a6.awr(s)
a6.xK(q,r!=null?a6.awu(r):0)}else a6.xK(0,0)
p=u.Gu(s)
if(a6.ad$==null)if(!a6.a03(s,p.a)){o=u.a0Z(a9.gxI())
a6.dy=D.oe(a7,!1,a7,a7,o,0,0,o,a7)
a9.y7()
return}n=p.a
m=n+p.c
t=a6.ad$
t.toString
t=t.b
t.toString
l=y.c
t=l.a(t).b
t.toString
k=t-1
t=y.t
j=a7
for(;k>=s;--k){i=u.Gu(k)
h=i.c
g=a6.aBP(a8.D8(i.d,h,h))
f=g.b
f.toString
t.a(f)
e=i.a
f.a=e
f.w=i.b
if(j==null)j=g
m=Math.max(m,e+h)}if(j==null){h=a6.ad$
h.toString
h.i7(p.a6t(a8))
j=a6.ad$
h=j.b
h.toString
t.a(h)
h.a=n
h.w=p.b}h=j.b
h.toString
h=l.a(h).b
h.toString
k=h+1
h=B.t(a6).i("ai.1")
f=r!=null
for(;;){if(!(!f||k<=r)){d=!1
break}i=u.Gu(k)
e=i.c
a0=a8.D8(i.d,e,e)
a1=j.b
a1.toString
g=h.a(a1).au$
if(g!=null){a1=g.b
a1.toString
a1=l.a(a1).b
a1.toString
a1=a1!==k}else a1=!0
if(a1){g=a6.aBO(a0,j)
if(g==null){d=!0
break}}else g.i7(a0)
a1=g.b
a1.toString
t.a(a1)
a2=i.a
a1.a=a2
a1.w=i.b
m=Math.max(m,a2+e);++k
j=g}t=a6.d2$
t.toString
t=t.b
t.toString
t=l.a(t).b
t.toString
a3=d?m:a9.a25(a8,s,t,n,m)
a4=a6.Dg(a8,Math.min(x,n),m)
a5=a6.M9(a8,n,m)
a6.dy=D.oe(a5,a3>a4||x>0||a8.f!==0,a7,a7,a3,a4,0,a3,a7)
if(a3===m)a9.R8=!0
a9.y7()}}
A.lU.prototype={
a0x(d){return new A.a_r(this.to,this.x1,null)}}
A.a_r.prototype={
aY(d){var x=new A.Zi(this.f,y.v.a(d),B.z(y.e,y.g),0,null,null,B.ao())
x.aV()
return x},
bc(d,e){e.sa6W(this.f)},
Nw(d,e,f,g,h){var x
this.aaC(d,e,f,g,h)
x=this.f.QF(d).a0Z(this.d.gux())
return x}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.w,[A.aA9,A.aAa,A.aA8])
w(A.aAb,A.aAa)
w(A.Iq,A.aA8)
w(A.zy,D.h8)
w(A.Zi,D.qe)
w(A.lU,D.D4)
w(A.a_r,D.oh)})()
B.dz(b.typeUniverse,JSON.parse('{"zy":{"h8":[],"og":[],"e4":["A"],"kL":[],"cR":[]},"Zi":{"qe":[],"dw":[],"ai":["A","h8"],"D":[],"at":[],"ai.1":"h8","ai.0":"A"},"lU":{"ab":[],"f":[]},"a_r":{"oh":[],"as":[],"f":[]}}'))
var y={x:B.P("v<m>"),g:B.P("A"),z:B.P("kZ"),t:B.P("zy"),v:B.P("va"),c:B.P("h8"),e:B.P("r")}};
(a=>{a["j8BEuhZ+9brRrnC9TadLr8664lM="]=a.current})($__dart_deferred_initializers__);