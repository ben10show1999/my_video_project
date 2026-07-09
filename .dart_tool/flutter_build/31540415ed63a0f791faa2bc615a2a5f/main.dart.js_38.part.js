((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,D,E,F,A={azY:function azY(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},azZ:function azZ(){},aA_:function aA_(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},azX:function azX(){},It:function It(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},zw:function zw(d,e,f){var _=this
_.b=_.w=null
_.c=!1
_.uC$=d
_.cZ$=e
_.ap$=f
_.a=null},Zl:function Zl(d,e,f,g,h,i,j){var _=this
_.aA=d
_.y1=e
_.y2=f
_.cL$=g
_.ab$=h
_.cY$=i
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
aYE(d,e,f,g){var x=null
return new A.lQ(d,new F.Is(e,f,!0,!0,!0,D.bam(),x),g,C.at,!1,x,x,E.ie,!1,x,x,f,C.aj,x,x,C.D,C.aY,x)},
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
a_t:function a_t(d,e,f){this.f=d
this.d=e
this.a=f}}
B=c[0]
C=c[2]
D=c[31]
E=c[37]
F=c[29]
A=a.updateHolder(c[13],A)
A.azY.prototype={
a6g(d){var x=this.c
return d.D2(this.d,x,x)},
k(d){var x=this
return"SliverGridGeometry("+C.b.bf(B.b(["scrollOffset: "+B.k(x.a),"crossAxisOffset: "+B.k(x.b),"mainAxisExtent: "+B.k(x.c),"crossAxisExtent: "+B.k(x.d)],y.x),", ")+")"}}
A.azZ.prototype={}
A.aA_.prototype={
a6r(d){var x=this.b
if(x>0)return Math.max(0,this.a*C.d.jx(d/x)-1)
return 0},
aih(d){var x,w,v=this
if(v.f){x=v.c
w=v.e
return v.a*x-d-w-(x-w)}return d},
Gv(d){var x=this,w=x.a,v=C.e.c1(d,w)
return new A.azY(C.e.jj(d,w)*x.b,x.aih(v*x.c),x.d,x.e)},
a0K(d){var x
if(d===0)return 0
x=this.b
return x*(C.e.jj(d-1,this.a)+1)-(x-this.d)}}
A.azX.prototype={}
A.It.prototype={
Qy(d){var x=this,w=x.c,v=x.a,u=Math.max(0,d.w-w*(v-1))/v,t=u/x.d
return new A.aA_(v,t+x.b,u+w,t,u,B.C0(d.x))}}
A.zw.prototype={
k(d){return"crossAxisOffset="+B.k(this.w)+"; "+this.aam(0)}}
A.Zl.prototype={
f5(d){if(!(d.b instanceof A.zw))d.b=new A.zw(!1,null,null)},
sa6J(d){var x,w,v=this
if(v.aA===d)return
x=!0
if(B.u(d)===B.u(v.aA)){w=v.aA
if(w.a===d.a)if(w.b===d.b)if(w.c===d.c)x=w.d!==d.d}if(x)v.aa()
v.aA=d},
u8(d){var x=d.b
x.toString
x=y.t.a(x).w
x.toString
return x},
bY(){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5,a6=this,a7=null,a8=y.z.a(B.D.prototype.ga5.call(a6)),a9=a6.y1
a9.R8=!1
x=a8.d
w=x+a8.z
v=w+a8.Q
u=a6.aA.Qy(a8)
t=u.b
s=t>1e-10?u.a*C.d.jj(w,t):0
r=isFinite(v)?u.a6r(v):a7
if(a6.ab$!=null){q=a6.aw1(s)
a6.xE(q,r!=null?a6.aw6(r):0)}else a6.xE(0,0)
p=u.Gv(s)
if(a6.ab$==null)if(!a6.a_Q(s,p.a)){o=u.a0K(a9.gxD())
a6.dy=D.oa(a7,!1,a7,a7,o,0,0,o,a7)
a9.y3()
return}n=p.a
m=n+p.c
t=a6.ab$
t.toString
t=t.b
t.toString
l=y.c
t=l.a(t).b
t.toString
k=t-1
t=y.t
j=a7
for(;k>=s;--k){i=u.Gv(k)
h=i.c
g=a6.aBw(a8.D2(i.d,h,h))
f=g.b
f.toString
t.a(f)
e=i.a
f.a=e
f.w=i.b
if(j==null)j=g
m=Math.max(m,e+h)}if(j==null){h=a6.ab$
h.toString
h.i6(p.a6g(a8))
j=a6.ab$
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
break}i=u.Gv(k)
e=i.c
a0=a8.D2(i.d,e,e)
a1=j.b
a1.toString
g=h.a(a1).ap$
if(g!=null){a1=g.b
a1.toString
a1=l.a(a1).b
a1.toString
a1=a1!==k}else a1=!0
if(a1){g=a6.aBv(a0,j)
if(g==null){d=!0
break}}else g.i6(a0)
a1=g.b
a1.toString
t.a(a1)
a2=i.a
a1.a=a2
a1.w=i.b
m=Math.max(m,a2+e);++k
j=g}t=a6.cY$
t.toString
t=t.b
t.toString
t=l.a(t).b
t.toString
a3=d?m:a9.a1S(a8,s,t,n,m)
a4=a6.Da(a8,Math.min(x,n),m)
a5=a6.M6(a8,n,m)
a6.dy=D.oa(a5,a3>a4||x>0||a8.f!==0,a7,a7,a3,a4,0,a3,a7)
if(a3===m)a9.R8=!0
a9.y3()}}
A.lQ.prototype={
a0h(d){return new A.a_t(this.to,this.x1,null)}}
A.a_t.prototype={
aU(d){var x=new A.Zl(this.f,y.v.a(d),B.A(y.e,y.g),0,null,null,B.ao())
x.aT()
return x},
bb(d,e){e.sa6J(this.f)},
Nu(d,e,f,g,h){var x
this.aan(d,e,f,g,h)
x=this.f.Qy(d).a0K(this.d.guu())
return x}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.x,[A.azY,A.azZ,A.azX])
w(A.aA_,A.azZ)
w(A.It,A.azX)
w(A.zw,D.ha)
w(A.Zl,D.qd)
w(A.lQ,D.D2)
w(A.a_t,D.od)})()
B.dy(b.typeUniverse,JSON.parse('{"zw":{"ha":[],"oc":[],"e5":["y"],"kI":[],"cQ":[]},"Zl":{"qd":[],"dv":[],"ah":["y","ha"],"D":[],"as":[],"ah.1":"ha","ah.0":"y"},"lQ":{"aa":[],"f":[]},"a_t":{"od":[],"ar":[],"f":[]}}'))
var y={x:B.P("v<q>"),g:B.P("y"),z:B.P("kW"),t:B.P("zw"),v:B.P("vb"),c:B.P("ha"),e:B.P("r")}};
(a=>{a["5v2D6Hd8ZJMTl9+ZYB94LD72s9U="]=a.current})($__dart_deferred_initializers__);