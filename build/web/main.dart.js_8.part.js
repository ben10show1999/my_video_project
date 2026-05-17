((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,D,E,B={
yt(d,e,f,g){return new B.ys(g,f,e,d,null)},
ys:function ys(d,e,f,g,h){var _=this
_.c=d
_.e=e
_.f=f
_.x=g
_.a=h},
awu:function awu(d,e,f){this.a=d
this.b=e
this.c=f},
awv:function awv(d){this.a=d},
Ap:function Ap(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.r=f
_.c=g
_.a=h},
a7A:function a7A(d,e){var _=this
_.c=_.b=_.a=_.CW=_.ay=_.p1=null
_.d=$
_.e=d
_.r=_.f=null
_.w=e
_.z=_.y=null
_.Q=!1
_.as=!0
_.at=!1},
Lh:function Lh(d,e,f,g,h,i,j){var _=this
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
aKP:function aKP(d,e){this.a=d
this.b=e},
aKO:function aKO(d){this.a=d},
Nc:function Nc(){},
aaf:function aaf(){},
aag:function aag(){}}
A=c[0]
C=c[2]
D=c[30]
E=c[38]
B=a.updateHolder(c[26],B)
B.ys.prototype={
K(d){var x,w,v,u,t,s=this,r=null,q={},p=s.c,o=D.aRR(d,p,!1),n=s.x
q.a=n
x=s.e
if(x!=null)q.a=new A.bq(x,n,r)
w=s.f==null&&D.b0H(d,p)
v=w?A.Ft(d):s.f
u=D.aV5(o,C.D,v,C.ag,!1,C.aX,r,r,r,r,r,new B.awu(q,s,o))
t=A.nx(d).Fy(d)
if(t===E.Jn)u=new A.ds(new B.awv(d),u,r,y.b)
return w&&v!=null?D.b0G(u):u}}
B.Ap.prototype={
aW(d){var x=new B.Lh(this.e,this.f,this.r,A.an(),null,new A.aN(),A.an())
x.aV()
x.sbo(null)
return x},
bd(d,e){var x
e.sdE(this.e)
e.sd6(this.f)
x=this.r
if(x!==e.a0){e.a0=x
e.aP()
e.br()}},
cq(){return new B.a7A(this,C.ae)}}
B.a7A.prototype={}
B.Lh.prototype={
sdE(d){if(d===this.p)return
this.p=d
this.ac()},
sd6(d){var x=this,w=x.R
if(d===w)return
if(x.y!=null)w.O(x.gAH())
x.R=d
if(x.y!=null)d.a3(x.gAH())
x.ac()},
aku(){this.aP()
this.br()},
eV(d){if(!(d.b instanceof A.cJ))d.b=new A.cJ()},
aK(d){this.aaS(d)
this.R.a3(this.gAH())},
ap(){this.R.O(this.gAH())
this.aaT()},
gfz(){return!0},
gasJ(){switch(A.ba(this.p).a){case 0:var x=this.gt().a
break
case 1:x=this.gt().b
break
default:x=null}return x},
gAU(){var x=this,w=x.v$
if(w==null)return 0
switch(A.ba(x.p).a){case 0:w=w.gt().a-x.gt().a
break
case 1:w=w.gt().b-x.gt().b
break
default:w=null}return Math.max(0,A.j0(w))},
U3(d){var x
switch(A.ba(this.p).a){case 0:x=new A.Z(0,1/0,d.c,d.d)
break
case 1:x=new A.Z(d.a,d.b,0,1/0)
break
default:x=null}return x},
bA(d){var x=this.v$
x=x==null?null:x.au(C.aL,d,x.gc_())
return x==null?0:x},
bx(d){var x=this.v$
x=x==null?null:x.au(C.ak,d,x.gbH())
return x==null?0:x},
bz(d){var x=this.v$
x=x==null?null:x.au(C.aM,d,x.gbZ())
return x==null?0:x},
bw(d){var x=this.v$
x=x==null?null:x.au(C.b2,d,x.gc8())
return x==null?0:x},
cP(d){var x=this.v$
if(x==null)return new A.E(A.I(0,d.a,d.b),A.I(0,d.c,d.d))
return d.bp(x.au(C.M,this.U3(d),x.gck()))},
bS(){var x,w,v=this,u=y.a.a(A.B.prototype.ga6.call(v)),t=v.v$
if(t==null)v.fy=new A.E(A.I(0,u.a,u.b),A.I(0,u.c,u.d))
else{t.cu(v.U3(u),!0)
v.fy=u.bp(v.v$.gt())}t=v.R.at
if(t!=null)if(t>v.gAU()){t=v.R
x=v.gAU()
w=v.R.at
w.toString
t.LF(x-w)}else{t=v.R
x=t.at
x.toString
if(x<0)t.LF(0-x)}v.R.wX(v.gasJ())
v.R.tF(0,v.gAU())},
wu(d){var x,w=this
switch(w.p.a){case 0:x=new A.c(0,d-w.v$.gt().b+w.gt().b)
break
case 3:x=new A.c(d-w.v$.gt().a+w.gt().a,0)
break
case 1:x=new A.c(-d,0)
break
case 2:x=new A.c(0,-d)
break
default:x=null}return x},
XC(d){var x,w,v=this
switch(v.a0.a){case 0:return!1
case 1:case 2:case 3:x=d.a
if(!(x<0)){w=d.b
x=w<0||x+v.v$.gt().a>v.gt().a||w+v.v$.gt().b>v.gt().b}else x=!0
return x}},
aU(d,e){var x,w,v,u,t,s=this
if(s.v$!=null){x=s.R.at
x.toString
w=s.wu(x)
x=new B.aKP(s,w)
v=s.a8
if(s.XC(w)){u=s.cx
u===$&&A.a()
t=s.gt()
v.saT(d.lY(u,e,new A.z(0,0,0+t.a,0+t.b),x,s.a0,v.a))}else{v.saT(null)
x.$2(d,e)}}},
l(){this.a8.saT(null)
this.fn()},
dN(d,e){var x,w=this.R.at
w.toString
x=this.wu(w)
e.ei(x.a,x.b,0,1)},
oc(d){var x=this,w=x.R.at
w.toString
w=x.XC(x.wu(w))
if(w){w=x.gt()
return new A.z(0,0,0+w.a,0+w.b)}return null},
d3(d,e){var x,w=this
if(w.v$!=null){x=w.R.at
x.toString
return d.jX(new B.aKO(w),w.wu(x),e)}return!1},
ri(d,e,f,g){var x,w,v,u,t,s,r,q,p,o,n=this,m=null
A.ba(n.p)
if(g==null)g=d.glU()
if(!(d instanceof A.x)){x=n.R.at
x.toString
return new D.u_(x,g)}w=A.e4(d.bf(n.v$),g)
v=n.v$.gt()
switch(n.p.a){case 0:x=w.d
x=new A.ij(n.gt().b,v.b-x,x-w.b)
break
case 3:x=w.c
x=new A.ij(n.gt().a,v.a-x,x-w.a)
break
case 1:x=w.a
x=new A.ij(n.gt().a,x,w.c-x)
break
case 2:x=w.b
x=new A.ij(n.gt().b,x,w.d-x)
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
return new D.u_(o,w.e2(n.wu(o)))},
FC(d,e,f){return this.ri(d,e,null,f)},
eX(d,e,f,g){this.R5(d,null,f,D.b18(d,e,f,this.R,g,this))},
vm(){return this.eX(C.b5,null,C.r,null)},
pf(d){return this.eX(C.b5,null,C.r,d)},
rv(d,e,f){return this.eX(d,null,e,f)},
vn(d){return this.eX(C.b5,null,d,null)},
pg(d,e){return this.eX(C.b5,d,C.r,e)},
LX(d){var x,w,v=this,u=v.gAU(),t=v.R.at
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
$iFF:1}
B.Nc.prototype={
aK(d){var x
this.ea(d)
x=this.v$
if(x!=null)x.aK(d)},
ap(){this.e4()
var x=this.v$
if(x!=null)x.ap()}}
B.aaf.prototype={}
B.aag.prototype={}
var z=a.updateTypes(["w(w)","Ap(G,iW)","~()","~({curve:eN,descendant:B?,duration:am,rect:z?})"])
B.awu.prototype={
$2(d,e){return new B.Ap(this.c,e,C.D,this.a.a,null)},
$S:z+1}
B.awv.prototype={
$1(d){var x,w=A.aU8(this.a)
if(d.d!=null&&!w.giY()&&w.gc6()){x=$.aa.aA$.d.c
if(x!=null)x.iA()}return!1},
$S:191}
B.aKP.prototype={
$2(d,e){var x=this.a.v$
x.toString
d.e9(x,e.a7(0,this.b))},
$S:26}
B.aKO.prototype={
$2(d,e){return this.a.v$.d2(d,e)},
$S:15};(function aliases(){var x=B.Nc.prototype
x.aaS=x.aK
x.aaT=x.ap})();(function installTearOffs(){var x=a._instance_0u,w=a._instance_1u,v=a.installInstanceTearOff
var u
x(u=B.Lh.prototype,"gAH","aku",2)
w(u,"gc_","bA",0)
w(u,"gbH","bx",0)
w(u,"gbZ","bz",0)
w(u,"gc8","bw",0)
v(u,"gru",0,0,null,["$4$curve$descendant$duration$rect","$0","$1$rect","$3$curve$duration$rect","$1$duration","$2$descendant$rect"],["eX","vm","pf","rv","vn","pg"],3,0,0)})();(function inheritance(){var x=a.mixinHard,w=a.mixin,v=a.inherit,u=a.inheritMany
v(B.ys,A.ac)
u(A.fm,[B.awu,B.aKP,B.aKO])
v(B.awv,A.d8)
v(B.Ap,A.aS)
v(B.aaf,A.yr)
v(B.aag,B.aaf)
v(B.a7A,B.aag)
v(B.Nc,A.x)
v(B.Lh,B.Nc)
x(B.Nc,A.aR)
w(B.aaf,A.F3)
w(B.aag,D.ZO)})()
A.dG(b.typeUniverse,JSON.parse('{"ys":{"ac":[],"f":[]},"Ap":{"aS":[],"ao":[],"f":[]},"a7A":{"b4":[],"aG":[],"G":[]},"Lh":{"x":[],"aR":["x"],"FF":[],"B":[],"ap":[]}}'))
var y={a:A.T("Z"),b:A.T("ds<jF>")}};
(a=>{a["05uOWRtNU1z8MH8TBfVd5Vky9ks="]=a.current})($__dart_deferred_initializers__);