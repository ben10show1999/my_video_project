// Compiles a dart2wasm-generated main module from `source` which can then
// be instantiated via the `instantiate` method.
//
// `source` needs to be a `Response` object (or promise thereof) e.g. created
// via the `fetch()` JS API.
export async function compileStreaming(source) {
  const builtins = {builtins: ['js-string']};
  return new CompiledApp(
      await WebAssembly.compileStreaming(source, builtins), builtins);
}

// Compiles a dart2wasm-generated wasm module from `bytes` which is then
// instantiable via the `instantiate` method.
export async function compile(bytes) {
  const builtins = {builtins: ['js-string']};
  return new CompiledApp(await WebAssembly.compile(bytes, builtins), builtins);
}

class CompiledApp {
  constructor(module, builtins) {
    this.module = module;
    this.builtins = builtins;
  }

  // The second argument is an options object containing:
  // `loadDeferredModules` is a JS function that takes an array of module names
  //   matching wasm files produced by the dart2wasm compiler. It also takes a
  //   callback that should be invoked for each loaded module with 2 arguments:
  //   (1) the module name, (2) the loaded module in a format supported by
  //   `WebAssembly.compile` or `WebAssembly.compileStreaming`. The callback
  //   returns a Promise that resolves when the module is instantiated.
  //   loadDeferredModules should return a Promise that resolves when all the
  //   modules have been loaded and the callback promises have resolved.
  // `loadDeferredId` is a JS function that takes load ID produced by the
  //   compiler when the `use-load-ids` option is passed. Each load ID maps to
  //   one or more wasm files as specified in the emitted JSON file. It also
  //   takes a callback that should be invoked for each loaded module with 2
  //   arguments: (1) the module name, (2) the loaded module in a format
  //   supported by `WebAssembly.compile` or `WebAssembly.compileStreaming`.
  //   The callback returns a Promise that resolves when the module is
  //   instantiated.
  //   loadDeferredId should return a Promise that resolves when all the
  //   modules have been loaded and the callback promises have resolved.
  async instantiate(additionalImports, {loadDeferredModules, loadDeferredId} = {}) {
    let dartInstance;

    // Prints to the console
    function printToConsole(value) {
      if (typeof dartPrint == "function") {
        dartPrint(value);
        return;
      }
      if (typeof console == "object" && typeof console.log != "undefined") {
        console.log(value);
        return;
      }
      if (typeof print == "function") {
        print(value);
        return;
      }

      throw "Unable to print message: " + value;
    }

    // A special symbol attached to functions that wrap Dart functions.
    const jsWrappedDartFunctionSymbol = Symbol("JSWrappedDartFunction");

    function finalizeWrapper(dartFunction, wrapped) {
      wrapped.dartFunction = dartFunction;
      wrapped[jsWrappedDartFunctionSymbol] = true;
      return wrapped;
    }

    // Imports
    const dart2wasm = {
            AB: x0 => new Int16Array(x0),
      AC: (o, start, length) => new Uint8Array(o.buffer, o.byteOffset + start, length),
      AD: (x0,x1,x2) => x0.setAttribute(x1,x2),
      AE: (x0,x1) => x0.matchMedia(x1),
      AF: x0 => x0.tiltY,
      AG: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      AH: x0 => x0.unlock(),
      AI: (x0,x1) => { x0.max = x1 },
      AJ: (x0,x1) => x0.forEach(x1),
      AK: (x0,x1) => { x0.playbackRate = x1 },
      AL: (o, p, v) => o[p] = v,
      AM: (x0,x1) => { x0.defaultConfig = x1 },
      AN: x0 => x0.trustedTypes,
      AO: (x0,x1,x2,x3,x4) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4),
      B: s => printToConsole(s),
      BB: x0 => new Uint16Array(x0),
      BC: (o, start, length) => new Int8Array(o.buffer, o.byteOffset + start, length),
      BD: x0 => x0.getBoundingClientRect(),
      BE: x0 => x0.matches,
      BF: x0 => x0.tiltX,
      BG: x0 => x0.now(),
      BH: (x0,x1) => x0.lock(x1),
      BI: (x0,x1) => { x0.disabled = x1 },
      BJ: x0 => x0.name,
      BK: x0 => x0.requestFullscreen(),
      BL: (x0,x1) => { x0.controls = x1 },
      BM: x0 => globalThis.firebase_remote_config.fetchAndActivate(x0),
      BN: (x0,x1) => { x0.crossOrigin = x1 },
      BO: (x0,x1,x2,x3,x4,x5) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4,x5),
      C: Function.prototype.call.bind(Number.prototype.toString),
      CB: x0 => new Int32Array(x0),
      CC: (x0,x1) => x0.querySelector(x1),
      CD: (ms, c) =>
      setTimeout(() => dartInstance.exports.$invokeCallback(c),ms),
      CE: o => typeof o === 'function' && o[jsWrappedDartFunctionSymbol] === true,
      CF: x0 => x0.pointerType,
      CG: x0 => x0.performance,
      CH: x0 => x0.orientation,
      CI: (x0,x1) => { x0.scrollLeft = x1 },
      CJ: x0 => x0.statusText,
      CK: (x0,x1) => x0.lock(x1),
      CL: x0 => x0.message,
      CM: (x0,x1) => globalThis.firebase_remote_config.getString(x0,x1),
      CN: (x0,x1) => globalThis.firebase_firestore.doc(x0,x1),
      CO: (x0,x1,x2,x3,x4,x5,x6) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4,x5,x6),
      D: Function.prototype.call.bind(BigInt.prototype.toString),
      DB: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI32ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      DC: (x0,x1) => x0.item(x1),
      DD: s => new Date(s * 1000).getTimezoneOffset() * 60,
      DE: f => f.dartFunction,
      DF: x0 => x0.pointerId,
      DG: (d, digits) => d.toFixed(digits),
      DH: (x0,x1) => x0.querySelector(x1),
      DI: (x0,x1) => { x0.spellcheck = x1 },
      DJ: x0 => x0.url,
      DK: x0 => x0.exitFullscreen(),
      DL: (x0,x1) => x0.getItem(x1),
      DM: x0 => x0.code,
      DN: (x0,x1) => globalThis.firebase_firestore.getFirestore(x0,x1),
      DO: (x0,x1,x2,x3,x4,x5,x6,x7) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4,x5,x6,x7),
      E: (exn) => {
        let stackString = exn.toString();
        let frames = stackString.split('\n');
        let drop = 4;
        if (frames[0].startsWith('Error')) {
            drop += 1;
        }
        return frames.slice(drop).join('\n');
      },
      EB: x0 => new Uint32Array(x0),
      EC: x0 => x0.length,
      ED: Date.now,
      EE: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      EF: x0 => x0.getCoalescedEvents(),
      EG: x0 => x0.maxHeight,
      EH: (x0,x1) => { x0.title = x1 },
      EI: (x0,x1) => { x0.disabled = x1 },
      EJ: x0 => x0.status,
      EK: x0 => x0.unlock(),
      EL: (x0,x1) => x0.removeItem(x1),
      EM: () => globalThis.Notification.requestPermission(),
      EN: x0 => x0.path,
      EO: (x0,x1,x2,x3,x4,x5,x6,x7,x8) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4,x5,x6,x7,x8),
      F: () => new Error().stack,
      FB: x0 => new Float32Array(x0),
      FC: (x0,x1) => x0.querySelectorAll(x1),
      FD: (handle) => clearTimeout(handle),
      FE: (wasmFunction,f) => finalizeWrapper(f, function(x0,x1) { return wasmFunction(f,arguments.length,x0,x1) }),
      FF: (x0,x1) => x0.getModifierState(x1),
      FG: x0 => x0.maxWidth,
      FH: (x0,x1) => x0.vibrate(x1),
      FI: (a, i) => a.splice(i, 1),
      FJ: x0 => x0.getReader(),
      FK: x0 => x0.orientation,
      FL: (x0,x1,x2) => x0.setItem(x1,x2),
      FM: (x0,x1) => ({vapidKey: x0,serviceWorkerRegistration: x1}),
      FN: x0 => x0.fromCache,
      FO: (x0,x1,x2,x3,x4,x5,x6,x7,x8,x9) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4,x5,x6,x7,x8,x9),
      G: s => JSON.stringify(s),
      GB: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmF32ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      GC: (x0,x1) => x0.getAttribute(x1),
      GD: (x0,x1) => x0.closest(x1),
      GE: (p, s, f) => p.then(s, (e) => f(e, e === undefined)),
      GF: s => s.trimLeft(),
      GG: x0 => x0.minHeight,
      GH: x0 => x0.arrayBuffer(),
      GI: a => a.pop(),
      GJ: x0 => x0.read(),
      GK: x0 => x0.screen,
      GL: x0 => x0.localStorage,
      GM: (x0,x1) => globalThis.firebase_messaging.getToken(x0,x1),
      GN: x0 => x0.hasPendingWrites,
      GO: () => globalThis.firebase_firestore.documentId(),
      H: Function.prototype.call.bind(Number.prototype.toString),
      HB: x0 => new Float64Array(x0),
      HC: x0 => x0.remove(),
      HD: x0 => x0.bottom,
      HE: (o, i) => o[i],
      HF: s => s.toUpperCase(),
      HG: x0 => x0.minWidth,
      HH: o => {
        if (o === null || o === undefined) return 0;
        if (o instanceof ArrayBuffer) return 1;
        if (globalThis.SharedArrayBuffer !== undefined &&
            o instanceof SharedArrayBuffer) {
          return 2;
        }
        return 3;
      },
      HI: (map, o, v) => map.set(o, v),
      HJ: x0 => x0.value,
      HK: x0 => x0.documentElement,
      HL: (x0,x1,x2) => x0.removeEventListener(x1,x2),
      HM: x0 => x0.link,
      HN: x0 => x0.metadata,
      HO: (x0,x1) => new firebase_firestore.GeoPoint(x0,x1),
      I: Function.prototype.call.bind(String.prototype.indexOf),
      IB: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmF64ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      IC: (x0,x1) => x0.appendChild(x1),
      ID: x0 => x0.top,
      IE: o => o.length,
      IF: (x0,x1) => x0[x1],
      IG: (x0,x1) => x0.removeProperty(x1),
      IH: x0 => x0.status,
      II: (map, o) => map.get(o),
      IJ: x0 => x0.done,
      IK: (x0,x1) => { x0.volume = x1 },
      IL: (o, p) => delete o[p],
      IM: x0 => x0.analyticsLabel,
      IN: x0 => ({serverTimestamps: x0}),
      IO: x0 => globalThis.firebase_firestore.vector(x0),
      J: (s, p, i) => s.lastIndexOf(p, i),
      JB: x0 => new ArrayBuffer(x0),
      JC: (x0,x1) => x0.append(x1),
      JD: x0 => x0.right,
      JE: o => {
        if (o === undefined) return 1;
        var type = typeof o;
        if (type === 'boolean') return 2;
        if (type === 'number') return 3;
        if (type === 'string') return 4;
        if (o instanceof Array) return 5;
        if (ArrayBuffer.isView(o)) {
          if (o instanceof Int8Array) return 6;
          if (o instanceof Uint8Array) return 7;
          if (o instanceof Uint8ClampedArray) return 8;
          if (o instanceof Int16Array) return 9;
          if (o instanceof Uint16Array) return 10;
          if (o instanceof Int32Array) return 11;
          if (o instanceof Uint32Array) return 12;
          if (o instanceof Float32Array) return 13;
          if (o instanceof Float64Array) return 14;
          if (o instanceof DataView) return 15;
        }
        if (o instanceof ArrayBuffer) return 16;
        // Feature check for `SharedArrayBuffer` before doing a type-check.
        if (globalThis.SharedArrayBuffer !== undefined &&
            o instanceof SharedArrayBuffer) {
            return 17;
        }
        if (o instanceof Promise) return 18;
        return 19;
      },
      JF: x0 => x0.length,
      JG: (x0,x1) => x0.add(x1),
      JH: (x0,x1) => x0.fetch(x1),
      JI: () => new WeakMap(),
      JJ: x0 => x0.cancel(),
      JK: (x0,x1) => { x0.muted = x1 },
      JL: (x0,x1) => ({body: x0,icon: x1}),
      JM: x0 => x0.image,
      JN: x0 => x0.metadata,
      JO: x0 => globalThis.firebase_firestore.Bytes.fromUint8Array(x0),
      K: (exn) => {
        if (exn instanceof Error) {
          return exn.stack;
        } else {
          return null;
        }
      },
      KB: (x0,x1,x2) => new Uint8Array(x0,x1,x2),
      KC: (x0,x1,x2,x3) => x0.setProperty(x1,x2,x3),
      KD: x0 => x0.left,
      KE: x0 => x0.language,
      KF: (x0,x1) => x0.exec(x1),
      KG: x0 => x0.data,
      KH: x0 => x0.content,
      KI: x0 => new WeakRef(x0),
      KJ: x0 => x0.body,
      KK: x0 => x0.muted,
      KL: (x0,x1) => new Notification(x0,x1),
      KM: x0 => x0.body,
      KN: x0 => x0.toArray(),
      KO: (x0,x1) => globalThis.firebase_firestore.collection(x0,x1),
      L: o => o === undefined,
      LB: (x0,x1,x2) => new DataView(x0,x1,x2),
      LC: x0 => x0.style,
      LD: x0 => x0.clientY,
      LE: (x0,x1,x2,x3) => x0.register(x1,x2,x3),
      LF: x0 => x0.index,
      LG: (x0,x1) => { x0.scrollTop = x1 },
      LH: x0 => x0.document,
      LI: x0 => x0.deref(),
      LJ: x0 => x0.headers,
      LK: x0 => x0.paused,
      LL: () => globalThis.Notification.permission,
      LM: x0 => x0.title,
      LN: x0 => x0.toUint8Array(),
      LO: x0 => x0.length,
      M: o => String(o),
      MB: (o, p) => o[p],
      MC: x0 => x0.debugShowSemanticsNodes,
      MD: x0 => x0.clientX,
      ME: () => globalThis.window.FinalizationRegistry,
      MF: x0 => x0.flags,
      MG: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
      MH: () => typeof dartUseDateNowForTicks !== "undefined",
      MI: () => globalThis.WeakRef,
      MJ: x0 => x0.signal,
      MK: (x0,x1,x2) => x0.setAttribute(x1,x2),
      ML: x0 => x0.href,
      MM: x0 => x0.fcmOptions,
      MN: () => globalThis.firebase_firestore.Bytes,
      MO: x0 => x0.getReader(),
      N: (c) =>
      queueMicrotask(() => dartInstance.exports.$invokeCallback(c)),
      NB: (o) => new DataView(o.buffer, o.byteOffset, o.byteLength),
      NC: o => o,
      ND: x0 => x0.changedTouches,
      NE: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      NF: (a, s) => a.join(s),
      NG: (x0,x1) => { x0.value = x1 },
      NH: () => Date.now(),
      NI: (o, offsetInBytes, lengthInBytes) => {
        var dst = new ArrayBuffer(lengthInBytes);
        new Uint8Array(dst).set(new Uint8Array(o, offsetInBytes, lengthInBytes));
        return new DataView(dst);
      },
      NJ: (x0,x1) => x0.getRandomValues(x1),
      NK: (x0,x1) => x0.removeAttribute(x1),
      NL: x0 => x0.location,
      NM: x0 => x0.notification,
      NN: () => globalThis.firebase_firestore.VectorValue,
      NO: x0 => x0.value,
      O: (x0,x1) => x0.didCreateEngineInitializer(x1),
      OB: Function.prototype.call.bind(Object.getOwnPropertyDescriptor(DataView.prototype, 'byteLength').get),
      OC: o => {
        if (o === undefined || o === null) return 0;
        if (typeof o === 'boolean') return 1;
        return 2;
      },
      OD: x0 => x0.offsetY,
      OE: x0 => new window.FinalizationRegistry(x0),
      OF: (x0,x1) => x0.error(x1),
      OG: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
      OH: () => 1000 * performance.now(),
      OI: (a, s, e) => a.slice(s, e),
      OJ: () => globalThis.crypto,
      OK: x0 => x0.remove(),
      OL: () => globalThis.window,
      OM: x0 => x0.messageId,
      ON: x0 => x0.longitude,
      OO: x0 => x0.done,
      P: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      PB: o => o.byteOffset,
      PC: (x0,x1) => x0.warn(x1),
      PD: x0 => x0.offsetX,
      PE: (x0,x1) => x0.unregister(x1),
      PF: () => globalThis.console,
      PG: (x0,x1) => { x0.value = x1 },
      PH: x0 => new Uint8Array(x0),
      PI: (x0,x1) => x0.revokeObjectURL(x1),
      PJ: l => new DataView(new ArrayBuffer(l)),
      PK: (x0,x1) => x0.getContext(x1),
      PL: () => {
        // On browsers return `globalThis.location.href`
        if (globalThis.location != null) {
          return globalThis.location.href;
        }
        return null;
      },
      PM: x0 => x0.from,
      PN: x0 => x0.latitude,
      PO: x0 => x0.read(),
      Q: (wasmFunction,f) => finalizeWrapper(f, function() { return wasmFunction(f,arguments.length) }),
      QB: o => o.buffer,
      QC: x0 => x0.console,
      QD: x0 => x0.type,
      QE: (x0,x1) => x0.contains(x1),
      QF: s => s.trimRight(),
      QG: s => {
        if (/[[\]{}()*+?.\\^$|]/.test(s)) {
            s = s.replace(/[[\]{}()*+?.\\^$|]/g, '\\$&');
        }
        return s;
      },
      QH: (x0,x1,x2) => x0.slice(x1,x2),
      QI: (x0,x1) => { x0.src = x1 },
      QJ: x0 => x0.play(),
      QK: (x0,x1,x2,x3,x4,x5) => x0.drawImage(x1,x2,x3,x4,x5),
      QL: (x0,x1) => x0.transferFromImageBitmap(x1),
      QM: x0 => x0.collapseKey,
      QN: () => globalThis.firebase_firestore.GeoPoint,
      QO: (x0,x1) => new OffscreenCanvas(x0,x1),
      R: (x0,x1) => ({initializeEngine: x0,autoStart: x1}),
      RB: Function.prototype.call.bind(DataView.prototype.getUint8),
      RC: () => globalThis.window,
      RD: x0 => x0.maxTouchPoints,
      RE: (s) => +s,
      RF: x0 => x0.blur(),
      RG: x0 => x0.value,
      RH: (x0,x1) => x0.decode(x1),
      RI: (x0,x1,x2,x3,x4) => globalThis.createImageBitmap(x0,x1,x2,x3,x4),
      RJ: x0 => x0.message,
      RK: (x0,x1,x2) => x0.toDataURL(x1,x2),
      RL: (x0,x1) => x0.getContext(x1),
      RM: x0 => x0.data,
      RN: (x0,x1) => x0.data(x1),
      RO: x0 => x0.assetBase,
      S: (wasmFunction,f) => finalizeWrapper(f, function(x0,x1) { return wasmFunction(f,arguments.length,x0,x1) }),
      SB: (b, o) => new DataView(b, o),
      SC: (o, c) => o instanceof c,
      SD: x0 => x0.platform,
      SE: s => {
        if (!/^\s*[+-]?(?:Infinity|NaN|(?:\.\d+|\d+(?:\.\d*)?)(?:[eE][+-]?\d+)?)\s*$/.test(s)) {
          return NaN;
        }
        return parseFloat(s);
      },
      SF: x0 => x0.button,
      SG: x0 => x0.selectionDirection,
      SH: (x0,x1) => x0.adoptText(x1),
      SI: x0 => x0.naturalHeight,
      SJ: (x0,x1) => { x0.currentTime = x1 },
      SK: x0 => x0.height,
      SL: (x0,x1) => { x0.height = x1 },
      SM: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      SN: x0 => x0.nanoseconds,
      SO: x0 => x0.loader,
      T: x0 => new Promise(x0),
      TB: (b, o, l) => new DataView(b, o, l),
      TC: (string, token) => string.split(token),
      TD: x0 => x0.body,
      TE: s => s.trim(),
      TF: x0 => x0.innerHeight,
      TG: x0 => x0.selectionStart,
      TH: x0 => x0.first(),
      TI: x0 => x0.naturalWidth,
      TJ: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      TK: x0 => x0.width,
      TL: (x0,x1) => { x0.width = x1 },
      TM: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      TN: x0 => x0.seconds,
      TO: () => globalThis._flutter,
      U: (x0,x1,x2) => x0.call(x1,x2),
      UB: Function.prototype.call.bind(DataView.prototype.getFloat64),
      UC: o => o instanceof Array,
      UD: () => globalThis.document,
      UE: x0 => x0.classList,
      UF: x0 => x0.innerWidth,
      UG: x0 => x0.selectionEnd,
      UH: x0 => x0.next(),
      UI: x0 => x0.decode(),
      UJ: (x0,x1,x2) => x0.addEventListener(x1,x2),
      UK: (x0,x1) => { x0.height = x1 },
      UL: x0 => x0.height,
      UM: (x0,x1) => ({next: x0,error: x1}),
      UN: () => globalThis.firebase_firestore.Timestamp,
      V: (constructor, args) => {
        const factoryFunction = constructor.bind.apply(
            constructor, [null, ...args]);
        return new factoryFunction();
      },
      VB: o => {
        if (o === null || o === undefined) return 0;
        if (o instanceof Float64Array) return 1;
        return 2;
      },
      VC: (a, i) => a[i],
      VD: (x0,x1,x2) => x0.addEventListener(x1,x2),
      VE: x0 => x0.preventDefault(),
      VF: x0 => x0.height,
      VG: x0 => x0.value,
      VH: x0 => x0.current(),
      VI: (x0,x1) => { x0.decoding = x1 },
      VJ: x0 => x0.preventDefault(),
      VK: x0 => x0.videoHeight,
      VL: x0 => x0.width,
      VM: (x0,x1) => globalThis.firebase_messaging.onMessage(x0,x1),
      VN: () => globalThis.firebase_firestore.DocumentReference,
      W: x0 => new Array(x0),
      WB: Function.prototype.call.bind(DataView.prototype.setFloat64),
      WC: a => a.length,
      WD: x0 => x0.hasFocus(),
      WE: x0 => x0.parent,
      WF: x0 => x0.width,
      WG: x0 => x0.selectionDirection,
      WH: (x0,x1) => new Intl.v8BreakIterator(x0,x1),
      WI: (x0,x1) => { x0.crossOrigin = x1 },
      WJ: x0 => x0.firstElementChild,
      WK: (x0,x1) => { x0.width = x1 },
      WL: x0 => x0.rasterEndMilliseconds,
      WM: x0 => globalThis.firebase_messaging.getMessaging(x0),
      WN: x0 => x0.path,
      X: o => [o],
      XB: (t, s) => t.set(s),
      XC: (x0,x1) => x0.test(x1),
      XD: x0 => x0.relatedTarget,
      XE: x0 => x0.timeStamp,
      XF: x0 => x0.clientHeight,
      XG: x0 => x0.selectionStart,
      XH: x0 => x0.v8BreakIterator,
      XI: (x0,x1) => x0.createObjectURL(x1),
      XJ: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      XK: x0 => x0.videoWidth,
      XL: x0 => x0.rasterStartMilliseconds,
      XM: x0 => x0.measurementId,
      XN: x0 => x0.ref,
      Y: (o0, o1) => [o0, o1],
      YB: Function.prototype.call.bind(DataView.prototype.setFloat32),
      YC: x0 => x0.userAgent,
      YD: x0 => x0.shiftKey,
      YE: (x0,x1) => x0.hasAttribute(x1),
      YF: x0 => x0.clientWidth,
      YG: x0 => x0.selectionEnd,
      YH: () => globalThis.Intl,
      YI: x0 => x0.URL,
      YJ: x0 => x0.data,
      YK: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
      YL: x0 => x0.imageBitmaps,
      YM: x0 => x0.appId,
      YN: x0 => x0.doc,
      Z: (o0, o1, o2) => [o0, o1, o2],
      ZB: Function.prototype.call.bind(DataView.prototype.getFloat32),
      ZC: x0 => x0.navigator,
      ZD: (decoder, codeUnits) => decoder.decode(codeUnits),
      ZE: x0 => x0.buttons,
      ZF: (x0,x1) => { x0.content = x1 },
      ZG: x0 => x0.keyCode,
      ZH: (x0,x1) => x0.segment(x1),
      ZI: x0 => new Blob(x0),
      ZJ: (x0,x1) => x0.createElement(x1),
      ZK: (x0,x1,x2,x3) => x0.removeEventListener(x1,x2,x3),
      ZL: x0 => x0.canvasKitMaximumSurfaces,
      ZM: x0 => x0.messagingSenderId,
      ZN: x0 => x0.newIndex,
      a: (o0, o1, o2, o3) => [o0, o1, o2, o3],
      aB: o => {
        if (o === null || o === undefined) return 0;
        if (o instanceof Float32Array) return 1;
        return 2;
      },
      aC: Function.prototype.call.bind(String.prototype.toLowerCase),
      aD: () => new TextDecoder("utf-8", {fatal: true}),
      aE: x0 => x0.ctrlKey,
      aF: (x0,x1) => { x0.name = x1 },
      aG: (x0,x1) => x0.scrollIntoView(x1),
      aH: x0 => x0.index,
      aI: (x0,x1,x2,x3,x4) => ({type: x0,data: x1,premultiplyAlpha: x2,colorSpaceConversion: x3,preferAnimation: x4}),
      aJ: (x0,x1) => x0.add(x1),
      aK: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      aL: x0 => x0.nextSibling,
      aM: x0 => x0.authDomain,
      aN: x0 => x0.oldIndex,
      b: (x0,x1,x2) => { x0[x1] = x2 },
      bB: Function.prototype.call.bind(DataView.prototype.getUint32),
      bC: Object.is,
      bD: () => new TextDecoder("utf-8", {fatal: false}),
      bE: x0 => x0.y,
      bF: x0 => x0.head,
      bG: x0 => x0.multiViewEnabled,
      bH: x0 => x0.next(),
      bI: x0 => new window.ImageDecoder(x0),
      bJ: (x0,x1) => { x0.srcdoc = x1 },
      bK: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      bL: (x0,x1) => x0.debug(x1),
      bM: x0 => x0.projectId,
      bN: x0 => x0.type,
      c: o => o,
      cB: o => {
        if (o === null || o === undefined) return 0;
        if (o instanceof Uint32Array) return 1;
        return 2;
      },
      cC: x0 => x0.vendor,
      cD: (a, i, v) => a[i] = v,
      cE: x0 => x0.x,
      cF: (x0,x1) => x0.removeChild(x1),
      cG: (x0,x1) => x0.replaceWith(x1),
      cH: x0 => x0.value,
      cI: x0 => x0.name,
      cJ: x0 => x0.sandbox,
      cK: (x0,x1) => { x0.preload = x1 },
      cL: x0 => x0.hostElement,
      cM: x0 => x0.name,
      cN: x0 => x0.docChanges(),
      d: (o, p) => o[p],
      dB: Function.prototype.call.bind(DataView.prototype.getInt32),
      dC: (x0,x1) => x0.createTextNode(x1),
      dD: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI8ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      dE: x0 => x0.scrollTop,
      dF: x0 => x0.firstChild,
      dG: (x0,x1) => { x0.type = x1 },
      dH: x0 => x0.done,
      dI: x0 => x0.repetitionCount,
      dJ: (x0,x1) => { x0.height = x1 },
      dK: (x0,x1) => { x0.playsInline = x1 },
      dL: x0 => x0.location,
      dM: x0 => x0.name,
      dN: x0 => x0.docs,
      e: () => globalThis,
      eB: o => {
        if (o === null || o === undefined) return 0;
        if (o instanceof Int32Array) return 1;
        return 2;
      },
      eC: (x0,x1) => { x0.id = x1 },
      eD: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI32ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      eE: x0 => x0.offsetTop,
      eF: x0 => x0.viewConstraints,
      eG: (x0,x1) => { x0.className = x1 },
      eH: (o, m, a) => o[m].apply(o, a),
      eI: x0 => x0.frameCount,
      eJ: (x0,x1) => { x0.width = x1 },
      eK: (x0,x1) => { x0.crossOrigin = x1 },
      eL: (x0,x1) => x0.getModifierState(x1),
      eM: (o) => {
        const typeofValue = typeof o;
        return (typeofValue === 'object') ||
            typeofValue === 'function';
      },
      eN: (x0,x1) => ({includeMetadataChanges: x0,source: x1}),
      f: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      fB: o => o instanceof Uint16Array,
      fC: (x0,x1) => { x0.nonce = x1 },
      fD: x0 => x0.visibilityState,
      fE: x0 => x0.scrollLeft,
      fF: x0 => x0.hostElement,
      fG: (x0,x1) => { x0.tabIndex = x1 },
      fH: x0 => x0.iterator,
      fI: x0 => x0.selectedTrack,
      fJ: (x0,x1) => { x0.border = x1 },
      fK: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      fL: x0 => x0.metaKey,
      fM: (x0,x1,x2,x3,x4,x5,x6,x7) => ({apiKey: x0,authDomain: x1,databaseURL: x2,projectId: x3,storageBucket: x4,messagingSenderId: x5,measurementId: x6,appId: x7}),
      fN: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      g: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      gB: Function.prototype.call.bind(DataView.prototype.getUint16),
      gC: x0 => x0.nonce,
      gD: (x0,x1,x2) => x0.removeEventListener(x1,x2),
      gE: x0 => x0.offsetLeft,
      gF: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      gG: (x0,x1) => { x0.name = x1 },
      gH: () => globalThis.Symbol,
      gI: x0 => x0.completed,
      gJ: x0 => x0.style,
      gK: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      gL: x0 => x0.altKey,
      gM: (x0,x1) => globalThis.firebase_core.initializeApp(x0,x1),
      gN: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      h: (x0,x1) => ({addView: x0,removeView: x1}),
      hB: o => o instanceof Int16Array,
      hC: () => globalThis.window.flutterConfiguration,
      hD: x0 => x0.disconnect(),
      hE: x0 => x0.offsetParent,
      hF: x0 => ({runApp: x0}),
      hG: (x0,x1) => { x0.placeholder = x1 },
      hH: (x0,x1) => new Intl.Segmenter(x0,x1),
      hI: x0 => x0.ready,
      hJ: () => globalThis.document,
      hK: (x0,x1) => x0.querySelectorAll(x1),
      hL: x0 => x0.ctrlKey,
      hM: x0 => x0.storageBucket,
      hN: x0 => x0.call(),
      i: (l, r) => l === r,
      iB: Function.prototype.call.bind(DataView.prototype.getInt16),
      iC: (x0,x1) => x0.attachShadow(x1),
      iD: x0 => new Intl.Locale(x0),
      iE: (o, p, r) => o.replace(p, () => r),
      iF: Function.prototype.call.bind(DataView.prototype.getBigInt64),
      iG: (x0,x1) => { x0.autocomplete = x1 },
      iH: x0 => x0.Segmenter,
      iI: x0 => x0.tracks,
      iJ: x0 => x0.pop(),
      iK: (x0,x1) => x0.item(x1),
      iL: x0 => x0.isComposing,
      iM: x0 => x0.databaseURL,
      iN: (x0,x1,x2,x3) => globalThis.firebase_firestore.onSnapshot(x0,x1,x2,x3),
      j: x0 => x0.random(),
      jB: o => o instanceof Uint8ClampedArray,
      jC: (x0,x1) => x0.createElement(x1),
      jD: x0 => x0.region,
      jE: (x0,x1) => { x0.lastIndex = x1 },
      jF: Function.prototype.call.bind(DataView.prototype.setBigInt64),
      jG: (x0,x1) => { x0.name = x1 },
      jH: x0 => x0.buffer,
      jI: x0 => x0.close(),
      jJ: x0 => x0.abort(),
      jK: x0 => x0.length,
      jL: x0 => x0.code,
      jM: x0 => x0.apiKey,
      jN: (x0,x1,x2) => globalThis.firebase_firestore.where(x0,x1,x2),
      k: o => o,
      kB: o => {
        if (o === null || o === undefined) return 0;
        if (o instanceof Uint8Array) return 1;
        return 2;
      },
      kC: x0 => x0.scale,
      kD: x0 => x0.script,
      kE: (s, m) => {
        try {
          return new RegExp(s, m);
        } catch (e) {
          return String(e);
        }
      },
      kF: (o, start, length) => new BigInt64Array(o.buffer, o.byteOffset + start, length),
      kG: (x0,x1) => { x0.placeholder = x1 },
      kH: x0 => x0.wasmMemory,
      kI: (x0,x1) => ({frameIndex: x0,completeFramesOnly: x1}),
      kJ: x0 => x0.pause(),
      kK: (x0,x1) => x0.append(x1),
      kL: x0 => x0.repeat,
      kM: x0 => x0.options,
      kN: (x0,x1) => globalThis.firebase_firestore.query(x0,x1),
      l: o => {
        if (o === undefined || o === null) return 0;
        if (typeof o === 'number') return 1;
        return 2;
      },
      lB: Function.prototype.call.bind(DataView.prototype.setInt32),
      lC: x0 => x0.visualViewport,
      lD: x0 => x0.language,
      lE: o => o instanceof RegExp,
      lF: (x0,x1,x2,x3) => x0.pushState(x1,x2,x3),
      lG: (x0,x1) => { x0.action = x1 },
      lH: () => globalThis.window._flutter_skwasmInstance,
      lI: (x0,x1) => x0.decode(x1),
      lJ: x0 => ({xhrSetup: x0}),
      lK: (x0,x1) => x0.append(x1),
      lL: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      lM: () => globalThis.firebase_core.SDK_VERSION,
      lN: (x0,x1) => new firebase_firestore.Timestamp(x0,x1),
      m: () => globalThis.Math,
      mB: Function.prototype.call.bind(DataView.prototype.setUint32),
      mC: x0 => x0.devicePixelRatio,
      mD: x0 => x0.languages,
      mE: x0 => x0.dotAll,
      mF: x0 => x0.history,
      mG: (x0,x1) => { x0.method = x1 },
      mH: () => new TextDecoder(),
      mI: x0 => x0.displayHeight,
      mJ: x0 => new Hls(x0),
      mK: x0 => x0.head,
      mL: x0 => globalThis.Wakelock.toggle(x0),
      mM: (x0,x1,x2) => globalThis.firebase_core.registerVersion(x0,x1,x2),
      mN: (wasmFunction,f) => finalizeWrapper(f, function() { return wasmFunction(f,arguments.length) }),
      n: (x0,x1) => x0.prepend(x1),
      nB: Function.prototype.call.bind(DataView.prototype.setInt16),
      nC: x0 => x0.height,
      nD: (x0,x1) => x0.observe(x1),
      nE: x0 => x0.unicode,
      nF: x0 => x0.search,
      nG: (x0,x1) => { x0.noValidate = x1 },
      nH: x0 => x0.debugSkipFontRetryDelay,
      nI: x0 => x0.displayWidth,
      nJ: (x0,x1) => x0.loadSource(x1),
      nK: (x0,x1) => { x0.src = x1 },
      nL: (x0,x1) => x0.appendChild(x1),
      nM: x0 => x0.sessionStorage,
      nN: () => globalThis.firebase_firestore.and,
      o: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
      oB: Function.prototype.call.bind(DataView.prototype.setUint16),
      oC: x0 => x0.width,
      oD: (wasmFunction,f) => finalizeWrapper(f, function(x0,x1) { return wasmFunction(f,arguments.length,x0,x1) }),
      oE: x0 => x0.ignoreCase,
      oF: x0 => x0.location,
      oG: (x0,x1) => x0.removeAttribute(x1),
      oH: (x0,x1,x2) => x0.set(x1,x2),
      oI: x0 => x0.duration,
      oJ: (x0,x1) => x0.attachMedia(x1),
      oK: (x0,x1) => { x0.type = x1 },
      oL: x0 => x0.id,
      oM: (x0,x1) => x0.debug(x1),
      oN: () => globalThis.firebase_firestore.or,
      p: b => !!b,
      pB: Function.prototype.call.bind(DataView.prototype.setUint8),
      pC: x0 => x0.screen,
      pD: x0 => new ResizeObserver(x0),
      pE: x0 => x0.multiline,
      pF: x0 => x0.pathname,
      pG: x0 => x0.isConnected,
      pH: x0 => x0.fontFallbackBaseUrl,
      pI: x0 => x0.image,
      pJ: (x0,x1) => { x0.src = x1 },
      pK: (x0,x1) => { x0.charset = x1 },
      pL: (x0,x1) => { x0.id = x1 },
      pM: (wasmFunction,f) => finalizeWrapper(f, function(x0,x1) { return wasmFunction(f,arguments.length,x0,x1) }),
      pN: x0 => globalThis.firebase_firestore.limitToLast(x0),
      q: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      qB: Function.prototype.call.bind(DataView.prototype.setInt8),
      qC: (string, times) => string.repeat(times),
      qD: (x0,x1) => x0.getPropertyValue(x1),
      qE: (o, p, r) => o.replaceAll(p, () => r),
      qF: (x0,x1,x2,x3) => x0.replaceState(x1,x2,x3),
      qG: x0 => x0.click(),
      qH: (handle) => clearInterval(handle),
      qI: () => globalThis.window.ImageDecoder,
      qJ: (x0,x1) => x0.canPlayType(x1),
      qK: (x0,x1) => { x0.async = x1 },
      qL: (x0,x1) => x0.querySelector(x1),
      qM: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      qN: x0 => globalThis.firebase_firestore.limit(x0),
      r: (x0,x1) => x0.focus(x1),
      rB: Function.prototype.call.bind(DataView.prototype.getInt8),
      rC: o => {
        if (o === null || o === undefined) return 0;
        if (typeof(o) === 'string') return 1;
        return 2;
      },
      rD: x0 => globalThis.parseFloat(x0),
      rE: x0 => x0.deltaMode,
      rF: o => {
        const proto = Object.getPrototypeOf(o);
        return proto === Object.prototype || proto === null;
      },
      rG: (x0,x1) => x0.getElementsByClassName(x1),
      rH: (ms, c) =>
      setInterval(() => dartInstance.exports.$invokeCallback(c), ms),
      rI: (x0,x1) => x0.get(x1),
      rJ: () => globalThis.Hls.isSupported(),
      rK: x0 => x0.message,
      rL: (x0,x1,x2,x3) => x0.open(x1,x2,x3),
      rM: (x0,x1) => ({createScript: x0,createScriptURL: x1}),
      rN: () => globalThis.firebase_firestore.endBefore,
      s: () => ({}),
      sB: o => {
        if (o === null || o === undefined) return 0;
        if (o instanceof Int8Array) return 1;
        return 2;
      },
      sC: x0 => x0.tabIndex,
      sD: (x0,x1) => x0.getComputedStyle(x1),
      sE: x0 => x0.deltaY,
      sF: o => Object.keys(o),
      sG: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmF32ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      sH: () => Date.now(),
      sI: x0 => x0.body,
      sJ: x0 => x0.userAgent,
      sK: x0 => x0.error,
      sL: (x0,x1) => x0.key(x1),
      sM: (x0,x1,x2) => x0.createPolicy(x1,x2),
      sN: () => globalThis.firebase_firestore.endAt,
      t: (o, p, v) => o[p] = v,
      tB: (o, start, length) => new Float64Array(o.buffer, o.byteOffset + start, length),
      tC: (x0,x1) => x0.contains(x1),
      tD: x0 => x0.documentElement,
      tE: x0 => x0.deltaX,
      tF: x0 => x0.state,
      tG: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmF64ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      tH: (x0,x1,x2) => x0.insertBefore(x1,x2),
      tI: x0 => x0.headers,
      tJ: x0 => x0.navigator,
      tK: x0 => x0.playbackRate,
      tL: x0 => x0.length,
      tM: (x0,x1) => x0.createScriptURL(x1),
      tN: () => globalThis.firebase_firestore.startAfter,
      u: () => [],
      uB: (o, start, length) => new Float32Array(o.buffer, o.byteOffset + start, length),
      uC: x0 => x0.activeElement,
      uD: x0 => x0.computedStyleMap(),
      uE: x0 => x0.wheelDeltaY,
      uF: x0 => x0.hash,
      uG: (x0,x1) => x0.dispatchEvent(x1),
      uH: x0 => x0.id,
      uI: () => {
        return typeof process != "undefined" &&
               Object.prototype.toString.call(process) == "[object process]" &&
               process.platform == "win32"
      },
      uJ: x0 => x0.load(),
      uK: x0 => x0.volume,
      uL: (x0,x1) => { x0.fetchTimeoutMillis = x1 },
      uM: (x0,x1,x2) => x0.createScript(x1,x2),
      uN: () => globalThis.firebase_firestore.startAt,
      v: (a, i) => a.push(i),
      vB: (o, start, length) => new Uint32Array(o.buffer, o.byteOffset + start, length),
      vC: x0 => x0.parentNode,
      vD: (x0,x1) => x0.get(x1),
      vE: x0 => x0.wheelDeltaX,
      vF: x0 => x0.state,
      vG: (x0,x1) => x0.createEvent(x1),
      vH: x0 => x0.offsetHeight,
      vI: () => new AbortController(),
      vJ: (x0,x1) => { x0.innerHTML = x1 },
      vK: (x0,x1) => x0.end(x1),
      vL: (x0,x1) => { x0.minimumFetchIntervalMillis = x1 },
      vM: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      vN: (x0,x1) => globalThis.firebase_firestore.orderBy(x0,x1),
      w: x0 => new Int8Array(x0),
      wB: (o, start, length) => new Int32Array(o.buffer, o.byteOffset + start, length),
      wC: x0 => x0.tagName,
      wD: (o, p) => p in o,
      wE: x0 => x0.key,
      wF: (x0,x1) => x0.go(x1),
      wG: (x0,x1,x2,x3) => x0.initEvent(x1,x2,x3),
      wH: x0 => x0.offsetWidth,
      wI: (x0,x1,x2,x3,x4,x5) => ({method: x0,headers: x1,body: x2,credentials: x3,redirect: x4,signal: x5}),
      wJ: (x0,x1,x2) => x0.register(x1,x2),
      wK: x0 => x0.length,
      wL: x0 => x0.settings,
      wM: (x0,x1) => { x0.text = x1 },
      wN: x0 => new firebase_firestore.FieldPath(x0),
      x: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI8ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      xB: (o, start, length) => new Uint16Array(o.buffer, o.byteOffset + start, length),
      xC: x0 => x0.target,
      xD: (x0,x1) => { x0.textContent = x1 },
      xE: x0 => x0.identifier,
      xF: x0 => x0.parentElement,
      xG: x0 => x0.readText(),
      xH: x0 => x0.stopPropagation(),
      xI: (x0,x1) => globalThis.fetch(x0,x1),
      xJ: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      xK: x0 => x0.buffered,
      xL: x0 => globalThis.firebase_remote_config.getRemoteConfig(x0),
      xM: (x0,x1) => { x0.text = x1 },
      xN: (x0,x1) => new firebase_firestore.FieldPath(x0,x1),
      y: x0 => new Uint8Array(x0),
      yB: (o, start, length) => new Int16Array(o.buffer, o.byteOffset + start, length),
      yC: x0 => x0.clientY,
      yD: (wasmFunction,f) => finalizeWrapper(f, function(x0) { return wasmFunction(f,arguments.length,x0) }),
      yE: x0 => x0.touches,
      yF: (x0,x1) => x0.querySelectorAll(x1),
      yG: x0 => x0.clipboard,
      yH: x0 => x0.disabled,
      yI: (x0,x1) => x0.get(x1),
      yJ: x0 => new FinalizationRegistry(x0),
      yK: x0 => x0.duration,
      yL: x0 => globalThis.firebase_core.getApp(x0),
      yM: x0 => x0.trustedTypes,
      yN: (x0,x1,x2) => new firebase_firestore.FieldPath(x0,x1,x2),
      z: x0 => new Uint8ClampedArray(x0),
      zB: (o, start, length) => new Uint8ClampedArray(o.buffer, o.byteOffset + start, length),
      zC: x0 => x0.clientX,
      zD: x0 => x0.matches,
      zE: x0 => x0.pressure,
      zF: (x0,x1) => x0.requestAnimationFrame(x1),
      zG: (x0,x1) => x0.writeText(x1),
      zH: (x0,x1) => { x0.min = x1 },
      zI: (wasmFunction,f) => finalizeWrapper(f, function(x0,x1,x2) { return wasmFunction(f,arguments.length,x0,x1,x2) }),
      zJ: () => globalThis.FinalizationRegistry,
      zK: x0 => x0.currentTime,
      zL: () => globalThis.firebase_core.getApp(),
      zM: () => globalThis.console,
      zN: (x0,x1,x2,x3) => new firebase_firestore.FieldPath(x0,x1,x2,x3),

    };

    const baseImports = {
      _: dart2wasm,
      Math: Math,
      Date: Date,
      Object: Object,
      Array: Array,
      Reflect: Reflect,
      WebAssembly: {
        JSTag: WebAssembly.JSTag,
      },
      "": new Proxy({}, { get(_, prop) { return prop; } }),

    };

    const jsStringPolyfill = {
      "charCodeAt": (s, i) => s.charCodeAt(i),
      "compare": (s1, s2) => {
        if (s1 < s2) return -1;
        if (s1 > s2) return 1;
        return 0;
      },
      "concat": (s1, s2) => s1 + s2,
      "equals": (s1, s2) => s1 === s2,
      "fromCharCode": (i) => String.fromCharCode(i),
      "length": (s) => s.length,
      "substring": (s, a, b) => s.substring(a, b),
      "fromCharCodeArray": (a, start, end) => {
        if (end <= start) return '';

        const read = dartInstance.exports.$wasmI16ArrayGet;
        let result = '';
        let index = start;
        const chunkLength = Math.min(end - index, 500);
        let array = new Array(chunkLength);
        while (index < end) {
          const newChunkLength = Math.min(end - index, 500);
          for (let i = 0; i < newChunkLength; i++) {
            array[i] = read(a, index++);
          }
          if (newChunkLength < chunkLength) {
            array = array.slice(0, newChunkLength);
          }
          result += String.fromCharCode(...array);
        }
        return result;
      },
      "intoCharCodeArray": (s, a, start) => {
        if (s === '') return 0;

        const write = dartInstance.exports.$wasmI16ArraySet;
        for (var i = 0; i < s.length; ++i) {
          write(a, start++, s.charCodeAt(i));
        }
        return s.length;
      },
      "test": (s) => typeof s == "string",
    };


    

    dartInstance = await WebAssembly.instantiate(this.module, {
      ...baseImports,
      ...additionalImports,
      
      "wasm:js-string": jsStringPolyfill,
    });

    return new InstantiatedApp(this, dartInstance);
  }
}

class InstantiatedApp {
  constructor(compiledApp, instantiatedModule) {
    this.compiledApp = compiledApp;
    this.instantiatedModule = instantiatedModule;
  }

  // Call the main function with the given arguments.
  invokeMain(...args) {
    this.instantiatedModule.exports.$invokeMain(args);
  }
}
