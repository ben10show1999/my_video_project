((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,D,B={
aXh(d){var x,w,v=new A.b9(new Float64Array(16))
v.eN()
for(x=d.length-1;x>0;--x){w=d[x]
if(w!=null)w.th(d[x-1],v)}return v},
agt(d,e,f,g){var x,w
if(d==null||e==null)return null
if(d===e)return d
x=d.z
w=e.z
if(x<w){g.push(e.r)
return B.agt(d,e.r,f,g)}else if(x>w){f.push(d.r)
return B.agt(d.r,e,f,g)}f.push(d.r)
g.push(e.r)
return B.agt(d.r,e.r,f,g)},
wu:function wu(){this.d=this.a=null},
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
Wo:function Wo(d,e,f,g){var _=this
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
Wk:function Wk(d,e,f,g,h,i,j,k){var _=this
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
ar8:function ar8(d){this.a=d},
aRg(d,e,f,g){return new B.Ol(e,g,f,d,null)},
qH:function qH(d,e,f){this.e=d
this.c=e
this.a=f},
Ol:function Ol(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.x=f
_.c=g
_.a=h},
vP(d){var x=d.L(y.n),w=x==null?null:x.w.c
return(w==null?D.cO:w).d9(d)},
aho(){var x=0,w=A.u(y.v)
var $async$aho=A.o(function(d,e){if(d===1)return A.q(e,w)
for(;;)switch(x){case 0:x=2
return A.p(D.bb.df("HapticFeedback.vibrate","HapticFeedbackType.selectionClick",y.v),$async$aho)
case 2:return A.r(null,w)}})
return A.t($async$aho,w)}},C
A=c[0]
D=c[2]
B=a.updateHolder(c[15],B)
C=c[55]
B.wu.prototype={
VJ(d){this.a=d},
XI(d){if(this.a===d)this.a=null},
k(d){var x=A.bn(this),w=this.a!=null?"<linked>":"<dangling>"
return"<optimized out>#"+x+"("+w+")"}}
B.CF.prototype={
Jq(d){var x,w,v,u,t=this
if(t.R8){x=t.OS()
x.toString
t.p4=A.rM(x)
t.R8=!1}if(t.p4==null)return null
w=new A.nz(new Float64Array(4))
w.PB(d.a,d.b,0,1)
x=t.p4.ai(w).a
v=x[0]
u=t.p1
return new A.c(v-u.a,x[1]-u.b)},
iI(d,e,f,g){var x,w=this
if(w.k3.a==null){if(w.k4)return w.nd(d,e.ab(0,w.ok),!0,g)
return!1}x=w.Jq(e)
if(x==null)return!1
return w.nd(d,x,!0,g)},
OS(){var x,w
if(this.p3==null)return null
x=this.p2
w=A.oX(-x.a,-x.b,0)
x=this.p3
x.toString
w.eB(x)
return w},
aeo(){var x,w,v,u,t,s,r=this
r.p3=null
x=r.k3.a
if(x==null)return
w=y.A
v=A.b([x],w)
u=A.b([r],w)
B.agt(x,r,v,u)
t=B.aXh(v)
x.th(null,t)
w=r.p1
t.eb(w.a,w.b,0,1)
s=B.aXh(u)
if(s.iC(s)===0)return
s.eB(t)
r.p3=s
r.R8=!0},
gte(){return!0},
iB(d){var x,w,v=this
if(v.k3.a==null&&!v.k4){v.p2=v.p3=null
v.R8=!0
v.shA(null)
return}v.aeo()
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
B.Wo.prototype={
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
if(w==null)x.saS(A.ajB(v,e))
else{y.t.a(w)
w.sqr(v)
w.sd1(e)}x=x.a
x.toString
d.mQ(x,A.f6.prototype.gf9.call(this),D.i)}}
B.Wk.prototype={
sqr(d){if(this.E===d)return
this.E=d
this.aN()},
sa5p(d){if(this.a2===d)return
this.a2=d
this.aN()},
sd1(d){if(this.ap.j(0,d))return
this.ap=d
this.aN()},
saz9(d){if(this.c5.j(0,d))return
this.c5=d
this.aN()},
sawC(d){if(this.bY.j(0,d))return
this.bY=d
this.aN()},
ao(){this.ch.saS(null)
this.p9()},
gkE(){return!0},
OM(){var x=y.s.a(A.B.prototype.gaS.call(this))
x=x==null?null:x.OS()
if(x==null){x=new A.b9(new Float64Array(16))
x.eN()}return x},
cW(d,e){if(this.E.a==null&&!this.a2)return!1
return this.d_(d,e)},
d_(d,e){return d.BD(new B.ar8(this),e,this.OM())},
aT(d,e){var x,w=this,v=w.E.d,u=v==null?w.ap:w.c5.BF(v).ab(0,w.bY.BF(w.gt())).a6(0,w.ap),t=y.s
if(t.a(A.B.prototype.gaS.call(w))==null)w.ch.saS(new B.CF(w.E,w.a2,e,u,A.D(y.e,y.k),A.an()))
else{x=t.a(A.B.prototype.gaS.call(w))
if(x!=null){x.k3=w.E
x.k4=w.a2
x.p1=u
x.ok=e}}t=t.a(A.B.prototype.gaS.call(w))
t.toString
d.ue(t,A.f6.prototype.gf9.call(w),D.i,C.act)},
dG(d,e){e.eB(this.OM())}}
B.qH.prototype={
b1(d){var x=new B.Wo(this.e,null,new A.aO(),A.an())
x.b0()
x.sbl(null)
return x},
bb(d,e){e.sqr(this.e)}}
B.Ol.prototype={
b1(d){var x=new B.Wk(this.e,this.f,this.x,C.fC,C.fC,null,new A.aO(),A.an())
x.b0()
x.sbl(null)
return x},
bb(d,e){e.sqr(this.e)
e.sa5p(this.f)
e.sd1(this.x)
e.saz9(C.fC)
e.sawC(C.fC)}}
var z=a.updateTypes([])
B.ar8.prototype={
$2(d,e){return this.a.vc(d,e)},
$S:17};(function inheritance(){var x=a.inherit,w=a.inheritMany
x(B.wu,A.E)
x(B.CF,A.eX)
w(A.iF,[B.Wo,B.Wk])
x(B.ar8,A.eV)
w(A.aS,[B.qH,B.Ol])})()
A.dH(b.typeUniverse,JSON.parse('{"CF":{"eX":[],"eL":[]},"Wo":{"y":[],"aP":["y"],"B":[],"ap":[]},"Wk":{"y":[],"aP":["y"],"B":[],"ap":[]},"qH":{"aS":[],"ao":[],"f":[]},"Ol":{"aS":[],"ao":[],"f":[]}}'))
var y={n:A.S("rk"),A:A.S("n<eX>"),t:A.S("Dl"),e:A.S("k"),s:A.S("CF?"),y:A.S("awX?"),v:A.S("~"),k:A.S("~()")};(function constants(){C.fC=new A.ek(-1,-1)
C.aeD=new A.F(48,48)
C.re=new A.aG(6,6,6,6)
C.act=new A.x(-1/0,-1/0,1/0,1/0)
C.kH=new A.cP(null,20,null,null)})()};
(a=>{a["QTUjAdNDYfiVCxpgQNEzNwEwn5Y="]=a.current})($__dart_deferred_initializers__);