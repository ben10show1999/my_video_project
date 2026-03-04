((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,E,A={au0:function au0(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},au1:function au1(){},au2:function au2(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},au_:function au_(){},FO:function FO(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},xw:function xw(d,e,f){var _=this
_.b=_.w=null
_.c=!1
_.tD$=d
_.d0$=e
_.aR$=f
_.a=null},W3:function W3(d,e,f,g,h,i,j){var _=this
_.dZ=d
_.y1=e
_.y2=f
_.ef$=g
_.ak$=h
_.dg$=i
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
aQg(d,e,f,g){var x=null
return new A.la(d,new E.FN(e,f,!0,!0,!0,D.b0u(),x),g,C.aA,!1,x,x,F.hU,!1,x,f,C.ah,x,x,C.K,C.aR,x)},
la:function la(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
Xc:function Xc(d,e,f){this.f=d
this.d=e
this.a=f}},D,F
B=c[0]
C=c[2]
E=c[29]
A=a.updateHolder(c[11],A)
D=c[30]
F=c[35]
A.au0.prototype={
a3B(d){var x=this.c
return d.Bs(this.d,x,x)},
k(d){var x=this
return"SliverGridGeometry("+C.b.bH(B.b(["scrollOffset: "+B.j(x.a),"crossAxisOffset: "+B.j(x.b),"mainAxisExtent: "+B.j(x.c),"crossAxisExtent: "+B.j(x.d)],y.x),", ")+")"}}
A.au1.prototype={}
A.au2.prototype={
a3M(d){var x=this.b
if(x>0)return Math.max(0,this.a*C.d.lk(d/x)-1)
return 0},
af0(d){var x,w,v=this
if(v.f){x=v.c
w=v.e
return v.a*x-d-w-(x-w)}return d},
EM(d){var x=this,w=x.a,v=C.e.bP(d,w)
return new A.au0(C.e.iX(d,w)*x.b,x.af0(v*x.c),x.d,x.e)},
Zq(d){var x
if(d===0)return 0
x=this.b
return x*(C.e.iX(d-1,this.a)+1)-(x-this.d)}}
A.au_.prototype={}
A.FO.prototype={
OF(d){var x=this,w=x.c,v=x.a,u=Math.max(0,d.w-w*(v-1))/v,t=u/x.d
return new A.au2(v,t+x.b,u+w,t,u,B.zR(d.x))}}
A.xw.prototype={
k(d){return"crossAxisOffset="+B.j(this.w)+"; "+this.a7v(0)}}
A.W3.prototype={
f9(d){if(!(d.b instanceof A.xw))d.b=new A.xw(!1,null,null)},
sa3Y(d){var x,w,v=this
if(v.dZ===d)return
x=!0
if(B.B(d)===B.B(v.dZ)){w=v.dZ
if(w.a===d.a)if(w.b===d.b)if(w.c===d.c)x=w.d!==d.d}if(x)v.ad()
v.dZ=d},
tf(d){var x=d.b
x.toString
x=y.t.a(x).w
x.toString
return x},
bU(){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5,a6=this,a7=null,a8=y.z.a(B.C.prototype.gac.call(a6)),a9=a6.y1
a9.R8=!1
x=a8.d
w=x+a8.z
v=w+a8.Q
u=a6.dZ.OF(a8)
t=u.b
s=t>1e-10?u.a*C.d.iX(w,t):0
r=isFinite(v)?u.a3M(v):a7
if(a6.ak$!=null){q=a6.ask(s)
a6.wB(q,r!=null?a6.aso(r):0)}else a6.wB(0,0)
p=u.EM(s)
if(a6.ak$==null)if(!a6.Yz(s,p.a)){o=u.Zq(a9.gwA())
a6.dy=D.n7(a7,!1,a7,a7,o,0,0,o,a7)
a9.wW()
return}n=p.a
m=n+p.c
t=a6.ak$
t.toString
t=t.b
t.toString
l=y.c
t=l.a(t).b
t.toString
k=t-1
t=y.t
j=a7
for(;k>=s;--k){i=u.EM(k)
h=i.c
g=a6.axJ(a8.Bs(i.d,h,h))
f=g.b
f.toString
t.a(f)
e=i.a
f.a=e
f.w=i.b
if(j==null)j=g
m=Math.max(m,e+h)}if(j==null){h=a6.ak$
h.toString
h.hB(p.a3B(a8))
j=a6.ak$
h=j.b
h.toString
t.a(h)
h.a=n
h.w=p.b}h=j.b
h.toString
h=l.a(h).b
h.toString
k=h+1
h=B.l(a6).h("ao.1")
f=r!=null
for(;;){if(!(!f||k<=r)){d=!1
break}i=u.EM(k)
e=i.c
a0=a8.Bs(i.d,e,e)
a1=j.b
a1.toString
g=h.a(a1).aR$
if(g!=null){a1=g.b
a1.toString
a1=l.a(a1).b
a1.toString
a1=a1!==k}else a1=!0
if(a1){g=a6.axI(a0,j)
if(g==null){d=!0
break}}else g.hB(a0)
a1=g.b
a1.toString
t.a(a1)
a2=i.a
a1.a=a2
a1.w=i.b
m=Math.max(m,a2+e);++k
j=g}t=a6.dg$
t.toString
t=t.b
t.toString
t=l.a(t).b
t.toString
a3=d?m:a9.a_x(a8,s,t,n,m)
a4=a6.BC(a8,Math.min(x,n),m)
a5=a6.Kj(a8,n,m)
a6.dy=D.n7(a5,a3>a4||x>0||a8.f!==0,a7,a7,a3,a4,0,a3,a7)
if(a3===m)a9.R8=!0
a9.wW()}}
A.la.prototype={
Z1(d){return new A.Xc(this.rx,this.ry,null)}}
A.Xc.prototype={
b1(d){var x=new A.W3(this.f,y.v.a(d),B.D(y.e,y.g),0,null,null,B.al())
x.b0()
return x},
b9(d,e){e.sa3Y(this.f)},
LF(d,e,f,g,h){var x
this.a7w(d,e,f,g,h)
x=this.f.OF(d).Zq(this.d.gtx())
return x}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.E,[A.au0,A.au1,A.au_])
w(A.au2,A.au1)
w(A.FO,A.au_)
w(A.xw,D.fG)
w(A.W3,D.p6)
w(A.la,D.AL)
w(A.Xc,D.na)})()
B.dy(b.typeUniverse,JSON.parse('{"xw":{"fG":[],"n9":[],"e4":["y"],"k2":[],"cK":[]},"W3":{"p6":[],"dd":[],"ao":["y","fG"],"C":[],"ap":[],"ao.1":"fG","ao.0":"y"},"la":{"ad":[],"f":[]},"Xc":{"na":[],"an":[],"f":[]}}'))
var y={x:B.S("m<n>"),g:B.S("y"),z:B.S("kh"),t:B.S("xw"),v:B.S("tF"),c:B.S("fG"),e:B.S("k")}};
(a=>{a["O7Ve4oZH4NwY54SEkslJGO805jk="]=a.current})($__dart_deferred_initializers__);