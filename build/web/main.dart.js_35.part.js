((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,D,E,F,A={avy:function avy(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},avz:function avz(){},avA:function avA(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},avx:function avx(){},Gm:function Gm(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},y2:function y2(d,e,f){var _=this
_.b=_.w=null
_.c=!1
_.tX$=d
_.cV$=e
_.ao$=f
_.a=null},WR:function WR(d,e,f,g,h,i,j){var _=this
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
aSM(d,e,f,g){var x=null
return new A.li(d,new F.Gl(e,f,!0,!0,!0,D.b3s(),x),g,C.aj,!1,x,x,E.i3,!1,x,f,C.ai,x,x,C.D,C.aW,x)},
li:function li(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
Y_:function Y_(d,e,f){this.f=d
this.d=e
this.a=f}}
B=c[0]
C=c[2]
D=c[31]
E=c[36]
F=c[29]
A=a.updateHolder(c[12],A)
A.avy.prototype={
a4m(d){var x=this.c
return d.BY(this.d,x,x)},
k(d){var x=this
return"SliverGridGeometry("+C.b.bP(B.b(["scrollOffset: "+B.j(x.a),"crossAxisOffset: "+B.j(x.b),"mainAxisExtent: "+B.j(x.c),"crossAxisExtent: "+B.j(x.d)],y.x),", ")+")"}}
A.avz.prototype={}
A.avA.prototype={
a4x(d){var x=this.b
if(x>0)return Math.max(0,this.a*C.d.kO(d/x)-1)
return 0},
afT(d){var x,w,v=this
if(v.f){x=v.c
w=v.e
return v.a*x-d-w-(x-w)}return d},
Fb(d){var x=this,w=x.a,v=C.e.bV(d,w)
return new A.avy(C.e.j9(d,w)*x.b,x.afT(v*x.c),x.d,x.e)},
a_7(d){var x
if(d===0)return 0
x=this.b
return x*(C.e.j9(d-1,this.a)+1)-(x-this.d)}}
A.avx.prototype={}
A.Gm.prototype={
P8(d){var x=this,w=x.c,v=x.a,u=Math.max(0,d.w-w*(v-1))/v,t=u/x.d
return new A.avA(v,t+x.b,u+w,t,u,B.Am(d.x))}}
A.y2.prototype={
k(d){return"crossAxisOffset="+B.j(this.w)+"; "+this.a8j(0)}}
A.WR.prototype={
eS(d){if(!(d.b instanceof A.y2))d.b=new A.y2(!1,null,null)},
sa4J(d){var x,w,v=this
if(v.e7===d)return
x=!0
if(B.z(d)===B.z(v.e7)){w=v.e7
if(w.a===d.a)if(w.b===d.b)if(w.c===d.c)x=w.d!==d.d}if(x)v.ac()
v.e7=d},
ty(d){var x=d.b
x.toString
x=y.t.a(x).w
x.toString
return x},
bQ(){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5,a6=this,a7=null,a8=y.z.a(B.B.prototype.ga6.call(a6)),a9=a6.y1
a9.R8=!1
x=a8.d
w=x+a8.z
v=w+a8.Q
u=a6.e7.P8(a8)
t=u.b
s=t>1e-10?u.a*C.d.j9(w,t):0
r=isFinite(v)?u.a4x(v):a7
if(a6.ae$!=null){q=a6.atq(s)
a6.wX(q,r!=null?a6.atu(r):0)}else a6.wX(0,0)
p=u.Fb(s)
if(a6.ae$==null)if(!a6.Ze(s,p.a)){o=u.a_7(a9.gwW())
a6.dy=D.ns(a7,!1,a7,a7,o,0,0,o,a7)
a9.xj()
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
for(;k>=s;--k){i=u.Fb(k)
h=i.c
g=a6.ayO(a8.BY(i.d,h,h))
f=g.b
f.toString
t.a(f)
e=i.a
f.a=e
f.w=i.b
if(j==null)j=g
m=Math.max(m,e+h)}if(j==null){h=a6.ae$
h.toString
h.hO(p.a4m(a8))
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
h=B.l(a6).h("ae.1")
f=r!=null
for(;;){if(!(!f||k<=r)){d=!1
break}i=u.Fb(k)
e=i.c
a0=a8.BY(i.d,e,e)
a1=j.b
a1.toString
g=h.a(a1).ao$
if(g!=null){a1=g.b
a1.toString
a1=l.a(a1).b
a1.toString
a1=a1!==k}else a1=!0
if(a1){g=a6.ayN(a0,j)
if(g==null){d=!0
break}}else g.hO(a0)
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
a3=d?m:a9.a0f(a8,s,t,n,m)
a4=a6.C5(a8,Math.min(x,n),m)
a5=a6.KM(a8,n,m)
a6.dy=D.ns(a5,a3>a4||x>0||a8.f!==0,a7,a7,a3,a4,0,a3,a7)
if(a3===m)a9.R8=!0
a9.xj()}}
A.li.prototype={
ZH(d){return new A.Y_(this.rx,this.ry,null)}}
A.Y_.prototype={
aW(d){var x=new A.WR(this.f,y.v.a(d),B.E(y.e,y.g),0,null,null,B.am())
x.aV()
return x},
bc(d,e){e.sa4J(this.f)},
M8(d,e,f,g,h){var x
this.a8k(d,e,f,g,h)
x=this.f.P8(d).a_7(this.d.gtQ())
return x}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.G,[A.avy,A.avz,A.avx])
w(A.avA,A.avz)
w(A.Gm,A.avx)
w(A.y2,D.fP)
w(A.WR,D.pk)
w(A.li,D.Be)
w(A.Y_,D.nv)})()
B.dF(b.typeUniverse,JSON.parse('{"y2":{"fP":[],"nu":[],"dP":["x"],"kg":[],"cG":[]},"WR":{"pk":[],"dj":[],"ae":["x","fP"],"B":[],"ap":[],"ae.1":"fP","ae.0":"x"},"li":{"ac":[],"f":[]},"Y_":{"nv":[],"ao":[],"f":[]}}'))
var y={x:B.S("p<m>"),g:B.S("x"),z:B.S("kr"),t:B.S("y2"),v:B.S("tZ"),c:B.S("fP"),e:B.S("k")}};
(a=>{a["IuncZTbid5UrvlYuTkfHZ8lr8jU="]=a.current})($__dart_deferred_initializers__);