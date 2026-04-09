((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,D,E,F,A={auF:function auF(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},auG:function auG(){},auH:function auH(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},auE:function auE(){},G1:function G1(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},xK:function xK(d,e,f){var _=this
_.b=_.w=null
_.c=!1
_.tM$=d
_.cV$=e
_.aJ$=f
_.a=null},Wt:function Wt(d,e,f,g,h,i,j){var _=this
_.e0=d
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
aRA(d,e,f,g){var x=null
return new A.lc(d,new F.G0(e,f,!0,!0,!0,D.b1Z(),x),g,C.aA,!1,x,x,E.i_,!1,x,f,C.ai,x,x,C.C,C.aS,x)},
lc:function lc(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
XC:function XC(d,e,f){this.f=d
this.d=e
this.a=f}}
B=c[0]
C=c[2]
D=c[30]
E=c[35]
F=c[29]
A=a.updateHolder(c[11],A)
A.auF.prototype={
a3W(d){var x=this.c
return d.BG(this.d,x,x)},
k(d){var x=this
return"SliverGridGeometry("+C.b.bM(B.b(["scrollOffset: "+B.j(x.a),"crossAxisOffset: "+B.j(x.b),"mainAxisExtent: "+B.j(x.c),"crossAxisExtent: "+B.j(x.d)],y.x),", ")+")"}}
A.auG.prototype={}
A.auH.prototype={
a46(d){var x=this.b
if(x>0)return Math.max(0,this.a*C.d.ln(d/x)-1)
return 0},
afo(d){var x,w,v=this
if(v.f){x=v.c
w=v.e
return v.a*x-d-w-(x-w)}return d},
EV(d){var x=this,w=x.a,v=C.e.bS(d,w)
return new A.auF(C.e.j3(d,w)*x.b,x.afo(v*x.c),x.d,x.e)},
ZI(d){var x
if(d===0)return 0
x=this.b
return x*(C.e.j3(d-1,this.a)+1)-(x-this.d)}}
A.auE.prototype={}
A.G1.prototype={
OO(d){var x=this,w=x.c,v=x.a,u=Math.max(0,d.w-w*(v-1))/v,t=u/x.d
return new A.auH(v,t+x.b,u+w,t,u,B.A5(d.x))}}
A.xK.prototype={
k(d){return"crossAxisOffset="+B.j(this.w)+"; "+this.a7Q(0)}}
A.Wt.prototype={
f3(d){if(!(d.b instanceof A.xK))d.b=new A.xK(!1,null,null)},
sa4i(d){var x,w,v=this
if(v.e0===d)return
x=!0
if(B.A(d)===B.A(v.e0)){w=v.e0
if(w.a===d.a)if(w.b===d.b)if(w.c===d.c)x=w.d!==d.d}if(x)v.ad()
v.e0=d},
tm(d){var x=d.b
x.toString
x=y.t.a(x).w
x.toString
return x},
bT(){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5,a6=this,a7=null,a8=y.z.a(B.B.prototype.ga7.call(a6)),a9=a6.y1
a9.R8=!1
x=a8.d
w=x+a8.z
v=w+a8.Q
u=a6.e0.OO(a8)
t=u.b
s=t>1e-10?u.a*C.d.j3(w,t):0
r=isFinite(v)?u.a46(v):a7
if(a6.af$!=null){q=a6.asT(s)
a6.wL(q,r!=null?a6.asX(r):0)}else a6.wL(0,0)
p=u.EV(s)
if(a6.af$==null)if(!a6.YQ(s,p.a)){o=u.ZI(a9.gwK())
a6.dy=D.nf(a7,!1,a7,a7,o,0,0,o,a7)
a9.x6()
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
for(;k>=s;--k){i=u.EV(k)
h=i.c
g=a6.ayh(a8.BG(i.d,h,h))
f=g.b
f.toString
t.a(f)
e=i.a
f.a=e
f.w=i.b
if(j==null)j=g
m=Math.max(m,e+h)}if(j==null){h=a6.af$
h.toString
h.hH(p.a3W(a8))
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
break}i=u.EV(k)
e=i.c
a0=a8.BG(i.d,e,e)
a1=j.b
a1.toString
g=h.a(a1).aJ$
if(g!=null){a1=g.b
a1.toString
a1=l.a(a1).b
a1.toString
a1=a1!==k}else a1=!0
if(a1){g=a6.ayg(a0,j)
if(g==null){d=!0
break}}else g.hH(a0)
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
a3=d?m:a9.a_Q(a8,s,t,n,m)
a4=a6.BQ(a8,Math.min(x,n),m)
a5=a6.Kt(a8,n,m)
a6.dy=D.nf(a5,a3>a4||x>0||a8.f!==0,a7,a7,a3,a4,0,a3,a7)
if(a3===m)a9.R8=!0
a9.x6()}}
A.lc.prototype={
Zh(d){return new A.XC(this.rx,this.ry,null)}}
A.XC.prototype={
b1(d){var x=new A.Wt(this.f,y.v.a(d),B.D(y.e,y.g),0,null,null,B.an())
x.b0()
return x},
bb(d,e){e.sa4i(this.f)},
LP(d,e,f,g,h){var x
this.a7R(d,e,f,g,h)
x=this.f.OO(d).ZI(this.d.gtG())
return x}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.E,[A.auF,A.auG,A.auE])
w(A.auH,A.auG)
w(A.G1,A.auE)
w(A.xK,D.fG)
w(A.Wt,D.pe)
w(A.lc,D.AY)
w(A.XC,D.ni)})()
B.dH(b.typeUniverse,JSON.parse('{"xK":{"fG":[],"nh":[],"dV":["y"],"k6":[],"cF":[]},"Wt":{"pe":[],"df":[],"ai":["y","fG"],"B":[],"ap":[],"ai.1":"fG","ai.0":"y"},"lc":{"ab":[],"f":[]},"XC":{"ni":[],"ao":[],"f":[]}}'))
var y={x:B.R("m<n>"),g:B.R("y"),z:B.R("kk"),t:B.R("xK"),v:B.R("tI"),c:B.R("fG"),e:B.R("k")}};
(a=>{a["lTS5qpm31/RhNcbq4W8wzWNZdcs="]=a.current})($__dart_deferred_initializers__);