((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,D,B={
b3x(d){var x,w,v=new A.be(new Float64Array(16))
v.f4()
for(x=d.length-1;x>0;--x){w=d[x]
if(w!=null)w.u_(d[x-1],v)}return v},
akq(d,e,f,g){var x,w
if(d==null||e==null)return null
if(d===e)return d
x=d.z
w=e.z
if(x<w){g.push(e.r)
return B.akq(d,e.r,f,g)}else if(x>w){f.push(d.r)
return B.akq(d.r,e,f,g)}f.push(d.r)
g.push(e.r)
return B.akq(d.r,e.r,f,g)},
y5:function y5(){this.d=this.a=null},
ER:function ER(d,e,f,g,h,i){var _=this
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
avV:function avV(d){this.a=d},
aXP(d,e,f,g){return new B.QM(e,g,f,d,null)},
rS:function rS(d,e,f){this.e=d
this.c=e
this.a=f},
QM:function QM(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.x=f
_.c=g
_.a=h},
xb(d){var x=d.L(y.n),w=x==null?null:x.w.c
return(w==null?D.cS:w).dk(d)},
alk(){var x=0,w=A.p(y.v)
var $async$alk=A.l(function(d,e){if(d===1)return A.m(e,w)
for(;;)switch(x){case 0:x=2
return A.k(D.bd.dC("HapticFeedback.vibrate","HapticFeedbackType.selectionClick",y.v),$async$alk)
case 2:return A.n(null,w)}})
return A.o($async$alk,w)}},C,E
A=c[0]
D=c[2]
B=a.updateHolder(c[19],B)
C=c[65]
E=c[68]
B.y5.prototype={
Xp(d){this.a=d},
Zq(d){if(this.a===d)this.a=null},
k(d){var x=A.bp(this),w=this.a!=null?"<linked>":"<dangling>"
return"<optimized out>#"+x+"("+w+")"}}
B.ER.prototype={
KN(d){var x,w,v,u,t=this
if(t.R8){x=t.Ql()
x.toString
t.p4=A.u4(x)
t.R8=!1}if(t.p4==null)return null
w=new A.op(new Float64Array(4))
w.R6(d.a,d.b,0,1)
x=t.p4.al(w).a
v=x[0]
u=t.p1
return new A.c(v-u.a,x[1]-u.b)},
j1(d,e,f,g){var x,w=this
if(w.k3.a==null){if(w.k4)return w.nA(d,e.ad(0,w.ok),!0,g)
return!1}x=w.KN(e)
if(x==null)return!1
return w.nA(d,x,!0,g)},
Ql(){var x,w
if(this.p3==null)return null
x=this.p2
w=A.pO(-x.a,-x.b,0)
x=this.p3
x.toString
w.eO(x)
return w},
agL(){var x,w,v,u,t,s,r=this
r.p3=null
x=r.k3.a
if(x==null)return
w=y.A
v=A.b([x],w)
u=A.b([r],w)
B.akq(x,r,v,u)
t=B.b3x(v)
x.u_(null,t)
w=r.p1
t.eq(w.a,w.b,0,1)
s=B.b3x(u)
if(s.iX(s)===0)return
s.eO(t)
r.p3=s
r.R8=!0},
gtX(){return!0},
iV(d){var x,w,v=this
if(v.k3.a==null&&!v.k4){v.p2=v.p3=null
v.R8=!0
v.si_(null)
return}v.agL()
x=v.p3
w=y.y
if(x!=null){v.p2=v.ok
v.si_(d.zc(x.a,w.a(v.x)))
v.kb(d)
d.fK()}else{v.p2=null
x=v.ok
v.si_(d.zc(A.pO(x.a,x.b,0).a,w.a(v.x)))
v.kb(d)
d.fK()}v.R8=!0},
u_(d,e){var x=this.p3
if(x!=null)e.eO(x)
else{x=this.ok
e.eO(A.pO(x.a,x.b,0))}}}
B.Z6.prototype={
sqW(d){var x=this,w=x.C
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
if(w==null)x.saV(A.anz(v,e))
else{y.t.a(w)
w.sqW(v)
w.sd9(e)}x=x.a
x.toString
d.ne(x,A.fu.prototype.gfs.call(this),D.h)}}
B.Z2.prototype={
sqW(d){if(this.C===d)return
this.C=d
this.aQ()},
sa7x(d){if(this.a1===d)return
this.a1=d
this.aQ()},
sd9(d){if(this.av.j(0,d))return
this.av=d
this.aQ()},
saC1(d){if(this.ce.j(0,d))return
this.ce=d
this.aQ()},
sazn(d){if(this.ci.j(0,d))return
this.ci=d
this.aQ()},
ar(){this.ch.saV(null)
this.pI()},
gl2(){return!0},
Qe(){var x=y.s.a(A.D.prototype.gaV.call(this))
x=x==null?null:x.Ql()
if(x==null){x=new A.be(new Float64Array(16))
x.f4()}return x},
d5(d,e){if(this.C.a==null&&!this.a1)return!1
return this.d6(d,e)},
d6(d,e){return d.CQ(new B.avV(this),e,this.Qe())},
aY(d,e){var x,w=this,v=w.C.d,u=v==null?w.av:w.ce.CS(v).ad(0,w.ci.CS(w.gu())).a8(0,w.av),t=y.s
if(t.a(A.D.prototype.gaV.call(w))==null)w.ch.saV(new B.ER(w.C,w.a1,e,u,A.A(y.e,y.k),A.ao()))
else{x=t.a(A.D.prototype.gaV.call(w))
if(x!=null){x.k3=w.C
x.k4=w.a1
x.p1=u
x.ok=e}}t=t.a(A.D.prototype.gaV.call(w))
t.toString
d.uV(t,A.fu.prototype.gfs.call(w),D.h,C.adn)},
dS(d,e){e.eO(this.Qe())}}
B.rS.prototype={
aX(d){var x=new B.Z6(this.e,null,new A.aT(),A.ao())
x.aW()
x.sbp(null)
return x},
bd(d,e){e.sqW(this.e)}}
B.QM.prototype={
aX(d){var x=new B.Z2(this.e,this.f,this.x,E.eA,E.eA,null,new A.aT(),A.ao())
x.aW()
x.sbp(null)
return x},
bd(d,e){e.sqW(this.e)
e.sa7x(this.f)
e.sd9(this.x)
e.saC1(E.eA)
e.sazn(E.eA)}}
var z=a.updateTypes([])
B.avV.prototype={
$2(d,e){return this.a.vV(d,e)},
$S:20};(function inheritance(){var x=a.inherit,w=a.inheritMany
x(B.y5,A.x)
x(B.ER,A.fk)
w(A.ip,[B.Z6,B.Z2])
x(B.avV,A.eZ)
w(A.aV,[B.rS,B.QM])})()
A.dy(b.typeUniverse,JSON.parse('{"ER":{"fk":[],"f4":[]},"Z6":{"y":[],"aU":["y"],"D":[],"as":[]},"Z2":{"y":[],"aU":["y"],"D":[],"as":[]},"rS":{"aV":[],"ar":[],"f":[]},"QM":{"aV":[],"ar":[],"f":[]}}'))
var y={n:A.P("tA"),A:A.P("v<fk>"),t:A.P("FC"),e:A.P("r"),s:A.P("ER?"),y:A.P("aC3?"),v:A.P("~"),k:A.P("~()")};(function constants(){C.fn=new A.aK(12,12)
C.afE=new A.G(48,48)
C.rO=new A.aE(6,6,6,6)
C.adn=new A.C(-1/0,-1/0,1/0,1/0)})()};
(a=>{a["pGklKE9jdc86Mm/bFptxGzc7Ot4="]=a.current})($__dart_deferred_initializers__);