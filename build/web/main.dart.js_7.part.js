((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,D,F,B={
FW(d,e,f){return new B.xI(f,e,d,null)},
xI:function xI(d,e,f,g){var _=this
_.c=d
_.f=e
_.x=f
_.a=g},
auC:function auC(d,e,f){this.a=d
this.b=e
this.c=f},
auD:function auD(d){this.a=d},
zD:function zD(d,e,f,g,h){var _=this
_.e=d
_.f=e
_.r=f
_.c=g
_.a=h},
a6u:function a6u(d,e){var _=this
_.c=_.b=_.a=_.CW=_.ay=_.p1=null
_.d=$
_.e=d
_.r=_.f=null
_.w=e
_.z=_.y=null
_.Q=!1
_.as=!0
_.at=!1},
Ko:function Ko(d,e,f,g,h,i,j){var _=this
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
aIH:function aIH(d,e){this.a=d
this.b=e},
aIG:function aIG(d){this.a=d},
Mh:function Mh(){},
a98:function a98(){},
a99:function a99(){}},E
A=c[0]
C=c[2]
D=c[31]
F=c[39]
B=a.updateHolder(c[23],B)
E=c[48]
B.xI.prototype={
K(d){var x,w,v,u,t=this,s=null,r={},q=t.c,p=D.b25(d,q,!1)
r.a=t.x
x=t.f==null&&D.aYU(d,q)
w=x?A.EF(d):t.f
v=D.aSE(p,C.C,w,C.ai,!1,C.aS,s,s,s,s,s,new B.auC(r,t,p))
u=A.n8(d).F1(d)
if(u===F.J5)v=new A.dl(new B.auD(d),v,s,y.b)
return x&&w!=null?D.aYT(v):v}}
B.zD.prototype={
b0(d){var x=new B.Ko(this.e,this.f,this.r,A.an(),null,new A.aO(),A.an())
x.b_()
x.sbl(null)
return x},
bb(d,e){var x
e.sdP(this.e)
e.sd1(this.f)
x=this.r
if(x!==e.a0){e.a0=x
e.aN()
e.bm()}},
cj(){return new B.a6u(this,C.ab)}}
B.a6u.prototype={}
B.Ko.prototype={
sdP(d){if(d===this.p)return
this.p=d
this.ad()},
sd1(d){var x=this,w=x.R
if(d===w)return
if(x.y!=null)w.N(x.gAe())
x.R=d
if(x.y!=null)d.a4(x.gAe())
x.ad()},
ajm(){this.aN()
this.bm()},
f3(d){if(!(d.b instanceof A.cG))d.b=new A.cG()},
aK(d){this.a9L(d)
this.R.a4(this.gAe())},
ao(){this.R.N(this.gAe())
this.a9M()},
gfp(){return!0},
gap8(){switch(A.bf(this.p).a){case 0:var x=this.gt().a
break
case 1:x=this.gt().b
break
default:x=null}return x},
gAq(){var x=this,w=x.u$
if(w==null)return 0
switch(A.bf(x.p).a){case 0:w=w.gt().a-x.gt().a
break
case 1:w=w.gt().b-x.gt().b
break
default:w=null}return Math.max(0,A.jN(w))},
Tj(d){var x
switch(A.bf(this.p).a){case 0:x=new A.a_(0,1/0,d.c,d.d)
break
case 1:x=new A.a_(d.a,d.b,0,1/0)
break
default:x=null}return x},
bB(d){var x=this.u$
x=x==null?null:x.aA(C.aT,d,x.gc2())
return x==null?0:x},
bt(d){var x=this.u$
x=x==null?null:x.aA(C.ar,d,x.gbJ())
return x==null?0:x},
bA(d){var x=this.u$
x=x==null?null:x.aA(C.aU,d,x.gc1())
return x==null?0:x},
bs(d){var x=this.u$
x=x==null?null:x.aA(C.bd,d,x.gcb())
return x==null?0:x},
cQ(d){var x=this.u$
if(x==null)return new A.F(A.H(0,d.a,d.b),A.H(0,d.c,d.d))
return d.bp(x.aA(C.Q,this.Tj(d),x.gcw()))},
bT(){var x,w,v=this,u=y.a.a(A.B.prototype.ga7.call(v)),t=v.u$
if(t==null)v.fy=new A.F(A.H(0,u.a,u.b),A.H(0,u.c,u.d))
else{t.cI(v.Tj(u),!0)
v.fy=u.bp(v.u$.gt())}t=v.R.at
if(t!=null)if(t>v.gAq()){t=v.R
x=v.gAq()
w=v.R.at
w.toString
t.L5(x-w)}else{t=v.R
x=t.at
x.toString
if(x<0)t.L5(0-x)}v.R.wC(v.gap8())
v.R.tf(0,v.gAq())},
w8(d){var x,w=this
switch(w.p.a){case 0:x=new A.c(0,d-w.u$.gt().b+w.gt().b)
break
case 3:x=new A.c(d-w.u$.gt().a+w.gt().a,0)
break
case 1:x=new A.c(-d,0)
break
case 2:x=new A.c(0,-d)
break
default:x=null}return x},
WM(d){var x,w,v=this
switch(v.a0.a){case 0:return!1
case 1:case 2:case 3:x=d.a
if(!(x<0)){w=d.b
x=w<0||x+v.u$.gt().a>v.gt().a||w+v.u$.gt().b>v.gt().b}else x=!0
return x}},
aT(d,e){var x,w,v,u,t,s=this
if(s.u$!=null){x=s.R.at
x.toString
w=s.w8(x)
x=new B.aIH(s,w)
v=s.a8
if(s.WM(w)){u=s.cx
u===$&&A.a()
t=s.gt()
v.saS(d.lK(u,e,new A.x(0,0,0+t.a,0+t.b),x,s.a0,v.a))}else{v.saS(null)
x.$2(d,e)}}},
l(){this.a8.saS(null)
this.fg()},
dG(d,e){var x,w=this.R.at
w.toString
x=this.w8(w)
e.eb(x.a,x.b,0,1)},
nS(d){var x=this,w=x.R.at
w.toString
w=x.WM(x.w8(w))
if(w){w=x.gt()
return new A.x(0,0,0+w.a,0+w.b)}return null},
d_(d,e){var x,w=this
if(w.u$!=null){x=w.R.at
x.toString
return d.jO(new B.aIG(w),w.w8(x),e)}return!1},
r0(d,e,f,g){var x,w,v,u,t,s,r,q,p,o,n=this,m=null
A.bf(n.p)
if(g==null)g=d.glH()
if(!(d instanceof A.y)){x=n.R.at
x.toString
return new D.tv(x,g)}w=A.dY(d.bc(n.u$),g)
v=n.u$.gt()
switch(n.p.a){case 0:x=w.d
x=new A.i5(n.gt().b,v.b-x,x-w.b)
break
case 3:x=w.c
x=new A.i5(n.gt().a,v.a-x,x-w.a)
break
case 1:x=w.a
x=new A.i5(n.gt().a,x,w.c-x)
break
case 2:x=w.b
x=new A.i5(n.gt().b,x,w.d-x)
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
return new D.tv(o,w.dZ(n.w8(o)))},
F5(d,e,f){return this.r0(d,e,null,f)},
eP(d,e,f,g){this.Qr(d,null,f,D.aZj(d,e,f,this.R,g,this))},
v_(){return this.eP(C.b6,null,C.r,null)},
v0(d){return this.eP(C.b6,null,d,null)},
oW(d){return this.eP(C.b6,null,C.r,d)},
rd(d,e,f){return this.eP(d,null,e,f)},
oX(d,e){return this.eP(C.b6,d,C.r,e)},
Lm(d){var x,w,v=this,u=v.gAq(),t=v.R.at
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
$iEQ:1}
B.Mh.prototype={
aK(d){var x
this.ed(d)
x=this.u$
if(x!=null)x.aK(d)},
ao(){this.e3()
var x=this.u$
if(x!=null)x.ao()}}
B.a98.prototype={}
B.a99.prototype={}
var z=a.updateTypes(["w(w)","zD(J,iN)","~()","~({curve:eI,descendant:B?,duration:am,rect:x?})"])
B.auC.prototype={
$2(d,e){return new B.zD(this.c,e,C.C,this.a.a,null)},
$S:z+1}
B.auD.prototype={
$1(d){var x,w=A.aRK(this.a)
if(d.d!=null&&!w.giJ()&&w.gc9()){x=$.ac.av$.d.c
if(x!=null)x.im()}return!1},
$S:213}
B.aIH.prototype={
$2(d,e){var x=this.a.u$
x.toString
d.e2(x,e.a6(0,this.b))},
$S:24}
B.aIG.prototype={
$2(d,e){return this.a.u$.cW(d,e)},
$S:17};(function aliases(){var x=B.Mh.prototype
x.a9L=x.aK
x.a9M=x.ao})();(function installTearOffs(){var x=a._instance_0u,w=a._instance_1u,v=a.installInstanceTearOff
var u
x(u=B.Ko.prototype,"gAe","ajm",2)
w(u,"gc2","bB",0)
w(u,"gbJ","bt",0)
w(u,"gc1","bA",0)
w(u,"gcb","bs",0)
v(u,"grb",0,0,null,["$4$curve$descendant$duration$rect","$0","$1$duration","$1$rect","$3$curve$duration$rect","$2$descendant$rect"],["eP","v_","v0","oW","rd","oX"],3,0,0)})();(function inheritance(){var x=a.mixinHard,w=a.mixin,v=a.inherit,u=a.inheritMany
v(B.xI,A.ab)
u(A.eV,[B.auC,B.aIH,B.aIG])
v(B.auD,A.dj)
v(B.zD,A.aS)
v(B.a98,A.xH)
v(B.a99,B.a98)
v(B.a6u,B.a99)
v(B.Mh,A.y)
v(B.Ko,B.Mh)
x(B.Mh,A.aP)
w(B.a98,A.Ee)
w(B.a99,D.YN)})()
A.dH(b.typeUniverse,JSON.parse('{"xI":{"ab":[],"f":[]},"zD":{"aS":[],"ao":[],"f":[]},"a6u":{"b4":[],"aF":[],"J":[]},"Ko":{"y":[],"aP":["y"],"EQ":[],"B":[],"ap":[]}}'))
var y={a:A.R("a_"),b:A.R("dl<js>")};(function constants(){E.q4=new D.ok(null,C.ag,null)
E.cL=new A.fg(C.L,null,null,E.q4,null)})()};
(a=>{a["srgsiAComeSzPDuRl/JvFhINrpg="]=a.current})($__dart_deferred_initializers__);