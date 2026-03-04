((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,D,B={
aVz(d){var x,w,v=new A.b8(new Float64Array(16))
v.eL()
for(x=d.length-1;x>0;--x){w=d[x]
if(w!=null)w.t9(d[x-1],v)}return v},
afL(d,e,f,g){var x,w
if(d==null||e==null)return null
if(d===e)return d
x=d.z
w=e.z
if(x<w){g.push(e.r)
return B.afL(d,e.r,f,g)}else if(x>w){f.push(d.r)
return B.afL(d.r,e,f,g)}f.push(d.r)
g.push(e.r)
return B.afL(d.r,e.r,f,g)},
wh:function wh(){this.d=this.a=null},
Cs:function Cs(d,e,f,g,h,i){var _=this
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
VS:function VS(d,e,f,g){var _=this
_.E=d
_.a0=null
_.t$=e
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
VO:function VO(d,e,f,g,h,i,j,k){var _=this
_.E=d
_.a0=e
_.an=f
_.c1=g
_.bW=h
_.t$=i
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
aqk:function aqk(d){this.a=d},
aPE(d,e,f,g){return new B.NW(e,g,f,d,null)},
qz:function qz(d,e,f){this.e=d
this.c=e
this.a=f},
NW:function NW(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.x=f
_.c=g
_.a=h},
vD(d){var x=d.K(y.n),w=x==null?null:x.w.c
return(w==null?D.cN:w).d4(d)},
agF(){var x=0,w=A.t(y.v)
var $async$agF=A.o(function(d,e){if(d===1)return A.p(e,w)
for(;;)switch(x){case 0:x=2
return A.v(D.b7.d9("HapticFeedback.vibrate","HapticFeedbackType.selectionClick",y.v),$async$agF)
case 2:return A.q(null,w)}})
return A.r($async$agF,w)}},C
A=c[0]
D=c[2]
B=a.updateHolder(c[15],B)
C=c[56]
B.wh.prototype={
Vo(d){this.a=d},
Xm(d){if(this.a===d)this.a=null},
k(d){var x=A.bB(this),w=this.a!=null?"<linked>":"<dangling>"
return"<optimized out>#"+x+"("+w+")"}}
B.Cs.prototype={
Jc(d){var x,w,v,u,t=this
if(t.R8){x=t.OE()
x.toString
t.p4=A.rD(x)
t.R8=!1}if(t.p4==null)return null
w=new A.nn(new Float64Array(4))
w.Pm(d.a,d.b,0,1)
x=t.p4.ah(w).a
v=x[0]
u=t.p1
return new A.d(v-u.a,x[1]-u.b)},
iA(d,e,f,g){var x,w=this
if(w.k3.a==null){if(w.k4)return w.n7(d,e.a9(0,w.ok),!0,g)
return!1}x=w.Jc(e)
if(x==null)return!1
return w.n7(d,x,!0,g)},
OE(){var x,w
if(this.p3==null)return null
x=this.p2
w=A.oO(-x.a,-x.b,0)
x=this.p3
x.toString
w.ey(x)
return w},
adW(){var x,w,v,u,t,s,r=this
r.p3=null
x=r.k3.a
if(x==null)return
w=y.A
v=A.b([x],w)
u=A.b([r],w)
B.afL(x,r,v,u)
t=B.aVz(v)
x.t9(null,t)
w=r.p1
t.e7(w.a,w.b,0,1)
s=B.aVz(u)
if(s.iu(s)===0)return
s.ey(t)
r.p3=s
r.R8=!0},
gt6(){return!0},
it(d){var x,w,v=this
if(v.k3.a==null&&!v.k4){v.p2=v.p3=null
v.R8=!0
v.shu(null)
return}v.adW()
x=v.p3
w=y.y
if(x!=null){v.p2=v.ok
v.shu(d.y8(x.a,w.a(v.x)))
v.jJ(d)
d.fC()}else{v.p2=null
x=v.ok
v.shu(d.y8(A.oO(x.a,x.b,0).a,w.a(v.x)))
v.jJ(d)
d.fC()}v.R8=!0},
t9(d,e){var x=this.p3
if(x!=null)e.ey(x)
else{x=this.ok
e.ey(A.oO(x.a,x.b,0))}}}
B.VS.prototype={
sqk(d){var x=this,w=x.E
if(w===d)return
w.d=null
x.E=d
w=x.a0
if(w!=null)d.d=w
x.aM()},
gkD(){return!0},
bU(){var x=this
x.p_()
x.a0=x.gv()
x.E.d=x.gv()},
aU(d,e){var x=this.ch,w=x.a,v=this.E
if(w==null)x.saS(A.aiT(v,e))
else{y.t.a(w)
w.sqk(v)
w.scV(e)}x=x.a
x.toString
d.mL(x,A.f4.prototype.gf5.call(this),D.h)}}
B.VO.prototype={
sqk(d){if(this.E===d)return
this.E=d
this.aM()},
sa5_(d){if(this.a0===d)return
this.a0=d
this.aM()},
scV(d){if(this.an.j(0,d))return
this.an=d
this.aM()},
sayu(d){if(this.c1.j(0,d))return
this.c1=d
this.aM()},
savZ(d){if(this.bW.j(0,d))return
this.bW=d
this.aM()},
ap(){this.ch.saS(null)
this.p0()},
gkD(){return!0},
Oy(){var x=y.s.a(A.C.prototype.gaS.call(this))
x=x==null?null:x.OE()
if(x==null){x=new A.b8(new Float64Array(16))
x.eL()}return x},
cS(d,e){if(this.E.a==null&&!this.a0)return!1
return this.d1(d,e)},
d1(d,e){return d.Bm(new B.aqk(this),e,this.Oy())},
aU(d,e){var x,w=this,v=w.E.d,u=v==null?w.an:w.c1.Bo(v).a9(0,w.bW.Bo(w.gv())).a6(0,w.an),t=y.s
if(t.a(A.C.prototype.gaS.call(w))==null)w.ch.saS(new B.Cs(w.E,w.a0,e,u,A.D(y.e,y.k),A.al()))
else{x=t.a(A.C.prototype.gaS.call(w))
if(x!=null){x.k3=w.E
x.k4=w.a0
x.p1=u
x.ok=e}}t=t.a(A.C.prototype.gaS.call(w))
t.toString
d.u5(t,A.f4.prototype.gf5.call(w),D.h,C.abD)},
dD(d,e){e.ey(this.Oy())}}
B.qz.prototype={
b1(d){var x=new B.VS(this.e,null,new A.aO(),A.al())
x.b0()
x.sbj(null)
return x},
b9(d,e){e.sqk(this.e)}}
B.NW.prototype={
b1(d){var x=new B.VO(this.e,this.f,this.x,C.fw,C.fw,null,new A.aO(),A.al())
x.b0()
x.sbj(null)
return x},
b9(d,e){e.sqk(this.e)
e.sa5_(this.f)
e.scV(this.x)
e.sayu(C.fw)
e.savZ(C.fw)}}
var z=a.updateTypes([])
B.aqk.prototype={
$2(d,e){return this.a.v0(d,e)},
$S:17};(function inheritance(){var x=a.inherit,w=a.inheritMany
x(B.wh,A.E)
x(B.Cs,A.eV)
w(A.iu,[B.VS,B.VO])
x(B.aqk,A.eE)
w(A.aQ,[B.qz,B.NW])})()
A.dy(b.typeUniverse,JSON.parse('{"Cs":{"eV":[],"ep":[]},"VS":{"y":[],"aN":["y"],"C":[],"ap":[]},"VO":{"y":[],"aN":["y"],"C":[],"ap":[]},"qz":{"aQ":[],"an":[],"f":[]},"NW":{"aQ":[],"an":[],"f":[]}}'))
var y={n:A.S("ra"),A:A.S("m<eV>"),t:A.S("D5"),e:A.S("k"),s:A.S("Cs?"),y:A.S("aw5?"),v:A.S("~"),k:A.S("~()")};(function constants(){C.fw=new A.eh(-1,-1)
C.adK=new A.G(48,48)
C.abD=new A.x(-1/0,-1/0,1/0,1/0)
C.kz=new A.cC(null,20,null,null)})()};
(a=>{a["XBF5IknwZ1ST8Uxxp+c5D/EEopU="]=a.current})($__dart_deferred_initializers__);