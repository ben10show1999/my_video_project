((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,D,B={
b3G(d){var x,w,v=new A.be(new Float64Array(16))
v.f4()
for(x=d.length-1;x>0;--x){w=d[x]
if(w!=null)w.u2(d[x-1],v)}return v},
akv(d,e,f,g){var x,w
if(d==null||e==null)return null
if(d===e)return d
x=d.z
w=e.z
if(x<w){g.push(e.r)
return B.akv(d,e.r,f,g)}else if(x>w){f.push(d.r)
return B.akv(d.r,e,f,g)}f.push(d.r)
g.push(e.r)
return B.akv(d.r,e.r,f,g)},
y8:function y8(){this.d=this.a=null},
EV:function EV(d,e,f,g,h,i){var _=this
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
Z9:function Z9(d,e,f,g){var _=this
_.C=d
_.a0=null
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
Z5:function Z5(d,e,f,g,h,i,j,k){var _=this
_.C=d
_.a0=e
_.aq=f
_.ca=g
_.cd=h
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
aw0:function aw0(d){this.a=d},
aXU(d,e,f,g){return new B.QO(e,g,f,d,null)},
rW:function rW(d,e,f){this.e=d
this.c=e
this.a=f},
QO:function QO(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.x=f
_.c=g
_.a=h},
xf(d){var x=d.L(y.n),w=x==null?null:x.w.c
return(w==null?D.cS:w).dj(d)},
alp(){var x=0,w=A.p(y.v)
var $async$alp=A.l(function(d,e){if(d===1)return A.m(e,w)
for(;;)switch(x){case 0:x=2
return A.j(D.bd.dA("HapticFeedback.vibrate","HapticFeedbackType.selectionClick",y.v),$async$alp)
case 2:return A.n(null,w)}})
return A.o($async$alp,w)}},C,E
A=c[0]
D=c[2]
B=a.updateHolder(c[19],B)
C=c[64]
E=c[67]
B.y8.prototype={
XB(d){this.a=d},
ZC(d){if(this.a===d)this.a=null},
k(d){var x=A.bp(this),w=this.a!=null?"<linked>":"<dangling>"
return"<optimized out>#"+x+"("+w+")"}}
B.EV.prototype={
KW(d){var x,w,v,u,t=this
if(t.R8){x=t.Qx()
x.toString
t.p4=A.u9(x)
t.R8=!1}if(t.p4==null)return null
w=new A.oq(new Float64Array(4))
w.Rj(d.a,d.b,0,1)
x=t.p4.aj(w).a
v=x[0]
u=t.p1
return new A.c(v-u.a,x[1]-u.b)},
j0(d,e,f,g){var x,w=this
if(w.k3.a==null){if(w.k4)return w.nA(d,e.ac(0,w.ok),!0,g)
return!1}x=w.KW(e)
if(x==null)return!1
return w.nA(d,x,!0,g)},
Qx(){var x,w
if(this.p3==null)return null
x=this.p2
w=A.pQ(-x.a,-x.b,0)
x=this.p3
x.toString
w.eP(x)
return w},
aha(){var x,w,v,u,t,s,r=this
r.p3=null
x=r.k3.a
if(x==null)return
w=y.A
v=A.b([x],w)
u=A.b([r],w)
B.akv(x,r,v,u)
t=B.b3G(v)
x.u2(null,t)
w=r.p1
t.eo(w.a,w.b,0,1)
s=B.b3G(u)
if(s.iX(s)===0)return
s.eP(t)
r.p3=s
r.R8=!0},
gu_(){return!0},
iW(d){var x,w,v=this
if(v.k3.a==null&&!v.k4){v.p2=v.p3=null
v.R8=!0
v.shY(null)
return}v.aha()
x=v.p3
w=y.y
if(x!=null){v.p2=v.ok
v.shY(d.zk(x.a,w.a(v.x)))
v.kb(d)
d.fJ()}else{v.p2=null
x=v.ok
v.shY(d.zk(A.pQ(x.a,x.b,0).a,w.a(v.x)))
v.kb(d)
d.fJ()}v.R8=!0},
u2(d,e){var x=this.p3
if(x!=null)e.eP(x)
else{x=this.ok
e.eP(A.pQ(x.a,x.b,0))}}}
B.Z9.prototype={
sqX(d){var x=this,w=x.C
if(w===d)return
w.d=null
x.C=d
w=x.a0
if(w!=null)d.d=w
x.aN()},
gl2(){return!0},
bY(){var x=this
x.pH()
x.a0=x.gu()
x.C.d=x.gu()},
aV(d,e){var x=this.ch,w=x.a,v=this.C
if(w==null)x.saS(A.anE(v,e))
else{y.t.a(w)
w.sqX(v)
w.sd9(e)}x=x.a
x.toString
d.ne(x,A.fv.prototype.gfq.call(this),D.h)}}
B.Z5.prototype={
sqX(d){if(this.C===d)return
this.C=d
this.aN()},
sa7R(d){if(this.a0===d)return
this.a0=d
this.aN()},
sd9(d){if(this.aq.j(0,d))return
this.aq=d
this.aN()},
saCo(d){if(this.ca.j(0,d))return
this.ca=d
this.aN()},
sazK(d){if(this.cd.j(0,d))return
this.cd=d
this.aN()},
ao(){this.ch.saS(null)
this.pI()},
gl2(){return!0},
Qq(){var x=y.s.a(A.D.prototype.gaS.call(this))
x=x==null?null:x.Qx()
if(x==null){x=new A.be(new Float64Array(16))
x.f4()}return x},
d5(d,e){if(this.C.a==null&&!this.a0)return!1
return this.d6(d,e)},
d6(d,e){return d.CX(new B.aw0(this),e,this.Qq())},
aV(d,e){var x,w=this,v=w.C.d,u=v==null?w.aq:w.ca.CZ(v).ac(0,w.cd.CZ(w.gu())).a7(0,w.aq),t=y.s
if(t.a(A.D.prototype.gaS.call(w))==null)w.ch.saS(new B.EV(w.C,w.a0,e,u,A.A(y.e,y.k),A.ao()))
else{x=t.a(A.D.prototype.gaS.call(w))
if(x!=null){x.k3=w.C
x.k4=w.a0
x.p1=u
x.ok=e}}t=t.a(A.D.prototype.gaS.call(w))
t.toString
d.v_(t,A.fv.prototype.gfq.call(w),D.h,C.adp)},
dR(d,e){e.eP(this.Qq())}}
B.rW.prototype={
aU(d){var x=new B.Z9(this.e,null,new A.aT(),A.ao())
x.aT()
x.sbn(null)
return x},
bb(d,e){e.sqX(this.e)}}
B.QO.prototype={
aU(d){var x=new B.Z5(this.e,this.f,this.x,E.eA,E.eA,null,new A.aT(),A.ao())
x.aT()
x.sbn(null)
return x},
bb(d,e){e.sqX(this.e)
e.sa7R(this.f)
e.sd9(this.x)
e.saCo(E.eA)
e.sazK(E.eA)}}
var z=a.updateTypes([])
B.aw0.prototype={
$2(d,e){return this.a.w_(d,e)},
$S:18};(function inheritance(){var x=a.inherit,w=a.inheritMany
x(B.y8,A.x)
x(B.EV,A.fl)
w(A.iq,[B.Z9,B.Z5])
x(B.aw0,A.f1)
w(A.aV,[B.rW,B.QO])})()
A.dy(b.typeUniverse,JSON.parse('{"EV":{"fl":[],"f6":[]},"Z9":{"y":[],"aU":["y"],"D":[],"as":[]},"Z5":{"y":[],"aU":["y"],"D":[],"as":[]},"rW":{"aV":[],"ar":[],"f":[]},"QO":{"aV":[],"ar":[],"f":[]}}'))
var y={n:A.P("tF"),A:A.P("v<fl>"),t:A.P("FG"),e:A.P("r"),s:A.P("EV?"),y:A.P("aC9?"),v:A.P("~"),k:A.P("~()")};(function constants(){C.fo=new A.aK(12,12)
C.afH=new A.G(48,48)
C.rO=new A.aE(6,6,6,6)
C.adp=new A.C(-1/0,-1/0,1/0,1/0)})()};
(a=>{a["i16YzD6x9gzbXxgTtc+7IBbIO+c="]=a.current})($__dart_deferred_initializers__);