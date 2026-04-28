((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,D,B={
aXq(d){var x,w,v=new A.b9(new Float64Array(16))
v.eN()
for(x=d.length-1;x>0;--x){w=d[x]
if(w!=null)w.tl(d[x-1],v)}return v},
ags(d,e,f,g){var x,w
if(d==null||e==null)return null
if(d===e)return d
x=d.z
w=e.z
if(x<w){g.push(e.r)
return B.ags(d,e.r,f,g)}else if(x>w){f.push(d.r)
return B.ags(d.r,e,f,g)}f.push(d.r)
g.push(e.r)
return B.ags(d.r,e.r,f,g)},
wy:function wy(){this.d=this.a=null},
CH:function CH(d,e,f,g,h,i){var _=this
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
Wm:function Wm(d,e,f,g){var _=this
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
Wi:function Wi(d,e,f,g,h,i,j,k){var _=this
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
aRj(d,e,f,g){return new B.Ok(e,g,f,d,null)},
qL:function qL(d,e,f){this.e=d
this.c=e
this.a=f},
Ok:function Ok(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.x=f
_.c=g
_.a=h},
vS(d){var x=d.L(y.n),w=x==null?null:x.w.c
return(w==null?D.cO:w).d9(d)},
ahn(){var x=0,w=A.t(y.v)
var $async$ahn=A.n(function(d,e){if(d===1)return A.p(e,w)
for(;;)switch(x){case 0:x=2
return A.o(D.bb.df("HapticFeedback.vibrate","HapticFeedbackType.selectionClick",y.v),$async$ahn)
case 2:return A.q(null,w)}})
return A.r($async$ahn,w)}},C
A=c[0]
D=c[2]
B=a.updateHolder(c[15],B)
C=c[55]
B.wy.prototype={
VK(d){this.a=d},
XJ(d){if(this.a===d)this.a=null},
k(d){var x=A.bp(this),w=this.a!=null?"<linked>":"<dangling>"
return"<optimized out>#"+x+"("+w+")"}}
B.CH.prototype={
Jr(d){var x,w,v,u,t=this
if(t.R8){x=t.OT()
x.toString
t.p4=A.rQ(x)
t.R8=!1}if(t.p4==null)return null
w=new A.nA(new Float64Array(4))
w.PC(d.a,d.b,0,1)
x=t.p4.ai(w).a
v=x[0]
u=t.p1
return new A.c(v-u.a,x[1]-u.b)},
iJ(d,e,f,g){var x,w=this
if(w.k3.a==null){if(w.k4)return w.ne(d,e.ac(0,w.ok),!0,g)
return!1}x=w.Jr(e)
if(x==null)return!1
return w.ne(d,x,!0,g)},
OT(){var x,w
if(this.p3==null)return null
x=this.p2
w=A.oY(-x.a,-x.b,0)
x=this.p3
x.toString
w.eC(x)
return w},
aeq(){var x,w,v,u,t,s,r=this
r.p3=null
x=r.k3.a
if(x==null)return
w=y.A
v=A.b([x],w)
u=A.b([r],w)
B.ags(x,r,v,u)
t=B.aXq(v)
x.tl(null,t)
w=r.p1
t.eb(w.a,w.b,0,1)
s=B.aXq(u)
if(s.iE(s)===0)return
s.eC(t)
r.p3=s
r.R8=!0},
gti(){return!0},
iD(d){var x,w,v=this
if(v.k3.a==null&&!v.k4){v.p2=v.p3=null
v.R8=!0
v.shA(null)
return}v.aeq()
x=v.p3
w=y.y
if(x!=null){v.p2=v.ok
v.shA(d.ym(x.a,w.a(v.x)))
v.jM(d)
d.fH()}else{v.p2=null
x=v.ok
v.shA(d.ym(A.oY(x.a,x.b,0).a,w.a(v.x)))
v.jM(d)
d.fH()}v.R8=!0},
tl(d,e){var x=this.p3
if(x!=null)e.eC(x)
else{x=this.ok
e.eC(A.oY(x.a,x.b,0))}}}
B.Wm.prototype={
sqs(d){var x=this,w=x.E
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
w.sqs(v)
w.sd1(e)}x=x.a
x.toString
d.mR(x,A.f6.prototype.gfa.call(this),D.i)}}
B.Wi.prototype={
sqs(d){if(this.E===d)return
this.E=d
this.aN()},
sa5r(d){if(this.a2===d)return
this.a2=d
this.aN()},
sd1(d){if(this.ap.j(0,d))return
this.ap=d
this.aN()},
saza(d){if(this.c5.j(0,d))return
this.c5=d
this.aN()},
sawD(d){if(this.bY.j(0,d))return
this.bY=d
this.aN()},
ao(){this.ch.saS(null)
this.p9()},
gkE(){return!0},
ON(){var x=y.s.a(A.B.prototype.gaS.call(this))
x=x==null?null:x.OT()
if(x==null){x=new A.b9(new Float64Array(16))
x.eN()}return x},
cW(d,e){if(this.E.a==null&&!this.a2)return!1
return this.d_(d,e)},
d_(d,e){return d.BE(new B.ar8(this),e,this.ON())},
aT(d,e){var x,w=this,v=w.E.d,u=v==null?w.ap:w.c5.BG(v).ac(0,w.bY.BG(w.gt())).a6(0,w.ap),t=y.s
if(t.a(A.B.prototype.gaS.call(w))==null)w.ch.saS(new B.CH(w.E,w.a2,e,u,A.D(y.e,y.k),A.an()))
else{x=t.a(A.B.prototype.gaS.call(w))
if(x!=null){x.k3=w.E
x.k4=w.a2
x.p1=u
x.ok=e}}t=t.a(A.B.prototype.gaS.call(w))
t.toString
d.ui(t,A.f6.prototype.gfa.call(w),D.i,C.acy)},
dG(d,e){e.eC(this.ON())}}
B.qL.prototype={
b0(d){var x=new B.Wm(this.e,null,new A.aO(),A.an())
x.b_()
x.sbk(null)
return x},
bb(d,e){e.sqs(this.e)}}
B.Ok.prototype={
b0(d){var x=new B.Wi(this.e,this.f,this.x,C.fD,C.fD,null,new A.aO(),A.an())
x.b_()
x.sbk(null)
return x},
bb(d,e){e.sqs(this.e)
e.sa5r(this.f)
e.sd1(this.x)
e.saza(C.fD)
e.sawD(C.fD)}}
var z=a.updateTypes([])
B.ar8.prototype={
$2(d,e){return this.a.ve(d,e)},
$S:14};(function inheritance(){var x=a.inherit,w=a.inheritMany
x(B.wy,A.E)
x(B.CH,A.eX)
w(A.iD,[B.Wm,B.Wi])
x(B.ar8,A.eV)
w(A.aT,[B.qL,B.Ok])})()
A.dH(b.typeUniverse,JSON.parse('{"CH":{"eX":[],"eK":[]},"Wm":{"y":[],"aP":["y"],"B":[],"ap":[]},"Wi":{"y":[],"aP":["y"],"B":[],"ap":[]},"qL":{"aT":[],"ao":[],"f":[]},"Ok":{"aT":[],"ao":[],"f":[]}}'))
var y={n:A.R("rn"),A:A.R("u<eX>"),t:A.R("Dn"),e:A.R("k"),s:A.R("CH?"),y:A.R("ax_?"),v:A.R("~"),k:A.R("~()")};(function constants(){C.fD=new A.ek(-1,-1)
C.aeI=new A.F(48,48)
C.re=new A.aE(6,6,6,6)
C.acy=new A.x(-1/0,-1/0,1/0,1/0)
C.kH=new A.cP(null,20,null,null)})()};
(a=>{a["OZQkuc57wgchuCsMY9/B5XXvTH4="]=a.current})($__dart_deferred_initializers__);