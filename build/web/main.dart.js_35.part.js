((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,D,E,F,A={awD:function awD(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},awE:function awE(){},awF:function awF(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},awC:function awC(){},GS:function GS(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},ys:function ys(d,e,f){var _=this
_.b=_.w=null
_.c=!1
_.u6$=d
_.cV$=e
_.ao$=f
_.a=null},Xs:function Xs(d,e,f,g,h,i,j){var _=this
_.e7=d
_.y1=e
_.y2=f
_.cK$=g
_.ae$=h
_.cW$=i
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
aU8(d,e,f,g){var x=null
return new A.lq(d,new F.GR(e,f,!0,!0,!0,D.b5a(),x),g,C.at,!1,x,x,E.i4,!1,x,f,C.ai,x,x,C.G,C.aX,x)},
lq:function lq(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
YB:function YB(d,e,f){this.f=d
this.d=e
this.a=f}}
B=c[0]
C=c[2]
D=c[30]
E=c[35]
F=c[28]
A=a.updateHolder(c[12],A)
A.awD.prototype={
a4N(d){var x=this.c
return d.Ca(this.d,x,x)},
k(d){var x=this
return"SliverGridGeometry("+C.b.bP(B.b(["scrollOffset: "+B.j(x.a),"crossAxisOffset: "+B.j(x.b),"mainAxisExtent: "+B.j(x.c),"crossAxisExtent: "+B.j(x.d)],y.x),", ")+")"}}
A.awE.prototype={}
A.awF.prototype={
a4Y(d){var x=this.b
if(x>0)return Math.max(0,this.a*C.d.kS(d/x)-1)
return 0},
agm(d){var x,w,v=this
if(v.f){x=v.c
w=v.e
return v.a*x-d-w-(x-w)}return d},
Fr(d){var x=this,w=x.a,v=C.e.bV(d,w)
return new A.awD(C.e.jc(d,w)*x.b,x.agm(v*x.c),x.d,x.e)},
a_u(d){var x
if(d===0)return 0
x=this.b
return x*(C.e.jc(d-1,this.a)+1)-(x-this.d)}}
A.awC.prototype={}
A.GS.prototype={
Pq(d){var x=this,w=x.c,v=x.a,u=Math.max(0,d.w-w*(v-1))/v,t=u/x.d
return new A.awF(v,t+x.b,u+w,t,u,B.AN(d.x))}}
A.ys.prototype={
k(d){return"crossAxisOffset="+B.j(this.w)+"; "+this.a8O(0)}}
A.Xs.prototype={
eT(d){if(!(d.b instanceof A.ys))d.b=new A.ys(!1,null,null)},
sa5c(d){var x,w,v=this
if(v.e7===d)return
x=!0
if(B.y(d)===B.y(v.e7)){w=v.e7
if(w.a===d.a)if(w.b===d.b)if(w.c===d.c)x=w.d!==d.d}if(x)v.ac()
v.e7=d},
tI(d){var x=d.b
x.toString
x=y.t.a(x).w
x.toString
return x},
bQ(){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5,a6=this,a7=null,a8=y.z.a(B.B.prototype.ga6.call(a6)),a9=a6.y1
a9.R8=!1
x=a8.d
w=x+a8.z
v=w+a8.Q
u=a6.e7.Pq(a8)
t=u.b
s=t>1e-10?u.a*C.d.jc(w,t):0
r=isFinite(v)?u.a4Y(v):a7
if(a6.ae$!=null){q=a6.atV(s)
a6.x8(q,r!=null?a6.atZ(r):0)}else a6.x8(0,0)
p=u.Fr(s)
if(a6.ae$==null)if(!a6.ZB(s,p.a)){o=u.a_u(a9.gx7())
a6.dy=D.nH(a7,!1,a7,a7,o,0,0,o,a7)
a9.xt()
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
for(;k>=s;--k){i=u.Fr(k)
h=i.c
g=a6.azm(a8.Ca(i.d,h,h))
f=g.b
f.toString
t.a(f)
e=i.a
f.a=e
f.w=i.b
if(j==null)j=g
m=Math.max(m,e+h)}if(j==null){h=a6.ae$
h.toString
h.hS(p.a4N(a8))
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
h=B.t(a6).i("ae.1")
f=r!=null
for(;;){if(!(!f||k<=r)){d=!1
break}i=u.Fr(k)
e=i.c
a0=a8.Ca(i.d,e,e)
a1=j.b
a1.toString
g=h.a(a1).ao$
if(g!=null){a1=g.b
a1.toString
a1=l.a(a1).b
a1.toString
a1=a1!==k}else a1=!0
if(a1){g=a6.azl(a0,j)
if(g==null){d=!0
break}}else g.hS(a0)
a1=g.b
a1.toString
t.a(a1)
a2=i.a
a1.a=a2
a1.w=i.b
m=Math.max(m,a2+e);++k
j=g}t=a6.cW$
t.toString
t=t.b
t.toString
t=l.a(t).b
t.toString
a3=d?m:a9.a0D(a8,s,t,n,m)
a4=a6.Cj(a8,Math.min(x,n),m)
a5=a6.L2(a8,n,m)
a6.dy=D.nH(a5,a3>a4||x>0||a8.f!==0,a7,a7,a3,a4,0,a3,a7)
if(a3===m)a9.R8=!0
a9.xt()}}
A.lq.prototype={
a_3(d){return new A.YB(this.rx,this.ry,null)}}
A.YB.prototype={
aW(d){var x=new A.Xs(this.f,y.v.a(d),B.D(y.e,y.g),0,null,null,B.an())
x.aV()
return x},
bc(d,e){e.sa5c(this.f)},
Mp(d,e,f,g,h){var x
this.a8P(d,e,f,g,h)
x=this.f.Pq(d).a_u(this.d.gu_())
return x}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.F,[A.awD,A.awE,A.awC])
w(A.awF,A.awE)
w(A.GS,A.awC)
w(A.ys,D.fR)
w(A.Xs,D.pB)
w(A.lq,D.BH)
w(A.YB,D.nK)})()
B.dG(b.typeUniverse,JSON.parse('{"ys":{"fR":[],"nJ":[],"dQ":["x"],"kn":[],"cJ":[]},"Xs":{"pB":[],"dj":[],"ae":["x","fR"],"B":[],"ap":[],"ae.1":"fR","ae.0":"x"},"lq":{"ac":[],"f":[]},"YB":{"nK":[],"ao":[],"f":[]}}'))
var y={x:B.R("u<r>"),g:B.R("x"),z:B.R("kz"),t:B.R("ys"),v:B.R("ud"),c:B.R("fR"),e:B.R("k")}};
(a=>{a["CZJL2NVFvf5RibP4o/md+OcXuOg="]=a.current})($__dart_deferred_initializers__);