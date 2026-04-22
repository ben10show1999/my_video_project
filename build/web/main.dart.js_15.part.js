((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,D,B={
aXj(d){var x,w,v=new A.b9(new Float64Array(16))
v.eN()
for(x=d.length-1;x>0;--x){w=d[x]
if(w!=null)w.th(d[x-1],v)}return v},
agq(d,e,f,g){var x,w
if(d==null||e==null)return null
if(d===e)return d
x=d.z
w=e.z
if(x<w){g.push(e.r)
return B.agq(d,e.r,f,g)}else if(x>w){f.push(d.r)
return B.agq(d.r,e,f,g)}f.push(d.r)
g.push(e.r)
return B.agq(d.r,e.r,f,g)},
ww:function ww(){this.d=this.a=null},
CF:function CF(d,e,f,g,h,i){var _=this
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
Wk:function Wk(d,e,f,g){var _=this
_.E=d
_.a2=null
_.u$=e
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
Wg:function Wg(d,e,f,g,h,i,j,k){var _=this
_.E=d
_.a2=e
_.ap=f
_.c5=g
_.bY=h
_.u$=i
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
ar6:function ar6(d){this.a=d},
aRf(d,e,f,g){return new B.Oi(e,g,f,d,null)},
qJ:function qJ(d,e,f){this.e=d
this.c=e
this.a=f},
Oi:function Oi(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.x=f
_.c=g
_.a=h},
vQ(d){var x=d.L(y.n),w=x==null?null:x.w.c
return(w==null?D.cO:w).d9(d)},
ahl(){var x=0,w=A.u(y.v)
var $async$ahl=A.o(function(d,e){if(d===1)return A.q(e,w)
for(;;)switch(x){case 0:x=2
return A.p(D.bb.df("HapticFeedback.vibrate","HapticFeedbackType.selectionClick",y.v),$async$ahl)
case 2:return A.r(null,w)}})
return A.t($async$ahl,w)}},C
A=c[0]
D=c[2]
B=a.updateHolder(c[15],B)
C=c[55]
B.ww.prototype={
VH(d){this.a=d},
XG(d){if(this.a===d)this.a=null},
k(d){var x=A.bo(this),w=this.a!=null?"<linked>":"<dangling>"
return"<optimized out>#"+x+"("+w+")"}}
B.CF.prototype={
Jp(d){var x,w,v,u,t=this
if(t.R8){x=t.OR()
x.toString
t.p4=A.rO(x)
t.R8=!1}if(t.p4==null)return null
w=new A.ny(new Float64Array(4))
w.PA(d.a,d.b,0,1)
x=t.p4.ai(w).a
v=x[0]
u=t.p1
return new A.c(v-u.a,x[1]-u.b)},
iI(d,e,f,g){var x,w=this
if(w.k3.a==null){if(w.k4)return w.nd(d,e.ab(0,w.ok),!0,g)
return!1}x=w.Jp(e)
if(x==null)return!1
return w.nd(d,x,!0,g)},
OR(){var x,w
if(this.p3==null)return null
x=this.p2
w=A.oX(-x.a,-x.b,0)
x=this.p3
x.toString
w.eB(x)
return w},
aem(){var x,w,v,u,t,s,r=this
r.p3=null
x=r.k3.a
if(x==null)return
w=y.A
v=A.b([x],w)
u=A.b([r],w)
B.agq(x,r,v,u)
t=B.aXj(v)
x.th(null,t)
w=r.p1
t.eb(w.a,w.b,0,1)
s=B.aXj(u)
if(s.iC(s)===0)return
s.eB(t)
r.p3=s
r.R8=!0},
gte(){return!0},
iB(d){var x,w,v=this
if(v.k3.a==null&&!v.k4){v.p2=v.p3=null
v.R8=!0
v.shA(null)
return}v.aem()
x=v.p3
w=y.y
if(x!=null){v.p2=v.ok
v.shA(d.yn(x.a,w.a(v.x)))
v.jM(d)
d.fH()}else{v.p2=null
x=v.ok
v.shA(d.yn(A.oX(x.a,x.b,0).a,w.a(v.x)))
v.jM(d)
d.fH()}v.R8=!0},
th(d,e){var x=this.p3
if(x!=null)e.eB(x)
else{x=this.ok
e.eB(A.oX(x.a,x.b,0))}}}
B.Wk.prototype={
sqr(d){var x=this,w=x.E
if(w===d)return
w.d=null
x.E=d
w=x.a2
if(w!=null)d.d=w
x.aN()},
gkE(){return!0},
bT(){var x=this
x.p8()
x.a2=x.gt()
x.E.d=x.gt()},
aT(d,e){var x=this.ch,w=x.a,v=this.E
if(w==null)x.saS(A.ajz(v,e))
else{y.t.a(w)
w.sqr(v)
w.sd1(e)}x=x.a
x.toString
d.mQ(x,A.f5.prototype.gf9.call(this),D.i)}}
B.Wg.prototype={
sqr(d){if(this.E===d)return
this.E=d
this.aN()},
sa5n(d){if(this.a2===d)return
this.a2=d
this.aN()},
sd1(d){if(this.ap.j(0,d))return
this.ap=d
this.aN()},
saz7(d){if(this.c5.j(0,d))return
this.c5=d
this.aN()},
sawA(d){if(this.bY.j(0,d))return
this.bY=d
this.aN()},
ao(){this.ch.saS(null)
this.p9()},
gkE(){return!0},
OL(){var x=y.s.a(A.B.prototype.gaS.call(this))
x=x==null?null:x.OR()
if(x==null){x=new A.b9(new Float64Array(16))
x.eN()}return x},
cW(d,e){if(this.E.a==null&&!this.a2)return!1
return this.d_(d,e)},
d_(d,e){return d.BD(new B.ar6(this),e,this.OL())},
aT(d,e){var x,w=this,v=w.E.d,u=v==null?w.ap:w.c5.BF(v).ab(0,w.bY.BF(w.gt())).a6(0,w.ap),t=y.s
if(t.a(A.B.prototype.gaS.call(w))==null)w.ch.saS(new B.CF(w.E,w.a2,e,u,A.D(y.e,y.k),A.an()))
else{x=t.a(A.B.prototype.gaS.call(w))
if(x!=null){x.k3=w.E
x.k4=w.a2
x.p1=u
x.ok=e}}t=t.a(A.B.prototype.gaS.call(w))
t.toString
d.ue(t,A.f5.prototype.gf9.call(w),D.i,C.acx)},
dG(d,e){e.eB(this.OL())}}
B.qJ.prototype={
b0(d){var x=new B.Wk(this.e,null,new A.aO(),A.an())
x.b_()
x.sbl(null)
return x},
bb(d,e){e.sqr(this.e)}}
B.Oi.prototype={
b0(d){var x=new B.Wg(this.e,this.f,this.x,C.fC,C.fC,null,new A.aO(),A.an())
x.b_()
x.sbl(null)
return x},
bb(d,e){e.sqr(this.e)
e.sa5n(this.f)
e.sd1(this.x)
e.saz7(C.fC)
e.sawA(C.fC)}}
var z=a.updateTypes([])
B.ar6.prototype={
$2(d,e){return this.a.vc(d,e)},
$S:17};(function inheritance(){var x=a.inherit,w=a.inheritMany
x(B.ww,A.E)
x(B.CF,A.eX)
w(A.iD,[B.Wk,B.Wg])
x(B.ar6,A.eV)
w(A.aS,[B.qJ,B.Oi])})()
A.dH(b.typeUniverse,JSON.parse('{"CF":{"eX":[],"eL":[]},"Wk":{"y":[],"aP":["y"],"B":[],"ap":[]},"Wg":{"y":[],"aP":["y"],"B":[],"ap":[]},"qJ":{"aS":[],"ao":[],"f":[]},"Oi":{"aS":[],"ao":[],"f":[]}}'))
var y={n:A.R("rl"),A:A.R("n<eX>"),t:A.R("Dl"),e:A.R("k"),s:A.R("CF?"),y:A.R("awU?"),v:A.R("~"),k:A.R("~()")};(function constants(){C.fC=new A.ek(-1,-1)
C.aeH=new A.F(48,48)
C.re=new A.aE(6,6,6,6)
C.acx=new A.x(-1/0,-1/0,1/0,1/0)
C.kH=new A.cP(null,20,null,null)})()};
(a=>{a["2/qYj+N9VoTXvBlUv4EU0Qd+5ww="]=a.current})($__dart_deferred_initializers__);