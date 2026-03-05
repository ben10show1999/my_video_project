((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,D,B={
aWk(d){var x,w,v=new A.b9(new Float64Array(16))
v.eM()
for(x=d.length-1;x>0;--x){w=d[x]
if(w!=null)w.td(d[x-1],v)}return v},
ag5(d,e,f,g){var x,w
if(d==null||e==null)return null
if(d===e)return d
x=d.z
w=e.z
if(x<w){g.push(e.r)
return B.ag5(d,e.r,f,g)}else if(x>w){f.push(d.r)
return B.ag5(d.r,e,f,g)}f.push(d.r)
g.push(e.r)
return B.ag5(d.r,e.r,f,g)},
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
W3:function W3(d,e,f,g){var _=this
_.E=d
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
W_:function W_(d,e,f,g,h,i,j,k){var _=this
_.E=d
_.a1=e
_.aq=f
_.c4=g
_.bX=h
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
aqL:function aqL(d){this.a=d},
aQr(d,e,f,g){return new B.O3(e,g,f,d,null)},
qu:function qu(d,e,f){this.e=d
this.c=e
this.a=f},
O3:function O3(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.x=f
_.c=g
_.a=h},
vx(d){var x=d.L(y.n),w=x==null?null:x.w.c
return(w==null?D.cM:w).d8(d)},
ah0(){var x=0,w=A.t(y.v)
var $async$ah0=A.o(function(d,e){if(d===1)return A.p(e,w)
for(;;)switch(x){case 0:x=2
return A.v(D.ba.df("HapticFeedback.vibrate","HapticFeedbackType.selectionClick",y.v),$async$ah0)
case 2:return A.q(null,w)}})
return A.r($async$ah0,w)}},C
A=c[0]
D=c[2]
B=a.updateHolder(c[14],B)
C=c[35]
B.wh.prototype={
Vq(d){this.a=d},
Xm(d){if(this.a===d)this.a=null},
k(d){var x=A.bl(this),w=this.a!=null?"<linked>":"<dangling>"
return"<optimized out>#"+x+"("+w+")"}}
B.Cs.prototype={
Jb(d){var x,w,v,u,t=this
if(t.R8){x=t.OA()
x.toString
t.p4=A.rz(x)
t.R8=!1}if(t.p4==null)return null
w=new A.ni(new Float64Array(4))
w.Pi(d.a,d.b,0,1)
x=t.p4.ai(w).a
v=x[0]
u=t.p1
return new A.c(v-u.a,x[1]-u.b)},
iF(d,e,f,g){var x,w=this
if(w.k3.a==null){if(w.k4)return w.n9(d,e.ab(0,w.ok),!0,g)
return!1}x=w.Jb(e)
if(x==null)return!1
return w.n9(d,x,!0,g)},
OA(){var x,w
if(this.p3==null)return null
x=this.p2
w=A.oG(-x.a,-x.b,0)
x=this.p3
x.toString
w.ey(x)
return w},
ae_(){var x,w,v,u,t,s,r=this
r.p3=null
x=r.k3.a
if(x==null)return
w=y.A
v=A.b([x],w)
u=A.b([r],w)
B.ag5(x,r,v,u)
t=B.aWk(v)
x.td(null,t)
w=r.p1
t.e8(w.a,w.b,0,1)
s=B.aWk(u)
if(s.iy(s)===0)return
s.ey(t)
r.p3=s
r.R8=!0},
gta(){return!0},
ix(d){var x,w,v=this
if(v.k3.a==null&&!v.k4){v.p2=v.p3=null
v.R8=!0
v.shw(null)
return}v.ae_()
x=v.p3
w=y.y
if(x!=null){v.p2=v.ok
v.shw(d.ya(x.a,w.a(v.x)))
v.jJ(d)
d.fC()}else{v.p2=null
x=v.ok
v.shw(d.ya(A.oG(x.a,x.b,0).a,w.a(v.x)))
v.jJ(d)
d.fC()}v.R8=!0},
td(d,e){var x=this.p3
if(x!=null)e.ey(x)
else{x=this.ok
e.ey(A.oG(x.a,x.b,0))}}}
B.W3.prototype={
sql(d){var x=this,w=x.E
if(w===d)return
w.d=null
x.E=d
w=x.a1
if(w!=null)d.d=w
x.aN()},
gkD(){return!0},
bR(){var x=this
x.p_()
x.a1=x.gt()
x.E.d=x.gt()},
aT(d,e){var x=this.ch,w=x.a,v=this.E
if(w==null)x.saS(A.aje(v,e))
else{y.t.a(w)
w.sql(v)
w.sd1(e)}x=x.a
x.toString
d.mN(x,A.f_.prototype.gf6.call(this),D.i)}}
B.W_.prototype={
sql(d){if(this.E===d)return
this.E=d
this.aN()},
sa53(d){if(this.a1===d)return
this.a1=d
this.aN()},
sd1(d){if(this.aq.j(0,d))return
this.aq=d
this.aN()},
sayO(d){if(this.c4.j(0,d))return
this.c4=d
this.aN()},
sawg(d){if(this.bX.j(0,d))return
this.bX=d
this.aN()},
ap(){this.ch.saS(null)
this.p0()},
gkD(){return!0},
Ou(){var x=y.s.a(A.C.prototype.gaS.call(this))
x=x==null?null:x.OA()
if(x==null){x=new A.b9(new Float64Array(16))
x.eM()}return x},
cW(d,e){if(this.E.a==null&&!this.a1)return!1
return this.d_(d,e)},
d_(d,e){return d.Bs(new B.aqL(this),e,this.Ou())},
aT(d,e){var x,w=this,v=w.E.d,u=v==null?w.aq:w.c4.Bu(v).ab(0,w.bX.Bu(w.gt())).a8(0,w.aq),t=y.s
if(t.a(A.C.prototype.gaS.call(w))==null)w.ch.saS(new B.Cs(w.E,w.a1,e,u,A.D(y.e,y.k),A.am()))
else{x=t.a(A.C.prototype.gaS.call(w))
if(x!=null){x.k3=w.E
x.k4=w.a1
x.p1=u
x.ok=e}}t=t.a(A.C.prototype.gaS.call(w))
t.toString
d.u8(t,A.f_.prototype.gf6.call(w),D.i,C.acj)},
dG(d,e){e.ey(this.Ou())}}
B.qu.prototype={
b1(d){var x=new B.W3(this.e,null,new A.aN(),A.am())
x.b0()
x.sbl(null)
return x},
bb(d,e){e.sql(this.e)}}
B.O3.prototype={
b1(d){var x=new B.W_(this.e,this.f,this.x,C.fA,C.fA,null,new A.aN(),A.am())
x.b0()
x.sbl(null)
return x},
bb(d,e){e.sql(this.e)
e.sa53(this.f)
e.sd1(this.x)
e.sayO(C.fA)
e.sawg(C.fA)}}
var z=a.updateTypes([])
B.aqL.prototype={
$2(d,e){return this.a.v2(d,e)},
$S:16};(function inheritance(){var x=a.inherit,w=a.inheritMany
x(B.wh,A.H)
x(B.Cs,A.eM)
w(A.lm,[B.W3,B.W_])
x(B.aqL,A.fM)
w(A.aW,[B.qu,B.O3])})()
A.fo(b.typeUniverse,JSON.parse('{"Cs":{"eM":[],"eC":[]},"W3":{"z":[],"aP":["z"],"C":[],"ap":[]},"W_":{"z":[],"aP":["z"],"C":[],"ap":[]},"qu":{"aW":[],"an":[],"f":[]},"O3":{"aW":[],"an":[],"f":[]}}'))
var y={n:A.T("r9"),A:A.T("n<eM>"),t:A.T("D8"),e:A.T("k"),s:A.T("Cs?"),y:A.T("awz?"),v:A.T("~"),k:A.T("~()")};(function constants(){C.fA=new A.ec(-1,-1)
C.aet=new A.E(48,48)
C.re=new A.aH(6,6,6,6)
C.acj=new A.w(-1/0,-1/0,1/0,1/0)
C.kE=new A.cq(null,20,null,null)})()};
(a=>{a["52GDVQKjUHF98Krr0WqGpHI2GUQ="]=a.current})($__dart_deferred_initializers__);