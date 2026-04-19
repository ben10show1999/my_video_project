((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,D,B={
aXC(d){var x,w,v=new A.ba(new Float64Array(16))
v.eO()
for(x=d.length-1;x>0;--x){w=d[x]
if(w!=null)w.tn(d[x-1],v)}return v},
agA(d,e,f,g){var x,w
if(d==null||e==null)return null
if(d===e)return d
x=d.z
w=e.z
if(x<w){g.push(e.r)
return B.agA(d,e.r,f,g)}else if(x>w){f.push(d.r)
return B.agA(d.r,e,f,g)}f.push(d.r)
g.push(e.r)
return B.agA(d.r,e.r,f,g)},
ww:function ww(){this.d=this.a=null},
CK:function CK(d,e,f,g,h,i){var _=this
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
Wt:function Wt(d,e,f,g){var _=this
_.D=d
_.a1=null
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
Wp:function Wp(d,e,f,g,h,i,j,k){var _=this
_.D=d
_.a1=e
_.al=f
_.c3=g
_.bR=h
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
arl:function arl(d){this.a=d},
aRz(d,e,f,g){return new B.Op(e,g,f,d,null)},
qM:function qM(d,e,f){this.e=d
this.c=e
this.a=f},
Op:function Op(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.x=f
_.c=g
_.a=h},
vQ(d){var x=d.L(y.n),w=x==null?null:x.w.c
return(w==null?D.cO:w).d9(d)},
ahv(){var x=0,w=A.u(y.v)
var $async$ahv=A.o(function(d,e){if(d===1)return A.q(e,w)
for(;;)switch(x){case 0:x=2
return A.n(D.bb.df("HapticFeedback.vibrate","HapticFeedbackType.selectionClick",y.v),$async$ahv)
case 2:return A.r(null,w)}})
return A.t($async$ahv,w)}},C
A=c[0]
D=c[2]
B=a.updateHolder(c[15],B)
C=c[55]
B.ww.prototype={
VS(d){this.a=d},
XR(d){if(this.a===d)this.a=null},
k(d){var x=A.bo(this),w=this.a!=null?"<linked>":"<dangling>"
return"<optimized out>#"+x+"("+w+")"}}
B.CK.prototype={
Jw(d){var x,w,v,u,t=this
if(t.R8){x=t.P_()
x.toString
t.p4=A.rO(x)
t.R8=!1}if(t.p4==null)return null
w=new A.nC(new Float64Array(4))
w.PI(d.a,d.b,0,1)
x=t.p4.ai(w).a
v=x[0]
u=t.p1
return new A.c(v-u.a,x[1]-u.b)},
iK(d,e,f,g){var x,w=this
if(w.k3.a==null){if(w.k4)return w.nh(d,e.ac(0,w.ok),!0,g)
return!1}x=w.Jw(e)
if(x==null)return!1
return w.nh(d,x,!0,g)},
P_(){var x,w
if(this.p3==null)return null
x=this.p2
w=A.p0(-x.a,-x.b,0)
x=this.p3
x.toString
w.eC(x)
return w},
aez(){var x,w,v,u,t,s,r=this
r.p3=null
x=r.k3.a
if(x==null)return
w=y.A
v=A.b([x],w)
u=A.b([r],w)
B.agA(x,r,v,u)
t=B.aXC(v)
x.tn(null,t)
w=r.p1
t.ec(w.a,w.b,0,1)
s=B.aXC(u)
if(s.iE(s)===0)return
s.eC(t)
r.p3=s
r.R8=!0},
gtk(){return!0},
iD(d){var x,w,v=this
if(v.k3.a==null&&!v.k4){v.p2=v.p3=null
v.R8=!0
v.shD(null)
return}v.aez()
x=v.p3
w=y.y
if(x!=null){v.p2=v.ok
v.shD(d.yt(x.a,w.a(v.x)))
v.jO(d)
d.fJ()}else{v.p2=null
x=v.ok
v.shD(d.yt(A.p0(x.a,x.b,0).a,w.a(v.x)))
v.jO(d)
d.fJ()}v.R8=!0},
tn(d,e){var x=this.p3
if(x!=null)e.eC(x)
else{x=this.ok
e.eC(A.p0(x.a,x.b,0))}}}
B.Wt.prototype={
sqv(d){var x=this,w=x.D
if(w===d)return
w.d=null
x.D=d
w=x.a1
if(w!=null)d.d=w
x.aN()},
gkG(){return!0},
bT(){var x=this
x.pd()
x.a1=x.gt()
x.D.d=x.gt()},
aT(d,e){var x=this.ch,w=x.a,v=this.D
if(w==null)x.saS(A.ajK(v,e))
else{y.t.a(w)
w.sqv(v)
w.sd1(e)}x=x.a
x.toString
d.mU(x,A.f8.prototype.gf_.call(this),D.i)}}
B.Wp.prototype={
sqv(d){if(this.D===d)return
this.D=d
this.aN()},
sa5z(d){if(this.a1===d)return
this.a1=d
this.aN()},
sd1(d){if(this.al.j(0,d))return
this.al=d
this.aN()},
sazk(d){if(this.c3.j(0,d))return
this.c3=d
this.aN()},
sawN(d){if(this.bR.j(0,d))return
this.bR=d
this.aN()},
aq(){this.ch.saS(null)
this.pe()},
gkG(){return!0},
OU(){var x=y.s.a(A.B.prototype.gaS.call(this))
x=x==null?null:x.P_()
if(x==null){x=new A.ba(new Float64Array(16))
x.eO()}return x},
cW(d,e){if(this.D.a==null&&!this.a1)return!1
return this.d_(d,e)},
d_(d,e){return d.BI(new B.arl(this),e,this.OU())},
aT(d,e){var x,w=this,v=w.D.d,u=v==null?w.al:w.c3.BK(v).ac(0,w.bR.BK(w.gt())).a8(0,w.al),t=y.s
if(t.a(A.B.prototype.gaS.call(w))==null)w.ch.saS(new B.CK(w.D,w.a1,e,u,A.E(y.e,y.k),A.an()))
else{x=t.a(A.B.prototype.gaS.call(w))
if(x!=null){x.k3=w.D
x.k4=w.a1
x.p1=u
x.ok=e}}t=t.a(A.B.prototype.gaS.call(w))
t.toString
d.ui(t,A.f8.prototype.gf_.call(w),D.i,C.acx)},
dH(d,e){e.eC(this.OU())}}
B.qM.prototype={
b_(d){var x=new B.Wt(this.e,null,new A.aO(),A.an())
x.aX()
x.sbl(null)
return x},
ba(d,e){e.sqv(this.e)}}
B.Op.prototype={
b_(d){var x=new B.Wp(this.e,this.f,this.x,C.fC,C.fC,null,new A.aO(),A.an())
x.aX()
x.sbl(null)
return x},
ba(d,e){e.sqv(this.e)
e.sa5z(this.f)
e.sd1(this.x)
e.sazk(C.fC)
e.sawN(C.fC)}}
var z=a.updateTypes([])
B.arl.prototype={
$2(d,e){return this.a.vg(d,e)},
$S:17};(function inheritance(){var x=a.inherit,w=a.inheritMany
x(B.ww,A.D)
x(B.CK,A.eY)
w(A.iE,[B.Wt,B.Wp])
x(B.arl,A.eW)
w(A.aR,[B.qM,B.Op])})()
A.dH(b.typeUniverse,JSON.parse('{"CK":{"eY":[],"eN":[]},"Wt":{"y":[],"aP":["y"],"B":[],"ap":[]},"Wp":{"y":[],"aP":["y"],"B":[],"ap":[]},"qM":{"aR":[],"ao":[],"f":[]},"Op":{"aR":[],"ao":[],"f":[]}}'))
var y={n:A.R("rn"),A:A.R("p<eY>"),t:A.R("Dp"),e:A.R("k"),s:A.R("CK?"),y:A.R("ax9?"),v:A.R("~"),k:A.R("~()")};(function constants(){C.fC=new A.ek(-1,-1)
C.aeH=new A.F(48,48)
C.rf=new A.aE(6,6,6,6)
C.acx=new A.x(-1/0,-1/0,1/0,1/0)
C.kH=new A.cP(null,20,null,null)})()};
(a=>{a["cRhknTN3rfIOFJHzO+tFsRh/VW8="]=a.current})($__dart_deferred_initializers__);