((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,D,F,B={
za(d,e,f,g){return new B.z9(g,f,e,d,null)},
z9:function z9(d,e,f,g,h){var _=this
_.c=d
_.e=e
_.f=f
_.x=g
_.a=h},
aye:function aye(d,e,f){this.a=d
this.b=e
this.c=f},
ayf:function ayf(d){this.a=d},
B7:function B7(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.r=f
_.c=g
_.a=h},
a8J:function a8J(d,e){var _=this
_.c=_.b=_.a=_.CW=_.ay=_.p1=null
_.d=$
_.e=d
_.r=_.f=null
_.w=e
_.z=_.y=null
_.Q=!1
_.as=!0
_.at=!1},
Me:function Me(d,e,f,g,h,i,j){var _=this
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
aME:function aME(d,e){this.a=d
this.b=e},
aMD:function aMD(d){this.a=d},
O9:function O9(){},
abo:function abo(){},
abp:function abp(){}},E
A=c[0]
C=c[2]
D=c[30]
F=c[38]
B=a.updateHolder(c[26],B)
E=c[47]
B.z9.prototype={
K(d){var x,w,v,u,t,s=this,r=null,q={},p=s.c,o=D.aTL(d,p,!1),n=s.x
q.a=n
x=s.e
if(x!=null)q.a=new A.bs(x,n,r)
w=s.f==null&&D.b2U(d,p)
v=w?A.Gp(d):s.f
u=D.aX6(o,C.D,v,C.ag,!1,C.aX,r,r,r,r,r,new B.aye(q,s,o))
t=A.nL(d).FM(d)
if(t===F.Jx)u=new A.dy(new B.ayf(d),u,r,y.b)
return w&&v!=null?D.b2T(u):u}}
B.B7.prototype={
aX(d){var x=new B.Me(this.e,this.f,this.r,A.ao(),null,new A.aQ(),A.ao())
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
cs(){return new B.a8J(this,C.ae)}}
B.a8J.prototype={}
B.Me.prototype={
sdI(d){if(d===this.p)return
this.p=d
this.ac()},
sd9(d){var x=this,w=x.T
if(d===w)return
if(x.y!=null)w.O(x.gAS())
x.T=d
if(x.y!=null)d.a3(x.gAS())
x.ac()},
akX(){this.aP()
this.bs()},
eZ(d){if(!(d.b instanceof A.cK))d.b=new A.cK()},
aK(d){this.abh(d)
this.T.a3(this.gAS())},
aq(){this.T.O(this.gAS())
this.abi()},
gfE(){return!0},
gata(){switch(A.bd(this.p).a){case 0:var x=this.gu().a
break
case 1:x=this.gu().b
break
default:x=null}return x},
gB4(){var x=this,w=x.v$
if(w==null)return 0
switch(A.bd(x.p).a){case 0:w=w.gu().a-x.gu().a
break
case 1:w=w.gu().b-x.gu().b
break
default:w=null}return Math.max(0,A.ji(w))},
Ul(d){var x
switch(A.bd(this.p).a){case 0:x=new A.a1(0,1/0,d.c,d.d)
break
case 1:x=new A.a1(d.a,d.b,0,1/0)
break
default:x=null}return x},
bD(d){var x=this.v$
x=x==null?null:x.av(C.aL,d,x.gc2())
return x==null?0:x},
by(d){var x=this.v$
x=x==null?null:x.av(C.ak,d,x.gbK())
return x==null?0:x},
bC(d){var x=this.v$
x=x==null?null:x.av(C.aM,d,x.gc1())
return x==null?0:x},
bx(d){var x=this.v$
x=x==null?null:x.av(C.b2,d,x.gca())
return x==null?0:x},
cS(d){var x=this.v$
if(x==null)return new A.F(A.I(0,d.a,d.b),A.I(0,d.c,d.d))
return d.bq(x.av(C.M,this.Ul(d),x.gcm()))},
bV(){var x,w,v=this,u=y.a.a(A.C.prototype.ga6.call(v)),t=v.v$
if(t==null)v.fy=new A.F(A.I(0,u.a,u.b),A.I(0,u.c,u.d))
else{t.cw(v.Ul(u),!0)
v.fy=u.bq(v.v$.gu())}t=v.T.at
if(t!=null)if(t>v.gB4()){t=v.T
x=v.gB4()
w=v.T.at
w.toString
t.LV(x-w)}else{t=v.T
x=t.at
x.toString
if(x<0)t.LV(0-x)}v.T.x4(v.gata())
v.T.tI(0,v.gB4())},
wB(d){var x,w=this
switch(w.p.a){case 0:x=new A.c(0,d-w.v$.gu().b+w.gu().b)
break
case 3:x=new A.c(d-w.v$.gu().a+w.gu().a,0)
break
case 1:x=new A.c(-d,0)
break
case 2:x=new A.c(0,-d)
break
default:x=null}return x},
XW(d){var x,w,v=this
switch(v.a0.a){case 0:return!1
case 1:case 2:case 3:x=d.a
if(!(x<0)){w=d.b
x=w<0||x+v.v$.gu().a>v.gu().a||w+v.v$.gu().b>v.gu().b}else x=!0
return x}},
aV(d,e){var x,w,v,u,t,s=this
if(s.v$!=null){x=s.T.at
x.toString
w=s.wB(x)
x=new B.aME(s,w)
v=s.a9
if(s.XW(w)){u=s.cx
u===$&&A.a()
t=s.gu()
v.saU(d.m1(u,e,new A.A(0,0,0+t.a,0+t.b),x,s.a0,v.a))}else{v.saU(null)
x.$2(d,e)}}},
l(){this.a9.saU(null)
this.ft()},
dQ(d,e){var x,w=this.T.at
w.toString
x=this.wB(w)
e.eo(x.a,x.b,0,1)},
oh(d){var x=this,w=x.T.at
w.toString
w=x.XW(x.wB(w))
if(w){w=x.gu()
return new A.A(0,0,0+w.a,0+w.b)}return null},
d6(d,e){var x,w=this
if(w.v$!=null){x=w.T.at
x.toString
return d.k0(new B.aMD(w),w.wB(x),e)}return!1},
rn(d,e,f,g){var x,w,v,u,t,s,r,q,p,o,n=this,m=null
A.bd(n.p)
if(g==null)g=d.glY()
if(!(d instanceof A.z)){x=n.T.at
x.toString
return new D.uv(x,g)}w=A.eb(d.bf(n.v$),g)
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
return new D.uv(o,w.e5(n.wB(o)))},
FQ(d,e,f){return this.rn(d,e,null,f)},
f0(d,e,f,g){this.Rq(d,null,f,D.b3k(d,e,f,this.T,g,this))},
vs(){return this.f0(C.b4,null,C.r,null)},
pm(d){return this.f0(C.b4,null,C.r,d)},
rB(d,e,f){return this.f0(d,null,e,f)},
vt(d){return this.f0(C.b4,null,d,null)},
pn(d,e){return this.f0(C.b4,d,C.r,e)},
Md(d){var x,w,v=this,u=v.gB4(),t=v.T.at
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
$iGB:1}
B.O9.prototype={
aK(d){var x
this.ee(d)
x=this.v$
if(x!=null)x.aK(d)},
aq(){this.e7()
var x=this.v$
if(x!=null)x.aq()}}
B.abo.prototype={}
B.abp.prototype={}
var z=a.updateTypes(["y(y)","B7(G,jc)","~()","~({curve:eV,descendant:C?,duration:an,rect:A?})"])
B.aye.prototype={
$2(d,e){return new B.B7(this.c,e,C.D,this.a.a,null)},
$S:z+1}
B.ayf.prototype={
$1(d){var x,w=A.aW7(this.a)
if(d.d!=null&&!w.gj0()&&w.gc8()){x=$.aa.aA$.d.c
if(x!=null)x.iG()}return!1},
$S:207}
B.aME.prototype={
$2(d,e){var x=this.a.v$
x.toString
d.ec(x,e.a7(0,this.b))},
$S:26}
B.aMD.prototype={
$2(d,e){return this.a.v$.d5(d,e)},
$S:18};(function aliases(){var x=B.O9.prototype
x.abh=x.aK
x.abi=x.aq})();(function installTearOffs(){var x=a._instance_0u,w=a._instance_1u,v=a.installInstanceTearOff
var u
x(u=B.Me.prototype,"gAS","akX",2)
w(u,"gc2","bD",0)
w(u,"gbK","by",0)
w(u,"gc1","bC",0)
w(u,"gca","bx",0)
v(u,"grA",0,0,null,["$4$curve$descendant$duration$rect","$0","$1$rect","$3$curve$duration$rect","$1$duration","$2$descendant$rect"],["f0","vs","pm","rB","vt","pn"],3,0,0)})();(function inheritance(){var x=a.mixinHard,w=a.mixin,v=a.inherit,u=a.inheritMany
v(B.z9,A.ad)
u(A.f7,[B.aye,B.aME,B.aMD])
v(B.ayf,A.d4)
v(B.B7,A.aU)
v(B.abo,A.z8)
v(B.abp,B.abo)
v(B.a8J,B.abp)
v(B.O9,A.z)
v(B.Me,B.O9)
x(B.O9,A.aT)
w(B.abo,A.G_)
w(B.abp,D.a_V)})()
A.dB(b.typeUniverse,JSON.parse('{"z9":{"ad":[],"f":[]},"B7":{"aU":[],"ap":[],"f":[]},"a8J":{"b7":[],"aG":[],"G":[]},"Me":{"z":[],"aT":["z"],"GB":[],"C":[],"aq":[]}}'))
var y={a:A.R("a1"),b:A.R("dy<jR>")};(function constants(){E.qs=new D.p1(null,C.a4,null)
E.ct=new A.fQ(C.P,null,null,E.qs,null)})()};
(a=>{a["KkfLg7uVAWHwegMTPQEC5aKuLNI="]=a.current})($__dart_deferred_initializers__);