((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,D,F,B={
G2(d,e,f){return new B.xL(f,e,d,null)},
xL:function xL(d,e,f,g){var _=this
_.c=d
_.f=e
_.x=f
_.a=g},
auS:function auS(d,e,f){this.a=d
this.b=e
this.c=f},
auT:function auT(d){this.a=d},
zH:function zH(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.r=f
_.c=g
_.a=h},
a6F:function a6F(d,e){var _=this
_.c=_.b=_.a=_.CW=_.ay=_.p1=null
_.d=$
_.e=d
_.r=_.f=null
_.w=e
_.z=_.y=null
_.Q=!1
_.as=!0
_.at=!1},
Kv:function Kv(d,e,f,g,h,i,j){var _=this
_.p=d
_.R=e
_.a0=f
_.a9=g
_.u$=h
_.dy=i
_.b=_.fy=null
_.c=0
_.y=_.d=null
_.z=!0
_.Q=null
_.as=!1
_.at=null
_.ay=$
_.ch=j
_.CW=!1
_.cx=$
_.cy=!0
_.db=!1
_.dx=$},
aJ2:function aJ2(d,e){this.a=d
this.b=e},
aJ1:function aJ1(d){this.a=d},
Mo:function Mo(){},
a9j:function a9j(){},
a9k:function a9k(){}},E
A=c[0]
C=c[2]
D=c[31]
F=c[39]
B=a.updateHolder(c[23],B)
E=c[48]
B.xL.prototype={
K(d){var x,w,v,u,t=this,s=null,r={},q=t.c,p=D.b2s(d,q,!1)
r.a=t.x
x=t.f==null&&D.aZg(d,q)
w=x?A.EL(d):t.f
v=D.aSW(p,C.C,w,C.ai,!1,C.aS,s,s,s,s,s,new B.auS(r,t,p))
u=A.nc(d).F7(d)
if(u===F.J5)v=new A.dl(new B.auT(d),v,s,y.b)
return x&&w!=null?D.aZf(v):v}}
B.zH.prototype={
b_(d){var x=new B.Kv(this.e,this.f,this.r,A.an(),null,new A.aO(),A.an())
x.aX()
x.sbl(null)
return x},
ba(d,e){var x
e.sdQ(this.e)
e.sd1(this.f)
x=this.r
if(x!==e.a0){e.a0=x
e.aN()
e.bm()}},
cj(){return new B.a6F(this,C.ac)}}
B.a6F.prototype={}
B.Kv.prototype={
sdQ(d){if(d===this.p)return
this.p=d
this.a7()},
sd1(d){var x=this,w=x.R
if(d===w)return
if(x.y!=null)w.N(x.gAl())
x.R=d
if(x.y!=null)d.a4(x.gAl())
x.a7()},
ajz(){this.aN()
this.bm()},
f6(d){if(!(d.b instanceof A.cG))d.b=new A.cG()},
aK(d){this.a9W(d)
this.R.a4(this.gAl())},
aq(){this.R.N(this.gAl())
this.a9X()},
gfu(){return!0},
gapm(){switch(A.bf(this.p).a){case 0:var x=this.gt().a
break
case 1:x=this.gt().b
break
default:x=null}return x},
gAw(){var x=this,w=x.u$
if(w==null)return 0
switch(A.bf(x.p).a){case 0:w=w.gt().a-x.gt().a
break
case 1:w=w.gt().b-x.gt().b
break
default:w=null}return Math.max(0,A.jQ(w))},
Tu(d){var x
switch(A.bf(this.p).a){case 0:x=new A.a_(0,1/0,d.c,d.d)
break
case 1:x=new A.a_(d.a,d.b,0,1/0)
break
default:x=null}return x},
bv(d){var x=this.u$
x=x==null?null:x.aA(C.aT,d,x.gc0())
return x==null?0:x},
bq(d){var x=this.u$
x=x==null?null:x.aA(C.ar,d,x.gbH())
return x==null?0:x},
bu(d){var x=this.u$
x=x==null?null:x.aA(C.aU,d,x.gc_())
return x==null?0:x},
bp(d){var x=this.u$
x=x==null?null:x.aA(C.bd,d,x.gc8())
return x==null?0:x},
cO(d){var x=this.u$
if(x==null)return new A.F(A.H(0,d.a,d.b),A.H(0,d.c,d.d))
return d.br(x.aA(C.Q,this.Tu(d),x.gcw()))},
bT(){var x,w,v=this,u=y.a.a(A.B.prototype.ga6.call(v)),t=v.u$
if(t==null)v.fy=new A.F(A.H(0,u.a,u.b),A.H(0,u.c,u.d))
else{t.cI(v.Tu(u),!0)
v.fy=u.br(v.u$.gt())}t=v.R.at
if(t!=null)if(t>v.gAw()){t=v.R
x=v.gAw()
w=v.R.at
w.toString
t.Ld(x-w)}else{t=v.R
x=t.at
x.toString
if(x<0)t.Ld(0-x)}v.R.wJ(v.gapm())
v.R.tl(0,v.gAw())},
wf(d){var x,w=this
switch(w.p.a){case 0:x=new A.c(0,d-w.u$.gt().b+w.gt().b)
break
case 3:x=new A.c(d-w.u$.gt().a+w.gt().a,0)
break
case 1:x=new A.c(-d,0)
break
case 2:x=new A.c(0,-d)
break
default:x=null}return x},
WX(d){var x,w,v=this
switch(v.a0.a){case 0:return!1
case 1:case 2:case 3:x=d.a
if(!(x<0)){w=d.b
x=w<0||x+v.u$.gt().a>v.gt().a||w+v.u$.gt().b>v.gt().b}else x=!0
return x}},
aT(d,e){var x,w,v,u,t,s=this
if(s.u$!=null){x=s.R.at
x.toString
w=s.wf(x)
x=new B.aJ2(s,w)
v=s.a9
if(s.WX(w)){u=s.cx
u===$&&A.a()
t=s.gt()
v.saS(d.l3(u,e,new A.x(0,0,0+t.a,0+t.b),x,s.a0,v.a))}else{v.saS(null)
x.$2(d,e)}}},
l(){this.a9.saS(null)
this.fi()},
dH(d,e){var x,w=this.R.at
w.toString
x=this.wf(w)
e.ec(x.a,x.b,0,1)},
nW(d){var x=this,w=x.R.at
w.toString
w=x.WX(x.wf(w))
if(w){w=x.gt()
return new A.x(0,0,0+w.a,0+w.b)}return null},
d_(d,e){var x,w=this
if(w.u$!=null){x=w.R.at
x.toString
return d.jQ(new B.aJ1(w),w.wf(x),e)}return!1},
r5(d,e,f,g){var x,w,v,u,t,s,r,q,p,o,n=this,m=null
A.bf(n.p)
if(g==null)g=d.glK()
if(!(d instanceof A.y)){x=n.R.at
x.toString
return new D.tu(x,g)}w=A.dZ(d.bc(n.u$),g)
v=n.u$.gt()
switch(n.p.a){case 0:x=w.d
x=new A.i8(n.gt().b,v.b-x,x-w.b)
break
case 3:x=w.c
x=new A.i8(n.gt().a,v.a-x,x-w.a)
break
case 1:x=w.a
x=new A.i8(n.gt().a,x,w.c-x)
break
case 2:x=w.b
x=new A.i8(n.gt().b,x,w.d-x)
break
default:x=m}u=x.a
t=m
s=m
r=x.b
q=x.c
s=q
t=r
p=u
o=t-(p-s)*e
return new D.tu(o,w.e_(n.wf(o)))},
Fb(d,e,f){return this.r5(d,e,null,f)},
eQ(d,e,f,g){this.QA(d,null,f,D.aZG(d,e,f,this.R,g,this))},
v3(){return this.eQ(C.b6,null,C.r,null)},
v4(d){return this.eQ(C.b6,null,d,null)},
p0(d){return this.eQ(C.b6,null,C.r,d)},
ri(d,e,f){return this.eQ(d,null,e,f)},
p5(d,e){return this.eQ(C.b6,d,C.r,e)},
Lu(d){var x,w,v=this,u=v.gAw(),t=v.R.at
t.toString
x=u-t
switch(v.p.a){case 0:v.gt()
v.gt()
u=v.gt()
t=v.gt()
w=v.R.at
w.toString
return new A.x(0,0-x,0+u.a,0+t.b+w)
case 1:v.gt()
u=v.R.at
u.toString
v.gt()
return new A.x(0-u,0,0+v.gt().a+x,0+v.gt().b)
case 2:v.gt()
v.gt()
u=v.R.at
u.toString
return new A.x(0,0-u,0+v.gt().a,0+v.gt().b+x)
case 3:v.gt()
v.gt()
u=v.gt()
t=v.R.at
t.toString
return new A.x(0-x,0,0+u.a+t,0+v.gt().b)}},
$iEW:1}
B.Mo.prototype={
aK(d){var x
this.ee(d)
x=this.u$
if(x!=null)x.aK(d)},
aq(){this.e4()
var x=this.u$
if(x!=null)x.aq()}}
B.a9j.prototype={}
B.a9k.prototype={}
var z=a.updateTypes(["w(w)","zH(I,iO)","~()","~({curve:eJ,descendant:B?,duration:am,rect:x?})"])
B.auS.prototype={
$2(d,e){return new B.zH(this.c,e,C.C,this.a.a,null)},
$S:z+1}
B.auT.prototype={
$1(d){var x,w=A.aS3(this.a)
if(d.d!=null&&!w.giL()&&w.gca()){x=$.ac.av$.d.c
if(x!=null)x.ip()}return!1},
$S:180}
B.aJ2.prototype={
$2(d,e){var x=this.a.u$
x.toString
d.e3(x,e.a8(0,this.b))},
$S:24}
B.aJ1.prototype={
$2(d,e){return this.a.u$.cW(d,e)},
$S:17};(function aliases(){var x=B.Mo.prototype
x.a9W=x.aK
x.a9X=x.aq})();(function installTearOffs(){var x=a._instance_0u,w=a._instance_1u,v=a.installInstanceTearOff
var u
x(u=B.Kv.prototype,"gAl","ajz",2)
w(u,"gc0","bv",0)
w(u,"gbH","bq",0)
w(u,"gc_","bu",0)
w(u,"gc8","bp",0)
v(u,"grh",0,0,null,["$4$curve$descendant$duration$rect","$0","$1$duration","$1$rect","$3$curve$duration$rect","$2$descendant$rect"],["eQ","v3","v4","p0","ri","p5"],3,0,0)})();(function inheritance(){var x=a.mixinHard,w=a.mixin,v=a.inherit,u=a.inheritMany
v(B.xL,A.aa)
u(A.eW,[B.auS,B.aJ2,B.aJ1])
v(B.auT,A.dj)
v(B.zH,A.aR)
v(B.a9j,A.xK)
v(B.a9k,B.a9j)
v(B.a6F,B.a9k)
v(B.Mo,A.y)
v(B.Kv,B.Mo)
x(B.Mo,A.aP)
w(B.a9j,A.Ek)
w(B.a9k,D.YX)})()
A.dH(b.typeUniverse,JSON.parse('{"xL":{"aa":[],"f":[]},"zH":{"aR":[],"ao":[],"f":[]},"a6F":{"b4":[],"aF":[],"I":[]},"Kv":{"y":[],"aP":["y"],"EW":[],"B":[],"ap":[]}}'))
var y={a:A.R("a_"),b:A.R("dl<ju>")};(function constants(){E.q4=new D.on(null,C.ag,null)
E.cL=new A.fC(C.L,null,null,E.q4,null)})()};
(a=>{a["kjNt219cflfO2FjoDYW3q5CcITo="]=a.current})($__dart_deferred_initializers__);