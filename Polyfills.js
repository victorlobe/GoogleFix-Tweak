/* GoogleFix: ES2015+ / Web-API polyfills for iOS 6-7 WebKit, injected into Google pages before any page script runs. ES5 only! */
(function(w){
if(w.__gfpoly)return;
try{if(!/(^|\.)google\.[a-z.]+$/i.test(w.location.hostname))return;}catch(e){return;}
w.__gfpoly=1;
var O=Object,AP=Array.prototype,SP=String.prototype,dp=O.defineProperty;
function def(o,k,v){if(o&&!(k in o)){try{dp(o,k,{value:v,configurable:true,writable:true,enumerable:false});}catch(e){o[k]=v;}}}
var now=function(){return new Date().getTime();};def(Date,'now',now);
var T0=Date.now();
/* globalThis */
if(typeof w.globalThis=='undefined')try{w.globalThis=w;}catch(e){}
/* performance (iOS 8+) */
if(!w.performance){var pf={timing:{navigationStart:T0,fetchStart:T0,responseStart:T0,domLoading:T0,loadEventEnd:0,domContentLoadedEventEnd:0,domInteractive:0,domComplete:0},
navigation:{type:0,redirectCount:0},now:function(){return Date.now()-T0;},getEntriesByType:function(){return [];},getEntriesByName:function(){return [];},getEntries:function(){return [];},mark:function(){},measure:function(){},clearMarks:function(){},clearMeasures:function(){},timeOrigin:T0};
try{w.performance=pf;}catch(e){}
if(!w.performance)try{dp(w,'performance',{value:pf,configurable:true,writable:true});}catch(e){}}
else if(!w.performance.now){w.performance.now=function(){return Date.now()-T0;};}
/* Symbol (string-keyed shim) */
if(typeof w.Symbol=='undefined'){var sc=0,reg={};
var Sym=function Symbol(d){if(this instanceof Sym)throw new TypeError('Symbol is not a constructor');return '@@sym_'+(d===void 0?'':String(d))+'_'+(sc++)+'_'+Math.random().toString(36).slice(2,7);};
var wk=['iterator','asyncIterator','hasInstance','isConcatSpreadable','match','matchAll','replace','search','species','split','toPrimitive','toStringTag','unscopables','dispose','asyncDispose'];
for(var i=0;i<wk.length;i++)Sym[wk[i]]='@@'+wk[i];
Sym['for']=function(k){k=String(k);return reg[k]||(reg[k]='@@for_'+k);};
Sym.keyFor=function(s){for(var k in reg)if(reg[k]===s)return k;};
w.Symbol=Sym;
var mkIt=function(a){var i=0;var it={next:function(){return i<a.length?{value:a[i++],done:false}:{value:void 0,done:true};}};it['@@iterator']=function(){return this;};return it;};
def(AP,'@@iterator',function(){return mkIt(this);});
def(SP,'@@iterator',function(){return mkIt(String(this));});
try{if(w.NodeList)def(NodeList.prototype,'@@iterator',function(){return mkIt(this);});}catch(e){}
try{if(w.HTMLCollection)def(HTMLCollection.prototype,'@@iterator',function(){return mkIt(this);});}catch(e){}
try{if(w.Uint8Array)def(Uint8Array.prototype,'@@iterator',function(){return mkIt(this);});}catch(e){}
}
/* Promise */
if(typeof w.Promise!='function'){
var P=function Promise(fn){if(!(this instanceof P))throw new TypeError('Promise must be called with new');var s=this;s._s=0;s._v=void 0;s._q=[];
var done=false;function res(v){if(done)return;done=true;rsl(s,v);}function rej(r){if(done)return;done=true;fin(s,2,r);}
try{fn(res,rej);}catch(e){rej(e);}};
var later=function(f){setTimeout(f,0);};
var fin=function(p,st,v){if(p._s)return;p._s=st;p._v=v;later(function(){var q=p._q;p._q=[];for(var i=0;i<q.length;i++)hdl(p,q[i]);});};
var rsl=function(p,v){if(v===p)return fin(p,2,new TypeError('cycle'));if(v&&(typeof v=='object'||typeof v=='function')){var th;try{th=v.then;}catch(e){return fin(p,2,e);}
if(typeof th=='function'){var c=false;try{th.call(v,function(y){if(c)return;c=true;rsl(p,y);},function(r){if(c)return;c=true;fin(p,2,r);});}catch(e){if(!c){c=true;fin(p,2,e);}}return;}}fin(p,1,v);};
var hdl=function(p,h){var cb=p._s==1?h.f:h.r;if(typeof cb!='function'){(p._s==1?h.res:h.rej)(p._v);return;}var x;try{x=cb(p._v);}catch(e){h.rej(e);return;}h.res(x);};
P.prototype.then=function(f,r){var s=this;return new P(function(res,rej){var h={f:f,r:r,res:res,rej:rej};if(s._s)later(function(){hdl(s,h);});else s._q.push(h);});};
P.prototype['catch']=function(r){return this.then(null,r);};
P.prototype['finally']=function(f){return this.then(function(v){return P.resolve(f()).then(function(){return v;});},function(e){return P.resolve(f()).then(function(){throw e;});});};
P.resolve=function(v){return v instanceof P?v:new P(function(r){r(v);});};
P.reject=function(v){return new P(function(a,r){r(v);});};
var toArr=function(it){if(it&&typeof it.length=='number')return AP.slice.call(it);var a=[];if(it&&it['@@iterator']){var i=it['@@iterator'](),n;while(!(n=i.next()).done)a.push(n.value);}return a;};
P.all=function(it){var a=toArr(it);return new P(function(res,rej){var n=a.length,out=new Array(n);if(!n)return res(out);for(var i=0;i<a.length;i++)(function(i){P.resolve(a[i]).then(function(v){out[i]=v;if(--n===0)res(out);},rej);})(i);});};
P.race=function(it){var a=toArr(it);return new P(function(res,rej){for(var i=0;i<a.length;i++)P.resolve(a[i]).then(res,rej);});};
P.allSettled=function(it){var a=toArr(it);return P.all(a.map(function(x){return P.resolve(x).then(function(v){return{status:'fulfilled',value:v};},function(e){return{status:'rejected',reason:e};});}));};
P.any=function(it){var a=toArr(it);return new P(function(res,rej){var n=a.length;if(!n)return rej(new Error('All promises were rejected'));for(var i=0;i<a.length;i++)P.resolve(a[i]).then(res,function(){if(--n===0)rej(new Error('All promises were rejected'));});});};
w.Promise=P;}
/* Object */
def(O,'setPrototypeOf',function(o,p){o.__proto__=p;return o;});
def(O,'hasOwn',function(o,k){return O.prototype.hasOwnProperty.call(o,k);});
def(O,'assign',function(t){t=O(t);for(var i=1;i<arguments.length;i++){var s=arguments[i];if(s!=null)for(var k in s)if(O.prototype.hasOwnProperty.call(s,k))t[k]=s[k];}return t;});
def(O,'entries',function(o){return O.keys(o).map(function(k){return[k,o[k]];});});
def(O,'values',function(o){return O.keys(o).map(function(k){return o[k];});});
def(O,'fromEntries',function(e){var o={};toA(e).forEach(function(p){o[p[0]]=p[1];});return o;});
def(O,'is',function(a,b){return a===b?(a!==0||1/a===1/b):(a!==a&&b!==b);});
def(O,'getOwnPropertySymbols',function(){return[];});
function toA(x){if(x==null)return[];if(typeof x.length=='number')return AP.slice.call(x);var a=[];var f=x['@@iterator'];if(typeof f=='function'){var it=f.call(x),n;while(!(n=it.next()).done)a.push(n.value);}return a;}
/* Array */
def(Array,'from',function(x,fn,th){var a=toA(typeof x=='string'?x.split(''):x);return fn?a.map(fn,th):a;});
def(Array,'of',function(){return AP.slice.call(arguments);});
def(AP,'find',function(f,t){for(var i=0;i<this.length;i++)if(f.call(t,this[i],i,this))return this[i];});
def(AP,'findIndex',function(f,t){for(var i=0;i<this.length;i++)if(f.call(t,this[i],i,this))return i;return -1;});
def(AP,'findLast',function(f,t){for(var i=this.length-1;i>=0;i--)if(f.call(t,this[i],i,this))return this[i];});
def(AP,'includes',function(v,s){for(var i=s|0;i<this.length;i++)if(this[i]===v||(v!==v&&this[i]!==this[i]))return true;return false;});
def(AP,'fill',function(v,s,e){var l=this.length;s=s|0;e=e===void 0?l:e|0;if(s<0)s+=l;if(e<0)e+=l;for(var i=s;i<e;i++)this[i]=v;return this;});
def(AP,'flat',function(d){d=d===void 0?1:d;var r=[];(function f(a,d){for(var i=0;i<a.length;i++)if(Array.isArray(a[i])&&d>0)f(a[i],d-1);else r.push(a[i]);})(this,d);return r;});
def(AP,'at',function(i){i=i|0;if(i<0)i+=this.length;return this[i];});
def(AP,'keys',function(){var i=0,s=this,it={next:function(){return i<s.length?{value:i++,done:false}:{done:true};}};it['@@iterator']=function(){return this;};return it;});
def(AP,'values',function(){return this['@@iterator']?this['@@iterator']():AP.slice.call(this);});
def(AP,'entries',function(){var i=0,s=this,it={next:function(){return i<s.length?{value:[i,s[i++]],done:false}:{done:true};}};it['@@iterator']=function(){return this;};return it;});
/* String */
def(SP,'includes',function(s,p){return this.indexOf(s,p)!==-1;});
def(SP,'startsWith',function(s,p){p=p|0;return this.substr(p,s.length)===s;});
def(SP,'endsWith',function(s,e){var t=String(this);e=e===void 0?t.length:e;return t.slice(e-s.length,e)===s;});
def(SP,'repeat',function(n){var r='',s=String(this);n=n|0;while(n-->0)r+=s;return r;});
def(SP,'padStart',function(l,c){var s=String(this);c=c===void 0?' ':String(c);while(s.length<l)s=c+s;return s.slice(s.length-Math.max(l,String(this).length));});
def(SP,'padEnd',function(l,c){var s=String(this);c=c===void 0?' ':String(c);while(s.length<l)s+=c;return s.slice(0,Math.max(l,String(this).length));});
def(SP,'trimStart',function(){return String(this).replace(/^\s+/,'');});
def(SP,'trimEnd',function(){return String(this).replace(/\s+$/,'');});
def(SP,'codePointAt',function(i){var c=this.charCodeAt(i);if(c>=0xD800&&c<=0xDBFF){var d=this.charCodeAt(i+1);if(d>=0xDC00&&d<=0xDFFF)return(c-0xD800)*0x400+d-0xDC00+0x10000;}return c;});
def(String,'fromCodePoint',function(){var r='';for(var i=0;i<arguments.length;i++){var c=arguments[i];if(c>0xFFFF){c-=0x10000;r+=String.fromCharCode(0xD800+(c>>10),0xDC00+(c&1023));}else r+=String.fromCharCode(c);}return r;});
/* Number / Math */
def(Number,'isNaN',function(v){return typeof v=='number'&&v!==v;});
def(Number,'isFinite',function(v){return typeof v=='number'&&isFinite(v);});
def(Number,'isInteger',function(v){return typeof v=='number'&&isFinite(v)&&Math.floor(v)===v;});
def(Number,'isSafeInteger',function(v){return Number.isInteger(v)&&Math.abs(v)<=9007199254740991;});
def(Number,'MAX_SAFE_INTEGER',9007199254740991);def(Number,'MIN_SAFE_INTEGER',-9007199254740991);def(Number,'EPSILON',Math.pow(2,-52));
def(Number,'parseInt',parseInt);def(Number,'parseFloat',parseFloat);
def(Math,'trunc',function(v){return v<0?Math.ceil(v):Math.floor(v);});
def(Math,'sign',function(v){v=+v;return v===0||v!==v?v:v>0?1:-1;});
def(Math,'imul',function(a,b){var ah=(a>>>16)&65535,al=a&65535,bh=(b>>>16)&65535,bl=b&65535;return((al*bl)+(((ah*bl+al*bh)<<16)>>>0)|0);});
def(Math,'clz32',function(x){x>>>=0;return x?31-Math.floor(Math.log(x)/Math.LN2):32;});
def(Math,'log2',function(x){return Math.log(x)/Math.LN2;});
def(Math,'log10',function(x){return Math.log(x)/Math.LN10;});
def(Math,'hypot',function(){var s=0;for(var i=0;i<arguments.length;i++)s+=arguments[i]*arguments[i];return Math.sqrt(s);});
def(Math,'cbrt',function(x){return x<0?-Math.pow(-x,1/3):Math.pow(x,1/3);});
def(Math,'fround',function(x){return x;});
/* Typed arrays */
var TA=['Int8Array','Uint8Array','Uint8ClampedArray','Int16Array','Uint16Array','Int32Array','Uint32Array','Float32Array','Float64Array'];
for(var t=0;t<TA.length;t++){var C=w[TA[t]];if(!C)continue;var CP=C.prototype;
def(CP,'slice',function(s,e){var l=this.length;s=s|0;e=e===void 0?l:e|0;if(s<0)s+=l;if(e<0)e+=l;if(e<s)e=s;return new this.constructor(this.subarray(s,e));});
def(CP,'fill',AP.fill);def(CP,'indexOf',AP.indexOf);def(CP,'join',AP.join);def(CP,'forEach',AP.forEach);
def(CP,'map',function(f,th){var r=new this.constructor(this.length);for(var i=0;i<this.length;i++)r[i]=f.call(th,this[i],i,this);return r;});
def(CP,'reduce',AP.reduce);def(CP,'includes',AP.includes);def(CP,'every',AP.every);def(CP,'some',AP.some);def(CP,'reverse',AP.reverse);
def(CP,'filter',function(f,th){var a=[];for(var i=0;i<this.length;i++)if(f.call(th,this[i],i,this))a.push(this[i]);return new this.constructor(a);});
def(C,'from',function(x,fn){var a=toA(x);if(fn)a=a.map(fn);return new this(a);});def(C,'of',function(){return new this(AP.slice.call(arguments));});}
/* Misc web APIs */
if(!w.requestAnimationFrame)w.requestAnimationFrame=w.webkitRequestAnimationFrame||function(f){return setTimeout(function(){f(Date.now()-T0);},16);};
if(!w.cancelAnimationFrame)w.cancelAnimationFrame=w.webkitCancelAnimationFrame||w.webkitCancelRequestAnimationFrame||clearTimeout;
if(typeof w.queueMicrotask!='function')w.queueMicrotask=function(f){setTimeout(f,0);};
if(w.navigator&&typeof w.navigator.sendBeacon!='function')try{w.navigator.sendBeacon=function(u,d){try{var x=new XMLHttpRequest();x.open('POST',u,true);x.send(d==null?'':d);}catch(e){try{(new Image).src=u;}catch(e2){}}return true;};}catch(e){}
if(w.document&&!('hidden' in w.document))try{dp(w.document,'hidden',{get:function(){return !!w.document.webkitHidden;},configurable:true});}catch(e){}
if(w.document&&!('visibilityState' in w.document))try{dp(w.document,'visibilityState',{get:function(){return w.document.webkitVisibilityState||'visible';},configurable:true});}catch(e){}
})(window);
