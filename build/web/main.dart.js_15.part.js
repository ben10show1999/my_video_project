((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,A={aus:function aus(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},aut:function aut(){},auu:function auu(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},aur:function aur(){},FQ:function FQ(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},xy:function xy(d,e,f){var _=this
_.b=_.w=null
_.c=!1
_.tI$=d
_.cV$=e
_.aI$=f
_.a=null},We:function We(d,e,f,g,h,i,j){var _=this
_.e_=d
_.y1=e
_.y2=f
_.cG$=g
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
aR1(d,e,f,g){var x=null
return new A.kY(d,new E.FP(e,f,!0,!0,!0,D.b1h(),x),g,C.aA,!1,x,x,F.hZ,!1,x,f,C.af,x,x,C.E,C.aS,x)},
kY:function kY(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
Xm:function Xm(d,e,f){this.f=d
this.d=e
this.a=f}},E,D,F
B=c[0]
C=c[2]
A=a.updateHolder(c[10],A)
E=c[18]
D=c[20]
F=c[23]
A.aus.prototype={
a3H(d){var x=this.c
return d.By(this.d,x,x)},
k(d){var x=this
return"SliverGridGeometry("+C.b.bO(B.b(["scrollOffset: "+B.j(x.a),"crossAxisOffset: "+B.j(x.b),"mainAxisExtent: "+B.j(x.c),"crossAxisExtent: "+B.j(x.d)],y.x),", ")+")"}}
A.aut.prototype={}
A.auu.prototype={
a3S(d){var x=this.b
if(x>0)return Math.max(0,this.a*C.d.lk(d/x)-1)
return 0},
af2(d){var x,w,v=this
if(v.f){x=v.c
w=v.e
return v.a*x-d-w-(x-w)}return d},
EN(d){var x=this,w=x.a,v=C.e.bQ(d,w)
return new A.aus(C.e.iY(d,w)*x.b,x.af2(v*x.c),x.d,x.e)},
Zy(d){var x
if(d===0)return 0
x=this.b
return x*(C.e.iY(d-1,this.a)+1)-(x-this.d)}}
A.aur.prototype={}
A.FQ.prototype={
OB(d){var x=this,w=x.c,v=x.a,u=Math.max(0,d.w-w*(v-1))/v,t=u/x.d
return new A.auu(v,t+x.b,u+w,t,u,B.zU(d.x))}}
A.xy.prototype={
k(d){return"crossAxisOffset="+B.j(this.w)+"; "+this.a7z(0)}}
A.We.prototype={
f0(d){if(!(d.b instanceof A.xy))d.b=new A.xy(!1,null,null)},
sa43(d){var x,w,v=this
if(v.e_===d)return
x=!0
if(B.x(d)===B.x(v.e_)){w=v.e_
if(w.a===d.a)if(w.b===d.b)if(w.c===d.c)x=w.d!==d.d}if(x)v.ad()
v.e_=d},
tj(d){var x=d.b
x.toString
x=y.t.a(x).w
x.toString
return x},
bR(){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5,a6=this,a7=null,a8=y.z.a(B.B.prototype.ga6.call(a6)),a9=a6.y1
a9.R8=!1
x=a8.d
w=x+a8.z
v=w+a8.Q
u=a6.e_.OB(a8)
t=u.b
s=t>1e-10?u.a*C.d.iY(w,t):0
r=isFinite(v)?u.a3S(v):a7
if(a6.af$!=null){q=a6.asC(s)
a6.wC(q,r!=null?a6.asG(r):0)}else a6.wC(0,0)
p=u.EN(s)
if(a6.af$==null)if(!a6.YA(s,p.a)){o=u.Zy(a9.gwB())
a6.dy=D.n_(a7,!1,a7,a7,o,0,0,o,a7)
a9.wW()
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
for(;k>=s;--k){i=u.EN(k)
h=i.c
g=a6.ay0(a8.By(i.d,h,h))
f=g.b
f.toString
t.a(f)
e=i.a
f.a=e
f.w=i.b
if(j==null)j=g
m=Math.max(m,e+h)}if(j==null){h=a6.af$
h.toString
h.hD(p.a3H(a8))
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
h=B.l(a6).h("ah.1")
f=r!=null
for(;;){if(!(!f||k<=r)){d=!1
break}i=u.EN(k)
e=i.c
a0=a8.By(i.d,e,e)
a1=j.b
a1.toString
g=h.a(a1).aI$
if(g!=null){a1=g.b
a1.toString
a1=l.a(a1).b
a1.toString
a1=a1!==k}else a1=!0
if(a1){g=a6.ay_(a0,j)
if(g==null){d=!0
break}}else g.hD(a0)
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
a3=d?m:a9.a_E(a8,s,t,n,m)
a4=a6.BJ(a8,Math.min(x,n),m)
a5=a6.Kd(a8,n,m)
a6.dy=D.n_(a5,a3>a4||x>0||a8.f!==0,a7,a7,a3,a4,0,a3,a7)
if(a3===m)a9.R8=!0
a9.wW()}}
A.kY.prototype={
Z7(d){return new A.Xm(this.rx,this.ry,null)}}
A.Xm.prototype={
b1(d){var x=new A.We(this.f,y.v.a(d),B.D(y.e,y.g),0,null,null,B.am())
x.b0()
return x},
bb(d,e){e.sa43(this.f)},
LA(d,e,f,g,h){var x
this.a7A(d,e,f,g,h)
x=this.f.OB(d).Zy(this.d.gtC())
return x}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.H,[A.aus,A.aut,A.aur])
w(A.auu,A.aut)
w(A.FQ,A.aur)
w(A.xy,D.fA)
w(A.We,D.oU)
w(A.kY,D.AM)
w(A.Xm,D.n2)})()
B.hp(b.typeUniverse,JSON.parse('{"xy":{"fA":[],"n1":[],"dS":["y"],"jU":[],"cD":[]},"We":{"oU":[],"dc":[],"ah":["y","fA"],"B":[],"ap":[],"ah.1":"fA","ah.0":"y"},"kY":{"aa":[],"f":[]},"Xm":{"n2":[],"an":[],"f":[]}}'))
var y={x:B.W("n<m>"),g:B.W("y"),z:B.W("k7"),t:B.W("xy"),v:B.W("tB"),c:B.W("fA"),e:B.W("k")}};
(a=>{a["Q3lrOM22ad5i670f8bpZByfStiM="]=a.current})($__dart_deferred_initializers__);