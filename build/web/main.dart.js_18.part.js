((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,D,B={
aZP(d){var x,w,v=new A.b9(new Float64Array(16))
v.eS()
for(x=d.length-1;x>0;--x){w=d[x]
if(w!=null)w.tD(d[x-1],v)}return v},
ahR(d,e,f,g){var x,w
if(d==null||e==null)return null
if(d===e)return d
x=d.z
w=e.z
if(x<w){g.push(e.r)
return B.ahR(d,e.r,f,g)}else if(x>w){f.push(d.r)
return B.ahR(d.r,e,f,g)}f.push(d.r)
g.push(e.r)
return B.ahR(d.r,e.r,f,g)},
x7:function x7(){this.d=this.a=null},
Dp:function Dp(d,e,f,g,h,i){var _=this
_.k3=d
_.k4=e
_.ok=f
_.p1=g
_.p4=_.p3=_.p2=null
_.R8=!0
_.ay=_.ax=null
_.a=h
_.b=0
_.e=i
_.f=0
_.r=null
_.w=!0
_.y=_.x=null
_.z=0
_.as=_.Q=null},
Xg:function Xg(d,e,f,g){var _=this
_.D=d
_.a3=null
_.v$=e
_.dy=f
_.b=_.fy=null
_.c=0
_.y=_.d=null
_.z=!0
_.Q=null
_.as=!1
_.at=null
_.ay=$
_.ch=g
_.CW=!1
_.cx=$
_.cy=!0
_.db=!1
_.dx=$},
Xc:function Xc(d,e,f,g,h,i,j,k){var _=this
_.D=d
_.a3=e
_.av=f
_.ca=g
_.c4=h
_.v$=i
_.dy=j
_.b=_.fy=null
_.c=0
_.y=_.d=null
_.z=!0
_.Q=null
_.as=!1
_.at=null
_.ay=$
_.ch=k
_.CW=!1
_.cx=$
_.cy=!0
_.db=!1
_.dx=$},
asK:function asK(d){this.a=d},
aTs(d,e,f,g){return new B.P9(e,g,f,d,null)},
r7:function r7(d,e,f){this.e=d
this.c=e
this.a=f},
P9:function P9(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.x=f
_.c=g
_.a=h},
wm(d){var x=d.L(y.n),w=x==null?null:x.w.c
return(w==null?D.cQ:w).dg(d)},
aiM(){var x=0,w=A.q(y.v)
var $async$aiM=A.m(function(d,e){if(d===1)return A.n(e,w)
for(;;)switch(x){case 0:x=2
return A.l(D.bd.dm("HapticFeedback.vibrate","HapticFeedbackType.selectionClick",y.v),$async$aiM)
case 2:return A.o(null,w)}})
return A.p($async$aiM,w)}},C
A=c[0]
D=c[2]
B=a.updateHolder(c[17],B)
C=c[61]
B.x7.prototype={
Wn(d){this.a=d},
Yn(d){if(this.a===d)this.a=null},
k(d){var x=A.bf(this),w=this.a!=null?"<linked>":"<dangling>"
return"<optimized out>#"+x+"("+w+")"}}
B.Dp.prototype={
JV(d){var x,w,v,u,t=this
if(t.R8){x=t.Pp()
x.toString
t.p4=A.tc(x)
t.R8=!1}if(t.p4==null)return null
w=new A.nX(new Float64Array(4))
w.Q8(d.a,d.b,0,1)
x=t.p4.ai(w).a
v=x[0]
u=t.p1
return new A.c(v-u.a,x[1]-u.b)},
iU(d,e,f,g){var x,w=this
if(w.k3.a==null){if(w.k4)return w.np(d,e.ad(0,w.ok),!0,g)
return!1}x=w.JV(e)
if(x==null)return!1
return w.np(d,x,!0,g)},
Pp(){var x,w
if(this.p3==null)return null
x=this.p2
w=A.pg(-x.a,-x.b,0)
x=this.p3
x.toString
w.eG(x)
return w},
afh(){var x,w,v,u,t,s,r=this
r.p3=null
x=r.k3.a
if(x==null)return
w=y.A
v=A.b([x],w)
u=A.b([r],w)
B.ahR(x,r,v,u)
t=B.aZP(v)
x.tD(null,t)
w=r.p1
t.eh(w.a,w.b,0,1)
s=B.aZP(u)
if(s.iP(s)===0)return
s.eG(t)
r.p3=s
r.R8=!0},
gtz(){return!0},
iN(d){var x,w,v=this
if(v.k3.a==null&&!v.k4){v.p2=v.p3=null
v.R8=!0
v.shK(null)
return}v.afh()
x=v.p3
w=y.y
if(x!=null){v.p2=v.ok
v.shK(d.yH(x.a,w.a(v.x)))
v.jT(d)
d.fM()}else{v.p2=null
x=v.ok
v.shK(d.yH(A.pg(x.a,x.b,0).a,w.a(v.x)))
v.jT(d)
d.fM()}v.R8=!0},
tD(d,e){var x=this.p3
if(x!=null)e.eG(x)
else{x=this.ok
e.eG(A.pg(x.a,x.b,0))}}}
B.Xg.prototype={
sqD(d){var x=this,w=x.D
if(w===d)return
w.d=null
x.D=d
w=x.a3
if(w!=null)d.d=w
x.aO()},
gkP(){return!0},
bQ(){var x=this
x.pm()
x.a3=x.gt()
x.D.d=x.gt()},
aU(d,e){var x=this.ch,w=x.a,v=this.D
if(w==null)x.saT(A.al1(v,e))
else{y.t.a(w)
w.sqD(v)
w.sd5(e)}x=x.a
x.toString
d.n0(x,A.fb.prototype.gfg.call(this),D.h)}}
B.Xc.prototype={
sqD(d){if(this.D===d)return
this.D=d
this.aO()},
sa6h(d){if(this.a3===d)return
this.a3=d
this.aO()},
sd5(d){if(this.av.j(0,d))return
this.av=d
this.aO()},
saAa(d){if(this.ca.j(0,d))return
this.ca=d
this.aO()},
saxy(d){if(this.c4.j(0,d))return
this.c4=d
this.aO()},
an(){this.ch.saT(null)
this.pn()},
gkP(){return!0},
Pj(){var x=y.s.a(A.B.prototype.gaT.call(this))
x=x==null?null:x.Pp()
if(x==null){x=new A.b9(new Float64Array(16))
x.eS()}return x},
d1(d,e){if(this.D.a==null&&!this.a3)return!1
return this.d2(d,e)},
d2(d,e){return d.C4(new B.asK(this),e,this.Pj())},
aU(d,e){var x,w=this,v=w.D.d,u=v==null?w.av:w.ca.C6(v).ad(0,w.c4.C6(w.gt())).a7(0,w.av),t=y.s
if(t.a(A.B.prototype.gaT.call(w))==null)w.ch.saT(new B.Dp(w.D,w.a3,e,u,A.D(y.e,y.k),A.an()))
else{x=t.a(A.B.prototype.gaT.call(w))
if(x!=null){x.k3=w.D
x.k4=w.a3
x.p1=u
x.ok=e}}t=t.a(A.B.prototype.gaT.call(w))
t.toString
d.uz(t,A.fb.prototype.gfg.call(w),D.h,C.ad8)},
dM(d,e){e.eG(this.Pj())}}
B.r7.prototype={
aW(d){var x=new B.Xg(this.e,null,new A.aN(),A.an())
x.aV()
x.sbn(null)
return x},
bc(d,e){e.sqD(this.e)}}
B.P9.prototype={
aW(d){var x=new B.Xc(this.e,this.f,this.x,C.fG,C.fG,null,new A.aN(),A.an())
x.aV()
x.sbn(null)
return x},
bc(d,e){e.sqD(this.e)
e.sa6h(this.f)
e.sd5(this.x)
e.saAa(C.fG)
e.saxy(C.fG)}}
var z=a.updateTypes([])
B.asK.prototype={
$2(d,e){return this.a.vv(d,e)},
$S:18};(function inheritance(){var x=a.inherit,w=a.inheritMany
x(B.x7,A.F)
x(B.Dp,A.f1)
w(A.i0,[B.Xg,B.Xc])
x(B.asK,A.fm)
w(A.aS,[B.r7,B.P9])})()
A.dG(b.typeUniverse,JSON.parse('{"Dp":{"f1":[],"eP":[]},"Xg":{"x":[],"aR":["x"],"B":[],"ap":[]},"Xc":{"x":[],"aR":["x"],"B":[],"ap":[]},"r7":{"aS":[],"ao":[],"f":[]},"P9":{"aS":[],"ao":[],"f":[]}}'))
var y={n:A.R("rL"),A:A.R("u<f1>"),t:A.R("E4"),e:A.R("k"),s:A.R("Dp?"),y:A.R("ayM?"),v:A.R("~"),k:A.R("~()")};(function constants(){C.fG=new A.eq(-1,-1)
C.afi=new A.E(48,48)
C.rs=new A.aD(6,6,6,6)
C.ad8=new A.z(-1/0,-1/0,1/0,1/0)
C.kM=new A.cR(null,20,null,null)})()};
(a=>{a["dGdT95C3/WA3NvsHibD1sa/60O8="]=a.current})($__dart_deferred_initializers__);