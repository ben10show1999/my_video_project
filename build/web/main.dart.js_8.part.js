((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,D,F,B={
zb(d,e,f,g){return new B.za(g,f,e,d,null)},
za:function za(d,e,f,g,h){var _=this
_.c=d
_.e=e
_.f=f
_.x=g
_.a=h},
ayf:function ayf(d,e,f){this.a=d
this.b=e
this.c=f},
ayg:function ayg(d){this.a=d},
B9:function B9(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.r=f
_.c=g
_.a=h},
a8M:function a8M(d,e){var _=this
_.c=_.b=_.a=_.CW=_.ay=_.p1=null
_.d=$
_.e=d
_.r=_.f=null
_.w=e
_.z=_.y=null
_.Q=!1
_.as=!0
_.at=!1},
Mg:function Mg(d,e,f,g,h,i,j){var _=this
_.p=d
_.T=e
_.a0=f
_.a9=g
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
aMI:function aMI(d,e){this.a=d
this.b=e},
aMH:function aMH(d){this.a=d},
Ob:function Ob(){},
abr:function abr(){},
abs:function abs(){}},E
A=c[0]
C=c[2]
D=c[30]
F=c[38]
B=a.updateHolder(c[26],B)
E=c[47]
B.za.prototype={
K(d){var x,w,v,u,t,s=this,r=null,q={},p=s.c,o=D.aTP(d,p,!1),n=s.x
q.a=n
x=s.e
if(x!=null)q.a=new A.bs(x,n,r)
w=s.f==null&&D.b3_(d,p)
v=w?A.Gr(d):s.f
u=D.aXb(o,C.D,v,C.ag,!1,C.aX,r,r,r,r,r,new B.ayf(q,s,o))
t=A.nO(d).FQ(d)
if(t===F.Jx)u=new A.dy(new B.ayg(d),u,r,y.b)
return w&&v!=null?D.b2Z(u):u}}
B.B9.prototype={
aX(d){var x=new B.Mg(this.e,this.f,this.r,A.ao(),null,new A.aQ(),A.ao())
x.aW()
x.sbp(null)
return x},
bd(d,e){var x
e.sdI(this.e)
e.sd9(this.f)
x=this.r
if(x!==e.a0){e.a0=x
e.aP()
e.bs()}},
cs(){return new B.a8M(this,C.ae)}}
B.a8M.prototype={}
B.Mg.prototype={
sdI(d){if(d===this.p)return
this.p=d
this.ac()},
sd9(d){var x=this,w=x.T
if(d===w)return
if(x.y!=null)w.O(x.gAV())
x.T=d
if(x.y!=null)d.a3(x.gAV())
x.ac()},
al2(){this.aP()
this.bs()},
f_(d){if(!(d.b instanceof A.cK))d.b=new A.cK()},
aL(d){this.abl(d)
this.T.a3(this.gAV())},
ar(){this.T.O(this.gAV())
this.abm()},
gfE(){return!0},
gatg(){switch(A.bd(this.p).a){case 0:var x=this.gu().a
break
case 1:x=this.gu().b
break
default:x=null}return x},
gB7(){var x=this,w=x.v$
if(w==null)return 0
switch(A.bd(x.p).a){case 0:w=w.gu().a-x.gu().a
break
case 1:w=w.gu().b-x.gu().b
break
default:w=null}return Math.max(0,A.jk(w))},
Up(d){var x
switch(A.bd(this.p).a){case 0:x=new A.a1(0,1/0,d.c,d.d)
break
case 1:x=new A.a1(d.a,d.b,0,1/0)
break
default:x=null}return x},
bD(d){var x=this.v$
x=x==null?null:x.aw(C.aL,d,x.gc2())
return x==null?0:x},
by(d){var x=this.v$
x=x==null?null:x.aw(C.ak,d,x.gbK())
return x==null?0:x},
bC(d){var x=this.v$
x=x==null?null:x.aw(C.aM,d,x.gc1())
return x==null?0:x},
bx(d){var x=this.v$
x=x==null?null:x.aw(C.b2,d,x.gca())
return x==null?0:x},
cS(d){var x=this.v$
if(x==null)return new A.F(A.I(0,d.a,d.b),A.I(0,d.c,d.d))
return d.bq(x.aw(C.M,this.Up(d),x.gcn()))},
bV(){var x,w,v=this,u=y.a.a(A.C.prototype.ga6.call(v)),t=v.v$
if(t==null)v.fy=new A.F(A.I(0,u.a,u.b),A.I(0,u.c,u.d))
else{t.cw(v.Up(u),!0)
v.fy=u.bq(v.v$.gu())}t=v.T.at
if(t!=null)if(t>v.gB7()){t=v.T
x=v.gB7()
w=v.T.at
w.toString
t.LZ(x-w)}else{t=v.T
x=t.at
x.toString
if(x<0)t.LZ(0-x)}v.T.x5(v.gatg())
v.T.tM(0,v.gB7())},
wC(d){var x,w=this
switch(w.p.a){case 0:x=new A.c(0,d-w.v$.gu().b+w.gu().b)
break
case 3:x=new A.c(d-w.v$.gu().a+w.gu().a,0)
break
case 1:x=new A.c(-d,0)
break
case 2:x=new A.c(0,-d)
break
default:x=null}return x},
Y_(d){var x,w,v=this
switch(v.a0.a){case 0:return!1
case 1:case 2:case 3:x=d.a
if(!(x<0)){w=d.b
x=w<0||x+v.v$.gu().a>v.gu().a||w+v.v$.gu().b>v.gu().b}else x=!0
return x}},
aV(d,e){var x,w,v,u,t,s=this
if(s.v$!=null){x=s.T.at
x.toString
w=s.wC(x)
x=new B.aMI(s,w)
v=s.a9
if(s.Y_(w)){u=s.cx
u===$&&A.a()
t=s.gu()
v.saU(d.m2(u,e,new A.A(0,0,0+t.a,0+t.b),x,s.a0,v.a))}else{v.saU(null)
x.$2(d,e)}}},
l(){this.a9.saU(null)
this.ft()},
dQ(d,e){var x,w=this.T.at
w.toString
x=this.wC(w)
e.eo(x.a,x.b,0,1)},
oh(d){var x=this,w=x.T.at
w.toString
w=x.Y_(x.wC(w))
if(w){w=x.gu()
return new A.A(0,0,0+w.a,0+w.b)}return null},
d6(d,e){var x,w=this
if(w.v$!=null){x=w.T.at
x.toString
return d.k0(new B.aMH(w),w.wC(x),e)}return!1},
rr(d,e,f,g){var x,w,v,u,t,s,r,q,p,o,n=this,m=null
A.bd(n.p)
if(g==null)g=d.glZ()
if(!(d instanceof A.z)){x=n.T.at
x.toString
return new D.ux(x,g)}w=A.eb(d.bf(n.v$),g)
v=n.v$.gu()
switch(n.p.a){case 0:x=w.d
x=new A.iy(n.gu().b,v.b-x,x-w.b)
break
case 3:x=w.c
x=new A.iy(n.gu().a,v.a-x,x-w.a)
break
case 1:x=w.a
x=new A.iy(n.gu().a,x,w.c-x)
break
case 2:x=w.b
x=new A.iy(n.gu().b,x,w.d-x)
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
return new D.ux(o,w.e5(n.wC(o)))},
FU(d,e,f){return this.rr(d,e,null,f)},
f1(d,e,f,g){this.Ru(d,null,f,D.b3r(d,e,f,this.T,g,this))},
vu(){return this.f1(C.b4,null,C.r,null)},
po(d){return this.f1(C.b4,null,C.r,d)},
rF(d,e,f){return this.f1(d,null,e,f)},
vv(d){return this.f1(C.b4,null,d,null)},
pp(d,e){return this.f1(C.b4,d,C.r,e)},
Mh(d){var x,w,v=this,u=v.gB7(),t=v.T.at
t.toString
x=u-t
switch(v.p.a){case 0:v.gu()
v.gu()
u=v.gu()
t=v.gu()
w=v.T.at
w.toString
return new A.A(0,0-x,0+u.a,0+t.b+w)
case 1:v.gu()
u=v.T.at
u.toString
v.gu()
return new A.A(0-u,0,0+v.gu().a+x,0+v.gu().b)
case 2:v.gu()
v.gu()
u=v.T.at
u.toString
return new A.A(0,0-u,0+v.gu().a,0+v.gu().b+x)
case 3:v.gu()
v.gu()
u=v.gu()
t=v.T.at
t.toString
return new A.A(0-x,0,0+u.a+t,0+v.gu().b)}},
$iGD:1}
B.Ob.prototype={
aL(d){var x
this.ee(d)
x=this.v$
if(x!=null)x.aL(d)},
ar(){this.e7()
var x=this.v$
if(x!=null)x.ar()}}
B.abr.prototype={}
B.abs.prototype={}
var z=a.updateTypes(["y(y)","B9(G,je)","~()","~({curve:eV,descendant:C?,duration:an,rect:A?})"])
B.ayf.prototype={
$2(d,e){return new B.B9(this.c,e,C.D,this.a.a,null)},
$S:z+1}
B.ayg.prototype={
$1(d){var x,w=A.aWb(this.a)
if(d.d!=null&&!w.gj0()&&w.gc8()){x=$.aa.aA$.d.c
if(x!=null)x.iG()}return!1},
$S:207}
B.aMI.prototype={
$2(d,e){var x=this.a.v$
x.toString
d.ec(x,e.a7(0,this.b))},
$S:26}
B.aMH.prototype={
$2(d,e){return this.a.v$.d5(d,e)},
$S:18};(function aliases(){var x=B.Ob.prototype
x.abl=x.aL
x.abm=x.ar})();(function installTearOffs(){var x=a._instance_0u,w=a._instance_1u,v=a.installInstanceTearOff
var u
x(u=B.Mg.prototype,"gAV","al2",2)
w(u,"gc2","bD",0)
w(u,"gbK","by",0)
w(u,"gc1","bC",0)
w(u,"gca","bx",0)
v(u,"grE",0,0,null,["$4$curve$descendant$duration$rect","$0","$1$rect","$3$curve$duration$rect","$1$duration","$2$descendant$rect"],["f1","vu","po","rF","vv","pp"],3,0,0)})();(function inheritance(){var x=a.mixinHard,w=a.mixin,v=a.inherit,u=a.inheritMany
v(B.za,A.ad)
u(A.f8,[B.ayf,B.aMI,B.aMH])
v(B.ayg,A.d5)
v(B.B9,A.aU)
v(B.abr,A.z9)
v(B.abs,B.abr)
v(B.a8M,B.abs)
v(B.Ob,A.z)
v(B.Mg,B.Ob)
x(B.Ob,A.aT)
w(B.abr,A.G1)
w(B.abs,D.a_Z)})()
A.dB(b.typeUniverse,JSON.parse('{"za":{"ad":[],"f":[]},"B9":{"aU":[],"ap":[],"f":[]},"a8M":{"b7":[],"aG":[],"G":[]},"Mg":{"z":[],"aT":["z"],"GD":[],"C":[],"aq":[]}}'))
var y={a:A.R("a1"),b:A.R("dy<jT>")};(function constants(){E.qt=new D.p3(null,C.a4,null)
E.ct=new A.fT(C.P,null,null,E.qt,null)})()};
(a=>{a["JVnCXgj/XsXvRcSOy6CH8Piakl4="]=a.current})($__dart_deferred_initializers__);