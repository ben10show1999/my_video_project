((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,B={
zr(d,e,f,g){return new B.zq(g,f,e,d,null)},
zq:function zq(d,e,f,g,h){var _=this
_.c=d
_.e=e
_.f=f
_.x=g
_.a=h},
azF:function azF(d,e,f){this.a=d
this.b=e
this.c=f},
azG:function azG(d){this.a=d},
Bx:function Bx(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.r=f
_.c=g
_.a=h},
a9w:function a9w(d,e){var _=this
_.c=_.b=_.a=_.CW=_.ay=_.p1=null
_.d=$
_.e=d
_.r=_.f=null
_.w=e
_.z=_.y=null
_.Q=!1
_.as=!0
_.at=!1},
MO:function MO(d,e,f,g,h,i,j){var _=this
_.n=d
_.S=e
_.a0=f
_.aa=g
_.E$=h
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
aOQ:function aOQ(d,e){this.a=d
this.b=e},
aOP:function aOP(d){this.a=d},
OJ:function OJ(){},
ace:function ace(){},
acf:function acf(){}},E,D,F
A=c[0]
C=c[2]
B=a.updateHolder(c[27],B)
E=c[53]
D=c[32]
F=c[41]
B.zq.prototype={
K(d){var x,w,v,u,t,s=this,r=null,q={},p=s.c,o=D.aW_(d,p,!1),n=s.x
q.a=n
x=s.e
if(x!=null)q.a=new A.bv(x,n,r)
w=s.f==null&&D.b5m(d,p)
v=w?A.GZ(d):s.f
u=D.aZp(o,C.D,v,C.aj,!1,C.aY,r,r,r,r,r,new B.azF(q,s,o))
t=A.nZ(d).Gp(d)
if(t===F.JM)u=new A.dB(new B.azG(d),u,r,y.b)
return w&&v!=null?D.b5l(u):u}}
B.Bx.prototype={
aX(d){var x=new B.MO(this.e,this.f,this.r,A.ao(),null,new A.aT(),A.ao())
x.aW()
x.sbp(null)
return x},
bd(d,e){var x
e.sdJ(this.e)
e.sd9(this.f)
x=this.r
if(x!==e.a0){e.a0=x
e.aQ()
e.bs()}},
cq(){return new B.a9w(this,C.ac)}}
B.a9w.prototype={}
B.MO.prototype={
sdJ(d){if(d===this.n)return
this.n=d
this.ab()},
sd9(d){var x=this,w=x.S
if(d===w)return
if(x.y!=null)w.N(x.gBs())
x.S=d
if(x.y!=null)d.a3(x.gBs())
x.ab()},
am0(){this.aQ()
this.bs()},
f5(d){if(!(d.b instanceof A.cP))d.b=new A.cP()},
aK(d){this.ac0(d)
this.S.a3(this.gBs())},
ar(){this.S.N(this.gBs())
this.ac1()},
gfI(){return!0},
garW(){switch(A.bf(this.n).a){case 0:var x=this.gu().a
break
case 1:x=this.gu().b
break
default:x=null}return x},
gBF(){var x=this,w=x.E$
if(w==null)return 0
switch(A.bf(x.n).a){case 0:w=w.gu().a-x.gu().a
break
case 1:w=w.gu().b-x.gu().b
break
default:w=null}return Math.max(0,A.ju(w))},
UZ(d){var x
switch(A.bf(this.n).a){case 0:x=new A.a2(0,1/0,d.c,d.d)
break
case 1:x=new A.a2(d.a,d.b,0,1/0)
break
default:x=null}return x},
bF(d){var x=this.E$
x=x==null?null:x.aw(C.aK,d,x.gc4())
return x==null?0:x},
bD(d){var x=this.E$
x=x==null?null:x.aw(C.am,d,x.gbM())
return x==null?0:x},
bE(d){var x=this.E$
x=x==null?null:x.aw(C.aL,d,x.gc3())
return x==null?0:x},
bC(d){var x=this.E$
x=x==null?null:x.aw(C.b3,d,x.gcb())
return x==null?0:x},
cS(d){var x=this.E$
if(x==null)return new A.G(A.I(0,d.a,d.b),A.I(0,d.c,d.d))
return d.bq(x.aw(C.M,this.UZ(d),x.gco()))},
bX(){var x,w,v=this,u=y.a.a(A.D.prototype.ga7.call(v)),t=v.E$
if(t==null)v.fy=new A.G(A.I(0,u.a,u.b),A.I(0,u.c,u.d))
else{t.cz(v.UZ(u),!0)
v.fy=u.bq(v.E$.gu())}t=v.S.at
if(t!=null)if(t>v.gBF()){t=v.S
x=v.gBF()
w=v.S.at
w.toString
t.MA(x-w)}else{t=v.S
x=t.at
x.toString
if(x<0)t.MA(0-x)}v.S.xp(v.garW())
v.S.u0(0,v.gBF())},
wU(d){var x,w=this
switch(w.n.a){case 0:x=new A.c(0,d-w.E$.gu().b+w.gu().b)
break
case 3:x=new A.c(d-w.E$.gu().a+w.gu().a,0)
break
case 1:x=new A.c(-d,0)
break
case 2:x=new A.c(0,-d)
break
default:x=null}return x},
Yy(d){var x,w,v=this
switch(v.a0.a){case 0:return!1
case 1:case 2:case 3:x=d.a
if(!(x<0)){w=d.b
x=w<0||x+v.E$.gu().a>v.gu().a||w+v.E$.gu().b>v.gu().b}else x=!0
return x}},
aY(d,e){var x,w,v,u,t,s=this
if(s.E$!=null){x=s.S.at
x.toString
w=s.wU(x)
x=new B.aOQ(s,w)
v=s.aa
if(s.Yy(w)){u=s.cx
u===$&&A.a()
t=s.gu()
v.saV(d.m8(u,e,new A.C(0,0,0+t.a,0+t.b),x,s.a0,v.a))}else{v.saV(null)
x.$2(d,e)}}},
l(){this.aa.saV(null)
this.fA()},
dS(d,e){var x,w=this.S.at
w.toString
x=this.wU(w)
e.eq(x.a,x.b,0,1)},
ol(d){var x=this,w=x.S.at
w.toString
w=x.Yy(x.wU(w))
if(w){w=x.gu()
return new A.C(0,0,0+w.a,0+w.b)}return null},
d6(d,e){var x,w=this
if(w.E$!=null){x=w.S.at
x.toString
return d.kd(new B.aOP(w),w.wU(x),e)}return!1},
rE(d,e,f,g){var x,w,v,u,t,s,r,q,p,o,n=this,m=null
A.bf(n.n)
if(g==null)g=d.gm5()
if(!(d instanceof A.y)){x=n.S.at
x.toString
return new D.uQ(x,g)}w=A.el(d.bg(n.E$),g)
v=n.E$.gu()
switch(n.n.a){case 0:x=w.d
x=new A.iD(n.gu().b,v.b-x,x-w.b)
break
case 3:x=w.c
x=new A.iD(n.gu().a,v.a-x,x-w.a)
break
case 1:x=w.a
x=new A.iD(n.gu().a,x,w.c-x)
break
case 2:x=w.b
x=new A.iD(n.gu().b,x,w.d-x)
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
return new D.uQ(o,w.e7(n.wU(o)))},
Gt(d,e,f){return this.rE(d,e,null,f)},
f7(d,e,f,g){this.S2(d,null,f,D.b5N(d,e,f,this.S,g,this))},
vM(){return this.f7(C.b5,null,C.r,null)},
vN(d){return this.f7(C.b5,null,d,null)},
pw(d){return this.f7(C.b5,null,C.r,d)},
rS(d,e,f){return this.f7(d,null,e,f)},
px(d,e){return this.f7(C.b5,d,C.r,e)},
MQ(d){var x,w,v=this,u=v.gBF(),t=v.S.at
t.toString
x=u-t
switch(v.n.a){case 0:v.gu()
v.gu()
u=v.gu()
t=v.gu()
w=v.S.at
w.toString
return new A.C(0,0-x,0+u.a,0+t.b+w)
case 1:v.gu()
u=v.S.at
u.toString
v.gu()
return new A.C(0-u,0,0+v.gu().a+x,0+v.gu().b)
case 2:v.gu()
v.gu()
u=v.S.at
u.toString
return new A.C(0,0-u,0+v.gu().a,0+v.gu().b+x)
case 3:v.gu()
v.gu()
u=v.gu()
t=v.S.at
t.toString
return new A.C(0-x,0,0+u.a+t,0+v.gu().b)}},
$iHb:1}
B.OJ.prototype={
aK(d){var x
this.ej(d)
x=this.E$
if(x!=null)x.aK(d)},
ar(){this.e9()
var x=this.E$
if(x!=null)x.ar()}}
B.ace.prototype={}
B.acf.prototype={}
var z=a.updateTypes(["z(z)","Bx(E,jn)","~()","~({curve:f1,descendant:D?,duration:ap,rect:C?})"])
B.azF.prototype={
$2(d,e){return new B.Bx(this.c,e,C.D,this.a.a,null)},
$S:z+1}
B.azG.prototype={
$1(d){var x,w=A.aYr(this.a)
if(d.d!=null&&!w.gj3()&&w.gcj()){x=$.ab.aD$.d.c
if(x!=null)x.iG()}return!1},
$S:168}
B.aOQ.prototype={
$2(d,e){var x=this.a.E$
x.toString
d.eg(x,e.a8(0,this.b))},
$S:28}
B.aOP.prototype={
$2(d,e){return this.a.E$.d5(d,e)},
$S:18};(function aliases(){var x=B.OJ.prototype
x.ac0=x.aK
x.ac1=x.ar})();(function installTearOffs(){var x=a._instance_0u,w=a._instance_1u,v=a.installInstanceTearOff
var u
x(u=B.MO.prototype,"gBs","am0",2)
w(u,"gc4","bF",0)
w(u,"gbM","bD",0)
w(u,"gc3","bE",0)
w(u,"gcb","bC",0)
v(u,"grR",0,0,null,["$4$curve$descendant$duration$rect","$0","$1$duration","$1$rect","$3$curve$duration$rect","$2$descendant$rect"],["f7","vM","vN","pw","rS","px"],3,0,0)})();(function inheritance(){var x=a.mixinHard,w=a.mixin,v=a.inherit,u=a.inheritMany
v(B.zq,A.a9)
u(A.f_,[B.azF,B.aOQ,B.aOP])
v(B.azG,A.db)
v(B.Bx,A.aV)
v(B.ace,A.zp)
v(B.acf,B.ace)
v(B.a9w,B.acf)
v(B.OJ,A.y)
v(B.MO,B.OJ)
x(B.OJ,A.aU)
w(B.ace,A.Gy)
w(B.acf,D.a0E)})()
A.dy(b.typeUniverse,JSON.parse('{"zq":{"a9":[],"f":[]},"Bx":{"aV":[],"ar":[],"f":[]},"a9w":{"b8":[],"aG":[],"E":[]},"MO":{"y":[],"aU":["y"],"Hb":[],"D":[],"as":[]}}'))
var y={a:A.P("a2"),b:A.P("dB<k1>")};(function constants(){E.qA=new D.pb(null,C.a5,null)
E.cx=new A.h_(C.Q,null,null,E.qA,null)})()};
(a=>{a["tBAZ8HpUONUrDIButfXN+9eR2wg="]=a.current})($__dart_deferred_initializers__);