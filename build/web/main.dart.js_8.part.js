((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,D,E,B={
yp(d,e,f,g){return new B.yo(g,f,e,d,null)},
yo:function yo(d,e,f,g,h){var _=this
_.c=d
_.e=e
_.f=f
_.x=g
_.a=h},
awn:function awn(d,e,f){this.a=d
this.b=e
this.c=f},
awo:function awo(d){this.a=d},
Am:function Am(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.r=f
_.c=g
_.a=h},
a7v:function a7v(d,e){var _=this
_.c=_.b=_.a=_.CW=_.ay=_.p1=null
_.d=$
_.e=d
_.r=_.f=null
_.w=e
_.z=_.y=null
_.Q=!1
_.as=!0
_.at=!1},
Le:function Le(d,e,f,g,h,i,j){var _=this
_.p=d
_.R=e
_.a0=f
_.a8=g
_.v$=h
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
aKI:function aKI(d,e){this.a=d
this.b=e},
aKH:function aKH(d){this.a=d},
N8:function N8(){},
aa9:function aa9(){},
aaa:function aaa(){}}
A=c[0]
C=c[2]
D=c[31]
E=c[39]
B=a.updateHolder(c[27],B)
B.yo.prototype={
K(d){var x,w,v,u,t,s=this,r=null,q={},p=s.c,o=D.aRH(d,p,!1),n=s.x
q.a=n
x=s.e
if(x!=null)q.a=new A.bq(x,n,r)
w=s.f==null&&D.b0t(d,p)
v=w?A.Fr(d):s.f
u=D.aUW(o,C.G,v,C.ai,!1,C.aX,r,r,r,r,r,new B.awn(q,s,o))
t=A.nw(d).Fu(d)
if(t===E.Jj)u=new A.ds(new B.awo(d),u,r,y.b)
return w&&v!=null?D.b0s(u):u}}
B.Am.prototype={
aW(d){var x=new B.Le(this.e,this.f,this.r,A.an(),null,new A.aN(),A.an())
x.aV()
x.sbn(null)
return x},
bc(d,e){var x
e.sdD(this.e)
e.sd5(this.f)
x=this.r
if(x!==e.a0){e.a0=x
e.aO()
e.bp()}},
cp(){return new B.a7v(this,C.ae)}}
B.a7v.prototype={}
B.Le.prototype={
sdD(d){if(d===this.p)return
this.p=d
this.ac()},
sd5(d){var x=this,w=x.R
if(d===w)return
if(x.y!=null)w.O(x.gAE())
x.R=d
if(x.y!=null)d.a4(x.gAE())
x.ac()},
akh(){this.aO()
this.bp()},
eT(d){if(!(d.b instanceof A.cJ))d.b=new A.cJ()},
aJ(d){this.aaE(d)
this.R.a4(this.gAE())},
an(){this.R.O(this.gAE())
this.aaF()},
gfz(){return!0},
gaq5(){switch(A.ba(this.p).a){case 0:var x=this.gt().a
break
case 1:x=this.gt().b
break
default:x=null}return x},
gAR(){var x=this,w=x.v$
if(w==null)return 0
switch(A.ba(x.p).a){case 0:w=w.gt().a-x.gt().a
break
case 1:w=w.gt().b-x.gt().b
break
default:w=null}return Math.max(0,A.iZ(w))},
TX(d){var x
switch(A.ba(this.p).a){case 0:x=new A.Z(0,1/0,d.c,d.d)
break
case 1:x=new A.Z(d.a,d.b,0,1/0)
break
default:x=null}return x},
bz(d){var x=this.v$
x=x==null?null:x.ar(C.aK,d,x.gbY())
return x==null?0:x},
bw(d){var x=this.v$
x=x==null?null:x.ar(C.ak,d,x.gbG())
return x==null?0:x},
by(d){var x=this.v$
x=x==null?null:x.ar(C.aL,d,x.gbX())
return x==null?0:x},
bv(d){var x=this.v$
x=x==null?null:x.ar(C.b2,d,x.gc6())
return x==null?0:x},
cO(d){var x=this.v$
if(x==null)return new A.E(A.I(0,d.a,d.b),A.I(0,d.c,d.d))
return d.bo(x.ar(C.M,this.TX(d),x.gcj()))},
bQ(){var x,w,v=this,u=y.a.a(A.B.prototype.ga6.call(v)),t=v.v$
if(t==null)v.fy=new A.E(A.I(0,u.a,u.b),A.I(0,u.c,u.d))
else{t.ct(v.TX(u),!0)
v.fy=u.bo(v.v$.gt())}t=v.R.at
if(t!=null)if(t>v.gAR()){t=v.R
x=v.gAR()
w=v.R.at
w.toString
t.LB(x-w)}else{t=v.R
x=t.at
x.toString
if(x<0)t.LB(0-x)}v.R.wT(v.gaq5())
v.R.tB(0,v.gAR())},
wp(d){var x,w=this
switch(w.p.a){case 0:x=new A.c(0,d-w.v$.gt().b+w.gt().b)
break
case 3:x=new A.c(d-w.v$.gt().a+w.gt().a,0)
break
case 1:x=new A.c(-d,0)
break
case 2:x=new A.c(0,-d)
break
default:x=null}return x},
Xt(d){var x,w,v=this
switch(v.a0.a){case 0:return!1
case 1:case 2:case 3:x=d.a
if(!(x<0)){w=d.b
x=w<0||x+v.v$.gt().a>v.gt().a||w+v.v$.gt().b>v.gt().b}else x=!0
return x}},
aU(d,e){var x,w,v,u,t,s=this
if(s.v$!=null){x=s.R.at
x.toString
w=s.wp(x)
x=new B.aKI(s,w)
v=s.a8
if(s.Xt(w)){u=s.cx
u===$&&A.a()
t=s.gt()
v.saT(d.lW(u,e,new A.z(0,0,0+t.a,0+t.b),x,s.a0,v.a))}else{v.saT(null)
x.$2(d,e)}}},
l(){this.a8.saT(null)
this.fn()},
dM(d,e){var x,w=this.R.at
w.toString
x=this.wp(w)
e.eh(x.a,x.b,0,1)},
o8(d){var x=this,w=x.R.at
w.toString
w=x.Xt(x.wp(w))
if(w){w=x.gt()
return new A.z(0,0,0+w.a,0+w.b)}return null},
d2(d,e){var x,w=this
if(w.v$!=null){x=w.R.at
x.toString
return d.jV(new B.aKH(w),w.wp(x),e)}return!1},
re(d,e,f,g){var x,w,v,u,t,s,r,q,p,o,n=this,m=null
A.ba(n.p)
if(g==null)g=d.glS()
if(!(d instanceof A.x)){x=n.R.at
x.toString
return new D.tW(x,g)}w=A.e3(d.be(n.v$),g)
v=n.v$.gt()
switch(n.p.a){case 0:x=w.d
x=new A.ic(n.gt().b,v.b-x,x-w.b)
break
case 3:x=w.c
x=new A.ic(n.gt().a,v.a-x,x-w.a)
break
case 1:x=w.a
x=new A.ic(n.gt().a,x,w.c-x)
break
case 2:x=w.b
x=new A.ic(n.gt().b,x,w.d-x)
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
return new D.tW(o,w.e1(n.wp(o)))},
Fy(d,e,f){return this.re(d,e,null,f)},
eV(d,e,f,g){this.R_(d,null,f,D.b0V(d,e,f,this.R,g,this))},
vj(){return this.eV(C.b5,null,C.r,null)},
vk(d){return this.eV(C.b5,null,d,null)},
pc(d){return this.eV(C.b5,null,C.r,d)},
rr(d,e,f){return this.eV(d,null,e,f)},
pd(d,e){return this.eV(C.b5,d,C.r,e)},
LT(d){var x,w,v=this,u=v.gAR(),t=v.R.at
t.toString
x=u-t
switch(v.p.a){case 0:v.gt()
v.gt()
u=v.gt()
t=v.gt()
w=v.R.at
w.toString
return new A.z(0,0-x,0+u.a,0+t.b+w)
case 1:v.gt()
u=v.R.at
u.toString
v.gt()
return new A.z(0-u,0,0+v.gt().a+x,0+v.gt().b)
case 2:v.gt()
v.gt()
u=v.R.at
u.toString
return new A.z(0,0-u,0+v.gt().a,0+v.gt().b+x)
case 3:v.gt()
v.gt()
u=v.gt()
t=v.R.at
t.toString
return new A.z(0-x,0,0+u.a+t,0+v.gt().b)}},
$iFD:1}
B.N8.prototype={
aJ(d){var x
this.e9(d)
x=this.v$
if(x!=null)x.aJ(d)},
an(){this.e3()
var x=this.v$
if(x!=null)x.an()}}
B.aa9.prototype={}
B.aaa.prototype={}
var z=a.updateTypes(["w(w)","Am(G,iT)","~()","~({curve:eM,descendant:B?,duration:am,rect:z?})"])
B.awn.prototype={
$2(d,e){return new B.Am(this.c,e,C.G,this.a.a,null)},
$S:z+1}
B.awo.prototype={
$1(d){var x,w=A.aTZ(this.a)
if(d.d!=null&&!w.giV()&&w.gcd()){x=$.aa.az$.d.c
if(x!=null)x.ix()}return!1},
$S:214}
B.aKI.prototype={
$2(d,e){var x=this.a.v$
x.toString
d.e8(x,e.a7(0,this.b))},
$S:26}
B.aKH.prototype={
$2(d,e){return this.a.v$.d1(d,e)},
$S:18};(function aliases(){var x=B.N8.prototype
x.aaE=x.aJ
x.aaF=x.an})();(function installTearOffs(){var x=a._instance_0u,w=a._instance_1u,v=a.installInstanceTearOff
var u
x(u=B.Le.prototype,"gAE","akh",2)
w(u,"gbY","bz",0)
w(u,"gbG","bw",0)
w(u,"gbX","by",0)
w(u,"gc6","bv",0)
v(u,"grq",0,0,null,["$4$curve$descendant$duration$rect","$0","$1$duration","$1$rect","$3$curve$duration$rect","$2$descendant$rect"],["eV","vj","vk","pc","rr","pd"],3,0,0)})();(function inheritance(){var x=a.mixinHard,w=a.mixin,v=a.inherit,u=a.inheritMany
v(B.yo,A.ac)
u(A.fl,[B.awn,B.aKI,B.aKH])
v(B.awo,A.dc)
v(B.Am,A.aS)
v(B.aa9,A.yn)
v(B.aaa,B.aa9)
v(B.a7v,B.aaa)
v(B.N8,A.x)
v(B.Le,B.N8)
x(B.N8,A.aR)
w(B.aa9,A.F1)
w(B.aaa,D.ZK)})()
A.dG(b.typeUniverse,JSON.parse('{"yo":{"ac":[],"f":[]},"Am":{"aS":[],"ao":[],"f":[]},"a7v":{"b4":[],"aG":[],"G":[]},"Le":{"x":[],"aR":["x"],"FD":[],"B":[],"ap":[]}}'))
var y={a:A.R("Z"),b:A.R("ds<jE>")}};
(a=>{a["0yA9jgbnrih2ExnrDnYn7Es7sHk="]=a.current})($__dart_deferred_initializers__);