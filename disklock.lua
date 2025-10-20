local ecc = (function () local function a(b)if type(b)=="table"then return string.char(unpack(b))else return tostring(b)end end;local c={__tostring=a,__index={toHex=function(self)return("%02x"):rep(#self):format(unpack(self))end,isEqual=function(self,b)if type(b)~="table"then return false end;if#self~=#b then return false end;local d=0;for e=1,#self do d=bit32.bor(d,bit32.bxor(self[e],b[e]))end;return d==0 end}}local function f(g)return setmetatable({g:byte(1,-1)},c)end;local h=(function()local i=2^32;local j=bit32 and bit32.band or bit.band;local k=bit32 and bit32.bnot or bit.bnot;local l=bit32 and bit32.bxor or bit.bxor;local m=bit32 and bit32.lshift or bit.blshift;local n=unpack;local function o(p,q)local g=p/2^q;local r=g%1;return g-r+r*i end;local function s(t,u)local g=t/2^u;return g-g%1 end;local v={0x6a09e667,0xbb67ae85,0x3c6ef372,0xa54ff53a,0x510e527f,0x9b05688c,0x1f83d9ab,0x5be0cd19}local w={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function x(y)local z,A=0,0;if 0xFFFFFFFF-z<y then A=A+1;z=y-(0xFFFFFFFF-z)-1 else z=z+y end;return A,z end;local function B(C,e)return m(C[e]or 0,24)+m(C[e+1]or 0,16)+m(C[e+2]or 0,8)+(C[e+3]or 0)end;local function D(E)local F=#E;local G={}E[#E+1]=0x80;while#E%64~=56 do E[#E+1]=0 end;local H=math.ceil(#E/64)for e=1,H do G[e]={}for I=1,16 do G[e][I]=B(E,1+(e-1)*64+(I-1)*4)end end;G[H][15],G[H][16]=x(F*8)return G end;local function J(K,L)for I=17,64 do local M=l(l(o(K[I-15],7),o(K[I-15],18)),s(K[I-15],3))local N=l(l(o(K[I-2],17),o(K[I-2],19)),s(K[I-2],10))K[I]=(K[I-16]+M+K[I-7]+N)%i end;local O,q,P,Q,R,r,S,T=n(L)for I=1,64 do local U=l(l(o(R,6),o(R,11)),o(R,25))local V=l(j(R,r),j(k(R),S))local W=(T+U+V+w[I]+K[I])%i;local X=l(l(o(O,2),o(O,13)),o(O,22))local Y=l(l(j(O,q),j(O,P)),j(q,P))local Z=(X+Y)%i;T,S,r,R,Q,P,q,O=S,r,R,(Q+W)%i,P,q,O,(W+Z)%i end;L[1]=(L[1]+O)%i;L[2]=(L[2]+q)%i;L[3]=(L[3]+P)%i;L[4]=(L[4]+Q)%i;L[5]=(L[5]+R)%i;L[6]=(L[6]+r)%i;L[7]=(L[7]+S)%i;L[8]=(L[8]+T)%i;return L end;local function _(b,p)local q={}for e=1,p do q[(e-1)*4+1]=j(s(b[e],24),0xFF)q[(e-1)*4+2]=j(s(b[e],16),0xFF)q[(e-1)*4+3]=j(s(b[e],8),0xFF)q[(e-1)*4+4]=j(b[e],0xFF)end;return setmetatable(q,c)end;local function a0(E)E=D(f(a(E or"")))local L={n(v)}for e=1,#E do L=J(E[e],L)end;return _(L,8)end;local function a1(E,a2)E=f(a(E))a2=a(a2)local a3=64;a2=#a2>a3 and a0(a2)or f(a2)local a4={}local a5={}local a6={}for e=1,a3 do a4[e]=l(0x36,a2[e]or 0)a5[e]=l(0x5C,a2[e]or 0)end;for e=1,#E do a4[a3+e]=E[e]end;a4=a0(a4)for e=1,a3 do a6[e]=a5[e]a6[a3+e]=a4[e]end;return a0(a6)end;local function a7(a8,a9,aa,ab)a9=f(a(a9))local ac=32;aa=tonumber(aa)or 1000;ab=tonumber(ab)or 32;local ad=1;local ae={}while ab>0 do local af={}local ag={n(a9)}local ah=ab>ac and ac or ab;ag[#ag+1]=j(s(ad,24),0xFF)ag[#ag+1]=j(s(ad,16),0xFF)ag[#ag+1]=j(s(ad,8),0xFF)ag[#ag+1]=j(ad,0xFF)for I=1,aa do ag=a1(ag,a(a8))for ai=1,ah do af[ai]=l(ag[ai],af[ai]or 0)end;if I%200==0 then os.queueEvent("PBKDF2",I)coroutine.yield("PBKDF2")end end;ab=ab-ah;ad=ad+1;for ai=1,ah do ae[#ae+1]=af[ai]end end;return setmetatable(ae,c)end;return{digest=a0,hmac=a1,pbkdf2=a7}end)()local aj=(function()local l=bit32.bxor;local j=bit32.band;local m=bit32.lshift;local s=bit32.arshift;local ak=2^32;local al={("expand 16-byte k"):byte(1,-1)}local am={("expand 32-byte k"):byte(1,-1)}local function an(p,q)local g=p/2^(32-q)local r=g%1;return g-r+r*ak end;local function ao(g,O,q,P,Q)g[O]=(g[O]+g[q])%ak;g[Q]=an(l(g[Q],g[O]),16)g[P]=(g[P]+g[Q])%ak;g[q]=an(l(g[q],g[P]),12)g[O]=(g[O]+g[q])%ak;g[Q]=an(l(g[Q],g[O]),8)g[P]=(g[P]+g[Q])%ak;g[q]=an(l(g[q],g[P]),7)return g end;local function ap(aq,ar)local g={unpack(aq)}for e=1,ar do local as=e%2==1;g=as and ao(g,1,5,9,13)or ao(g,1,6,11,16)g=as and ao(g,2,6,10,14)or ao(g,2,7,12,13)g=as and ao(g,3,7,11,15)or ao(g,3,8,9,14)g=as and ao(g,4,8,12,16)or ao(g,4,5,10,15)end;for e=1,16 do g[e]=(g[e]+aq[e])%ak end;return g end;local function at(C,e)return(C[e+1]or 0)+m(C[e+2]or 0,8)+m(C[e+3]or 0,16)+m(C[e+4]or 0,24)end;local function au(a2,av,x)local aw=#a2==32;local ax=aw and am or al;local aq={}aq[1]=at(ax,0)aq[2]=at(ax,4)aq[3]=at(ax,8)aq[4]=at(ax,12)aq[5]=at(a2,0)aq[6]=at(a2,4)aq[7]=at(a2,8)aq[8]=at(a2,12)aq[9]=at(a2,aw and 16 or 0)aq[10]=at(a2,aw and 20 or 4)aq[11]=at(a2,aw and 24 or 8)aq[12]=at(a2,aw and 28 or 12)aq[13]=x;aq[14]=at(av,0)aq[15]=at(av,4)aq[16]=at(av,8)return aq end;local function ay(aq)local as={}for e=1,16 do as[#as+1]=j(aq[e],0xFF)as[#as+1]=j(s(aq[e],8),0xFF)as[#as+1]=j(s(aq[e],16),0xFF)as[#as+1]=j(s(aq[e],24),0xFF)end;return as end;local function az(E,a2,av,aA,aB)E=f(a(E))a2=f(a(a2))av=f(a(av))assert(#a2==16 or#a2==32,"ChaCha20: Invalid key length ("..#a2 .."), must be 16 or 32")assert(#av==12,"ChaCha20: Invalid nonce length ("..#av.."), must be 12")aA=tonumber(aA)or 1;aB=tonumber(aB)or 20;local ae={}local aq=au(a2,av,aA)local aC=math.floor(#E/64)for e=0,aC do local aD=ay(ap(aq,aB))aq[13]=(aq[13]+1)%ak;local ad={}for I=1,64 do ad[I]=E[e*64+I]end;for I=1,#ad do ae[#ae+1]=l(ad[I],aD[I])end;if e%1000==0 then os.queueEvent("")os.pullEvent("")end end;return setmetatable(ae,c)end;return{crypt=az}end)()local aE=(function()local aF=""local aG=""local aH="/.random"local function aI(E)aG=aG..(E or"")end;local function a0()aF=tostring(h.digest(aF..aG))aG=""end;if fs.exists(aH)then local aJ=fs.open(aH,"rb")aI(aJ.readAll())aJ.close()end;aI("init")aI(tostring(math.random(1,2^31-1)))aI("|")aI(tostring(math.random(1,2^31-1)))aI("|")aI(tostring(math.random(1,2^4)))aI("|")aI(tostring(os.epoch("utc")))aI("|")aI(tostring({}))aI(tostring({}))a0()aI(tostring(os.epoch("utc")))a0()local aK={}local aL="function()return{"..("e'utc',"):rep(256).."}end"local aM=assert(load("local e=os.epoch return "..aL))()for e=1,300 do while true do local b=aM()local z=b[1]if z~=b[256]then for I=1,256 do if z~=b[I]then aK[e]=I-1;break end end;break end end end;aI(a(aK))a0()local function aN()aI("save")aI(tostring(os.epoch("utc")))aI(tostring({}))a0()local aJ=fs.open(aH,"wb")aJ.write(tostring(h.hmac("save",aF)))aF=tostring(h.digest(aF))aJ.close()end;aN()local function aO(E)aI("seed")aI(tostring(os.epoch("utc")))aI(tostring({}))aI(a(E))a0()aN()end;local function aE()aI("random")aI(tostring(os.epoch("utc")))aI(tostring({}))a0()aN()local aP=h.hmac("out",aF)aF=tostring(h.digest(aF))return aP end;return{seed=aO,save=aN,random=aE}end)()local aQ=(function()local function aR(O,q)return O[1]==q[1]and O[2]==q[2]and O[3]==q[3]and O[4]==q[4]and O[5]==q[5]and O[6]==q[6]and O[7]==q[7]end;local function aS(O,q)for e=7,1,-1 do if O[e]>q[e]then return 1 elseif O[e]<q[e]then return-1 end end;return 0 end;local function aT(O,q)local aU=O[1]+q[1]local aV=O[2]+q[2]local aW=O[3]+q[3]local aX=O[4]+q[4]local aY=O[5]+q[5]local aZ=O[6]+q[6]local a_=O[7]+q[7]if aU>0xffffff then aV=aV+1;aU=aU-0x1000000 end;if aV>0xffffff then aW=aW+1;aV=aV-0x1000000 end;if aW>0xffffff then aX=aX+1;aW=aW-0x1000000 end;if aX>0xffffff then aY=aY+1;aX=aX-0x1000000 end;if aY>0xffffff then aZ=aZ+1;aY=aY-0x1000000 end;if aZ>0xffffff then a_=a_+1;aZ=aZ-0x1000000 end;return{aU,aV,aW,aX,aY,aZ,a_}end;local function b0(O,q)local aU=O[1]-q[1]local aV=O[2]-q[2]local aW=O[3]-q[3]local aX=O[4]-q[4]local aY=O[5]-q[5]local aZ=O[6]-q[6]local a_=O[7]-q[7]if aU<0 then aV=aV-1;aU=aU+0x1000000 end;if aV<0 then aW=aW-1;aV=aV+0x1000000 end;if aW<0 then aX=aX-1;aW=aW+0x1000000 end;if aX<0 then aY=aY-1;aX=aX+0x1000000 end;if aY<0 then aZ=aZ-1;aY=aY+0x1000000 end;if aZ<0 then a_=a_-1;aZ=aZ+0x1000000 end;return{aU,aV,aW,aX,aY,aZ,a_}end;local function b1(O)local aU=O[1]local aV=O[2]local aW=O[3]local aX=O[4]local aY=O[5]local aZ=O[6]local a_=O[7]aU=aU/2;aU=aU-aU%1;aU=aU+aV%2*0x800000;aV=aV/2;aV=aV-aV%1;aV=aV+aW%2*0x800000;aW=aW/2;aW=aW-aW%1;aW=aW+aX%2*0x800000;aX=aX/2;aX=aX-aX%1;aX=aX+aY%2*0x800000;aY=aY/2;aY=aY-aY%1;aY=aY+aZ%2*0x800000;aZ=aZ/2;aZ=aZ-aZ%1;aZ=aZ+a_%2*0x800000;a_=a_/2;a_=a_-a_%1;return{aU,aV,aW,aX,aY,aZ,a_}end;local function b2(O,q)local aU=O[1]+q[1]local aV=O[2]+q[2]local aW=O[3]+q[3]local aX=O[4]+q[4]local aY=O[5]+q[5]local aZ=O[6]+q[6]local a_=O[7]+q[7]local b3=O[8]+q[8]local b4=O[9]+q[9]local b5=O[10]+q[10]local b6=O[11]+q[11]local b7=O[12]+q[12]local b8=O[13]+q[13]local b9=O[14]+q[14]if aU>0xffffff then aV=aV+1;aU=aU-0x1000000 end;if aV>0xffffff then aW=aW+1;aV=aV-0x1000000 end;if aW>0xffffff then aX=aX+1;aW=aW-0x1000000 end;if aX>0xffffff then aY=aY+1;aX=aX-0x1000000 end;if aY>0xffffff then aZ=aZ+1;aY=aY-0x1000000 end;if aZ>0xffffff then a_=a_+1;aZ=aZ-0x1000000 end;if a_>0xffffff then b3=b3+1;a_=a_-0x1000000 end;if b3>0xffffff then b4=b4+1;b3=b3-0x1000000 end;if b4>0xffffff then b5=b5+1;b4=b4-0x1000000 end;if b5>0xffffff then b6=b6+1;b5=b5-0x1000000 end;if b6>0xffffff then b7=b7+1;b6=b6-0x1000000 end;if b7>0xffffff then b8=b8+1;b7=b7-0x1000000 end;if b8>0xffffff then b9=b9+1;b8=b8-0x1000000 end;return{aU,aV,aW,aX,aY,aZ,a_,b3,b4,b5,b6,b7,b8,b9}end;local function ba(O,q,bb)local bc,bd,be,bf,bg,bh,bi=unpack(O)local bj,bk,bl,bm,bn,bo,bp=unpack(q)local aU=bc*bj;local aV=bc*bk+bd*bj;local aW=bc*bl+bd*bk+be*bj;local aX=bc*bm+bd*bl+be*bk+bf*bj;local aY=bc*bn+bd*bm+be*bl+bf*bk+bg*bj;local aZ=bc*bo+bd*bn+be*bm+bf*bl+bg*bk+bh*bj;local a_=bc*bp+bd*bo+be*bn+bf*bm+bg*bl+bh*bk+bi*bj;local b3,b4,b5,b6,b7,b8,b9;if not bb then b3=bd*bp+be*bo+bf*bn+bg*bm+bh*bl+bi*bk;b4=be*bp+bf*bo+bg*bn+bh*bm+bi*bl;b5=bf*bp+bg*bo+bh*bn+bi*bm;b6=bg*bp+bh*bo+bi*bn;b7=bh*bp+bi*bo;b8=bi*bp;b9=0 else b3=0 end;local bq;bq=aU;aU=aU%0x1000000;aV=aV+(bq-aU)/0x1000000;bq=aV;aV=aV%0x1000000;aW=aW+(bq-aV)/0x1000000;bq=aW;aW=aW%0x1000000;aX=aX+(bq-aW)/0x1000000;bq=aX;aX=aX%0x1000000;aY=aY+(bq-aX)/0x1000000;bq=aY;aY=aY%0x1000000;aZ=aZ+(bq-aY)/0x1000000;bq=aZ;aZ=aZ%0x1000000;a_=a_+(bq-aZ)/0x1000000;bq=a_;a_=a_%0x1000000;if not bb then b3=b3+(bq-a_)/0x1000000;bq=b3;b3=b3%0x1000000;b4=b4+(bq-b3)/0x1000000;bq=b4;b4=b4%0x1000000;b5=b5+(bq-b4)/0x1000000;bq=b5;b5=b5%0x1000000;b6=b6+(bq-b5)/0x1000000;bq=b6;b6=b6%0x1000000;b7=b7+(bq-b6)/0x1000000;bq=b7;b7=b7%0x1000000;b8=b8+(bq-b7)/0x1000000;bq=b8;b8=b8%0x1000000;b9=b9+(bq-b8)/0x1000000 end;return{aU,aV,aW,aX,aY,aZ,a_,b3,b4,b5,b6,b7,b8,b9}end;local function br(O)local bc,bd,be,bf,bg,bh,bi=unpack(O)local aU=bc*bc;local aV=bc*bd*2;local aW=bc*be*2+bd*bd;local aX=bc*bf*2+bd*be*2;local aY=bc*bg*2+bd*bf*2+be*be;local aZ=bc*bh*2+bd*bg*2+be*bf*2;local a_=bc*bi*2+bd*bh*2+be*bg*2+bf*bf;local b3=bd*bi*2+be*bh*2+bf*bg*2;local b4=be*bi*2+bf*bh*2+bg*bg;local b5=bf*bi*2+bg*bh*2;local b6=bg*bi*2+bh*bh;local b7=bh*bi*2;local b8=bi*bi;local b9=0;local bq;bq=aU;aU=aU%0x1000000;aV=aV+(bq-aU)/0x1000000;bq=aV;aV=aV%0x1000000;aW=aW+(bq-aV)/0x1000000;bq=aW;aW=aW%0x1000000;aX=aX+(bq-aW)/0x1000000;bq=aX;aX=aX%0x1000000;aY=aY+(bq-aX)/0x1000000;bq=aY;aY=aY%0x1000000;aZ=aZ+(bq-aY)/0x1000000;bq=aZ;aZ=aZ%0x1000000;a_=a_+(bq-aZ)/0x1000000;bq=a_;a_=a_%0x1000000;b3=b3+(bq-a_)/0x1000000;bq=b3;b3=b3%0x1000000;b4=b4+(bq-b3)/0x1000000;bq=b4;b4=b4%0x1000000;b5=b5+(bq-b4)/0x1000000;bq=b5;b5=b5%0x1000000;b6=b6+(bq-b5)/0x1000000;bq=b6;b6=b6%0x1000000;b7=b7+(bq-b6)/0x1000000;bq=b7;b7=b7%0x1000000;b8=b8+(bq-b7)/0x1000000;bq=b8;b8=b8%0x1000000;b9=b9+(bq-b8)/0x1000000;return{aU,aV,aW,aX,aY,aZ,a_,b3,b4,b5,b6,b7,b8,b9}end;local function bs(O)local bt={}for e=1,7 do local bu=O[e]for I=1,3 do bt[#bt+1]=bu%256;bu=math.floor(bu/256)end end;return bt end;local function bv(bt)local O={}local bw={}for e=1,21 do local bx=bt[e]assert(type(bx)=="number","integer decoding failure")assert(bx>=0 and bx<=255,"integer decoding failure")assert(bx%1==0,"integer decoding failure")bw[e]=bx end;for e=1,21,3 do local bu=0;for I=2,0,-1 do bu=bu*256;bu=bu+bw[e+I]end;O[#O+1]=bu end;return O end;local function by(Q,K)local aP=Q[1]%2^K;if aP>=2^(K-1)then aP=aP-2^K end;return aP end;local function bz(Q,K)local b={}local Q={unpack(Q)}for bA=1,168 do if Q[1]%2==1 then b[#b+1]=by(Q,K)Q=b0(Q,{b[#b],0,0,0,0,0,0})else b[#b+1]=0 end;Q=b1(Q)end;return b end;return{isEqual=aR,compare=aS,add=aT,sub=b0,addDouble=b2,mult=ba,square=br,encodeInt=bs,decodeInt=bv,NAF=bz}end)()local bB=(function()local aT=aQ.add;local b0=aQ.sub;local b2=aQ.addDouble;local ba=aQ.mult;local br=aQ.square;local bC={3,0,0,0,0,0,15761408}local bD={5592405,5592405,5592405,5592405,5592405,5592405,14800213}local bE={13533400,837116,6278376,13533388,837116,6278376,7504076}local function bF(O)local bc,bd,be,bf,bg,bh,bi=unpack(O)local aU=bc*3;local aV=bd*3;local aW=be*3;local aX=bf*3;local aY=bg*3;local aZ=bh*3;local a_=bc*15761408;a_=a_+bi*3;local b3=bd*15761408;local b4=be*15761408;local b5=bf*15761408;local b6=bg*15761408;local b7=bh*15761408;local b8=bi*15761408;local b9=0;local bq;bq=aU/0x1000000;aV=aV+bq-bq%1;aU=aU%0x1000000;bq=aV/0x1000000;aW=aW+bq-bq%1;aV=aV%0x1000000;bq=aW/0x1000000;aX=aX+bq-bq%1;aW=aW%0x1000000;bq=aX/0x1000000;aY=aY+bq-bq%1;aX=aX%0x1000000;bq=aY/0x1000000;aZ=aZ+bq-bq%1;aY=aY%0x1000000;bq=aZ/0x1000000;a_=a_+bq-bq%1;aZ=aZ%0x1000000;bq=a_/0x1000000;b3=b3+bq-bq%1;a_=a_%0x1000000;bq=b3/0x1000000;b4=b4+bq-bq%1;b3=b3%0x1000000;bq=b4/0x1000000;b5=b5+bq-bq%1;b4=b4%0x1000000;bq=b5/0x1000000;b6=b6+bq-bq%1;b5=b5%0x1000000;bq=b6/0x1000000;b7=b7+bq-bq%1;b6=b6%0x1000000;bq=b7/0x1000000;b8=b8+bq-bq%1;b7=b7%0x1000000;bq=b8/0x1000000;b9=b9+bq-bq%1;b8=b8%0x1000000;return{aU,aV,aW,aX,aY,aZ,a_,b3,b4,b5,b6,b7,b8,b9}end;local function bG(O)if O[7]<15761408 or O[7]==15761408 and O[1]<3 then return{unpack(O)}end;local aU=O[1]local aV=O[2]local aW=O[3]local aX=O[4]local aY=O[5]local aZ=O[6]local a_=O[7]aU=aU-3;a_=a_-15761408;if aU<0 then aV=aV-1;aU=aU+0x1000000 end;if aV<0 then aW=aW-1;aV=aV+0x1000000 end;if aW<0 then aX=aX-1;aW=aW+0x1000000 end;if aX<0 then aY=aY-1;aX=aX+0x1000000 end;if aY<0 then aZ=aZ-1;aY=aY+0x1000000 end;if aZ<0 then a_=a_-1;aZ=aZ+0x1000000 end;return{aU,aV,aW,aX,aY,aZ,a_}end;local function bH(O,q)return bG(aT(O,q))end;local function bI(O,q)local aP=b0(O,q)if aP[7]<0 then aP=aT(aP,bC)end;return aP end;local function bJ(bK)local bL=ba(bK,bD,true)local b={unpack(b2(bK,bF(bL)),8,14)}return bG(b)end;local function bM(O,q)return bJ(ba(O,q))end;local function bN(O)return bJ(br(O))end;local function bO(O)return bM(O,bE)end;local function bP(O)O={unpack(O)}for e=8,14 do O[e]=0 end;return bJ(O)end;local bQ=bO({1,0,0,0,0,0,0})local function bR(bS,bT)bS={unpack(bS)}local aP={unpack(bQ)}for e=1,168 do if bT[e]==1 then aP=bM(aP,bS)end;bS=bN(bS)end;return aP end;return{addModP=bH,subModP=bI,multModP=bM,squareModP=bN,montgomeryModP=bO,inverseMontgomeryModP=bP,expModP=bR}end)()local bU=(function()local aR=aQ.isEqual;local aS=aQ.compare;local aT=aQ.add;local b0=aQ.sub;local b2=aQ.addDouble;local ba=aQ.mult;local br=aQ.square;local bs=aQ.encodeInt;local bv=aQ.decodeInt;local bV;local bW={9622359,6699217,13940450,16775734,16777215,16777215,3940351}local bX={1,0,1,0,1,0,1,0,1,1,0,0,1,0,1,1,0,1,0,0,1,0,0,1,1,0,0,0,1,0,1,1,0,0,0,1,1,1,0,0,0,1,1,0,0,1,1,0,0,1,0,0,0,1,1,1,0,1,1,0,1,1,0,1,0,0,1,0,1,0,1,1,0,1,1,0,1,1,0,0,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,1}local bY={15218585,5740955,3271338,9903997,9067368,7173545,6988392}local bE={1336213,11071705,9716828,11083885,9188643,1494868,3306114}local function bZ(O)local aP={unpack(O)}if aS(aP,bW)>=0 then aP=b0(aP,bW)end;return setmetatable(aP,bV)end;local function b_(O,q)return bZ(aT(O,q))end;local function c0(O,q)local aP=b0(O,q)if aP[7]<0 then aP=aT(aP,bW)end;return setmetatable(aP,bV)end;local function bJ(bK)local bL={unpack(ba({unpack(bK,1,7)},bY,true),1,7)}local b={unpack(b2(bK,ba(bL,bW)),8,14)}return bZ(b)end;local function c1(O,q)return bJ(ba(O,q))end;local function c2(O)return bJ(br(O))end;local function c3(O)return c1(O,bE)end;local function c4(O)local O={unpack(O)}for e=8,14 do O[e]=0 end;return bJ(O)end;local bQ=c3({1,0,0,0,0,0,0})local function c5(bS,bT)local bS={unpack(bS)}local aP={unpack(bQ)}for e=1,168 do if bT[e]==1 then aP=c1(aP,bS)end;bS=c2(bS)end;return aP end;local function c6(bS,c7)local bS={unpack(bS)}local aP=setmetatable({unpack(bQ)},bV)if c7<0 then bS=c5(bS,bX)c7=-c7 end;while c7>0 do if c7%2==1 then aP=c1(aP,bS)end;bS=c2(bS)c7=c7/2;c7=c7-c7%1 end;return aP end;local function c8(O)local aP=bs(O)return setmetatable(aP,c)end;local function c9(g)local aP=bv(f(a(g):sub(1,21)))aP[7]=aP[7]%bW[7]return setmetatable(aP,bV)end;local function ca()while true do local g={unpack(aE.random(),1,21)}local aP=bv(g)if aP[7]<bW[7]then return setmetatable(aP,bV)end end end;local function cb(E)return c9(h.digest(E))end;bV={__index={encode=function(self)return c8(self)end},__tostring=function(self)return self:encode():toHex()end,__add=function(self,cc)if type(self)=="number"then return cc+self end;if type(cc)=="number"then assert(cc<2^24,"number operand too big")cc=c3({cc,0,0,0,0,0,0})end;return b_(self,cc)end,__sub=function(O,q)if type(O)=="number"then assert(O<2^24,"number operand too big")O=c3({O,0,0,0,0,0,0})end;if type(q)=="number"then assert(q<2^24,"number operand too big")q=c3({q,0,0,0,0,0,0})end;return c0(O,q)end,__unm=function(self)return c0(bW,self)end,__eq=function(self,cc)return aR(self,cc)end,__mul=function(self,cc)if type(self)=="number"then return cc*self end;if type(cc)=="table"and type(cc[1])=="table"then return cc*self end;if type(cc)=="number"then assert(cc<2^24,"number operand too big")cc=c3({cc,0,0,0,0,0,0})end;return c1(self,cc)end,__div=function(O,q)if type(O)=="number"then assert(O<2^24,"number operand too big")O=c3({O,0,0,0,0,0,0})end;if type(q)=="number"then assert(q<2^24,"number operand too big")q=c3({q,0,0,0,0,0,0})end;local cd=c5(q,bX)return c1(O,cd)end,__pow=function(self,cc)return c6(self,cc)end}return{hashModQ=cb,randomModQ=ca,decodeModQ=c9,inverseMontgomeryModQ=c4}end)()local ce=(function()local aR=aQ.isEqual;local bz=aQ.NAF;local bs=aQ.encodeInt;local bv=aQ.decodeInt;local bM=bB.multModP;local bN=bB.squareModP;local bH=bB.addModP;local bI=bB.subModP;local bO=bB.montgomeryModP;local bR=bB.expModP;local c4=bU.inverseMontgomeryModQ;local cf;local cg={0,0,0,0,0,0,0}local bQ=bO({1,0,0,0,0,0,0})local Q=bO({122,0,0,0,0,0,0})local bC={3,0,0,0,0,0,15761408}local ch={1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,1,1,1}local ci={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,1,1,1}local cj={{6636044,10381432,15741790,2914241,5785600,264923,4550291},{13512827,8449886,5647959,1135556,5489843,7177356,8002203},{unpack(bQ)}}local ck={{unpack(cg)},{unpack(bQ)},{unpack(bQ)}}local function cl(cm)local cn,co,cp=unpack(cm)local q=bH(cn,co)local cq=bN(q)local L=bN(cn)local cr=bN(co)local cs=bH(L,cr)local v=bN(cp)local ct=bI(cs,bH(v,v))local cu=bM(bI(cq,cs),ct)local cv=bM(cs,bI(L,cr))local cw=bM(cs,ct)local cx={cu,cv,cw}return setmetatable(cx,cf)end;local function cy(cm,cz)local cn,co,cp=unpack(cm)local cA,cB,cC=unpack(cz)local cD=bM(cp,cC)local cq=bN(cD)local L=bM(cn,cA)local cr=bM(co,cB)local cs=bM(Q,bM(L,cr))local cE=bI(cq,cs)local cj=bH(cq,cs)local cu=bM(cD,bM(cE,bI(bM(bH(cn,co),bH(cA,cB)),bH(L,cr))))local cv=bM(cD,bM(cj,bI(cr,L)))local cw=bM(cE,cj)local cx={cu,cv,cw}return setmetatable(cx,cf)end;local function cF(cm)local cn,co,cp=unpack(cm)local cu=bI(cg,cn)local cv={unpack(co)}local cw={unpack(cp)}local cx={cu,cv,cw}return setmetatable(cx,cf)end;local function cG(cm,cz)return cy(cm,cF(cz))end;local function cH(cm)local cn,co,cp=unpack(cm)local cD=bR(cp,ch)local cu=bM(cn,cD)local cv=bM(co,cD)local cw={unpack(bQ)}local cx={cu,cv,cw}return setmetatable(cx,cf)end;local function cI(cm,cz)local cn,co,cp=unpack(cm)local cA,cB,cC=unpack(cz)local cJ=bM(cn,cC)local cK=bM(co,cC)local cL=bM(cA,cp)local cM=bM(cB,cp)return aR(cJ,cL)and aR(cK,cM)end;local function cN(cm)local cn,co,cp=unpack(cm)local cO=bN(cn)local cP=bN(co)local cQ=bN(cp)local cR=bN(cQ)local O=bH(cO,cP)O=bM(O,cQ)local q=bM(Q,bM(cO,cP))q=bH(cR,q)return aR(O,q)end;local function cS(cm)return aR(cm[1],cg)end;local function cT(cU,cm)local cV=bz(cU,5)local cW={cm}local cz=cl(cm)local cX={{unpack(cg)},{unpack(bQ)},{unpack(bQ)}}for e=3,31,2 do cW[e]=cy(cW[e-2],cz)end;for e=#cV,1,-1 do cX=cl(cX)if cV[e]>0 then cX=cy(cX,cW[cV[e]])elseif cV[e]<0 then cX=cG(cX,cW[-cV[e]])end end;return setmetatable(cX,cf)end;local cY={cj}for e=2,168 do cY[e]=cl(cY[e-1])end;local function cZ(cU)local cV=bz(cU,2)local cX={{unpack(cg)},{unpack(bQ)},{unpack(bQ)}}for e=1,168 do if cV[e]==1 then cX=cy(cX,cY[e])elseif cV[e]==-1 then cX=cG(cX,cY[e])end end;return setmetatable(cX,cf)end;local function c_(cm)cm=cH(cm)local aP={}local d0,d1=unpack(cm)aP=bs(d1)aP[22]=d0[1]%2;return setmetatable(aP,c)end;local function d2(bt)bt=f(a(bt):sub(1,22))local d1=bv(bt)d1[7]=d1[7]%bC[7]local d3=bN(d1)local d4=bI(d3,bQ)local d5=bI(bM(Q,d3),bQ)local d6=bN(d4)local d7=bM(d4,d6)local d8=bM(d7,d6)local d9=bM(d5,bN(d5))local K=bM(d8,d9)local d0=bM(d7,bM(d5,bR(K,ci)))if d0[1]%2~=bt[22]then d0=bI(cg,d0)end;local cx={d0,d1,{unpack(bQ)}}return setmetatable(cx,cf)end;cf={__index={isOnCurve=function(self)return cN(self)end,isInf=function(self)return self:isOnCurve()and cS(self)end,encode=function(self)return c_(self)end},__tostring=function(self)return self:encode():toHex()end,__add=function(cm,cz)assert(cm:isOnCurve(),"invalid point")assert(cz:isOnCurve(),"invalid point")return cy(cm,cz)end,__sub=function(cm,cz)assert(cm:isOnCurve(),"invalid point")assert(cz:isOnCurve(),"invalid point")return cG(cm,cz)end,__unm=function(self)assert(self:isOnCurve(),"invalid point")return cF(self)end,__eq=function(cm,cz)assert(cm:isOnCurve(),"invalid point")assert(cz:isOnCurve(),"invalid point")return cI(cm,cz)end,__mul=function(cm,g)if type(cm)=="number"then return g*cm end;if type(g)=="number"then assert(g<2^24,"number multiplier too big")g={g,0,0,0,0,0,0}else g=c4(g)end;if cm==cj then return cZ(g)else return cT(g,cm)end end}cj=setmetatable(cj,cf)ck=setmetatable(ck,cf)return{G=cj,O=ck,pointDecode=d2}end)()local function da()local av={}local db=os.epoch("utc")for bA=1,12 do av[#av+1]=db%256;db=db/256;db=db-db%1 end;return av end;local function dc(E,a2)a2=a(a2)local dd=h.hmac("encKey",a2)local de=h.hmac("macKey",a2)local av=da()local df=aj.crypt(a(E),dd,av)local aP=av;for e=1,#df do aP[#aP+1]=df[e]end;local dg=h.hmac(aP,de)for e=1,#dg do aP[#aP+1]=dg[e]end;return setmetatable(aP,c)end;local function dh(E,a2)E=a(E)a2=a(a2)local dd=h.hmac("encKey",a2)local de=h.hmac("macKey",a2)local dg=h.hmac(E:sub(1,-33),de)assert(dg:isEqual(f(E:sub(-32))),"invalid mac")local aP=aj.crypt(E:sub(13,-33),dd,E:sub(1,12))return setmetatable(aP,c)end;local function di(dj,dk)local d0=bU.decodeModQ(a(dj))local ai=bU.randomModQ()local dl=ce.G*ai;local R=bU.hashModQ(a(dk)..tostring(dl))local g=ai-d0*R;R=R:encode()g=g:encode()local aP=R;for e=1,#g do aP[#aP+1]=g[e]end;return setmetatable(aP,c)end;local function dm(dn,dk,dp)dp=a(dp)local dq=ce.pointDecode(a(dn))local R=bU.decodeModQ(dp:sub(1,21))local g=bU.decodeModQ(dp:sub(22))local dr=ce.G*g+dq*R;local ds=bU.hashModQ(a(dk)..tostring(dr))return ds==R end;return{chacha20=aj,sha256=h,random=aE,encrypt=dc,decrypt=dh,keypair=keypair,exchange=exchange,sign=di,verify=dm} end)()

local deflate = (function () local a;do local b="1.0.2-release"local c="LibDeflate"local d=3;local e="LibDeflate "..b.." Copyright (C) 2018-2021 Haoqian He.".." Licensed under the zlib License"if LibStub then local f,g=LibStub:GetLibrary(c,true)if f and g and g>=d then return f else a=LibStub:NewLibrary(c,d)end else a={}end;a._VERSION=b;a._MAJOR=c;a._MINOR=d;a._COPYRIGHT=e end;local assert=assert;local error=error;local pairs=pairs;local h=string.byte;local i=string.char;local j=string.find;local k=string.gsub;local l=string.sub;local m=table.concat;local n=table.sort;local tostring=tostring;local type=type;local o={}local p={}local q={}local r={}local s={}local t={}local u={}local v={}local w={}local x={3,4,5,6,7,8,9,10,11,13,15,17,19,23,27,31,35,43,51,59,67,83,99,115,131,163,195,227,258}local y={0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,0}local z={[0]=1,2,3,4,5,7,9,13,17,25,33,49,65,97,129,193,257,385,513,769,1025,1537,2049,3073,4097,6145,8193,12289,16385,24577}local A={[0]=0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13}local B={16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15}local C;local D;local E;local F;local G;local H;local I;local J;for K=0,255 do p[K]=i(K)end;do local L=1;for K=0,32 do o[K]=L;L=L*2 end end;for K=1,9 do q[K]={}for M=0,o[K+1]-1 do local N=0;local O=M;for P=1,K do N=N-N%2+((N%2==1 or O%2==1)and 1 or 0)O=(O-O%2)/2;N=N*2 end;q[K][M]=(N-N%2)/2 end end;do local Q=18;local R=16;local S=265;local T=1;for U=3,258 do if U<=10 then r[U]=U+254;t[U]=0 elseif U==258 then r[U]=285;t[U]=0 else if U>Q then Q=Q+R;R=R*2;S=S+4;T=T+1 end;local V=U-Q-1+R/2;r[U]=(V-V%(R/8))/(R/8)+S;t[U]=T;s[U]=V%(R/8)end end end;do u[1]=0;u[2]=1;w[1]=0;w[2]=0;local Q=3;local R=4;local W=2;local T=0;for X=3,256 do if X>R then Q=Q*2;R=R*2;W=W+2;T=T+1 end;u[X]=X<=Q and W or W+1;w[X]=T<0 and 0 or T;if R>=8 then v[X]=(X-R/2-1)%(R/4)end end end;function a:Adler32(Y)if type(Y)~="string"then error(("Usage: LibDeflate:Adler32(str):".." \'str\' - string expected got \'%s\'."):format(type(Y)),2)end;local Z=#Y;local K=1;local Q=1;local R=0;while K<=Z-15 do local _,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,aa,ab,ac,ad,ae=h(Y,K,K+15)R=(R+16*Q+16*_+15*a0+14*a1+13*a2+12*a3+11*a4+10*a5+9*a6+8*a7+7*a8+6*a9+5*aa+4*ab+3*ac+2*ad+ae)%65521;Q=(Q+_+a0+a1+a2+a3+a4+a5+a6+a7+a8+a9+aa+ab+ac+ad+ae)%65521;K=K+16 end;while K<=Z do local af=h(Y,K,K)Q=(Q+af)%65521;R=(R+Q)%65521;K=K+1 end;return(R*65536+Q)%4294967296 end;local function ag(ah,ai)return ah%4294967296==ai%4294967296 end;function a:CreateDictionary(Y,Z,aj)if type(Y)~="string"then error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):".." \'str\' - string expected got \'%s\'."):format(type(Y)),2)end;if type(Z)~="number"then error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):".." \'strlen\' - number expected got \'%s\'."):format(type(Z)),2)end;if type(aj)~="number"then error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):".." \'adler32\' - number expected got \'%s\'."):format(type(aj)),2)end;if Z~=#Y then error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):".." \'strlen\' does not match the actual length of \'str\'.".." \'strlen\': %u, \'#str\': %u .".." Please check if \'str\' is modified unintentionally."):format(Z,#Y))end;if Z==0 then error("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):".." \'str\' - Empty string is not allowed.",2)end;if Z>32768 then error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):".." \'str\' - string longer than 32768 bytes is not allowed.".." Got %d bytes."):format(Z),2)end;local ak=self:Adler32(Y)if not ag(aj,ak)then error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):".." \'adler32\' does not match the actual adler32 of \'str\'.".." \'adler32\': %u, \'Adler32(str)\': %u .".." Please check if \'str\' is modified unintentionally."):format(aj,ak))end;local al={}al.adler32=aj;al.hash_tables={}al.string_table={}al.strlen=Z;local am=al.string_table;local an=al.hash_tables;am[1]=h(Y,1,1)am[2]=h(Y,2,2)if Z>=3 then local K=1;local ao=am[1]*256+am[2]while K<=Z-2-3 do local _,a0,a1,a2=h(Y,K+2,K+5)am[K+2]=_;am[K+3]=a0;am[K+4]=a1;am[K+5]=a2;ao=(ao*256+_)%16777216;local V=an[ao]if not V then V={}an[ao]=V end;V[#V+1]=K-Z;K=K+1;ao=(ao*256+a0)%16777216;V=an[ao]if not V then V={}an[ao]=V end;V[#V+1]=K-Z;K=K+1;ao=(ao*256+a1)%16777216;V=an[ao]if not V then V={}an[ao]=V end;V[#V+1]=K-Z;K=K+1;ao=(ao*256+a2)%16777216;V=an[ao]if not V then V={}an[ao]=V end;V[#V+1]=K-Z;K=K+1 end;while K<=Z-2 do local af=h(Y,K+2)am[K+2]=af;ao=(ao*256+af)%16777216;local V=an[ao]if not V then V={}an[ao]=V end;V[#V+1]=K-Z;K=K+1 end end;return al end;local function ap(al)if type(al)~="table"then return false,("\'dictionary\' - table expected got \'%s\'."):format(type(al))end;if type(al.adler32)~="number"or type(al.string_table)~="table"or type(al.strlen)~="number"or al.strlen<=0 or al.strlen>32768 or al.strlen~=#al.string_table or type(al.hash_tables)~="table"then return false,("\'dictionary\' - corrupted dictionary."):format(type(al))end;return true,""end;local aq={[0]={false,nil,0,0,0},[1]={false,nil,4,8,4},[2]={false,nil,5,18,8},[3]={false,nil,6,32,32},[4]={true,4,4,16,16},[5]={true,8,16,32,32},[6]={true,8,16,128,128},[7]={true,8,32,128,256},[8]={true,32,128,258,1024},[9]={true,32,258,258,4096}}local function ar(Y,as,al,at,au)if type(Y)~="string"then return false,("\'str\' - string expected got \'%s\'."):format(type(Y))end;if as then local av,aw=ap(al)if not av then return false,aw end end;if at then local ax=type(au)if ax~="nil"and ax~="table"then return false,("\'configs\' - nil or table expected got \'%s\'."):format(type(au))end;if ax=="table"then for ay,az in pairs(au)do if ay~="level"and ay~="strategy"then return false,("\'configs\' - unsupported table key in the configs: \'%s\'."):format(ay)elseif ay=="level"and not aq[az]then return false,("\'configs\' - unsupported \'level\': %s."):format(tostring(az))elseif ay=="strategy"and az~="fixed"and az~="huffman_only"and az~="dynamic"then return false,("\'configs\' - unsupported \'strategy\': \'%s\'."):format(tostring(az))end end end end;return true,""end;local aA=0;local aB=1;local aC=2;local aD=3;local function aE()local aF=0;local aG=0;local aH=0;local aI=0;local aJ={}local aK={}local function aL(O,T)aG=aG+O*o[aH]aH=aH+T;aI=aI+T;if aH>=32 then aF=aF+1;aJ[aF]=p[aG%256]..p[(aG-aG%256)/256%256]..p[(aG-aG%65536)/65536%256]..p[(aG-aG%16777216)/16777216%256]local aM=o[32-aH+T]aG=(O-O%aM)/aM;aH=aH-32 end end;local function aN(Y)for P=1,aH,8 do aF=aF+1;aJ[aF]=i(aG%256)aG=(aG-aG%256)/256 end;aH=0;aF=aF+1;aJ[aF]=Y;aI=aI+#Y*8 end;local function aO(aP)if aP==aD then return aI end;if aP==aB or aP==aC then local aQ=(8-aH%8)%8;if aH>0 then aG=aG-o[aH]+o[aH+aQ]for P=1,aH,8 do aF=aF+1;aJ[aF]=p[aG%256]aG=(aG-aG%256)/256 end;aG=0;aH=0 end;if aP==aC then aI=aI+aQ;return aI end end;local aR=m(aJ)aJ={}aF=0;aK[#aK+1]=aR;if aP==aA then return aI else return aI,m(aK)end end;return aL,aN,aO end;local function aS(aT,aU,aV)aV=aV+1;aT[aV]=aU;local O=aU[1]local aW=aV;local aX=(aW-aW%2)/2;while aX>=1 and aT[aX][1]>O do local V=aT[aX]aT[aX]=aU;aT[aW]=V;aW=aX;aX=(aX-aX%2)/2 end end;local function aY(aT,aV)local aZ=aT[1]local aU=aT[aV]local O=aU[1]aT[1]=aU;aT[aV]=aZ;aV=aV-1;local aW=1;local a_=aW*2;local b0=a_+1;while a_<=aV do local b1=aT[a_]if b0<=aV and aT[b0][1]<b1[1]then local b2=aT[b0]if b2[1]<O then aT[b0]=aU;aT[aW]=b2;aW=b0;a_=aW*2;b0=a_+1 else break end else if b1[1]<O then aT[a_]=aU;aT[aW]=b1;aW=a_;a_=aW*2;b0=a_+1 else break end end end;return aZ end;local function b3(b4,b5,b6,b7)local b8=0;local b9={}local ba={}for T=1,b7 do b8=(b8+(b4[T-1]or 0))*2;b9[T]=b8 end;for bb=0,b6 do local T=b5[bb]if T then b8=b9[T]b9[T]=b8+1;if T<=9 then ba[bb]=q[T][b8]else local N=0;for P=1,T do N=N-N%2+((N%2==1 or b8%2==1)and 1 or 0)b8=(b8-b8%2)/2;N=N*2 end;ba[bb]=(N-N%2)/2 end end end;return ba end;local function bc(Q,R)return Q[1]<R[1]or Q[1]==R[1]and Q[2]<R[2]end;local function bd(be,b7,b6)local aV;local bf=-1;local bg={}local aT={}local b5={}local bh={}local b4={}local bi=0;for bb,bj in pairs(be)do bi=bi+1;bg[bi]={bj,bb}end;if bi==0 then return{},{},-1 elseif bi==1 then local bb=bg[1][2]b5[bb]=1;bh[bb]=0;return b5,bh,bb else n(bg,bc)aV=bi;for K=1,aV do aT[K]=bg[K]end;while aV>1 do local bk=aY(aT,aV)aV=aV-1;local bl=aY(aT,aV)aV=aV-1;local bm={bk[1]+bl[1],-1,bk,bl}aS(aT,bm,aV)aV=aV+1 end;local bn=0;local bo={aT[1],0,0,0}local bp=1;local bq=1;aT[1][1]=0;while bq<=bp do local aU=bo[bq]local T=aU[1]local bb=aU[2]local b1=aU[3]local b2=aU[4]if b1 then bp=bp+1;bo[bp]=b1;b1[1]=T+1 end;if b2 then bp=bp+1;bo[bp]=b2;b2[1]=T+1 end;bq=bq+1;if T>b7 then bn=bn+1;T=b7 end;if bb>=0 then b5[bb]=T;bf=bb>bf and bb or bf;b4[T]=(b4[T]or 0)+1 end end;if bn>0 then repeat local T=b7-1;while(b4[T]or 0)==0 do T=T-1 end;b4[T]=b4[T]-1;b4[T+1]=(b4[T+1]or 0)+2;b4[b7]=b4[b7]-1;bn=bn-2 until bn<=0;bq=1;for T=b7,1,-1 do local br=b4[T]or 0;while br>0 do local bb=bg[bq][2]b5[bb]=T;br=br-1;bq=bq+1 end end end;bh=b3(b4,b5,b6,b7)return b5,bh,bf end end;local function bs(bt,bu,bv,bw)local bx=0;local by={}local bz={}local bA=0;local bB={}local bC=nil;local bj=0;bw=bw<0 and 0 or bw;local bD=bu+bw+1;for W=0,bD+1 do local U=W<=bu and(bt[W]or 0)or(W<=bD and(bv[W-bu-1]or 0)or nil)if U==bC then bj=bj+1;if U~=0 and bj==6 then bx=bx+1;by[bx]=16;bA=bA+1;bB[bA]=3;bz[16]=(bz[16]or 0)+1;bj=0 elseif U==0 and bj==138 then bx=bx+1;by[bx]=18;bA=bA+1;bB[bA]=127;bz[18]=(bz[18]or 0)+1;bj=0 end else if bj==1 then bx=bx+1;by[bx]=bC;bz[bC]=(bz[bC]or 0)+1 elseif bj==2 then bx=bx+1;by[bx]=bC;bx=bx+1;by[bx]=bC;bz[bC]=(bz[bC]or 0)+2 elseif bj>=3 then bx=bx+1;local bE=bC~=0 and 16 or(bj<=10 and 17 or 18)by[bx]=bE;bz[bE]=(bz[bE]or 0)+1;bA=bA+1;bB[bA]=bj<=10 and bj-3 or bj-11 end;bC=U;if U and U~=0 then bx=bx+1;by[bx]=U;bz[U]=(bz[U]or 0)+1;bj=0 else bj=1 end end end;return by,bB,bz end;local function bF(Y,V,bG,bH,bI)local K=bG-bI;while K<=bH-15-bI do V[K],V[K+1],V[K+2],V[K+3],V[K+4],V[K+5],V[K+6],V[K+7],V[K+8],V[K+9],V[K+10],V[K+11],V[K+12],V[K+13],V[K+14],V[K+15]=h(Y,K+bI,K+15+bI)K=K+16 end;while K<=bH-bI do V[K]=h(Y,K+bI,K+bI)K=K+1 end;return V end;local function bJ(bK,am,an,bL,bM,bI,al)local bN=aq[bK]local bO,bP,bQ,bR,bS=bN[1],bN[2],bN[3],bN[4],bN[5]local bT=not bO and bQ or 2147483646;local bU=bS-bS%4/4;local ao;local bV;local bW;local bX=0;if al then bV=al.hash_tables;bW=al.string_table;bX=al.strlen;assert(bL==1)if bM>=bL and bX>=2 then ao=bW[bX-1]*65536+bW[bX]*256+am[1]local V=an[ao]if not V then V={}an[ao]=V end;V[#V+1]=-1 end;if bM>=bL+1 and bX>=1 then ao=bW[bX]*65536+am[1]*256+am[2]local V=an[ao]if not V then V={}an[ao]=V end;V[#V+1]=0 end end;local bY=bX+3;ao=(am[bL-bI]or 0)*256+(am[bL+1-bI]or 0)local bZ={}local b_=0;local c0={}local c1={}local c2=0;local c3={}local c4={}local c5=0;local c6={}local c7=0;local c8=false;local c9;local ca;local cb=0;local cc=0;local bq=bL;local cd=bM+(bO and 1 or 0)while bq<=cd do local ce=bq-bI;local cf=bI-3;c9=cb;ca=cc;cb=0;ao=(ao*256+(am[ce+2]or 0))%16777216;local cg;local ch;local ci=an[ao]local cj;if not ci then cj=0;ci={}an[ao]=ci;if bV then ch=bV[ao]cg=ch and#ch or 0 else cg=0 end else cj=#ci;ch=ci;cg=cj end;if bq<=bM then ci[cj+1]=bq end;if cg>0 and bq+2<=bM and(not bO or c9<bQ)then local ck=bO and c9>=bP and bU or bS;local cl=bM-bq;cl=cl>=257 and 257 or cl;cl=cl+ce;local cm=ce+3;while cg>=1 and ck>0 do local bC=ch[cg]if bq-bC>32768 then break end;if bC<bq then local cn=cm;if bC>=-257 then local co=bC-cf;while cn<=cl and am[co]==am[cn]do cn=cn+1;co=co+1 end else local co=bY+bC;while cn<=cl and bW[co]==am[cn]do cn=cn+1;co=co+1 end end;local M=cn-ce;if M>cb then cb=M;cc=bq-bC end;if cb>=bR then break end end;cg=cg-1;ck=ck-1;if cg==0 and bC>0 and bV then ch=bV[ao]cg=ch and#ch or 0 end end end;if not bO then c9,ca=cb,cc end;if(not bO or c8)and(c9>3 or c9==3 and ca<4096)and cb<=c9 then local W=r[c9]local cp=t[c9]local cq,cr,cs;if ca<=256 then cq=u[ca]cs=v[ca]cr=w[ca]else cq=16;cr=7;local Q=384;local R=512;while true do if ca<=Q then cs=(ca-R/2-1)%(R/4)break elseif ca<=R then cs=(ca-R/2-1)%(R/4)cq=cq+1;break else cq=cq+2;cr=cr+1;Q=Q*2;R=R*2 end end end;b_=b_+1;bZ[b_]=W;c0[W]=(c0[W]or 0)+1;c2=c2+1;c1[c2]=cq;c3[cq]=(c3[cq]or 0)+1;if cp>0 then local ct=s[c9]c5=c5+1;c4[c5]=ct end;if cr>0 then c7=c7+1;c6[c7]=cs end;for K=bq+1,bq+c9-(bO and 2 or 1)do ao=(ao*256+(am[K-bI+2]or 0))%16777216;if c9<=bT then ci=an[ao]if not ci then ci={}an[ao]=ci end;ci[#ci+1]=K end end;bq=bq+c9-(bO and 1 or 0)c8=false elseif not bO or c8 then local W=am[bO and ce-1 or ce]b_=b_+1;bZ[b_]=W;c0[W]=(c0[W]or 0)+1;bq=bq+1 else c8=true;bq=bq+1 end end;b_=b_+1;bZ[b_]=256;c0[256]=(c0[256]or 0)+1;return bZ,c4,c0,c1,c6,c3 end;local function cu(c0,c3)local cv,cw,bu=bd(c0,15,285)local cx,cy,bw=bd(c3,15,29)local cz,bB,cA=bs(cv,bu,cx,bw)local cB,cC=bd(cA,7,18)local cD=0;for K=1,19 do local bb=B[K]local cE=cB[bb]or 0;if cE~=0 then cD=K end end;cD=cD-4;local cF=bu+1-257;local cG=bw+1-1;if cG<0 then cG=0 end;return cF,cG,cD,cB,cC,cz,bB,cv,cw,cx,cy end;local function cH(bZ,c1,cD,cB,cz,cv,cx)local cI=17;cI=cI+(cD+4)*3;for K=1,#cz do local W=cz[K]cI=cI+cB[W]if W>=16 then cI=cI+(W==16 and 2 or(W==17 and 3 or 7))end end;local cJ=0;for K=1,#bZ do local W=bZ[K]local cK=cv[W]cI=cI+cK;if W>256 then cJ=cJ+1;if W>264 and W<285 then local cL=y[W-256]cI=cI+cL end;local cq=c1[cJ]local cM=cx[cq]cI=cI+cM;if cq>3 then local cr=(cq-cq%2)/2-1;cI=cI+cr end end end;return cI end;local function cN(aL,cO,bZ,c4,c1,c6,cF,cG,cD,cB,cC,cz,bB,cv,cw,cx,cy)aL(cO and 1 or 0,1)aL(2,2)aL(cF,5)aL(cG,5)aL(cD,4)for K=1,cD+4 do local bb=B[K]local cE=cB[bb]or 0;aL(cE,3)end;local cP=1;for K=1,#cz do local W=cz[K]aL(cC[W],cB[W])if W>=16 then local cQ=bB[cP]aL(cQ,W==16 and 2 or(W==17 and 3 or 7))cP=cP+1 end end;local cJ=0;local cR=0;local cS=0;for K=1,#bZ do local cT=bZ[K]local b8=cw[cT]local cK=cv[cT]aL(b8,cK)if cT>256 then cJ=cJ+1;if cT>264 and cT<285 then cR=cR+1;local cU=c4[cR]local cL=y[cT-256]aL(cU,cL)end;local cV=c1[cJ]local cW=cy[cV]local cM=cx[cV]aL(cW,cM)if cV>3 then cS=cS+1;local cs=c6[cS]local cr=(cV-cV%2)/2-1;aL(cs,cr)end end end end;local function cX(bZ,c1)local cI=3;local cJ=0;for K=1,#bZ do local W=bZ[K]local cK=E[W]cI=cI+cK;if W>256 then cJ=cJ+1;if W>264 and W<285 then local cL=y[W-256]cI=cI+cL end;local cq=c1[cJ]cI=cI+5;if cq>3 then local cr=(cq-cq%2)/2-1;cI=cI+cr end end end;return cI end;local function cY(aL,cO,bZ,c4,c1,c6)aL(cO and 1 or 0,1)aL(1,2)local cJ=0;local cR=0;local cS=0;for K=1,#bZ do local cZ=bZ[K]local b8=C[cZ]local cK=E[cZ]aL(b8,cK)if cZ>256 then cJ=cJ+1;if cZ>264 and cZ<285 then cR=cR+1;local cU=c4[cR]local cL=y[cZ-256]aL(cU,cL)end;local cq=c1[cJ]local cW=G[cq]aL(cW,5)if cq>3 then cS=cS+1;local cs=c6[cS]local cr=(cq-cq%2)/2-1;aL(cs,cr)end end end end;local function c_(bL,bM,aI)assert(bM-bL+1<=65535)local cI=3;aI=aI+3;local aQ=(8-aI%8)%8;cI=cI+aQ;cI=cI+32;cI=cI+(bM-bL+1)*8;return cI end;local function d0(aL,aN,cO,Y,bL,bM,aI)assert(bM-bL+1<=65535)aL(cO and 1 or 0,1)aL(0,2)aI=aI+3;local aQ=(8-aI%8)%8;if aQ>0 then aL(o[aQ]-1,aQ)end;local d1=bM-bL+1;aL(d1,16)local d2=255-d1%256+(255-(d1-d1%256)/256)*256;aL(d2,16)aN(Y:sub(bL,bM))end;local function d3(au,aL,aN,aO,Y,al)local am={}local an={}local cO=nil;local bL;local bM;local d4;local aI=aO(aD)local Z=#Y;local bI;local bK;local d5;if au then if au.level then bK=au.level end;if au.strategy then d5=au.strategy end end;if not bK then if Z<2048 then bK=7 elseif Z>65536 then bK=3 else bK=5 end end;while not cO do if not bL then bL=1;bM=64*1024-1;bI=0 else bL=bM+1;bM=bM+32*1024;bI=bL-32*1024-1 end;if bM>=Z then bM=Z;cO=true else cO=false end;local bZ,c4,c0,c1,c6,c3;local cF,cG,cD,cB,cC,cz,bB,cv,cw,cx,cy;local d6;local d7;local d8;if bK~=0 then bF(Y,am,bL,bM+3,bI)if bL==1 and al then local bW=al.string_table;local d9=al.strlen;for K=0,-d9+1<-257 and-257 or-d9+1,-1 do am[K]=bW[d9+K]end end;if d5=="huffman_only"then bZ={}bF(Y,bZ,bL,bM,bL-1)c4={}c0={}bZ[bM-bL+2]=256;for K=1,bM-bL+2 do local W=bZ[K]c0[W]=(c0[W]or 0)+1 end;c1={}c6={}c3={}else bZ,c4,c0,c1,c6,c3=bJ(bK,am,an,bL,bM,bI,al)end;cF,cG,cD,cB,cC,cz,bB,cv,cw,cx,cy=cu(c0,c3)d6=cH(bZ,c1,cD,cB,cz,cv,cx)d7=cX(bZ,c1)end;d8=c_(bL,bM,aI)local da=d8;da=d7 and d7<da and d7 or da;da=d6 and d6<da and d6 or da;if bK==0 or d5~="fixed"and d5~="dynamic"and d8==da then d0(aL,aN,cO,Y,bL,bM,aI)aI=aI+d8 elseif d5~="dynamic"and(d5=="fixed"or d7==da)then cY(aL,cO,bZ,c4,c1,c6)aI=aI+d7 elseif d5=="dynamic"or d6==da then cN(aL,cO,bZ,c4,c1,c6,cF,cG,cD,cB,cC,cz,bB,cv,cw,cx,cy)aI=aI+d6 end;if cO then d4=aO(aD)else d4=aO(aA)end;assert(d4==aI)if not cO then local M;if al and bL==1 then M=0;while am[M]do am[M]=nil;M=M-1 end end;al=nil;M=1;for K=bM-32767,bM do am[M]=am[K-bI]M=M+1 end;for ay,V in pairs(an)do local db=#V;if db>0 and bM+1-V[1]>32768 then if db==1 then an[ay]=nil else local dc={}local dd=0;for K=2,db do M=V[K]if bM+1-M<=32768 then dd=dd+1;dc[dd]=M end end;an[ay]=dc end end end end end end;local function de(Y,al,au)local aL,aN,aO=aE()d3(au,aL,aN,aO,Y,al)local aI,df=aO(aB)local aQ=(8-aI%8)%8;return df,aQ end;local function dg(Y,al,au)local aL,aN,aO=aE()local dh=8;local di=7;local dj=di*16+dh;aL(dj,8)local dk=al and 1 or 0;local dl=2;local dm=dl*64+dk*32;local dn=31-(dj*256+dm)%31;dm=dm+dn;aL(dm,8)if dk==1 then local aj=al.adler32;local dp=aj%256;aj=(aj-dp)/256;local dq=aj%256;aj=(aj-dq)/256;local dr=aj%256;aj=(aj-dr)/256;local ds=aj%256;aL(ds,8)aL(dr,8)aL(dq,8)aL(dp,8)end;d3(au,aL,aN,aO,Y,al)aO(aC)local aj=a:Adler32(Y)local ds=aj%256;aj=(aj-ds)/256;local dr=aj%256;aj=(aj-dr)/256;local dq=aj%256;aj=(aj-dq)/256;local dp=aj%256;aL(dp,8)aL(dq,8)aL(dr,8)aL(ds,8)local aI,df=aO(aB)local aQ=(8-aI%8)%8;return df,aQ end;function a:CompressDeflate(Y,au)local dt,du=ar(Y,false,nil,true,au)if not dt then error("Usage: LibDeflate:CompressDeflate(str, configs): "..du,2)end;return de(Y,nil,au)end;function a:CompressDeflateWithDict(Y,al,au)local dt,du=ar(Y,true,al,true,au)if not dt then error("Usage: LibDeflate:CompressDeflateWithDict".."(str, dictionary, configs): "..du,2)end;return de(Y,al,au)end;function a:CompressZlib(Y,au)local dt,du=ar(Y,false,nil,true,au)if not dt then error("Usage: LibDeflate:CompressZlib(str, configs): "..du,2)end;return dg(Y,nil,au)end;function a:CompressZlibWithDict(Y,al,au)local dt,du=ar(Y,true,al,true,au)if not dt then error("Usage: LibDeflate:CompressZlibWithDict".."(str, dictionary, configs): "..du,2)end;return dg(Y,al,au)end;local function dv(dw)local dx=dw;local dy=#dw;local dz=1;local aH=0;local aG=0;local function dA(T)local aM=o[T]local W;if T<=aH then W=aG%aM;aG=(aG-W)/aM;aH=aH-T else local dB=o[aH]local dq,dr,ds,dC=h(dx,dz,dz+3)aG=aG+((dq or 0)+(dr or 0)*256+(ds or 0)*65536+(dC or 0)*16777216)*dB;dz=dz+4;aH=aH+32-T;W=aG%aM;aG=(aG-W)/aM end;return W end;local function dD(dE,aJ,aF)assert(aH%8==0)local dF=aH/8<dE and aH/8 or dE;for P=1,dF do local dG=aG%256;aF=aF+1;aJ[aF]=i(dG)aG=(aG-dG)/256 end;aH=aH-dF*8;dE=dE-dF;if(dy-dz-dE+1)*8+aH<0 then return-1 end;for K=dz,dz+dE-1 do aF=aF+1;aJ[aF]=l(dx,K,K)end;dz=dz+dE;return aF end;local function dH(dI,dJ,da)local W=0;local dK=0;local bq=0;local bj;if da>0 then if aH<15 and dx then local dB=o[aH]local dq,dr,ds,dC=h(dx,dz,dz+3)aG=aG+((dq or 0)+(dr or 0)*256+(ds or 0)*65536+(dC or 0)*16777216)*dB;dz=dz+4;aH=aH+32 end;local aM=o[da]aH=aH-da;W=aG%aM;aG=(aG-W)/aM;W=q[da][W]bj=dI[da]if W<bj then return dJ[W]end;bq=bj;dK=bj*2;W=W*2 end;for T=da+1,15 do local dL;dL=aG%2;aG=(aG-dL)/2;aH=aH-1;W=dL==1 and W+1-W%2 or W;bj=dI[T]or 0;local dM=W-dK;if dM<bj then return dJ[bq+dM]end;bq=bq+bj;dK=dK+bj;dK=dK*2;W=W*2 end;return-10 end;local function dN()return(dy-dz+1)*8+aH end;local function dO()local dP=aH%8;local aM=o[dP]aH=aH-dP;aG=(aG-aG%aM)/aM end;return dA,dD,dH,dN,dO end;local function dQ(Y,al)local dA,dD,dH,dN,dO=dv(Y)local dR={ReadBits=dA,ReadBytes=dD,Decode=dH,ReaderBitlenLeft=dN,SkipToByteBoundary=dO,buffer_size=0,buffer={},result_buffer={},dictionary=al}return dR end;local function dS(dT,b6,b7)local dI={}local da=b7;for bb=0,b6 do local T=dT[bb]or 0;da=T>0 and T<da and T or da;dI[T]=(dI[T]or 0)+1 end;if dI[0]==b6+1 then return 0,dI,{},0 end;local dU=1;for U=1,b7 do dU=dU*2;dU=dU-(dI[U]or 0)if dU<0 then return dU end end;local dV={}dV[1]=0;for U=1,b7-1 do dV[U+1]=dV[U]+(dI[U]or 0)end;local dJ={}for bb=0,b6 do local T=dT[bb]or 0;if T~=0 then local bI=dV[T]dJ[bI]=bb;dV[T]=dV[T]+1 end end;return dU,dI,dJ,da end;local function dW(dR,cv,dX,dY,cx,dZ,d_)local aJ,aF,dA,dH,dN,aK=dR.buffer,dR.buffer_size,dR.ReadBits,dR.Decode,dR.ReaderBitlenLeft,dR.result_buffer;local al=dR.dictionary;local bW;local d9;local e0=1;if al and not aJ[0]then bW=al.string_table;d9=al.strlen;e0=-d9+1;for K=0,-d9+1<-257 and-257 or-d9+1,-1 do aJ[K]=p[bW[d9+K]]end end;repeat local bb=dH(cv,dX,dY)if bb<0 or bb>285 then return-10 elseif bb<256 then aF=aF+1;aJ[aF]=p[bb]elseif bb>256 then bb=bb-256;local T=x[bb]T=bb>=8 and T+dA(y[bb])or T;bb=dH(cx,dZ,d_)if bb<0 or bb>29 then return-10 end;local X=z[bb]X=X>4 and X+dA(A[bb])or X;local e1=aF-X+1;if e1<e0 then return-11 end;if e1>=-257 then for P=1,T do aF=aF+1;aJ[aF]=aJ[e1]e1=e1+1 end else e1=d9+e1;for P=1,T do aF=aF+1;aJ[aF]=p[bW[e1]]e1=e1+1 end end end;if dN()<0 then return 2 end;if aF>=65536 then aK[#aK+1]=m(aJ,"",1,32768)for K=32769,aF do aJ[K-32768]=aJ[K]end;aF=aF-32768;aJ[aF+1]=nil end until bb==256;dR.buffer_size=aF;return 0 end;local function e2(dR)local aJ,aF,dA,dD,dN,dO,aK=dR.buffer,dR.buffer_size,dR.ReadBits,dR.ReadBytes,dR.ReaderBitlenLeft,dR.SkipToByteBoundary,dR.result_buffer;dO()local dE=dA(16)if dN()<0 then return 2 end;local e3=dA(16)if dN()<0 then return 2 end;if dE%256+e3%256~=255 then return-2 end;if(dE-dE%256)/256+(e3-e3%256)/256~=255 then return-2 end;aF=dD(dE,aJ,aF)if aF<0 then return 2 end;if aF>=65536 then aK[#aK+1]=m(aJ,"",1,32768)for K=32769,aF do aJ[K-32768]=aJ[K]end;aF=aF-32768;aJ[aF+1]=nil end;dR.buffer_size=aF;return 0 end;local function e4(dR)return dW(dR,F,D,7,J,H,5)end;local function e5(dR)local dA,dH=dR.ReadBits,dR.Decode;local e6=dA(5)+257;local e7=dA(5)+1;local e8=dA(4)+4;if e6>286 or e7>30 then return-3 end;local cB={}for K=1,e8 do cB[B[K]]=dA(3)end;local e9,ea,eb,ec=dS(cB,18,7)if e9~=0 then return-4 end;local cv={}local cx={}local bq=0;while bq<e6+e7 do local bb;local T;bb=dH(ea,eb,ec)if bb<0 then return bb elseif bb<16 then if bq<e6 then cv[bq]=bb else cx[bq-e6]=bb end;bq=bq+1 else T=0;if bb==16 then if bq==0 then return-5 end;if bq-1<e6 then T=cv[bq-1]else T=cx[bq-e6-1]end;bb=3+dA(2)elseif bb==17 then bb=3+dA(3)else bb=11+dA(7)end;if bq+bb>e6+e7 then return-6 end;while bb>0 do bb=bb-1;if bq<e6 then cv[bq]=T else cx[bq-e6]=T end;bq=bq+1 end end end;if(cv[256]or 0)==0 then return-9 end;local ed,ee,dX,dY=dS(cv,e6-1,15)if ed~=0 and(ed<0 or e6~=(ee[0]or 0)+(ee[1]or 0))then return-7 end;local ef,eg,dZ,d_=dS(cx,e7-1,15)if ef~=0 and(ef<0 or e7~=(eg[0]or 0)+(eg[1]or 0))then return-8 end;return dW(dR,ee,dX,dY,eg,dZ,d_)end;local function eh(dR)local dA=dR.ReadBits;local cO;while not cO do cO=dA(1)==1;local ei=dA(2)local ej;if ei==0 then ej=e2(dR)elseif ei==1 then ej=e4(dR)elseif ei==2 then ej=e5(dR)else return nil,-1 end;if ej~=0 then return nil,ej end end;dR.result_buffer[#dR.result_buffer+1]=m(dR.buffer,"",1,dR.buffer_size)local df=m(dR.result_buffer)return df end;local function ek(Y,al)local dR=dQ(Y,al)local df,ej=eh(dR)if not df then return nil,ej end;local el=dR.ReaderBitlenLeft()local em=(el-el%8)/8;return df,em end;local function en(Y,al)local dR=dQ(Y,al)local dA=dR.ReadBits;local dj=dA(8)if dR.ReaderBitlenLeft()<0 then return nil,2 end;local dh=dj%16;local di=(dj-dh)/16;if dh~=8 then return nil,-12 end;if di>7 then return nil,-13 end;local dm=dA(8)if dR.ReaderBitlenLeft()<0 then return nil,2 end;if(dj*256+dm)%31~=0 then return nil,-14 end;local dk=(dm-dm%32)/32%2;local dl=(dm-dm%64)/64%4;if dk==1 then if not al then return nil,-16 end;local ds=dA(8)local dr=dA(8)local dq=dA(8)local dp=dA(8)local ak=ds*16777216+dr*65536+dq*256+dp;if dR.ReaderBitlenLeft()<0 then return nil,2 end;if not ag(ak,al.adler32)then return nil,-17 end end;local df,ej=eh(dR)if not df then return nil,ej end;dR.SkipToByteBoundary()local eo=dA(8)local ep=dA(8)local eq=dA(8)local er=dA(8)if dR.ReaderBitlenLeft()<0 then return nil,2 end;local es=eo*16777216+ep*65536+eq*256+er;local et=a:Adler32(df)if not ag(es,et)then return nil,-15 end;local el=dR.ReaderBitlenLeft()local em=(el-el%8)/8;return df,em end;function a:DecompressDeflate(Y)local dt,du=ar(Y)if not dt then error("Usage: LibDeflate:DecompressDeflate(str): "..du,2)end;return ek(Y)end;function a:DecompressDeflateWithDict(Y,al)local dt,du=ar(Y,true,al)if not dt then error("Usage: LibDeflate:DecompressDeflateWithDict(str, dictionary): "..du,2)end;return ek(Y,al)end;function a:DecompressZlib(Y)local dt,du=ar(Y)if not dt then error("Usage: LibDeflate:DecompressZlib(str): "..du,2)end;return en(Y)end;function a:DecompressZlibWithDict(Y,al)local dt,du=ar(Y,true,al)if not dt then error("Usage: LibDeflate:DecompressZlibWithDict(str, dictionary): "..du,2)end;return en(Y,al)end;do E={}for eu=0,143 do E[eu]=8 end;for eu=144,255 do E[eu]=9 end;for eu=256,279 do E[eu]=7 end;for eu=280,287 do E[eu]=8 end;I={}for X=0,31 do I[X]=5 end;local ej;ej,F,D=dS(E,287,9)assert(ej==0)ej,J,H=dS(I,31,5)assert(ej==0)C=b3(F,E,287,9)G=b3(J,I,31,5)end;local ev={["\000"]="%z",["("]="%(",[")"]="%)",["."]="%.",["%"]="%%",["+"]="%+",["-"]="%-",["*"]="%*",["?"]="%?",["["]="%[",["]"]="%]",["^"]="%^",["$"]="%$"}local function ew(Y)return Y:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])",ev)end;function a:CreateCodec(ex,ey,ez)if type(ex)~="string"or type(ey)~="string"or type(ez)~="string"then error("Usage: LibDeflate:CreateCodec(reserved_chars,".." escape_chars, map_chars):".." All arguments must be string.",2)end;if ey==""then return nil,"No escape characters supplied."end;if#ex<#ez then return nil,"The number of reserved characters must be".." at least as many as the number of mapped chars."end;if ex==""then return nil,"No characters to encode."end;local eA=ex..ey..ez;local eB={}for K=1,#eA do local dG=h(eA,K,K)if eB[dG]then return nil,"There must be no duplicate characters in the".." concatenation of reserved_chars, escape_chars and".." map_chars."end;eB[dG]=true end;local eC={}local eD={}local eE={}local eF={}if#ez>0 then local eG={}local eH={}for K=1,#ez do local eI=l(ex,K,K)local eJ=l(ez,K,K)eF[eI]=eJ;eE[#eE+1]=eI;eH[eJ]=eI;eG[#eG+1]=eJ end;eC[#eC+1]="(["..ew(m(eG)).."])"eD[#eD+1]=eH end;local eK=1;local eL=l(ey,eK,eK)local eM=0;local eG={}local eH={}for K=1,#eA do local S=l(eA,K,K)if not eF[S]then while eM>=256 or eB[eM]do eM=eM+1;if eM>255 then eC[#eC+1]=ew(eL).."(["..ew(m(eG)).."])"eD[#eD+1]=eH;eK=eK+1;eL=l(ey,eK,eK)eM=0;eG={}eH={}if not eL or eL==""then return nil,"Out of escape characters."end end end;local eN=p[eM]eF[S]=eL..eN;eE[#eE+1]=S;eH[eN]=S;eG[#eG+1]=eN;eM=eM+1 end;if K==#eA then eC[#eC+1]=ew(eL).."(["..ew(m(eG)).."])"eD[#eD+1]=eH end end;local eO={}local eP="(["..ew(m(eE)).."])"local eQ=eF;function eO:Encode(Y)if type(Y)~="string"then error(("Usage: codec:Encode(str):".." \'str\' - string expected got \'%s\'."):format(type(Y)),2)end;return k(Y,eP,eQ)end;local eR=#eC;local eS="(["..ew(ex).."])"function eO:Decode(Y)if type(Y)~="string"then error(("Usage: codec:Decode(str):".." \'str\' - string expected got \'%s\'."):format(type(Y)),2)end;if j(Y,eS)then return nil end;for K=1,eR do Y=k(Y,eC[K],eD[K])end;return Y end;return eO end;local eT={[0]="a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9","(",")"}local eU={[97]=0,[98]=1,[99]=2,[100]=3,[101]=4,[102]=5,[103]=6,[104]=7,[105]=8,[106]=9,[107]=10,[108]=11,[109]=12,[110]=13,[111]=14,[112]=15,[113]=16,[114]=17,[115]=18,[116]=19,[117]=20,[118]=21,[119]=22,[120]=23,[121]=24,[122]=25,[65]=26,[66]=27,[67]=28,[68]=29,[69]=30,[70]=31,[71]=32,[72]=33,[73]=34,[74]=35,[75]=36,[76]=37,[77]=38,[78]=39,[79]=40,[80]=41,[81]=42,[82]=43,[83]=44,[84]=45,[85]=46,[86]=47,[87]=48,[88]=49,[89]=50,[90]=51,[48]=52,[49]=53,[50]=54,[51]=55,[52]=56,[53]=57,[54]=58,[55]=59,[56]=60,[57]=61,[40]=62,[41]=63}function a:EncodeForPrint(Y)if type(Y)~="string"then error(("Usage: LibDeflate:EncodeForPrint(str):".." \'str\' - string expected got \'%s\'."):format(type(Y)),2)end;local Z=#Y;local eV=Z-2;local K=1;local aJ={}local aF=0;while K<=eV do local _,a0,a1=h(Y,K,K+2)K=K+3;local aG=_+a0*256+a1*65536;local eW=aG%64;aG=(aG-eW)/64;local eX=aG%64;aG=(aG-eX)/64;local eY=aG%64;local eZ=(aG-eY)/64;aF=aF+1;aJ[aF]=eT[eW]..eT[eX]..eT[eY]..eT[eZ]end;local aG=0;local aH=0;while K<=Z do local af=h(Y,K,K)aG=aG+af*o[aH]aH=aH+8;K=K+1 end;while aH>0 do local e_=aG%64;aF=aF+1;aJ[aF]=eT[e_]aG=(aG-e_)/64;aH=aH-6 end;return m(aJ)end;function a:DecodeForPrint(Y)if type(Y)~="string"then error(("Usage: LibDeflate:DecodeForPrint(str):".." \'str\' - string expected got \'%s\'."):format(type(Y)),2)end;Y=Y:gsub("^[%c ]+","")Y=Y:gsub("[%c ]+$","")local Z=#Y;if Z==1 then return nil end;local f0=Z-3;local K=1;local aJ={}local aF=0;while K<=f0 do local _,a0,a1,a2=h(Y,K,K+3)_=eU[_]a0=eU[a0]a1=eU[a1]a2=eU[a2]if not(_ and a0 and a1 and a2)then return nil end;K=K+4;local aG=_+a0*64+a1*4096+a2*262144;local eW=aG%256;aG=(aG-eW)/256;local eX=aG%256;local eY=(aG-eX)/256;aF=aF+1;aJ[aF]=p[eW]..p[eX]..p[eY]end;local aG=0;local aH=0;while K<=Z do local af=h(Y,K,K)af=eU[af]if not af then return nil end;aG=aG+af*o[aH]aH=aH+6;K=K+1 end;while aH>=8 do local dG=aG%256;aF=aF+1;aJ[aF]=p[dG]aG=(aG-dG)/256;aH=aH-8 end;return m(aJ)end;local function f1()_chat_channel_codec=nil;_addon_channel_codec=nil end;a.internals={LoadStringToTable=bF,IsValidDictionary=ap,IsEqualAdler32=ag,_byte_to_6bit_char=eT,_6bit_to_byte=eU,InternalClearCache=f1}if io and os and debug and _G.arg then local io=io;local os=os;local debug=debug;local f2=_G.arg;local f3=debug.getinfo(1)if f3.source==f2[0]or f3.short_src==f2[0]then local dx;local f4;local K=1;local ej;local f5=false;local f6=false;local bK;local d5;local al;while f2[K]do local Q=f2[K]if Q=="-h"then print(a._COPYRIGHT.."\nUsage: lua LibDeflate.lua [OPTION] [INPUT] [OUTPUT]\n".."  -0    store only. no compression.\n".."  -1    fastest compression.\n".."  -9    slowest and best compression.\n".."  -d    do decompression instead of compression.\n".."  --dict <filename> specify the file that contains".." the entire preset dictionary.\n".."  -h    give this help.\n".."  --strategy <fixed/huffman_only/dynamic>".." specify a special compression strategy.\n".."  -v    print the version and copyright info.\n".."  --zlib  use zlib format instead of raw deflate.\n")os.exit(0)elseif Q=="-v"then print(a._COPYRIGHT)os.exit(0)elseif Q:find("^%-[0-9]$")then bK=tonumber(Q:sub(2,2))elseif Q=="-d"then f6=true elseif Q=="--dict"then K=K+1;local f7=f2[K]if not f7 then io.stderr:write("You must speicify the dict filename")os.exit(1)end;local f8,f9=io.open(f7,"rb")if not f8 then io.stderr:write(("LibDeflate: Cannot read the dictionary file \'%s\': %s"):format(f7,f9))os.exit(1)end;local fa=f8:read("*all")f8:close()al=a:CreateDictionary(fa,#fa,a:Adler32(fa))elseif Q=="--strategy"then K=K+1;d5=f2[K]elseif Q=="--zlib"then f5=true elseif Q:find("^%-")then io.stderr:write(("LibDeflate: Invalid argument: %s"):format(Q))os.exit(1)else if not dx then dx,ej=io.open(Q,"rb")if not dx then io.stderr:write(("LibDeflate: Cannot read the file \'%s\': %s"):format(Q,tostring(ej)))os.exit(1)end elseif not f4 then f4,ej=io.open(Q,"wb")if not f4 then io.stderr:write(("LibDeflate: Cannot write the file \'%s\': %s"):format(Q,tostring(ej)))os.exit(1)end end end;K=K+1 end;if not dx or not f4 then io.stderr:write("LibDeflate:".." You must specify both input and output files.")os.exit(1)end;local fb=dx:read("*all")local au={level=bK,strategy=d5}local fc;if not f6 then if not f5 then if not al then fc=a:CompressDeflate(fb,au)else fc=a:CompressDeflateWithDict(fb,al,au)end else if not al then fc=a:CompressZlib(fb,au)else fc=a:CompressZlibWithDict(fb,al,au)end end else if not f5 then if not al then fc=a:DecompressDeflate(fb)else fc=a:DecompressDeflateWithDict(fb,al)end else if not al then fc=a:DecompressZlib(fb)else fc=a:DecompressZlibWithDict(fb,al)end end end;if not fc then io.stderr:write("LibDeflate: Decompress fails.")os.exit(1)end;f4:write(fc)if dx and dx~=io.stdin then dx:close()end;if f4 and f4~=io.stdout then f4:close()end;io.stderr:write(("Successfully writes %d bytes"):format(fc:len()))os.exit(0)end end;return a end)()
local expect = dofile("rom/modules/main/cc/expect.lua")
local expect, field = expect.expect, expect.field
local filesystem = nil

local password

local function deepcopy(o, seen)
  seen = seen or {}
  if o == nil then return nil end
  if seen[o] then return seen[o] end

  local no
  if type(o) == 'table' then
    no = {}
    seen[o] = no

    for k, v in next, o, nil do
      no[deepcopy(k, seen)] = deepcopy(v, seen)
    end
    setmetatable(no, deepcopy(getmetatable(o), seen))
  else -- number, string, boolean, etc
    no = o
  end
  return no
end

local realfs = deepcopy(fs)
local function getRom(path)
    if not path then path = "/rom" end
    local out = {}
    for _,file in ipairs(realfs.list(path)) do
        local fullPath = realfs.combine(path, file) -- use realfs here to avoid recursing into _G.fs
        if realfs.isDir(fullPath) then
            out[file] = getRom(fullPath)
        else
            local handle = realfs.open(fullPath, "r")
            out[file] = handle.readAll()
            handle.close()
        end
    end
    return out
end

local function getFileSystem()
    if filesystem then filesystem.rom = getRom() return filesystem end
    if not realfs.exists("fs") then
        return {rom=getRom()}
    end
    local file = realfs.open("fs", "r")
    local compressedData = string.char(table.unpack(ecc.decrypt(file.readAll(),password)))
    file.close()
    local decompressedData = deflate:DecompressDeflate(compressedData,{level=7})
    local data = textutils.unserialize(decompressedData) or {rom=getRom()}
    filesystem = data
    data.rom = getRom()
    return data
end

local succ = false
while not succ do
    term.write("password> ")
    password = read("*")
    succ = pcall(getFileSystem)
    if not succ then
        printError("sorry wrong password")
    end
end

local function setFileSystem(data)
    filesystem = data
    data.rom = nil
    data = textutils.serialize(data)
    local file = realfs.open("fs", "w")
    file.write(string.char(table.unpack(ecc.encrypt(deflate:CompressDeflate(data,{level=8}),password))))
    file.close()
end

local function normalizeParts(path)
  local parts = {}
  for part in string.gmatch(path, "[^/]+") do
    if part == "" or part == "." then
      -- skip
    elseif part == ".." then
      if #parts > 0 then table.remove(parts) end
    else
      parts[#parts + 1] = part
    end
  end
  return parts
end

local function getDataAt(path)
    expect(1, path, "string")
    local parts = normalizeParts(path)
    local current = getFileSystem()
    if #parts == 0 then return current end
    for i = 1, #parts do
        local part = parts[i]
        if type(current) ~= "table" then
            -- trying to index into a file
            return nil
        end
        current = current[part]
        if current == nil then return nil end
    end
    return current
end

local function setDataAt(path, data)
    expect(1, path, "string")
    local parts = normalizeParts(path)
    local filesys = getFileSystem()
    local current = filesys
    for i, part in ipairs(parts) do
        if i == #parts then
            current[part] = data
        elseif type(current[part]) == "table" then
            current = current[part]
        elseif type(current[part]) == "string" then
            return
        end
    end
    setFileSystem(filesys)
end


function _G.fs.list(path)
    expect(1, path, "string")
    local out = {}
    local data = getDataAt(path)
    if data then
        for k, v in pairs(data) do
            table.insert(out, k)
        end
    end
    return out
end

function _G.fs.isDir(path)
    expect(1, path, "string")
    local data = getDataAt(path)
    return type(data) == "table"
end

function _G.fs.isReadOnly(path)
    if path == "" then return false end
    expect(1, path, "string")
    local offset = string.find(path, "rom")
    return offset ~= nil and offset < 3
end

function _G.fs.exists(path)
    expect(1, path, "string")
    local data = getDataAt(path)
    return data ~= nil
end

function _G.fs.complete(sPath, sLocation, bIncludeFiles, bIncludeDirs)
    expect(1, sPath, "string")
    expect(2, sLocation, "string")
    local bIncludeHidden = nil
    if type(bIncludeFiles) == "table" then
        bIncludeDirs = field(bIncludeFiles, "include_dirs", "boolean", "nil")
        bIncludeHidden = field(bIncludeFiles, "include_hidden", "boolean", "nil")
        bIncludeFiles = field(bIncludeFiles, "include_files", "boolean", "nil")
    else
        expect(3, bIncludeFiles, "boolean", "nil")
        expect(4, bIncludeDirs, "boolean", "nil")
    end

    bIncludeHidden = bIncludeHidden ~= false
    bIncludeFiles = bIncludeFiles ~= false
    bIncludeDirs = bIncludeDirs ~= false
    local sDir = sLocation
    local nStart = 1
    local nSlash = string.find(sPath, "[/\\]", nStart)
    if nSlash == 1 then
        sDir = ""
        nStart = 2
    end
    local sName
    while not sName do
        local nSlash = string.find(sPath, "[/\\]", nStart)
        if nSlash then
            local sPart = string.sub(sPath, nStart, nSlash - 1)
            sDir = _G.fs.combine(sDir, sPart)
            nStart = nSlash + 1
        else
            sName = string.sub(sPath, nStart)
        end
    end

    if _G.fs.isDir(sDir) then
        local tResults = {}
        if bIncludeDirs and sPath == "" then
            table.insert(tResults, ".")
        end
        if sDir ~= "" then
            if sPath == "" then
                table.insert(tResults, bIncludeDirs and ".." or "../")
            elseif sPath == "." then
                table.insert(tResults, bIncludeDirs and "." or "./")
            end
        end
        local tFiles = _G.fs.list(sDir)
        for n = 1, #tFiles do
            local sFile = tFiles[n]
            if #sFile >= #sName and string.sub(sFile, 1, #sName) == sName and (
                bIncludeHidden or sFile:sub(1, 1) ~= "." or sName:sub(1, 1) == "."
            ) then
                local bIsDir = _G.fs.isDir(fs.combine(sDir, sFile))
                local sResult = string.sub(sFile, #sName + 1)
                if bIsDir then
                    table.insert(tResults, sResult .. "/")
                    if bIncludeDirs and #sResult > 0 then
                        table.insert(tResults, sResult)
                    end
                else
                    if bIncludeFiles and #sResult > 0 then
                        table.insert(tResults, sResult)
                    end
                end
            end
        end
        return tResults
    end

    return {}
end

local function getReadHandle(path, isBinary)
    expect(1, path, "string")
    local data = getDataAt(path)
    local seek = 1
    return {
        readAll = function()
            if data == nil then return nil end
            seek = #data + 1
            return data
        end,
        readLine = function(includeTrailing)
            if data == nil then return nil end
            local line = ""
            if includeTrailing then
                line = data:sub(seek,#data):match("^[^\n]*\n?")
            else
                line = data:sub(seek,#data):match("^[^\n]*")
            end
            seek = seek + #line + 1
            if line == "" then
                return nil
            end
            return line
        end,
        read = function(count)
            if type(count) == "table" then
                count = 1
            end
            expect(1, count, "number", "nil")
            if data == nil then return nil end
            if not count then count = 1 end
            if not data then return nil end
            local toReturn = string.sub(data, seek, seek+count-1)
            seek = seek + count
            if toReturn == "" then toReturn = nil elseif isBinary and count == 1 then toReturn = string.byte(toReturn) end
            return toReturn
        end,
        seek = function (offset, whence)
            if data == nil then return nil, "File is closed" end
            if offset == nil then
                offset = 0
            end
            if whence == nil then
                whence = "cur"
            end
            if whence == "set" then
                seek = math.min(math.max(0,offset),#data) + 1
            elseif whence == "cur" then
                seek = math.min(math.max(1,seek + offset),#data + 1)
            elseif whence == "end" then
                seek = math.min(math.max(0,#data + offset),#data) + 1
            end
            return seek-1
        end,
        close = function()
            data = nil
        end
    }
end

local function getWriteHandle(path, isBinary, append_mode)
    local data = ""
    local seek = 1
    if append_mode then
        data = getDataAt(path) or ""
        seek = #data + 1
    end
    return {
        write = function(str)
            if data == nil then error("File is closed", 2) end
            if type(str) == "number" and isBinary then
                str = string.char(str)
            elseif type(str) ~= "string" then
                error("bad argument #1 (string or number expected, got "..type(str).." )", 2)
            end
            data = string.sub(data,1,seek-1) .. str .. string.sub(data,seek + #str)
            seek = seek + #str
        end,
        writeLine = function (str)
            if data == nil then error("File is closed", 2) end
            expect(1, str, "string")
            write(str .. "\n")
        end,
        flush = function()
            if data == nil then error("File is closed", 2) end
            setDataAt(path,data)
        end,
        close = function()
            if data == nil then error("File is already closed", 2) end
            setDataAt(path,data)
            data = nil
        end
    }
end

local function getReadWriteHandle(path, isBinary,erase_data)
    expect(1, path, "string")
    local data = ""
    if not erase_data then
        data = getDataAt(path) or ""
    end
    local seek = 1
    return {
        readAll = function()
            if data == nil then return nil end
            seek = #data + 1
            return data
        end,
        readLine = function(includeTrailing)
            if data == nil then return nil end
            local line = ""
            if includeTrailing then
                line = data:sub(seek,#data):match("^[^\n]*\n?")
            else
                line = data:sub(seek,#data):match("^[^\n]*")
            end
            seek = seek + #line + 1
            if line == "" then
                return nil
            end
            return line
        end,
        read = function(count)
            if type(count) == "table" then
                count = 1
            end
            expect(1, count, "number", "nil")
            if data == nil then error("File is closed", 2) end
            if not count then count = 1 end
            if not data then return nil end
            local toReturn = string.sub(data, seek, seek+count-1)
            seek = seek + count
            if toReturn == "" then toReturn = nil elseif isBinary and count == 1 then toReturn = string.byte(toReturn) end
            return toReturn
        end,
        seek = function (offset, whence)
            if data == nil then return nil, "File is closed" end
            if offset == nil then
                offset = 0
            end
            if whence == nil then
                whence = "cur"
            end
            if whence == "set" then
                seek = math.min(math.max(0,offset),#data) + 1
            elseif whence == "cur" then
                seek = math.min(math.max(1,seek + offset),#data + 1)
            elseif whence == "end" then
                seek = math.min(math.max(0,#data + offset),#data) + 1
            end
            return seek-1
        end,
        write = function(str)
            if type(str) == "number" and isBinary then
                str = string.char(str)
            elseif type(str) ~= "string" then
                error("bad argument #1 (string or number expected, got "..type(str).." )", 2)
            end
            if data == nil then error("File is closed", 2) end
            data = string.sub(data,1,seek-1) .. str .. string.sub(data,seek + #str)
            seek = seek + #str
        end,
        writeLine = function (str)
            expect(1, str, "string")
            write(str .. "\n")
        end,
        flush = function()
            setDataAt(path,data)
        end,
        close = function()
            setDataAt(path,data)
            data = nil
        end
    }
end

local function ioHandleWrapper(handle)
    local closed = false
    return {
        read = function (self,mode)
            if closed then error("File is closed", 2) end
            expect(2, mode, "string", "nil")
            if not mode then mode = "l" end
            if type(self) ~= "table" then error("bad argument #1 (FILE expected, got "..type(self).." )", 2) end
            if string.find(mode,"*") == 1 then mode = mode:gsub("%*","") end
            if mode == "l" then
                return handle.readLine(false)
            elseif mode == "L" then
                return handle.readLine(true)
            elseif mode == "a" then
                return handle.readAll()
            end
        end,
        seek = function (self,whence,offset)
            if closed then error("File is closed", 2) end
            expect(2, whence, "string", "nil")
            expect(3, offset, "number", "nil")
            if type(self) ~= "table" then error("bad argument #1 (FILE expected, got "..type(self).." )", 2) end
            return handle.seek(offset, whence)
        end,
        write = function (self, ...)
            if closed then error("File is closed", 2) end
            if type(self) ~= "table" then error("bad argument #1 (FILE expected, got "..type(self).." )", 2) end
            local args = {...}
            for i = 1, #args do
                local arg = args[i]
                if type(arg) ~= "string" and type(arg) ~= "number" then
                    error("bad argument #"..(i+1).." (string or number expected, got "..type(arg).." )", 2)
                end
                if type(arg) == "number" then arg = string.char(arg) end
                handle.write(args[i])
            end
        end,
        close = function (self)
            if closed then error("File is already closed", 2) end
            if type(self) ~= "table" then error("bad argument #1 (FILE expected, got "..type(self).." )", 2) end
            handle.close()
            closed = true
        end,
        flush = function (self)
            if closed then error("File is closed", 2) end
            if type(self) ~= "table" then error("bad argument #1 (FILE expected, got "..type(self).." )", 2) end
            handle.flush()
        end,
        lines = function (self)
            if closed then error("File is closed", 2) end
            if type(self) ~= "table" then error("bad argument #1 (FILE expected, got "..type(self).." )", 2) end
            return function ()
                if closed then error("file is already closed", 2) end
                return handle.readLine(false)
            end
        end
    }
end

function _G.fs.open(path,mode)
    expect(1, path, "string")
    expect(2, mode, "string")
    if mode == "r" or mode == "rb" then
        if _G.fs.exists(path) then
            return getReadHandle(path, mode == "rb")
        else
            error("File not found", 2)
        end
    elseif mode == "w" or mode == "wb" then
        return getWriteHandle(path, mode == "wb", false)
    elseif mode == "a" or mode == "ab" then
        return getWriteHandle(path, mode == "ab", true)
    elseif mode == "r+" or mode == "rb+" or mode == "r+b" then
        if _G.fs.exists(path) then
            return getReadWriteHandle(path, mode == "rb+" or mode == "r+b", false)
        else
            error("File not found", 2)
        end
    elseif mode == "w+" or mode == "wb+" or mode == "w+b" then
        return getReadWriteHandle(path, mode == "wb+" or mode == "w+b", true)
    elseif mode == "a+" or mode == "ab+" or mode == "a+b" then
        return getReadWriteHandle(path, mode == "ab+" or mode == "a+b", true)
    else
        error("Invalid mode", 2)
    end
end

function _G.fs.move(srcPath, dstPath)
    expect(1, srcPath, "string")
    expect(2, dstPath, "string")
    if not _G.fs.exists(srcPath) then
        error("Source does not exist", 2)
    end
    if _G.fs.exists(dstPath) then
        error("Destination already exists", 2)
    end
    local data = getDataAt(srcPath)
    setDataAt(dstPath, data)
    setDataAt(srcPath, nil)
end

function _G.fs.copy(srcPath, dstPath)
    expect(1, srcPath, "string")
    expect(2, dstPath, "string")
    if not _G.fs.exists(srcPath) then
        error("Source does not exist", 2)
    end
    if _G.fs.exists(dstPath) then
        error("Destination already exists", 2)
    end
    local data = getDataAt(srcPath)
    setDataAt(dstPath, data)
end

local function find_aux(path, parts, i, out)
    local part = parts[i]
    if not part then
        -- If we're at the end of the pattern, ensure our path exists and append it.
        if _G.fs.exists(path) then out[#out + 1] = path end
    elseif part.exact then
        -- If we're an exact match, just recurse into this directory.
        return find_aux(_G.fs.combine(path, part.contents), parts, i + 1, out)
    else
        -- Otherwise we're a pattern. Check we're a directory, then recurse into each
        -- matching file.
        if not _G.fs.isDir(path) then return end

        local files = _G.fs.list(path)
        for j = 1, #files do
            local file = files[j]
            if file:find(part.contents) then find_aux(_G.fs.combine(path, file), parts, i + 1, out) end
        end
    end
end

local find_escape = {
    -- Escape standard Lua pattern characters
    ["^"] = "%^", ["$"] = "%$", ["("] = "%(", [")"] = "%)", ["%"] = "%%",
    ["."] = "%.", ["["] = "%[", ["]"] = "%]", ["+"] = "%+", ["-"] = "%-",
    -- Aside from our wildcards.
    ["*"] = ".*",
    ["?"] = ".",
}

function _G.fs.find(pattern)
    expect(1, pattern, "string")

    pattern = _G.fs.combine(pattern) -- Normalise the path, removing ".."s.

    -- If the pattern is trying to search outside the computer root, just abort.
    -- This will fail later on anyway.
    if pattern == ".." or pattern:sub(1, 3) == "../" then
        error("/" .. pattern .. ": Invalid Path", 2)
    end

    -- If we've no wildcards, just check the file exists.
    if not pattern:find("[*?]") then
        if _G.fs.exists(pattern) then return { pattern } else return {} end
    end

    local parts = {}
    for part in pattern:gmatch("[^/]+") do
        if part:find("[*?]") then
            parts[#parts + 1] = {
                exact = false,
                contents = "^" .. part:gsub(".", find_escape) .. "$",
            }
        else
            parts[#parts + 1] = { exact = true, contents = part }
        end
    end

    local out = {}
    find_aux("", parts, 1, out)
    return out
end

function _G.io.open(path, mode)
    expect(1, path, "string")
    expect(2, mode, "string", "nil")
    if not mode then mode = "r" end
    local handle
    if mode == "r" or mode == "rb" then
        if _G.fs.exists(path) and not _G.fs.isDir(path) then
            handle = getReadHandle(path, mode == "rb")
        elseif _G.fs.isDir(path) then
            return nil, "Attempt to open a directory"
        else
            return nil, "File not found"
        end
    elseif mode == "w" or mode == "wb" then
        handle = getWriteHandle(path, mode == "wb", false)
    elseif mode == "a" or mode == "ab" then
        handle = getWriteHandle(path, mode == "ab", true)
    elseif mode == "r+" or mode == "rb+" or mode == "r+b" then  
        if _G.fs.exists(path) and not _G.fs.isDir(path) then
            handle = getReadWriteHandle(path, mode == "rb+" or mode == "r+b", false)
        elseif _G.fs.isDir(path) then
            return nil, "Attempt to open a directory"
        else
            return nil, "File not found"
        end
    elseif mode == "w+" or mode == "wb+" or mode == "w+b" then
        handle = getReadWriteHandle(path, mode == "wb+" or mode == "w+b", true)
    elseif mode == "a+" or mode == "ab+" or mode == "a+b" then
        handle = getReadWriteHandle(path, mode == "ab+" or mode == "a+b", true)
    else
        return nil, "Invalid mode"
    end
    return ioHandleWrapper(handle)
end
function _G.io.lines(path,...)
    local args = {...}
    expect(1, path, "string")
    local handle = _G.io.open(path, table.unpack(args))
    local count = 0
    return function ()
        count = count + 1
        local line = handle:read(args[count%#args + 1] or "l")
        if line == nil then
            handle:close()
        end
        return line
    end
end
function _G.fs.delete(path)
    expect(1, path, "string")
    if not _G.fs.exists(path) then
        error("File not found", 2)
    end
    setDataAt(path, nil)
end
function _G.fs.getSize(path)
    expect(1, path, "string")
    if not _G.fs.exists(path) then
        error("File not found", 2)
    end
    if _G.fs.isDir(path) then
        return 0
    else
        return #getDataAt(path)
    end
end

function _G.fs.makeDir(path)
    expect(1, path, "string")
    if _G.fs.exists(path) then
        return
    end
    setDataAt(path, {})
end

if (fs.exists("/startup.lua") and not fs.isDir("/startup.lua")) or (fs.exists("/startup") and not fs.isDir("/startup")) then
    shell.run("startup")
end
if fs.exists("/startup") and fs.isDir("/startup") then
    shell.setDir("/startup")
    for _,file in ipairs(fs.list("/startup")) do
        if not fs.isDir("/startup/"..file) then
            shell.run("/startup/"..file)
        end
    end
end
