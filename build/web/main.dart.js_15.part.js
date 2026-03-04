((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,D,E,B={
FF(d,e,f){return new B.xt(f,e,d,null)},
xt:function xt(d,e,f,g){var _=this
_.c=d
_.f=e
_.x=f
_.a=g},
atL:function atL(d,e,f){this.a=d
this.b=e
this.c=f},
atM:function atM(d){this.a=d},
zn:function zn(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.r=f
_.c=g
_.a=h},
a5Z:function a5Z(d,e){var _=this
_.c=_.b=_.a=_.CW=_.ay=_.p1=null
_.d=$
_.e=d
_.r=_.f=null
_.w=e
_.z=_.y=null
_.Q=!1
_.as=!0
_.at=!1},
K3:function K3(d,e,f,g,h,i,j){var _=this
_.p=d
_.S=e
_.a5=f
_.aa=g
_.t$=h
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
aHF:function aHF(d,e){this.a=d
this.b=e},
aHE:function aHE(d){this.a=d},
LX:function LX(){},
a8A:function a8A(){},
a8B:function a8B(){}},F
A=c[0]
C=c[2]
D=c[31]
E=c[38]
B=a.updateHolder(c[19],B)
F=c[44]
B.xt.prototype={
L(d){var x,w,v,u,t=this,s=null,r={},q=t.c,p=D.b0a(d,q,!1)
r.a=t.x
x=t.f==null&&D.aXb(d,q)
w=x?A.Eo(d):t.f
v=D.aQY(p,C.K,w,C.ah,!1,C.aR,s,s,s,s,s,new B.atL(r,t,p))
u=A.mY(d).EP(d)
if(u===E.IE)v=new A.di(new B.atM(d),v,s,y.b)
return x&&w!=null?D.aXa(v):v}}
B.zn.prototype={
b1(d){var x=new B.K3(this.e,this.f,this.r,A.al(),null,new A.aO(),A.al())
x.b0()
x.sbj(null)
return x},
b9(d,e){var x
e.sdL(this.e)
e.scV(this.f)
x=this.r
if(x!==e.a5){e.a5=x
e.aM()
e.bk()}},
ce(){return new B.a5Z(this,C.aa)}}
B.a5Z.prototype={}
B.K3.prototype={
sdL(d){if(d===this.p)return
this.p=d
this.ad()},
scV(d){var x=this,w=x.S
if(d===w)return
if(x.y!=null)w.N(x.gzY())
x.S=d
if(x.y!=null)d.a3(x.gzY())
x.ad()},
aiU(){this.aM()
this.bk()},
f9(d){if(!(d.b instanceof A.cK))d.b=new A.cK()},
aK(d){this.a9n(d)
this.S.a3(this.gzY())},
ap(){this.S.N(this.gzY())
this.a9o()},
gfh(){return!0},
gaoC(){switch(A.bf(this.p).a){case 0:var x=this.gv().a
break
case 1:x=this.gv().b
break
default:x=null}return x},
gA9(){var x=this,w=x.t$
if(w==null)return 0
switch(A.bf(x.p).a){case 0:w=w.gv().a-x.gv().a
break
case 1:w=w.gv().b-x.gv().b
break
default:w=null}return Math.max(0,A.jF(w))},
T1(d){var x
switch(A.bf(this.p).a){case 0:x=new A.Z(0,1/0,d.c,d.d)
break
case 1:x=new A.Z(d.a,d.b,0,1/0)
break
default:x=null}return x},
bA(d){var x=this.t$
x=x==null?null:x.au(C.b9,d,x.gcd())
return x==null?0:x},
bu(d){var x=this.t$
x=x==null?null:x.au(C.ar,d,x.gbK())
return x==null?0:x},
bz(d){var x=this.t$
x=x==null?null:x.au(C.b3,d,x.gcb())
return x==null?0:x},
bt(d){var x=this.t$
x=x==null?null:x.au(C.bt,d,x.gcj())
return x==null?0:x},
cR(d){var x=this.t$
if(x==null)return new A.G(A.I(0,d.a,d.b),A.I(0,d.c,d.d))
return d.bv(x.au(C.T,this.T1(d),x.gcC()))},
bU(){var x,w,v=this,u=y.a.a(A.C.prototype.gac.call(v)),t=v.t$
if(t==null)v.fy=new A.G(A.I(0,u.a,u.b),A.I(0,u.c,u.d))
else{t.cL(v.T1(u),!0)
v.fy=u.bv(v.t$.gv())}t=v.S.at
if(t!=null)if(t>v.gA9()){t=v.S
x=v.gA9()
w=v.S.at
w.toString
t.KS(x-w)}else{t=v.S
x=t.at
x.toString
if(x<0)t.KS(0-x)}v.S.wo(v.gaoC())
v.S.t7(0,v.gA9())},
vU(d){var x,w=this
switch(w.p.a){case 0:x=new A.d(0,d-w.t$.gv().b+w.gv().b)
break
case 3:x=new A.d(d-w.t$.gv().a+w.gv().a,0)
break
case 1:x=new A.d(-d,0)
break
case 2:x=new A.d(0,-d)
break
default:x=null}return x},
Wt(d){var x,w,v=this
switch(v.a5.a){case 0:return!1
case 1:case 2:case 3:x=d.a
if(!(x<0)){w=d.b
x=w<0||x+v.t$.gv().a>v.gv().a||w+v.t$.gv().b>v.gv().b}else x=!0
return x}},
aU(d,e){var x,w,v,u,t,s=this
if(s.t$!=null){x=s.S.at
x.toString
w=s.vU(x)
x=new B.aHF(s,w)
v=s.aa
if(s.Wt(w)){u=s.cx
u===$&&A.a()
t=s.gv()
v.saS(d.lG(u,e,new A.x(0,0,0+t.a,0+t.b),x,s.a5,v.a))}else{v.saS(null)
x.$2(d,e)}}},
l(){this.aa.saS(null)
this.fa()},
dD(d,e){var x,w=this.S.at
w.toString
x=this.vU(w)
e.e7(x.a,x.b,0,1)},
nN(d){var x=this,w=x.S.at
w.toString
w=x.Wt(x.vU(w))
if(w){w=x.gv()
return new A.x(0,0,0+w.a,0+w.b)}return null},
d1(d,e){var x,w=this
if(w.t$!=null){x=w.S.at
x.toString
return d.jL(new B.aHE(w),w.vU(x),e)}return!1},
qU(d,e,f,g){var x,w,v,u,t,s,r,q,p,o,n=this,m=null
A.bf(n.p)
if(g==null)g=d.glD()
if(!(d instanceof A.y)){x=n.S.at
x.toString
return new D.tl(x,g)}w=A.dW(d.ba(n.t$),g)
v=n.t$.gv()
switch(n.p.a){case 0:x=w.d
x=new A.hX(n.gv().b,v.b-x,x-w.b)
break
case 3:x=w.c
x=new A.hX(n.gv().a,v.a-x,x-w.a)
break
case 1:x=w.a
x=new A.hX(n.gv().a,x,w.c-x)
break
case 2:x=w.b
x=new A.hX(n.gv().b,x,w.d-x)
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
return new D.tl(o,w.dT(n.vU(o)))},
ET(d,e,f){return this.qU(d,e,null,f)},
eN(d,e,f,g){this.Qe(d,null,f,D.aXt(d,e,f,this.S,g,this))},
uQ(){return this.eN(C.b4,null,C.t,null)},
uR(d){return this.eN(C.b4,null,d,null)},
oR(d){return this.eN(C.b4,null,C.t,d)},
r5(d,e,f){return this.eN(d,null,e,f)},
oS(d,e){return this.eN(C.b4,d,C.t,e)},
L8(d){var x,w,v=this,u=v.gA9(),t=v.S.at
t.toString
x=u-t
switch(v.p.a){case 0:v.gv()
v.gv()
u=v.gv()
t=v.gv()
w=v.S.at
w.toString
return new A.x(0,0-x,0+u.a,0+t.b+w)
case 1:v.gv()
u=v.S.at
u.toString
v.gv()
return new A.x(0-u,0,0+v.gv().a+x,0+v.gv().b)
case 2:v.gv()
v.gv()
u=v.S.at
u.toString
return new A.x(0,0-u,0+v.gv().a,0+v.gv().b+x)
case 3:v.gv()
v.gv()
u=v.gv()
t=v.S.at
t.toString
return new A.x(0-x,0,0+u.a+t,0+v.gv().b)}},
$iEz:1}
B.LX.prototype={
aK(d){var x
this.eq(d)
x=this.t$
if(x!=null)x.aK(d)},
ap(){this.e9()
var x=this.t$
if(x!=null)x.ap()}}
B.a8A.prototype={}
B.a8B.prototype={}
var z=a.updateTypes(["w(w)","zn(N,iE)","~()","~({curve:eG,descendant:C?,duration:am,rect:x?})"])
B.atL.prototype={
$2(d,e){return new B.zn(this.c,e,C.K,this.a.a,null)},
$S:z+1}
B.atM.prototype={
$1(d){var x,w=A.aQ6(this.a)
if(d.d!=null&&!w.giB()&&w.gc6()){x=$.ab.ar$.d.c
if(x!=null)x.ie()}return!1},
$S:128}
B.aHF.prototype={
$2(d,e){var x=this.a.t$
x.toString
d.e_(x,e.a6(0,this.b))},
$S:24}
B.aHE.prototype={
$2(d,e){return this.a.t$.cS(d,e)},
$S:17};(function aliases(){var x=B.LX.prototype
x.a9n=x.aK
x.a9o=x.ap})();(function installTearOffs(){var x=a._instance_0u,w=a._instance_1u,v=a.installInstanceTearOff
var u
x(u=B.K3.prototype,"gzY","aiU",2)
w(u,"gcd","bA",0)
w(u,"gbK","bu",0)
w(u,"gcb","bz",0)
w(u,"gcj","bt",0)
v(u,"gr4",0,0,null,["$4$curve$descendant$duration$rect","$0","$1$duration","$1$rect","$3$curve$duration$rect","$2$descendant$rect"],["eN","uQ","uR","oR","r5","oS"],3,0,0)})();(function inheritance(){var x=a.mixinHard,w=a.mixin,v=a.inherit,u=a.inheritMany
v(B.xt,A.ad)
u(A.eE,[B.atL,B.aHF,B.aHE])
v(B.atM,A.df)
v(B.zn,A.aQ)
v(B.a8A,A.xs)
v(B.a8B,B.a8A)
v(B.a5Z,B.a8B)
v(B.LX,A.y)
v(B.K3,B.LX)
x(B.LX,A.aN)
w(B.a8A,A.DY)
w(B.a8B,D.Yk)})()
A.dy(b.typeUniverse,JSON.parse('{"xt":{"ad":[],"f":[]},"zn":{"aQ":[],"an":[],"f":[]},"a5Z":{"b1":[],"aE":[],"N":[]},"K3":{"y":[],"aN":["y"],"Ez":[],"C":[],"ap":[]}}'))
var y={a:A.S("Z"),b:A.S("di<jk>")};(function constants(){F.ou=new A.cC(null,6,null,null)})()};
(a=>{a["i6eowp28Vmt9pEmPMGph5BpMp6w="]=a.current})($__dart_deferred_initializers__);