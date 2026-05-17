((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,D,E,F,A={awK:function awK(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},awL:function awL(){},awM:function awM(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},awJ:function awJ(){},GV:function GV(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},yw:function yw(d,e,f){var _=this
_.b=_.w=null
_.c=!1
_.ua$=d
_.cW$=e
_.aq$=f
_.a=null},Xx:function Xx(d,e,f,g,h,i,j){var _=this
_.e8=d
_.y1=e
_.y2=f
_.cL$=g
_.ae$=h
_.cX$=i
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
aUi(d,e,f,g){var x=null
return new A.lt(d,new F.GU(e,f,!0,!0,!0,D.b5p(),x),g,C.at,!1,x,x,E.i5,!1,x,f,C.ag,x,x,C.D,C.aX,x)},
lt:function lt(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
YG:function YG(d,e,f){this.f=d
this.d=e
this.a=f}}
B=c[0]
C=c[2]
D=c[29]
E=c[35]
F=c[27]
A=a.updateHolder(c[12],A)
A.awK.prototype={
a5_(d){var x=this.c
return d.Cd(this.d,x,x)},
k(d){var x=this
return"SliverGridGeometry("+C.b.bR(B.b(["scrollOffset: "+B.j(x.a),"crossAxisOffset: "+B.j(x.b),"mainAxisExtent: "+B.j(x.c),"crossAxisExtent: "+B.j(x.d)],y.x),", ")+")"}}
A.awL.prototype={}
A.awM.prototype={
a5a(d){var x=this.b
if(x>0)return Math.max(0,this.a*C.d.kU(d/x)-1)
return 0},
agz(d){var x,w,v=this
if(v.f){x=v.c
w=v.e
return v.a*x-d-w-(x-w)}return d},
Fv(d){var x=this,w=x.a,v=C.e.bX(d,w)
return new A.awK(C.e.je(d,w)*x.b,x.agz(v*x.c),x.d,x.e)},
a_F(d){var x
if(d===0)return 0
x=this.b
return x*(C.e.je(d-1,this.a)+1)-(x-this.d)}}
A.awJ.prototype={}
A.GV.prototype={
Px(d){var x=this,w=x.c,v=x.a,u=Math.max(0,d.w-w*(v-1))/v,t=u/x.d
return new A.awM(v,t+x.b,u+w,t,u,B.AQ(d.x))}}
A.yw.prototype={
k(d){return"crossAxisOffset="+B.j(this.w)+"; "+this.a90(0)}}
A.Xx.prototype={
eV(d){if(!(d.b instanceof A.yw))d.b=new A.yw(!1,null,null)},
sa5p(d){var x,w,v=this
if(v.e8===d)return
x=!0
if(B.y(d)===B.y(v.e8)){w=v.e8
if(w.a===d.a)if(w.b===d.b)if(w.c===d.c)x=w.d!==d.d}if(x)v.ac()
v.e8=d},
tM(d){var x=d.b
x.toString
x=y.t.a(x).w
x.toString
return x},
bS(){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5,a6=this,a7=null,a8=y.z.a(B.B.prototype.ga6.call(a6)),a9=a6.y1
a9.R8=!1
x=a8.d
w=x+a8.z
v=w+a8.Q
u=a6.e8.Px(a8)
t=u.b
s=t>1e-10?u.a*C.d.je(w,t):0
r=isFinite(v)?u.a5a(v):a7
if(a6.ae$!=null){q=a6.aue(s)
a6.xc(q,r!=null?a6.aui(r):0)}else a6.xc(0,0)
p=u.Fv(s)
if(a6.ae$==null)if(!a6.ZK(s,p.a)){o=u.a_F(a9.gxb())
a6.dy=D.nI(a7,!1,a7,a7,o,0,0,o,a7)
a9.xx()
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
for(;k>=s;--k){i=u.Fv(k)
h=i.c
g=a6.azH(a8.Cd(i.d,h,h))
f=g.b
f.toString
t.a(f)
e=i.a
f.a=e
f.w=i.b
if(j==null)j=g
m=Math.max(m,e+h)}if(j==null){h=a6.ae$
h.toString
h.hT(p.a5_(a8))
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
break}i=u.Fv(k)
e=i.c
a0=a8.Cd(i.d,e,e)
a1=j.b
a1.toString
g=h.a(a1).aq$
if(g!=null){a1=g.b
a1.toString
a1=l.a(a1).b
a1.toString
a1=a1!==k}else a1=!0
if(a1){g=a6.azG(a0,j)
if(g==null){d=!0
break}}else g.hT(a0)
a1=g.b
a1.toString
t.a(a1)
a2=i.a
a1.a=a2
a1.w=i.b
m=Math.max(m,a2+e);++k
j=g}t=a6.cX$
t.toString
t=t.b
t.toString
t=l.a(t).b
t.toString
a3=d?m:a9.a0O(a8,s,t,n,m)
a4=a6.Cm(a8,Math.min(x,n),m)
a5=a6.L6(a8,n,m)
a6.dy=D.nI(a5,a3>a4||x>0||a8.f!==0,a7,a7,a3,a4,0,a3,a7)
if(a3===m)a9.R8=!0
a9.xx()}}
A.lt.prototype={
a_c(d){return new A.YG(this.rx,this.ry,null)}}
A.YG.prototype={
aW(d){var x=new A.Xx(this.f,y.v.a(d),B.D(y.e,y.g),0,null,null,B.an())
x.aV()
return x},
bd(d,e){e.sa5p(this.f)},
Mt(d,e,f,g,h){var x
this.a91(d,e,f,g,h)
x=this.f.Px(d).a_F(this.d.gu3())
return x}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.F,[A.awK,A.awL,A.awJ])
w(A.awM,A.awL)
w(A.GV,A.awJ)
w(A.yw,D.fR)
w(A.Xx,D.pD)
w(A.lt,D.BK)
w(A.YG,D.nL)})()
B.dG(b.typeUniverse,JSON.parse('{"yw":{"fR":[],"nK":[],"dR":["x"],"ko":[],"cJ":[]},"Xx":{"pD":[],"dl":[],"ae":["x","fR"],"B":[],"ap":[],"ae.1":"fR","ae.0":"x"},"lt":{"ac":[],"f":[]},"YG":{"nL":[],"ao":[],"f":[]}}'))
var y={x:B.T("u<n>"),g:B.T("x"),z:B.T("kA"),t:B.T("yw"),v:B.T("ui"),c:B.T("fR"),e:B.T("k")}};
(a=>{a["ADT5yvalnyw1mPmTmtU7E//FydQ="]=a.current})($__dart_deferred_initializers__);