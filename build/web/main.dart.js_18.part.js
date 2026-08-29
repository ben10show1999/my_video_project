((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,D,B={
b3U(d){var x,w,v=A.eR()
for(x=d.length-1;x>0;--x){w=d[x]
if(w!=null)w.u6(d[x-1],v)}return v},
akM(d,e,f,g){var x,w
if(d==null||e==null)return null
if(d===e)return d
x=d.z
w=e.z
if(x<w){g.push(e.r)
return B.akM(d,e.r,f,g)}else if(x>w){f.push(d.r)
return B.akM(d.r,e,f,g)}f.push(d.r)
g.push(e.r)
return B.akM(d.r,e.r,f,g)},
ya:function ya(){this.d=this.a=null},
ET:function ET(d,e,f,g,h,i){var _=this
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
Z6:function Z6(d,e,f,g){var _=this
_.C=d
_.a1=null
_.E$=e
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
Z2:function Z2(d,e,f,g,h,i,j,k){var _=this
_.C=d
_.a1=e
_.av=f
_.c_=g
_.ci=h
_.E$=i
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
aw9:function aw9(d){this.a=d},
aY3(d,e,f,g){return new B.QK(e,g,f,d,null)},
rZ:function rZ(d,e,f){this.e=d
this.c=e
this.a=f},
QK:function QK(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.x=f
_.c=g
_.a=h},
xd(d){var x=d.L(y.n),w=x==null?null:x.w.c
return(w==null?D.cS:w).dl(d)},
alE(){var x=0,w=A.q(y.v)
var $async$alE=A.l(function(d,e){if(d===1)return A.n(e,w)
for(;;)switch(x){case 0:x=2
return A.k(D.bf.dA("HapticFeedback.vibrate","HapticFeedbackType.selectionClick",y.v),$async$alE)
case 2:return A.o(null,w)}})
return A.p($async$alE,w)}},C,E
A=c[0]
D=c[2]
B=a.updateHolder(c[19],B)
C=c[65]
E=c[68]
B.ya.prototype={
XO(d){this.a=d},
ZQ(d){if(this.a===d)this.a=null},
k(d){var x=A.bo(this),w=this.a!=null?"<linked>":"<dangling>"
return"<optimized out>#"+x+"("+w+")"}}
B.ET.prototype={
KZ(d){var x,w,v,u,t=this
if(t.R8){x=t.QE()
x.toString
t.p4=A.u8(x)
t.R8=!1}if(t.p4==null)return null
w=new A.ou(new Float64Array(4))
w.Rr(d.a,d.b,0,1)
x=t.p4.al(w).a
v=x[0]
u=t.p1
return new A.c(v-u.a,x[1]-u.b)},
j3(d,e,f,g){var x,w=this
if(w.k3.a==null){if(w.k4)return w.nD(d,e.ac(0,w.ok),!0,g)
return!1}x=w.KZ(e)
if(x==null)return!1
return w.nD(d,x,!0,g)},
QE(){var x,w
if(this.p3==null)return null
x=this.p2
w=A.pT(-x.a,-x.b,0)
x=this.p3
x.toString
w.eB(x)
return w},
ahn(){var x,w,v,u,t,s,r=this
r.p3=null
x=r.k3.a
if(x==null)return
w=y.A
v=A.b([x],w)
u=A.b([r],w)
B.akM(x,r,v,u)
t=B.b3U(v)
x.u6(null,t)
w=r.p1
t.en(w.a,w.b,0,1)
s=B.b3U(u)
if(s.iu(s)===0)return
s.eB(t)
r.p3=s
r.R8=!0},
gu3(){return!0},
iY(d){var x,w,v=this
if(v.k3.a==null&&!v.k4){v.p2=v.p3=null
v.R8=!0
v.si0(null)
return}v.ahn()
x=v.p3
w=y.y
if(x!=null){v.p2=v.ok
v.si0(d.zq(x.a,w.a(v.x)))
v.k7(d)
d.fL()}else{v.p2=null
x=v.ok
v.si0(d.zq(A.pT(x.a,x.b,0).a,w.a(v.x)))
v.k7(d)
d.fL()}v.R8=!0},
u6(d,e){var x=this.p3
if(x!=null)e.eB(x)
else{x=this.ok
e.eB(A.pT(x.a,x.b,0))}}}
B.Z6.prototype={
sr9(d){var x=this,w=x.C
if(w===d)return
w.d=null
x.C=d
w=x.a1
if(w!=null)d.d=w
x.aQ()},
gkW(){return!0},
bY(){var x=this
x.pT()
x.a1=x.gu()
x.C.d=x.gu()},
aZ(d,e){var x=this.ch,w=x.a,v=this.C
if(w==null)x.saU(A.anS(v,e))
else{y.t.a(w)
w.sr9(v)
w.sdc(e)}x=x.a
x.toString
d.nh(x,A.fx.prototype.gfu.call(this),D.h)}}
B.Z2.prototype={
sr9(d){if(this.C===d)return
this.C=d
this.aQ()},
sa85(d){if(this.a1===d)return
this.a1=d
this.aQ()},
sdc(d){if(this.av.j(0,d))return
this.av=d
this.aQ()},
saCH(d){if(this.c_.j(0,d))return
this.c_=d
this.aQ()},
saA0(d){if(this.ci.j(0,d))return
this.ci=d
this.aQ()},
ao(){this.ch.saU(null)
this.mu()},
gkW(){return!0},
Qx(){var x=y.s.a(A.D.prototype.gaU.call(this))
x=x==null?null:x.QE()
return x==null?A.eR():x},
d3(d,e){if(this.C.a==null&&!this.a1)return!1
return this.d7(d,e)},
d7(d,e){return d.D2(new B.aw9(this),e,this.Qx())},
aZ(d,e){var x,w=this,v=w.C.d,u=v==null?w.av:w.c_.D4(v).ac(0,w.ci.D4(w.gu())).a8(0,w.av),t=y.s
if(t.a(A.D.prototype.gaU.call(w))==null)w.ch.saU(new B.ET(w.C,w.a1,e,u,A.z(y.e,y.k),A.ao()))
else{x=t.a(A.D.prototype.gaU.call(w))
if(x!=null){x.k3=w.C
x.k4=w.a1
x.p1=u
x.ok=e}}t=t.a(A.D.prototype.gaU.call(w))
t.toString
d.v1(t,A.fx.prototype.gfu.call(w),D.h,C.adJ)},
dV(d,e){e.eB(this.Qx())}}
B.rZ.prototype={
aY(d){var x=new B.Z6(this.e,null,new A.aS(),A.ao())
x.aV()
x.sbp(null)
return x},
bc(d,e){e.sr9(this.e)}}
B.QK.prototype={
aY(d){var x=new B.Z2(this.e,this.f,this.x,E.eB,E.eB,null,new A.aS(),A.ao())
x.aV()
x.sbp(null)
return x},
bc(d,e){e.sr9(this.e)
e.sa85(this.f)
e.sdc(this.x)
e.saCH(E.eB)
e.saA0(E.eB)}}
var z=a.updateTypes([])
B.aw9.prototype={
$2(d,e){return this.a.w0(d,e)},
$S:19};(function inheritance(){var x=a.inherit,w=a.inheritMany
x(B.ya,A.w)
x(B.ET,A.fo)
w(A.io,[B.Z6,B.Z2])
x(B.aw9,A.f2)
w(A.aV,[B.rZ,B.QK])})()
A.dz(b.typeUniverse,JSON.parse('{"ET":{"fo":[],"f8":[]},"Z6":{"A":[],"aU":["A"],"D":[],"at":[]},"Z2":{"A":[],"aU":["A"],"D":[],"at":[]},"rZ":{"aV":[],"as":[],"f":[]},"QK":{"aV":[],"as":[],"f":[]}}'))
var y={n:A.P("tG"),A:A.P("v<fo>"),t:A.P("FE"),e:A.P("r"),s:A.P("ET?"),y:A.P("aCl?"),v:A.P("~"),k:A.P("~()")};(function constants(){C.fp=new A.aL(12,12)
C.afY=new A.H(48,48)
C.rS=new A.aF(6,6,6,6)
C.adJ=new A.C(-1/0,-1/0,1/0,1/0)})()};
(a=>{a["Mcau4At6X1P1um0Hr9CT7JeL54w="]=a.current})($__dart_deferred_initializers__);