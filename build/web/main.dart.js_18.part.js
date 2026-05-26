((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,D,B={
b3D(d){var x,w,v=new A.be(new Float64Array(16))
v.f4()
for(x=d.length-1;x>0;--x){w=d[x]
if(w!=null)w.u2(d[x-1],v)}return v},
aks(d,e,f,g){var x,w
if(d==null||e==null)return null
if(d===e)return d
x=d.z
w=e.z
if(x<w){g.push(e.r)
return B.aks(d,e.r,f,g)}else if(x>w){f.push(d.r)
return B.aks(d.r,e,f,g)}f.push(d.r)
g.push(e.r)
return B.aks(d.r,e.r,f,g)},
y6:function y6(){this.d=this.a=null},
ES:function ES(d,e,f,g,h,i){var _=this
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
Z7:function Z7(d,e,f,g){var _=this
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
Z3:function Z3(d,e,f,g,h,i,j,k){var _=this
_.C=d
_.a1=e
_.av=f
_.ce=g
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
avY:function avY(d){this.a=d},
aXR(d,e,f,g){return new B.QM(e,g,f,d,null)},
rU:function rU(d,e,f){this.e=d
this.c=e
this.a=f},
QM:function QM(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.x=f
_.c=g
_.a=h},
xd(d){var x=d.L(y.n),w=x==null?null:x.w.c
return(w==null?D.cS:w).dk(d)},
alm(){var x=0,w=A.p(y.v)
var $async$alm=A.l(function(d,e){if(d===1)return A.m(e,w)
for(;;)switch(x){case 0:x=2
return A.j(D.bd.dC("HapticFeedback.vibrate","HapticFeedbackType.selectionClick",y.v),$async$alm)
case 2:return A.n(null,w)}})
return A.o($async$alm,w)}},C,E
A=c[0]
D=c[2]
B=a.updateHolder(c[19],B)
C=c[65]
E=c[68]
B.y6.prototype={
Xr(d){this.a=d},
Zs(d){if(this.a===d)this.a=null},
k(d){var x=A.bp(this),w=this.a!=null?"<linked>":"<dangling>"
return"<optimized out>#"+x+"("+w+")"}}
B.ES.prototype={
KP(d){var x,w,v,u,t=this
if(t.R8){x=t.Qn()
x.toString
t.p4=A.u7(x)
t.R8=!1}if(t.p4==null)return null
w=new A.oq(new Float64Array(4))
w.R9(d.a,d.b,0,1)
x=t.p4.al(w).a
v=x[0]
u=t.p1
return new A.c(v-u.a,x[1]-u.b)},
j1(d,e,f,g){var x,w=this
if(w.k3.a==null){if(w.k4)return w.nA(d,e.ad(0,w.ok),!0,g)
return!1}x=w.KP(e)
if(x==null)return!1
return w.nA(d,x,!0,g)},
Qn(){var x,w
if(this.p3==null)return null
x=this.p2
w=A.pQ(-x.a,-x.b,0)
x=this.p3
x.toString
w.eP(x)
return w},
agR(){var x,w,v,u,t,s,r=this
r.p3=null
x=r.k3.a
if(x==null)return
w=y.A
v=A.b([x],w)
u=A.b([r],w)
B.aks(x,r,v,u)
t=B.b3D(v)
x.u2(null,t)
w=r.p1
t.eq(w.a,w.b,0,1)
s=B.b3D(u)
if(s.iX(s)===0)return
s.eP(t)
r.p3=s
r.R8=!0},
gu_(){return!0},
iW(d){var x,w,v=this
if(v.k3.a==null&&!v.k4){v.p2=v.p3=null
v.R8=!0
v.si_(null)
return}v.agR()
x=v.p3
w=y.y
if(x!=null){v.p2=v.ok
v.si_(d.zi(x.a,w.a(v.x)))
v.kb(d)
d.fK()}else{v.p2=null
x=v.ok
v.si_(d.zi(A.pQ(x.a,x.b,0).a,w.a(v.x)))
v.kb(d)
d.fK()}v.R8=!0},
u2(d,e){var x=this.p3
if(x!=null)e.eP(x)
else{x=this.ok
e.eP(A.pQ(x.a,x.b,0))}}}
B.Z7.prototype={
sqX(d){var x=this,w=x.C
if(w===d)return
w.d=null
x.C=d
w=x.a1
if(w!=null)d.d=w
x.aQ()},
gl2(){return!0},
bX(){var x=this
x.pH()
x.a1=x.gu()
x.C.d=x.gu()},
aY(d,e){var x=this.ch,w=x.a,v=this.C
if(w==null)x.saV(A.anB(v,e))
else{y.t.a(w)
w.sqX(v)
w.sd9(e)}x=x.a
x.toString
d.ne(x,A.fv.prototype.gfs.call(this),D.h)}}
B.Z3.prototype={
sqX(d){if(this.C===d)return
this.C=d
this.aQ()},
sa7B(d){if(this.a1===d)return
this.a1=d
this.aQ()},
sd9(d){if(this.av.j(0,d))return
this.av=d
this.aQ()},
saC8(d){if(this.ce.j(0,d))return
this.ce=d
this.aQ()},
sazu(d){if(this.ci.j(0,d))return
this.ci=d
this.aQ()},
ar(){this.ch.saV(null)
this.pI()},
gl2(){return!0},
Qg(){var x=y.s.a(A.D.prototype.gaV.call(this))
x=x==null?null:x.Qn()
if(x==null){x=new A.be(new Float64Array(16))
x.f4()}return x},
d5(d,e){if(this.C.a==null&&!this.a1)return!1
return this.d6(d,e)},
d6(d,e){return d.CU(new B.avY(this),e,this.Qg())},
aY(d,e){var x,w=this,v=w.C.d,u=v==null?w.av:w.ce.CX(v).ad(0,w.ci.CX(w.gu())).a8(0,w.av),t=y.s
if(t.a(A.D.prototype.gaV.call(w))==null)w.ch.saV(new B.ES(w.C,w.a1,e,u,A.A(y.e,y.k),A.ao()))
else{x=t.a(A.D.prototype.gaV.call(w))
if(x!=null){x.k3=w.C
x.k4=w.a1
x.p1=u
x.ok=e}}t=t.a(A.D.prototype.gaV.call(w))
t.toString
d.uY(t,A.fv.prototype.gfs.call(w),D.h,C.adn)},
dS(d,e){e.eP(this.Qg())}}
B.rU.prototype={
aX(d){var x=new B.Z7(this.e,null,new A.aT(),A.ao())
x.aW()
x.sbp(null)
return x},
bd(d,e){e.sqX(this.e)}}
B.QM.prototype={
aX(d){var x=new B.Z3(this.e,this.f,this.x,E.eA,E.eA,null,new A.aT(),A.ao())
x.aW()
x.sbp(null)
return x},
bd(d,e){e.sqX(this.e)
e.sa7B(this.f)
e.sd9(this.x)
e.saC8(E.eA)
e.sazu(E.eA)}}
var z=a.updateTypes([])
B.avY.prototype={
$2(d,e){return this.a.vY(d,e)},
$S:18};(function inheritance(){var x=a.inherit,w=a.inheritMany
x(B.y6,A.x)
x(B.ES,A.fl)
w(A.ip,[B.Z7,B.Z3])
x(B.avY,A.f_)
w(A.aV,[B.rU,B.QM])})()
A.dy(b.typeUniverse,JSON.parse('{"ES":{"fl":[],"f5":[]},"Z7":{"y":[],"aU":["y"],"D":[],"as":[]},"Z3":{"y":[],"aU":["y"],"D":[],"as":[]},"rU":{"aV":[],"ar":[],"f":[]},"QM":{"aV":[],"ar":[],"f":[]}}'))
var y={n:A.P("tD"),A:A.P("v<fl>"),t:A.P("FD"),e:A.P("r"),s:A.P("ES?"),y:A.P("aC6?"),v:A.P("~"),k:A.P("~()")};(function constants(){C.fo=new A.aK(12,12)
C.afE=new A.G(48,48)
C.rO=new A.aE(6,6,6,6)
C.adn=new A.C(-1/0,-1/0,1/0,1/0)})()};
(a=>{a["cbEB72tXYfcWQus5DYQK4miv4Cg="]=a.current})($__dart_deferred_initializers__);