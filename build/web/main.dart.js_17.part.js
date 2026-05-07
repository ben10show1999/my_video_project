((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,D,B={
aYj(d){var x,w,v=new A.b9(new Float64Array(16))
v.eR()
for(x=d.length-1;x>0;--x){w=d[x]
if(w!=null)w.ts(d[x-1],v)}return v},
agT(d,e,f,g){var x,w
if(d==null||e==null)return null
if(d===e)return d
x=d.z
w=e.z
if(x<w){g.push(e.r)
return B.agT(d,e.r,f,g)}else if(x>w){f.push(d.r)
return B.agT(d.r,e,f,g)}f.push(d.r)
g.push(e.r)
return B.agT(d.r,e.r,f,g)},
wJ:function wJ(){this.d=this.a=null},
CV:function CV(d,e,f,g,h,i){var _=this
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
WF:function WF(d,e,f,g){var _=this
_.D=d
_.a3=null
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
WB:function WB(d,e,f,g,h,i,j,k){var _=this
_.D=d
_.a3=e
_.au=f
_.c9=g
_.c3=h
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
arG:function arG(d){this.a=d},
aS6(d,e,f,g){return new B.OE(e,g,f,d,null)},
qS:function qS(d,e,f){this.e=d
this.c=e
this.a=f},
OE:function OE(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.x=f
_.c=g
_.a=h},
w0(d){var x=d.L(y.n),w=x==null?null:x.w.c
return(w==null?D.cQ:w).dg(d)},
ahO(){var x=0,w=A.u(y.v)
var $async$ahO=A.o(function(d,e){if(d===1)return A.q(e,w)
for(;;)switch(x){case 0:x=2
return A.n(D.be.dm("HapticFeedback.vibrate","HapticFeedbackType.selectionClick",y.v),$async$ahO)
case 2:return A.r(null,w)}})
return A.t($async$ahO,w)}},C
A=c[0]
D=c[2]
B=a.updateHolder(c[17],B)
C=c[62]
B.wJ.prototype={
W0(d){this.a=d},
Y0(d){if(this.a===d)this.a=null},
k(d){var x=A.be(this),w=this.a!=null?"<linked>":"<dangling>"
return"<optimized out>#"+x+"("+w+")"}}
B.CV.prototype={
JD(d){var x,w,v,u,t=this
if(t.R8){x=t.P7()
x.toString
t.p4=A.rY(x)
t.R8=!1}if(t.p4==null)return null
w=new A.nI(new Float64Array(4))
w.PQ(d.a,d.b,0,1)
x=t.p4.ah(w).a
v=x[0]
u=t.p1
return new A.c(v-u.a,x[1]-u.b)},
iP(d,e,f,g){var x,w=this
if(w.k3.a==null){if(w.k4)return w.nn(d,e.ad(0,w.ok),!0,g)
return!1}x=w.JD(e)
if(x==null)return!1
return w.nn(d,x,!0,g)},
P7(){var x,w
if(this.p3==null)return null
x=this.p2
w=A.p0(-x.a,-x.b,0)
x=this.p3
x.toString
w.eF(x)
return w},
aeO(){var x,w,v,u,t,s,r=this
r.p3=null
x=r.k3.a
if(x==null)return
w=y.A
v=A.b([x],w)
u=A.b([r],w)
B.agT(x,r,v,u)
t=B.aYj(v)
x.ts(null,t)
w=r.p1
t.eh(w.a,w.b,0,1)
s=B.aYj(u)
if(s.iK(s)===0)return
s.eF(t)
r.p3=s
r.R8=!0},
gtp(){return!0},
iJ(d){var x,w,v=this
if(v.k3.a==null&&!v.k4){v.p2=v.p3=null
v.R8=!0
v.shF(null)
return}v.aeO()
x=v.p3
w=y.y
if(x!=null){v.p2=v.ok
v.shF(d.yx(x.a,w.a(v.x)))
v.jR(d)
d.fM()}else{v.p2=null
x=v.ok
v.shF(d.yx(A.p0(x.a,x.b,0).a,w.a(v.x)))
v.jR(d)
d.fM()}v.R8=!0},
ts(d,e){var x=this.p3
if(x!=null)e.eF(x)
else{x=this.ok
e.eF(A.p0(x.a,x.b,0))}}}
B.WF.prototype={
sqx(d){var x=this,w=x.D
if(w===d)return
w.d=null
x.D=d
w=x.a3
if(w!=null)d.d=w
x.aO()},
gkK(){return!0},
bQ(){var x=this
x.pi()
x.a3=x.gt()
x.D.d=x.gt()},
aU(d,e){var x=this.ch,w=x.a,v=this.D
if(w==null)x.saT(A.ak1(v,e))
else{y.t.a(w)
w.sqx(v)
w.sd5(e)}x=x.a
x.toString
d.mX(x,A.f8.prototype.gff.call(this),D.h)}}
B.WB.prototype={
sqx(d){if(this.D===d)return
this.D=d
this.aO()},
sa5O(d){if(this.a3===d)return
this.a3=d
this.aO()},
sd5(d){if(this.au.j(0,d))return
this.au=d
this.aO()},
sazC(d){if(this.c9.j(0,d))return
this.c9=d
this.aO()},
sax4(d){if(this.c3.j(0,d))return
this.c3=d
this.aO()},
an(){this.ch.saT(null)
this.pj()},
gkK(){return!0},
P1(){var x=y.s.a(A.B.prototype.gaT.call(this))
x=x==null?null:x.P7()
if(x==null){x=new A.b9(new Float64Array(16))
x.eR()}return x},
d1(d,e){if(this.D.a==null&&!this.a3)return!1
return this.d2(d,e)},
d2(d,e){return d.BS(new B.arG(this),e,this.P1())},
aU(d,e){var x,w=this,v=w.D.d,u=v==null?w.au:w.c9.BU(v).ad(0,w.c3.BU(w.gt())).a7(0,w.au),t=y.s
if(t.a(A.B.prototype.gaT.call(w))==null)w.ch.saT(new B.CV(w.D,w.a3,e,u,A.E(y.e,y.k),A.am()))
else{x=t.a(A.B.prototype.gaT.call(w))
if(x!=null){x.k3=w.D
x.k4=w.a3
x.p1=u
x.ok=e}}t=t.a(A.B.prototype.gaT.call(w))
t.toString
d.uo(t,A.f8.prototype.gff.call(w),D.h,C.acK)},
dK(d,e){e.eF(this.P1())}}
B.qS.prototype={
aW(d){var x=new B.WF(this.e,null,new A.aM(),A.am())
x.aV()
x.sbn(null)
return x},
bc(d,e){e.sqx(this.e)}}
B.OE.prototype={
aW(d){var x=new B.WB(this.e,this.f,this.x,C.fH,C.fH,null,new A.aM(),A.am())
x.aV()
x.sbn(null)
return x},
bc(d,e){e.sqx(this.e)
e.sa5O(this.f)
e.sd5(this.x)
e.sazC(C.fH)
e.sax4(C.fH)}}
var z=a.updateTypes([])
B.arG.prototype={
$2(d,e){return this.a.vk(d,e)},
$S:17};(function inheritance(){var x=a.inherit,w=a.inheritMany
x(B.wJ,A.G)
x(B.CV,A.eZ)
w(A.hW,[B.WF,B.WB])
x(B.arG,A.eX)
w(A.aQ,[B.qS,B.OE])})()
A.dF(b.typeUniverse,JSON.parse('{"CV":{"eZ":[],"eM":[]},"WF":{"x":[],"aP":["x"],"B":[],"ap":[]},"WB":{"x":[],"aP":["x"],"B":[],"ap":[]},"qS":{"aQ":[],"ao":[],"f":[]},"OE":{"aQ":[],"ao":[],"f":[]}}'))
var y={n:A.S("ru"),A:A.S("p<eZ>"),t:A.S("DA"),e:A.S("k"),s:A.S("CV?"),y:A.S("axF?"),v:A.S("~"),k:A.S("~()")};(function constants(){C.fH=new A.eo(-1,-1)
C.aeU=new A.D(48,48)
C.rl=new A.aD(6,6,6,6)
C.acK=new A.y(-1/0,-1/0,1/0,1/0)
C.kK=new A.cQ(null,20,null,null)})()};
(a=>{a["3QbOqqtwggxC/D8X3N1ax1NHlkA="]=a.current})($__dart_deferred_initializers__);