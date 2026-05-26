((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,D,E,F,A={azV:function azV(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},azW:function azW(){},azX:function azX(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},azU:function azU(){},Ir:function Ir(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},zu:function zu(d,e,f){var _=this
_.b=_.w=null
_.c=!1
_.uA$=d
_.d_$=e
_.au$=f
_.a=null},Zj:function Zj(d,e,f,g,h,i,j){var _=this
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
aYB(d,e,f,g){var x=null
return new A.lQ(d,new F.Iq(e,f,!0,!0,!0,D.bai(),x),g,C.at,!1,x,x,E.id,!1,x,x,f,C.aj,x,x,C.D,C.aY,x)},
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
a_r:function a_r(d,e,f){this.f=d
this.d=e
this.a=f}}
B=c[0]
C=c[2]
D=c[31]
E=c[37]
F=c[29]
A=a.updateHolder(c[13],A)
A.azV.prototype={
a60(d){var x=this.c
return d.D0(this.d,x,x)},
k(d){var x=this
return"SliverGridGeometry("+C.b.bj(B.b(["scrollOffset: "+B.k(x.a),"crossAxisOffset: "+B.k(x.b),"mainAxisExtent: "+B.k(x.c),"crossAxisExtent: "+B.k(x.d)],y.x),", ")+")"}}
A.azW.prototype={}
A.azX.prototype={
a6b(d){var x=this.b
if(x>0)return Math.max(0,this.a*C.d.jy(d/x)-1)
return 0},
ahV(d){var x,w,v=this
if(v.f){x=v.c
w=v.e
return v.a*x-d-w-(x-w)}return d},
Gn(d){var x=this,w=x.a,v=C.e.c_(d,w)
return new A.azV(C.e.jk(d,w)*x.b,x.ahV(v*x.c),x.d,x.e)},
a0A(d){var x
if(d===0)return 0
x=this.b
return x*(C.e.jk(d-1,this.a)+1)-(x-this.d)}}
A.azU.prototype={}
A.Ir.prototype={
Qo(d){var x=this,w=x.c,v=x.a,u=Math.max(0,d.w-w*(v-1))/v,t=u/x.d
return new A.azX(v,t+x.b,u+w,t,u,B.BZ(d.x))}}
A.zu.prototype={
k(d){return"crossAxisOffset="+B.k(this.w)+"; "+this.aa6(0)}}
A.Zj.prototype={
f5(d){if(!(d.b instanceof A.zu))d.b=new A.zu(!1,null,null)},
sa6t(d){var x,w,v=this
if(v.aD===d)return
x=!0
if(B.u(d)===B.u(v.aD)){w=v.aD
if(w.a===d.a)if(w.b===d.b)if(w.c===d.c)x=w.d!==d.d}if(x)v.ab()
v.aD=d},
u8(d){var x=d.b
x.toString
x=y.t.a(x).w
x.toString
return x},
bX(){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5,a6=this,a7=null,a8=y.z.a(B.D.prototype.ga7.call(a6)),a9=a6.y1
a9.R8=!1
x=a8.d
w=x+a8.z
v=w+a8.Q
u=a6.aD.Qo(a8)
t=u.b
s=t>1e-10?u.a*C.d.jk(w,t):0
r=isFinite(v)?u.a6b(v):a7
if(a6.ac$!=null){q=a6.avM(s)
a6.xC(q,r!=null?a6.avR(r):0)}else a6.xC(0,0)
p=u.Gn(s)
if(a6.ac$==null)if(!a6.a_G(s,p.a)){o=u.a0A(a9.gxB())
a6.dy=D.oa(a7,!1,a7,a7,o,0,0,o,a7)
a9.y_()
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
for(;k>=s;--k){i=u.Gn(k)
h=i.c
g=a6.aBg(a8.D0(i.d,h,h))
f=g.b
f.toString
t.a(f)
e=i.a
f.a=e
f.w=i.b
if(j==null)j=g
m=Math.max(m,e+h)}if(j==null){h=a6.ac$
h.toString
h.i6(p.a60(a8))
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
break}i=u.Gn(k)
e=i.c
a0=a8.D0(i.d,e,e)
a1=j.b
a1.toString
g=h.a(a1).au$
if(g!=null){a1=g.b
a1.toString
a1=l.a(a1).b
a1.toString
a1=a1!==k}else a1=!0
if(a1){g=a6.aBf(a0,j)
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
a3=d?m:a9.a1I(a8,s,t,n,m)
a4=a6.D8(a8,Math.min(x,n),m)
a5=a6.LZ(a8,n,m)
a6.dy=D.oa(a5,a3>a4||x>0||a8.f!==0,a7,a7,a3,a4,0,a3,a7)
if(a3===m)a9.R8=!0
a9.y_()}}
A.lQ.prototype={
a07(d){return new A.a_r(this.to,this.x1,null)}}
A.a_r.prototype={
aX(d){var x=new A.Zj(this.f,y.v.a(d),B.A(y.e,y.g),0,null,null,B.ao())
x.aW()
return x},
bd(d,e){e.sa6t(this.f)},
Nm(d,e,f,g,h){var x
this.aa7(d,e,f,g,h)
x=this.f.Qo(d).a0A(this.d.guu())
return x}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.x,[A.azV,A.azW,A.azU])
w(A.azX,A.azW)
w(A.Ir,A.azU)
w(A.zu,D.h9)
w(A.Zj,D.qd)
w(A.lQ,D.D_)
w(A.a_r,D.od)})()
B.dy(b.typeUniverse,JSON.parse('{"zu":{"h9":[],"oc":[],"e5":["y"],"kI":[],"cP":[]},"Zj":{"qd":[],"dv":[],"ah":["y","h9"],"D":[],"as":[],"ah.1":"h9","ah.0":"y"},"lQ":{"a9":[],"f":[]},"a_r":{"od":[],"ar":[],"f":[]}}'))
var y={x:B.P("v<q>"),g:B.P("y"),z:B.P("kW"),t:B.P("zu"),v:B.P("v8"),c:B.P("h9"),e:B.P("r")}};
(a=>{a["sVjJXMVfMssHBq6qxl/XIH1UD2M="]=a.current})($__dart_deferred_initializers__);