((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,D,E,B={
y0(d,e,f,g){return new B.y_(g,f,e,d,null)},
y_:function y_(d,e,f,g,h){var _=this
_.c=d
_.e=e
_.f=f
_.x=g
_.a=h},
avj:function avj(d,e,f){this.a=d
this.b=e
this.c=f},
avk:function avk(d){this.a=d},
zW:function zW(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.r=f
_.c=g
_.a=h},
a6T:function a6T(d,e){var _=this
_.c=_.b=_.a=_.CW=_.ay=_.p1=null
_.d=$
_.e=d
_.r=_.f=null
_.w=e
_.z=_.y=null
_.Q=!1
_.as=!0
_.at=!1},
KJ:function KJ(d,e,f,g,h,i,j){var _=this
_.p=d
_.R=e
_.a0=f
_.a8=g
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
aJA:function aJA(d,e){this.a=d
this.b=e},
aJz:function aJz(d){this.a=d},
MD:function MD(){},
a9x:function a9x(){},
a9y:function a9y(){}}
A=c[0]
C=c[2]
D=c[32]
E=c[40]
B=a.updateHolder(c[28],B)
B.y_.prototype={
K(d){var x,w,v,u,t,s=this,r=null,q={},p=s.c,o=D.aQt(d,p,!1),n=s.x
q.a=n
x=s.e
if(x!=null)q.a=new A.bp(x,n,r)
w=s.f==null&&D.aZT(d,p)
v=w?A.EX(d):s.f
u=D.aTB(o,C.D,v,C.ai,!1,C.aW,r,r,r,r,r,new B.avj(q,s,o))
t=A.nh(d).Fe(d)
if(t===E.J9)u=new A.dq(new B.avk(d),u,r,y.b)
return w&&v!=null?D.aZS(u):u}}
B.zW.prototype={
aW(d){var x=new B.KJ(this.e,this.f,this.r,A.am(),null,new A.aM(),A.am())
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
co(){return new B.a6T(this,C.ad)}}
B.a6T.prototype={}
B.KJ.prototype={
sdD(d){if(d===this.p)return
this.p=d
this.ac()},
sd5(d){var x=this,w=x.R
if(d===w)return
if(x.y!=null)w.N(x.gAs())
x.R=d
if(x.y!=null)d.a4(x.gAs())
x.ac()},
ajO(){this.aO()
this.bp()},
eS(d){if(!(d.b instanceof A.cG))d.b=new A.cG()},
aJ(d){this.aab(d)
this.R.a4(this.gAs())},
an(){this.R.N(this.gAs())
this.aac()},
gfw(){return!0},
gapC(){switch(A.ba(this.p).a){case 0:var x=this.gt().a
break
case 1:x=this.gt().b
break
default:x=null}return x},
gAE(){var x=this,w=x.u$
if(w==null)return 0
switch(A.ba(x.p).a){case 0:w=w.gt().a-x.gt().a
break
case 1:w=w.gt().b-x.gt().b
break
default:w=null}return Math.max(0,A.iX(w))},
TB(d){var x
switch(A.ba(this.p).a){case 0:x=new A.Z(0,1/0,d.c,d.d)
break
case 1:x=new A.Z(d.a,d.b,0,1/0)
break
default:x=null}return x},
by(d){var x=this.u$
x=x==null?null:x.ar(C.aK,d,x.gbY())
return x==null?0:x},
bv(d){var x=this.u$
x=x==null?null:x.ar(C.am,d,x.gbG())
return x==null?0:x},
bx(d){var x=this.u$
x=x==null?null:x.ar(C.aL,d,x.gbX())
return x==null?0:x},
bu(d){var x=this.u$
x=x==null?null:x.ar(C.b1,d,x.gc5())
return x==null?0:x},
cO(d){var x=this.u$
if(x==null)return new A.D(A.I(0,d.a,d.b),A.I(0,d.c,d.d))
return d.bo(x.ar(C.M,this.TB(d),x.gcj()))},
bQ(){var x,w,v=this,u=y.a.a(A.B.prototype.ga6.call(v)),t=v.u$
if(t==null)v.fy=new A.D(A.I(0,u.a,u.b),A.I(0,u.c,u.d))
else{t.cs(v.TB(u),!0)
v.fy=u.bo(v.u$.gt())}t=v.R.at
if(t!=null)if(t>v.gAE()){t=v.R
x=v.gAE()
w=v.R.at
w.toString
t.Lk(x-w)}else{t=v.R
x=t.at
x.toString
if(x<0)t.Lk(0-x)}v.R.wJ(v.gapC())
v.R.tq(0,v.gAE())},
we(d){var x,w=this
switch(w.p.a){case 0:x=new A.c(0,d-w.u$.gt().b+w.gt().b)
break
case 3:x=new A.c(d-w.u$.gt().a+w.gt().a,0)
break
case 1:x=new A.c(-d,0)
break
case 2:x=new A.c(0,-d)
break
default:x=null}return x},
X6(d){var x,w,v=this
switch(v.a0.a){case 0:return!1
case 1:case 2:case 3:x=d.a
if(!(x<0)){w=d.b
x=w<0||x+v.u$.gt().a>v.gt().a||w+v.u$.gt().b>v.gt().b}else x=!0
return x}},
aU(d,e){var x,w,v,u,t,s=this
if(s.u$!=null){x=s.R.at
x.toString
w=s.we(x)
x=new B.aJA(s,w)
v=s.a8
if(s.X6(w)){u=s.cx
u===$&&A.a()
t=s.gt()
v.saT(d.lR(u,e,new A.y(0,0,0+t.a,0+t.b),x,s.a0,v.a))}else{v.saT(null)
x.$2(d,e)}}},
l(){this.a8.saT(null)
this.fm()},
dK(d,e){var x,w=this.R.at
w.toString
x=this.we(w)
e.eh(x.a,x.b,0,1)},
o5(d){var x=this,w=x.R.at
w.toString
w=x.X6(x.we(w))
if(w){w=x.gt()
return new A.y(0,0,0+w.a,0+w.b)}return null},
d2(d,e){var x,w=this
if(w.u$!=null){x=w.R.at
x.toString
return d.jT(new B.aJz(w),w.we(x),e)}return!1},
r6(d,e,f,g){var x,w,v,u,t,s,r,q,p,o,n=this,m=null
A.ba(n.p)
if(g==null)g=d.glN()
if(!(d instanceof A.x)){x=n.R.at
x.toString
return new D.tG(x,g)}w=A.e2(d.be(n.u$),g)
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
return new D.tG(o,w.e1(n.we(o)))},
Fi(d,e,f){return this.r6(d,e,null,f)},
eU(d,e,f,g){this.QH(d,null,f,D.b_k(d,e,f,this.R,g,this))},
v8(){return this.eU(C.b4,null,C.r,null)},
v9(d){return this.eU(C.b4,null,d,null)},
p9(d){return this.eU(C.b4,null,C.r,d)},
rk(d,e,f){return this.eU(d,null,e,f)},
pa(d,e){return this.eU(C.b4,d,C.r,e)},
LC(d){var x,w,v=this,u=v.gAE(),t=v.R.at
t.toString
x=u-t
switch(v.p.a){case 0:v.gt()
v.gt()
u=v.gt()
t=v.gt()
w=v.R.at
w.toString
return new A.y(0,0-x,0+u.a,0+t.b+w)
case 1:v.gt()
u=v.R.at
u.toString
v.gt()
return new A.y(0-u,0,0+v.gt().a+x,0+v.gt().b)
case 2:v.gt()
v.gt()
u=v.R.at
u.toString
return new A.y(0,0-u,0+v.gt().a,0+v.gt().b+x)
case 3:v.gt()
v.gt()
u=v.gt()
t=v.R.at
t.toString
return new A.y(0-x,0,0+u.a+t,0+v.gt().b)}},
$iF7:1}
B.MD.prototype={
aJ(d){var x
this.e9(d)
x=this.u$
if(x!=null)x.aJ(d)},
an(){this.e3()
var x=this.u$
if(x!=null)x.an()}}
B.a9x.prototype={}
B.a9y.prototype={}
var z=a.updateTypes(["w(w)","zW(F,iR)","~()","~({curve:eJ,descendant:B?,duration:an,rect:y?})"])
B.avj.prototype={
$2(d,e){return new B.zW(this.c,e,C.D,this.a.a,null)},
$S:z+1}
B.avk.prototype={
$1(d){var x,w=A.aSC(this.a)
if(d.d!=null&&!w.giQ()&&w.gcc()){x=$.aa.az$.d.c
if(x!=null)x.iv()}return!1},
$S:180}
B.aJA.prototype={
$2(d,e){var x=this.a.u$
x.toString
d.e8(x,e.a7(0,this.b))},
$S:25}
B.aJz.prototype={
$2(d,e){return this.a.u$.d1(d,e)},
$S:17};(function aliases(){var x=B.MD.prototype
x.aab=x.aJ
x.aac=x.an})();(function installTearOffs(){var x=a._instance_0u,w=a._instance_1u,v=a.installInstanceTearOff
var u
x(u=B.KJ.prototype,"gAs","ajO",2)
w(u,"gbY","by",0)
w(u,"gbG","bv",0)
w(u,"gbX","bx",0)
w(u,"gc5","bu",0)
v(u,"grj",0,0,null,["$4$curve$descendant$duration$rect","$0","$1$duration","$1$rect","$3$curve$duration$rect","$2$descendant$rect"],["eU","v8","v9","p9","rk","pa"],3,0,0)})();(function inheritance(){var x=a.mixinHard,w=a.mixin,v=a.inherit,u=a.inheritMany
v(B.y_,A.ac)
u(A.eX,[B.avj,B.aJA,B.aJz])
v(B.avk,A.dd)
v(B.zW,A.aQ)
v(B.a9x,A.xZ)
v(B.a9y,B.a9x)
v(B.a6T,B.a9y)
v(B.MD,A.x)
v(B.KJ,B.MD)
x(B.MD,A.aP)
w(B.a9x,A.Ev)
w(B.a9y,D.Z7)})()
A.dF(b.typeUniverse,JSON.parse('{"y_":{"ac":[],"f":[]},"zW":{"aQ":[],"ao":[],"f":[]},"a6T":{"b4":[],"aG":[],"F":[]},"KJ":{"x":[],"aP":["x"],"F7":[],"B":[],"ap":[]}}'))
var y={a:A.S("Z"),b:A.S("dq<jz>")}};
(a=>{a["0hDlZzbkBVg3Bv7GA5NsL01YDFM="]=a.current})($__dart_deferred_initializers__);