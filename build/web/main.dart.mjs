// Compiles a dart2wasm-generated main module from `source` which can then
// instantiatable via the `instantiate` method.
//
// `source` needs to be a `Response` object (or promise thereof) e.g. created
// via the `fetch()` JS API.
export async function compileStreaming(source) {
  const builtins = {builtins: ['js-string']};
  return new CompiledApp(
      await WebAssembly.compileStreaming(source, builtins), builtins);
}

// Compiles a dart2wasm-generated wasm modules from `bytes` which is then
// instantiatable via the `instantiate` method.
export async function compile(bytes) {
  const builtins = {builtins: ['js-string']};
  return new CompiledApp(await WebAssembly.compile(bytes, builtins), builtins);
}

// DEPRECATED: Please use `compile` or `compileStreaming` to get a compiled app,
// use `instantiate` method to get an instantiated app and then call
// `invokeMain` to invoke the main function.
export async function instantiate(modulePromise, importObjectPromise) {
  var moduleOrCompiledApp = await modulePromise;
  if (!(moduleOrCompiledApp instanceof CompiledApp)) {
    moduleOrCompiledApp = new CompiledApp(moduleOrCompiledApp);
  }
  const instantiatedApp = await moduleOrCompiledApp.instantiate(await importObjectPromise);
  return instantiatedApp.instantiatedModule;
}

// DEPRECATED: Please use `compile` or `compileStreaming` to get a compiled app,
// use `instantiate` method to get an instantiated app and then call
// `invokeMain` to invoke the main function.
export const invoke = (moduleInstance, ...args) => {
  moduleInstance.exports.$invokeMain(args);
}

class CompiledApp {
  constructor(module, builtins) {
    this.module = module;
    this.builtins = builtins;
  }

  // The second argument is an options object containing:
  // `loadDeferredModules` is a JS function that takes an array of module names
  //   matching wasm files produced by the dart2wasm compiler. It also takes a
  //   callback that should be invoked for each loaded module with 2 arugments:
  //   (1) the module name, (2) the loaded module in a format supported by
  //   `WebAssembly.compile` or `WebAssembly.compileStreaming`. The callback
  //   returns a Promise that resolves when the module is instantiated.
  //   loadDeferredModules should return a Promise that resolves when all the
  //   modules have been loaded and the callback promises have resolved.
  // `loadDeferredId` is a JS function that takes load ID produced by the
  //   compiler when the `load-ids` option is passed. Each load ID maps to one
  //   or more wasm files as specified in the emitted JSON file. It also takes a
  //   callback that should be invoked for each loaded module with 2 arugments:
  //   (1) the module name, (2) the loaded module in a format supported by
  //   `WebAssembly.compile` or `WebAssembly.compileStreaming`. The callback
  //   returns a Promise that resolves when the module is instantiated.
  //   loadDeferredModules should return a Promise that resolves when all the
  //   modules have been loaded and the callback promises have resolved.
  // `loadDynamicModule` is a JS function that takes two string names matching,
  //   in order, a wasm file produced by the dart2wasm compiler during dynamic
  //   module compilation and a corresponding js file produced by the same
  //   compilation. It also takes a callback that should be invoked with the
  //   loaded module in a format supported by `WebAssembly.compile` or
  //   `WebAssembly.compileStreaming` and the result of using the JS 'import'
  //   API on the js file path. It should return a Promise that resolves when
  //   all the modules have been loaded and the callback promises have resolved.
  async instantiate(additionalImports,
      {loadDeferredModules, loadDynamicModule, loadDeferredId} = {}) {
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
            _1: (decoder, codeUnits) => decoder.decode(codeUnits),
      _2: () => new TextDecoder("utf-8", {fatal: true}),
      _3: () => new TextDecoder("utf-8", {fatal: false}),
      _4: (s) => +s,
      _5: x0 => new Uint8Array(x0),
      _6: (x0,x1,x2) => x0.set(x1,x2),
      _7: (x0,x1) => x0.transferFromImageBitmap(x1),
      _9: (x0,x1,x2) => x0.slice(x1,x2),
      _10: (x0,x1) => x0.decode(x1),
      _11: (x0,x1) => x0.segment(x1),
      _12: () => new TextDecoder(),
      _13: (x0,x1) => x0.get(x1),
      _14: x0 => x0.buffer,
      _15: x0 => x0.wasmMemory,
      _16: () => globalThis.window._flutter_skwasmInstance,
      _17: x0 => x0.rasterStartMilliseconds,
      _18: x0 => x0.rasterEndMilliseconds,
      _19: x0 => x0.imageBitmaps,
      _135: (x0,x1) => x0.appendChild(x1),
      _166: (x0,x1,x2) => x0.addEventListener(x1,x2),
      _167: (x0,x1,x2) => x0.removeEventListener(x1,x2),
      _168: (x0,x1) => new OffscreenCanvas(x0,x1),
      _169: x0 => x0.remove(),
      _170: (x0,x1) => x0.append(x1),
      _172: x0 => x0.unlock(),
      _173: x0 => x0.getReader(),
      _174: (x0,x1) => x0.item(x1),
      _175: x0 => x0.next(),
      _176: x0 => x0.now(),
      _177: (x0,x1) => x0.revokeObjectURL(x1),
      _178: x0 => x0.close(),
      _179: (x0,x1,x2,x3,x4) => ({type: x0,data: x1,premultiplyAlpha: x2,colorSpaceConversion: x3,preferAnimation: x4}),
      _180: x0 => new window.ImageDecoder(x0),
      _181: (x0,x1) => ({frameIndex: x0,completeFramesOnly: x1}),
      _182: (x0,x1) => x0.decode(x1),
      _183: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._183(f,arguments.length,x0) }),
      _184: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
      _186: (x0,x1) => x0.getModifierState(x1),
      _187: x0 => x0.preventDefault(),
      _188: x0 => x0.stopPropagation(),
      _189: (x0,x1) => x0.removeProperty(x1),
      _190: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._190(f,arguments.length,x0) }),
      _191: x0 => new window.FinalizationRegistry(x0),
      _192: (x0,x1,x2,x3) => x0.register(x1,x2,x3),
      _194: (x0,x1) => x0.unregister(x1),
      _195: (x0,x1) => x0.prepend(x1),
      _196: x0 => new Intl.Locale(x0),
      _197: (x0,x1) => x0.observe(x1),
      _198: x0 => x0.disconnect(),
      _199: (x0,x1) => x0.getAttribute(x1),
      _200: (x0,x1) => x0.contains(x1),
      _201: (x0,x1) => x0.querySelector(x1),
      _202: (x0,x1) => x0.matchMedia(x1),
      _203: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._203(f,arguments.length,x0) }),
      _204: (x0,x1,x2) => x0.call(x1,x2),
      _205: x0 => x0.blur(),
      _206: x0 => x0.hasFocus(),
      _207: (x0,x1) => x0.removeAttribute(x1),
      _208: (x0,x1,x2) => x0.insertBefore(x1,x2),
      _209: (x0,x1) => x0.hasAttribute(x1),
      _210: (x0,x1) => x0.getModifierState(x1),
      _211: (x0,x1) => x0.createTextNode(x1),
      _212: x0 => x0.getBoundingClientRect(),
      _213: (x0,x1) => x0.replaceWith(x1),
      _214: (x0,x1) => x0.contains(x1),
      _215: (x0,x1) => x0.closest(x1),
      _653: x0 => new Uint8Array(x0),
      _656: () => globalThis.window.flutterConfiguration,
      _658: x0 => x0.assetBase,
      _663: x0 => x0.canvasKitMaximumSurfaces,
      _664: x0 => x0.debugShowSemanticsNodes,
      _665: x0 => x0.hostElement,
      _666: x0 => x0.multiViewEnabled,
      _667: x0 => x0.nonce,
      _669: x0 => x0.fontFallbackBaseUrl,
      _679: x0 => x0.console,
      _680: x0 => x0.devicePixelRatio,
      _681: x0 => x0.document,
      _682: x0 => x0.history,
      _683: x0 => x0.innerHeight,
      _684: x0 => x0.innerWidth,
      _685: x0 => x0.location,
      _686: x0 => x0.navigator,
      _687: x0 => x0.visualViewport,
      _688: x0 => x0.performance,
      _689: x0 => x0.parent,
      _691: x0 => x0.URL,
      _693: (x0,x1) => x0.getComputedStyle(x1),
      _694: x0 => x0.screen,
      _695: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._695(f,arguments.length,x0) }),
      _696: (x0,x1) => x0.requestAnimationFrame(x1),
      _700: (x0,x1) => x0.warn(x1),
      _702: (x0,x1) => x0.debug(x1),
      _703: x0 => globalThis.parseFloat(x0),
      _704: () => globalThis.window,
      _705: () => globalThis.Intl,
      _706: () => globalThis.Symbol,
      _707: (x0,x1,x2,x3,x4) => globalThis.createImageBitmap(x0,x1,x2,x3,x4),
      _709: x0 => x0.clipboard,
      _710: x0 => x0.maxTouchPoints,
      _711: x0 => x0.vendor,
      _712: x0 => x0.language,
      _713: x0 => x0.platform,
      _714: x0 => x0.userAgent,
      _715: (x0,x1) => x0.vibrate(x1),
      _716: x0 => x0.languages,
      _717: x0 => x0.documentElement,
      _718: (x0,x1) => x0.querySelector(x1),
      _719: (x0,x1) => x0.querySelectorAll(x1),
      _721: (x0,x1) => x0.createElement(x1),
      _724: (x0,x1) => x0.createEvent(x1),
      _725: x0 => x0.activeElement,
      _728: x0 => x0.head,
      _729: x0 => x0.body,
      _731: (x0,x1) => { x0.title = x1 },
      _734: x0 => x0.visibilityState,
      _735: () => globalThis.document,
      _736: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._736(f,arguments.length,x0) }),
      _737: (x0,x1) => x0.dispatchEvent(x1),
      _745: x0 => x0.target,
      _747: x0 => x0.timeStamp,
      _748: x0 => x0.type,
      _750: (x0,x1,x2,x3) => x0.initEvent(x1,x2,x3),
      _757: x0 => x0.firstChild,
      _761: x0 => x0.parentElement,
      _763: (x0,x1) => { x0.textContent = x1 },
      _764: x0 => x0.parentNode,
      _765: x0 => x0.nextSibling,
      _766: (x0,x1) => x0.removeChild(x1),
      _767: x0 => x0.isConnected,
      _772: x0 => x0.firstElementChild,
      _775: x0 => x0.clientHeight,
      _776: x0 => x0.clientWidth,
      _777: x0 => x0.offsetHeight,
      _778: x0 => x0.offsetWidth,
      _779: x0 => x0.id,
      _780: (x0,x1) => { x0.id = x1 },
      _783: (x0,x1) => { x0.spellcheck = x1 },
      _784: x0 => x0.tagName,
      _785: x0 => x0.style,
      _787: (x0,x1) => x0.querySelectorAll(x1),
      _788: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _789: x0 => x0.tabIndex,
      _790: (x0,x1) => { x0.tabIndex = x1 },
      _791: (x0,x1) => x0.focus(x1),
      _792: x0 => x0.scrollTop,
      _793: (x0,x1) => { x0.scrollTop = x1 },
      _794: (x0,x1) => { x0.scrollLeft = x1 },
      _795: x0 => x0.scrollLeft,
      _796: x0 => x0.classList,
      _797: (x0,x1) => x0.scrollIntoView(x1),
      _800: (x0,x1) => { x0.className = x1 },
      _802: (x0,x1) => x0.getElementsByClassName(x1),
      _803: x0 => x0.click(),
      _804: (x0,x1) => x0.attachShadow(x1),
      _807: x0 => x0.computedStyleMap(),
      _808: (x0,x1) => x0.get(x1),
      _814: (x0,x1) => x0.getPropertyValue(x1),
      _815: (x0,x1,x2,x3) => x0.setProperty(x1,x2,x3),
      _816: x0 => x0.offsetLeft,
      _817: x0 => x0.offsetTop,
      _818: x0 => x0.offsetParent,
      _820: (x0,x1) => { x0.name = x1 },
      _821: x0 => x0.content,
      _822: (x0,x1) => { x0.content = x1 },
      _826: (x0,x1) => { x0.src = x1 },
      _827: x0 => x0.naturalWidth,
      _828: x0 => x0.naturalHeight,
      _832: (x0,x1) => { x0.crossOrigin = x1 },
      _834: (x0,x1) => { x0.decoding = x1 },
      _835: x0 => x0.decode(),
      _840: (x0,x1) => { x0.nonce = x1 },
      _845: (x0,x1) => { x0.width = x1 },
      _847: (x0,x1) => { x0.height = x1 },
      _850: (x0,x1) => x0.getContext(x1),
      _918: x0 => x0.width,
      _919: x0 => x0.height,
      _921: (x0,x1) => x0.fetch(x1),
      _922: x0 => x0.status,
      _923: x0 => x0.headers,
      _924: x0 => x0.body,
      _925: x0 => x0.arrayBuffer(),
      _928: x0 => x0.read(),
      _929: x0 => x0.value,
      _930: x0 => x0.done,
      _937: x0 => x0.name,
      _938: x0 => x0.x,
      _939: x0 => x0.y,
      _942: x0 => x0.top,
      _943: x0 => x0.right,
      _944: x0 => x0.bottom,
      _945: x0 => x0.left,
      _955: x0 => x0.height,
      _956: x0 => x0.width,
      _957: x0 => x0.scale,
      _958: (x0,x1) => { x0.value = x1 },
      _961: (x0,x1) => { x0.placeholder = x1 },
      _963: (x0,x1) => { x0.name = x1 },
      _964: x0 => x0.selectionDirection,
      _965: x0 => x0.selectionStart,
      _966: x0 => x0.selectionEnd,
      _969: x0 => x0.value,
      _971: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
      _972: x0 => x0.readText(),
      _973: (x0,x1) => x0.writeText(x1),
      _975: x0 => x0.altKey,
      _976: x0 => x0.code,
      _977: x0 => x0.ctrlKey,
      _978: x0 => x0.key,
      _979: x0 => x0.keyCode,
      _980: x0 => x0.location,
      _981: x0 => x0.metaKey,
      _982: x0 => x0.repeat,
      _983: x0 => x0.shiftKey,
      _984: x0 => x0.isComposing,
      _986: x0 => x0.state,
      _987: (x0,x1) => x0.go(x1),
      _989: (x0,x1,x2,x3) => x0.pushState(x1,x2,x3),
      _990: (x0,x1,x2,x3) => x0.replaceState(x1,x2,x3),
      _991: x0 => x0.pathname,
      _992: x0 => x0.search,
      _993: x0 => x0.hash,
      _997: x0 => x0.state,
      _1000: (x0,x1) => x0.createObjectURL(x1),
      _1002: x0 => new Blob(x0),
      _1012: x0 => x0.matches,
      _1016: x0 => x0.matches,
      _1020: x0 => x0.relatedTarget,
      _1022: x0 => x0.clientX,
      _1023: x0 => x0.clientY,
      _1024: x0 => x0.offsetX,
      _1025: x0 => x0.offsetY,
      _1028: x0 => x0.button,
      _1029: x0 => x0.buttons,
      _1030: x0 => x0.ctrlKey,
      _1034: x0 => x0.pointerId,
      _1035: x0 => x0.pointerType,
      _1036: x0 => x0.pressure,
      _1037: x0 => x0.tiltX,
      _1038: x0 => x0.tiltY,
      _1039: x0 => x0.getCoalescedEvents(),
      _1042: x0 => x0.deltaX,
      _1043: x0 => x0.deltaY,
      _1044: x0 => x0.wheelDeltaX,
      _1045: x0 => x0.wheelDeltaY,
      _1046: x0 => x0.deltaMode,
      _1053: x0 => x0.changedTouches,
      _1056: x0 => x0.clientX,
      _1057: x0 => x0.clientY,
      _1060: x0 => x0.data,
      _1063: (x0,x1) => { x0.disabled = x1 },
      _1065: (x0,x1) => { x0.type = x1 },
      _1066: (x0,x1) => { x0.max = x1 },
      _1067: (x0,x1) => { x0.min = x1 },
      _1068: x0 => x0.value,
      _1069: (x0,x1) => { x0.value = x1 },
      _1070: x0 => x0.disabled,
      _1071: (x0,x1) => { x0.disabled = x1 },
      _1073: (x0,x1) => { x0.placeholder = x1 },
      _1075: (x0,x1) => { x0.name = x1 },
      _1076: (x0,x1) => { x0.autocomplete = x1 },
      _1078: x0 => x0.selectionDirection,
      _1079: x0 => x0.selectionStart,
      _1081: x0 => x0.selectionEnd,
      _1084: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
      _1085: (x0,x1) => x0.add(x1),
      _1087: (x0,x1) => { x0.noValidate = x1 },
      _1088: (x0,x1) => { x0.method = x1 },
      _1089: (x0,x1) => { x0.action = x1 },
      _1114: x0 => x0.orientation,
      _1115: x0 => x0.width,
      _1116: x0 => x0.height,
      _1117: (x0,x1) => x0.lock(x1),
      _1136: x0 => new ResizeObserver(x0),
      _1139: (module,f) => finalizeWrapper(f, function(x0,x1) { return module.exports._1139(f,arguments.length,x0,x1) }),
      _1147: x0 => x0.length,
      _1148: x0 => x0.iterator,
      _1149: x0 => x0.Segmenter,
      _1150: x0 => x0.v8BreakIterator,
      _1151: (x0,x1) => new Intl.Segmenter(x0,x1),
      _1154: x0 => x0.language,
      _1155: x0 => x0.script,
      _1156: x0 => x0.region,
      _1174: x0 => x0.done,
      _1175: x0 => x0.value,
      _1176: x0 => x0.index,
      _1180: (x0,x1) => new Intl.v8BreakIterator(x0,x1),
      _1181: (x0,x1) => x0.adoptText(x1),
      _1182: x0 => x0.first(),
      _1183: x0 => x0.next(),
      _1184: x0 => x0.current(),
      _1186: () => globalThis.window.FinalizationRegistry,
      _1197: x0 => x0.hostElement,
      _1198: x0 => x0.viewConstraints,
      _1201: x0 => x0.maxHeight,
      _1202: x0 => x0.maxWidth,
      _1203: x0 => x0.minHeight,
      _1204: x0 => x0.minWidth,
      _1205: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._1205(f,arguments.length,x0) }),
      _1206: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._1206(f,arguments.length,x0) }),
      _1207: (x0,x1) => ({addView: x0,removeView: x1}),
      _1210: x0 => x0.loader,
      _1211: () => globalThis._flutter,
      _1212: (x0,x1) => x0.didCreateEngineInitializer(x1),
      _1213: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._1213(f,arguments.length,x0) }),
      _1214: (module,f) => finalizeWrapper(f, function() { return module.exports._1214(f,arguments.length) }),
      _1215: (x0,x1) => ({initializeEngine: x0,autoStart: x1}),
      _1218: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._1218(f,arguments.length,x0) }),
      _1219: x0 => ({runApp: x0}),
      _1221: (module,f) => finalizeWrapper(f, function(x0,x1) { return module.exports._1221(f,arguments.length,x0,x1) }),
      _1222: x0 => new Promise(x0),
      _1223: x0 => x0.length,
      _1224: () => globalThis.window.ImageDecoder,
      _1225: x0 => x0.tracks,
      _1227: x0 => x0.completed,
      _1229: x0 => x0.image,
      _1235: x0 => x0.displayWidth,
      _1236: x0 => x0.displayHeight,
      _1237: x0 => x0.duration,
      _1240: x0 => x0.ready,
      _1241: x0 => x0.selectedTrack,
      _1242: x0 => x0.repetitionCount,
      _1243: x0 => x0.frameCount,
      _1285: x0 => x0.requestFullscreen(),
      _1286: x0 => x0.exitFullscreen(),
      _1287: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._1287(f,arguments.length,x0) }),
      _1288: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._1288(f,arguments.length,x0) }),
      _1289: (x0,x1,x2) => x0.addEventListener(x1,x2),
      _1290: (x0,x1) => x0.querySelectorAll(x1),
      _1291: (x0,x1) => x0.item(x1),
      _1292: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _1293: (x0,x1) => x0.lock(x1),
      _1294: x0 => x0.unlock(),
      _1295: (x0,x1,x2) => x0.removeEventListener(x1,x2),
      _1296: (x0,x1) => x0.getItem(x1),
      _1297: (x0,x1) => x0.removeItem(x1),
      _1298: (x0,x1) => ({body: x0,icon: x1}),
      _1299: (x0,x1) => new Notification(x0,x1),
      _1300: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._1300(f,arguments.length,x0) }),
      _1301: (x0,x1) => x0.createElement(x1),
      _1302: (x0,x1) => x0.add(x1),
      _1315: x0 => x0.preventDefault(),
      _1316: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._1316(f,arguments.length,x0) }),
      _1317: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
      _1318: (x0,x1,x2,x3) => x0.removeEventListener(x1,x2,x3),
      _1319: (x0,x1) => x0.removeAttribute(x1),
      _1324: (x0,x1,x2,x3) => x0.open(x1,x2,x3),
      _1325: () => globalThis.Notification.requestPermission(),
      _1326: (x0,x1,x2) => x0.setItem(x1,x2),
      _1330: x0 => globalThis.firebase_remote_config.fetchAndActivate(x0),
      _1337: (x0,x1) => globalThis.firebase_remote_config.getString(x0,x1),
      _1348: x0 => globalThis.firebase_remote_config.getRemoteConfig(x0),
      _1359: x0 => x0.toArray(),
      _1360: x0 => x0.toUint8Array(),
      _1361: x0 => ({serverTimestamps: x0}),
      _1365: x0 => new firebase_firestore.FieldPath(x0),
      _1366: (x0,x1) => new firebase_firestore.FieldPath(x0,x1),
      _1367: (x0,x1,x2) => new firebase_firestore.FieldPath(x0,x1,x2),
      _1368: (x0,x1,x2,x3) => new firebase_firestore.FieldPath(x0,x1,x2,x3),
      _1369: (x0,x1,x2,x3,x4) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4),
      _1370: (x0,x1,x2,x3,x4,x5) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4,x5),
      _1371: (x0,x1,x2,x3,x4,x5,x6) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4,x5,x6),
      _1372: (x0,x1,x2,x3,x4,x5,x6,x7) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4,x5,x6,x7),
      _1373: (x0,x1,x2,x3,x4,x5,x6,x7,x8) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4,x5,x6,x7,x8),
      _1374: (x0,x1,x2,x3,x4,x5,x6,x7,x8,x9) => new firebase_firestore.FieldPath(x0,x1,x2,x3,x4,x5,x6,x7,x8,x9),
      _1375: () => globalThis.firebase_firestore.documentId(),
      _1376: (x0,x1) => new firebase_firestore.Timestamp(x0,x1),
      _1377: (x0,x1) => new firebase_firestore.GeoPoint(x0,x1),
      _1378: x0 => globalThis.firebase_firestore.vector(x0),
      _1379: x0 => globalThis.firebase_firestore.Bytes.fromUint8Array(x0),
      _1381: (x0,x1) => globalThis.firebase_firestore.collection(x0,x1),
      _1383: (x0,x1) => globalThis.firebase_firestore.doc(x0,x1),
      _1386: x0 => x0.call(),
      _1418: (x0,x1) => ({includeMetadataChanges: x0,source: x1}),
      _1421: (x0,x1,x2,x3) => globalThis.firebase_firestore.onSnapshot(x0,x1,x2,x3),
      _1425: (x0,x1) => globalThis.firebase_firestore.query(x0,x1),
      _1429: x0 => globalThis.firebase_firestore.limit(x0),
      _1430: x0 => globalThis.firebase_firestore.limitToLast(x0),
      _1431: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._1431(f,arguments.length,x0) }),
      _1432: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._1432(f,arguments.length,x0) }),
      _1433: (x0,x1) => globalThis.firebase_firestore.orderBy(x0,x1),
      _1435: (x0,x1,x2) => globalThis.firebase_firestore.where(x0,x1,x2),
      _1440: (x0,x1) => x0.data(x1),
      _1444: x0 => x0.docChanges(),
      _1462: (x0,x1) => globalThis.firebase_firestore.getFirestore(x0,x1),
      _1464: x0 => globalThis.firebase_firestore.Timestamp.fromMillis(x0),
      _1465: (module,f) => finalizeWrapper(f, function() { return module.exports._1465(f,arguments.length) }),
      _1604: () => globalThis.firebase_firestore.or,
      _1605: () => globalThis.firebase_firestore.and,
      _1619: x0 => x0.path,
      _1622: () => globalThis.firebase_firestore.GeoPoint,
      _1623: x0 => x0.latitude,
      _1624: x0 => x0.longitude,
      _1626: () => globalThis.firebase_firestore.VectorValue,
      _1627: () => globalThis.firebase_firestore.Bytes,
      _1630: x0 => x0.type,
      _1632: x0 => x0.doc,
      _1634: x0 => x0.oldIndex,
      _1636: x0 => x0.newIndex,
      _1638: () => globalThis.firebase_firestore.DocumentReference,
      _1642: x0 => x0.path,
      _1651: x0 => x0.metadata,
      _1652: x0 => x0.ref,
      _1657: x0 => x0.docs,
      _1659: x0 => x0.metadata,
      _1664: () => globalThis.firebase_firestore.Timestamp,
      _1665: x0 => x0.seconds,
      _1666: x0 => x0.nanoseconds,
      _1702: x0 => x0.hasPendingWrites,
      _1704: x0 => x0.fromCache,
      _1716: () => globalThis.firebase_firestore.startAfter,
      _1717: () => globalThis.firebase_firestore.startAt,
      _1718: () => globalThis.firebase_firestore.endBefore,
      _1719: () => globalThis.firebase_firestore.endAt,
      _1761: (x0,x1,x2,x3,x4,x5,x6,x7,x8) => ({apiKey: x0,authDomain: x1,databaseURL: x2,projectId: x3,storageBucket: x4,messagingSenderId: x5,measurementId: x6,appId: x7,recaptchaSiteKey: x8}),
      _1762: (x0,x1) => globalThis.firebase_core.initializeApp(x0,x1),
      _1763: x0 => globalThis.firebase_core.getApp(x0),
      _1764: () => globalThis.firebase_core.getApp(),
      _1765: (x0,x1,x2) => globalThis.firebase_core.registerVersion(x0,x1,x2),
      _1770: x0 => x0.settings,
      _1773: (x0,x1) => { x0.defaultConfig = x1 },
      _1779: (x0,x1) => { x0.minimumFetchIntervalMillis = x1 },
      _1781: (x0,x1) => { x0.fetchTimeoutMillis = x1 },
      _1785: x0 => globalThis.firebase_messaging.getMessaging(x0),
      _1787: (x0,x1) => globalThis.firebase_messaging.getToken(x0,x1),
      _1789: (x0,x1) => globalThis.firebase_messaging.onMessage(x0,x1),
      _1790: (x0,x1) => ({next: x0,error: x1}),
      _1793: (x0,x1) => ({vapidKey: x0,serviceWorkerRegistration: x1}),
      _1796: x0 => x0.title,
      _1797: x0 => x0.body,
      _1798: x0 => x0.image,
      _1799: x0 => x0.messageId,
      _1800: x0 => x0.collapseKey,
      _1801: x0 => x0.fcmOptions,
      _1802: x0 => x0.notification,
      _1803: x0 => x0.data,
      _1804: x0 => x0.from,
      _1805: x0 => x0.analyticsLabel,
      _1806: x0 => x0.link,
      _1808: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._1808(f,arguments.length,x0) }),
      _1809: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._1809(f,arguments.length,x0) }),
      _1811: () => globalThis.firebase_core.SDK_VERSION,
      _1817: x0 => x0.apiKey,
      _1819: x0 => x0.authDomain,
      _1821: x0 => x0.databaseURL,
      _1823: x0 => x0.projectId,
      _1825: x0 => x0.storageBucket,
      _1827: x0 => x0.messagingSenderId,
      _1829: x0 => x0.measurementId,
      _1831: x0 => x0.appId,
      _1833: x0 => x0.recaptchaSiteKey,
      _1835: x0 => x0.name,
      _1836: x0 => x0.options,
      _1837: (x0,x1) => x0.debug(x1),
      _1838: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._1838(f,arguments.length,x0) }),
      _1839: (module,f) => finalizeWrapper(f, function(x0,x1) { return module.exports._1839(f,arguments.length,x0,x1) }),
      _1840: (x0,x1) => ({createScript: x0,createScriptURL: x1}),
      _1841: (x0,x1,x2) => x0.createPolicy(x1,x2),
      _1842: (x0,x1) => x0.createScriptURL(x1),
      _1843: (x0,x1,x2) => x0.createScript(x1,x2),
      _1844: (x0,x1) => x0.appendChild(x1),
      _1845: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._1845(f,arguments.length,x0) }),
      _1847: x0 => x0.load(),
      _1848: x0 => x0.remove(),
      _1849: (x0,x1) => x0.getContext(x1),
      _1850: (x0,x1,x2,x3,x4,x5) => x0.drawImage(x1,x2,x3,x4,x5),
      _1851: (x0,x1,x2) => x0.toDataURL(x1,x2),
      _1852: (x0,x1) => x0.querySelector(x1),
      _1853: Date.now,
      _1855: s => new Date(s * 1000).getTimezoneOffset() * 60,
      _1856: s => {
        if (!/^\s*[+-]?(?:Infinity|NaN|(?:\.\d+|\d+(?:\.\d*)?)(?:[eE][+-]?\d+)?)\s*$/.test(s)) {
          return NaN;
        }
        return parseFloat(s);
      },
      _1857: () => typeof dartUseDateNowForTicks !== "undefined",
      _1858: () => 1000 * performance.now(),
      _1859: () => Date.now(),
      _1860: () => {
        // On browsers return `globalThis.location.href`
        if (globalThis.location != null) {
          return globalThis.location.href;
        }
        return null;
      },
      _1861: () => {
        return typeof process != "undefined" &&
               Object.prototype.toString.call(process) == "[object process]" &&
               process.platform == "win32"
      },
      _1862: () => new WeakMap(),
      _1863: (map, o) => map.get(o),
      _1864: (map, o, v) => map.set(o, v),
      _1865: x0 => new WeakRef(x0),
      _1866: x0 => x0.deref(),
      _1867: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._1867(f,arguments.length,x0) }),
      _1868: x0 => new FinalizationRegistry(x0),
      _1870: (x0,x1,x2) => x0.register(x1,x2),
      _1873: () => globalThis.WeakRef,
      _1874: () => globalThis.FinalizationRegistry,
      _1876: s => JSON.stringify(s),
      _1877: s => printToConsole(s),
      _1878: o => {
        if (o === null || o === undefined) return 0;
        if (typeof(o) === 'string') return 1;
        return 2;
      },
      _1879: (o, p, r) => o.replaceAll(p, () => r),
      _1880: (o, p, r) => o.replace(p, () => r),
      _1881: Function.prototype.call.bind(String.prototype.toLowerCase),
      _1882: s => s.toUpperCase(),
      _1883: s => s.trim(),
      _1884: s => s.trimLeft(),
      _1885: s => s.trimRight(),
      _1886: (string, times) => string.repeat(times),
      _1887: Function.prototype.call.bind(String.prototype.indexOf),
      _1888: (s, p, i) => s.lastIndexOf(p, i),
      _1889: (string, token) => string.split(token),
      _1890: Object.is,
      _1895: (o, c) => o instanceof c,
      _1896: o => Object.keys(o),
      _1950: x0 => new Array(x0),
      _1952: x0 => x0.length,
      _1954: (x0,x1) => x0[x1],
      _1955: (x0,x1,x2) => { x0[x1] = x2 },
      _1958: (x0,x1,x2) => new DataView(x0,x1,x2),
      _1960: x0 => new Int8Array(x0),
      _1961: (x0,x1,x2) => new Uint8Array(x0,x1,x2),
      _1963: x0 => new Uint8ClampedArray(x0),
      _1965: x0 => new Int16Array(x0),
      _1967: x0 => new Uint16Array(x0),
      _1969: x0 => new Int32Array(x0),
      _1971: x0 => new Uint32Array(x0),
      _1973: x0 => new Float32Array(x0),
      _1975: x0 => new Float64Array(x0),
      _1999: x0 => x0.random(),
      _2000: (x0,x1) => x0.getRandomValues(x1),
      _2001: () => globalThis.crypto,
      _2002: () => globalThis.Math,
      _2015: (ms, c) =>
      setTimeout(() => dartInstance.exports.$invokeCallback(c),ms),
      _2016: (handle) => clearTimeout(handle),
      _2017: (ms, c) =>
      setInterval(() => dartInstance.exports.$invokeCallback(c), ms),
      _2018: (handle) => clearInterval(handle),
      _2019: (c) =>
      queueMicrotask(() => dartInstance.exports.$invokeCallback(c)),
      _2020: () => Date.now(),
      _2021: () => new Error().stack,
      _2022: (exn) => {
        let stackString = exn.toString();
        let frames = stackString.split('\n');
        let drop = 4;
        if (frames[0].startsWith('Error')) {
            drop += 1;
        }
        return frames.slice(drop).join('\n');
      },
      _2023: (s, m) => {
        try {
          return new RegExp(s, m);
        } catch (e) {
          return String(e);
        }
      },
      _2024: (x0,x1) => x0.exec(x1),
      _2025: (x0,x1) => x0.test(x1),
      _2026: x0 => x0.pop(),
      _2028: o => o === undefined,
      _2030: o => typeof o === 'function' && o[jsWrappedDartFunctionSymbol] === true,
      _2032: o => {
        const proto = Object.getPrototypeOf(o);
        return proto === Object.prototype || proto === null;
      },
      _2033: o => o instanceof RegExp,
      _2034: (l, r) => l === r,
      _2035: o => o,
      _2036: o => {
        if (o === undefined || o === null) return 0;
        if (typeof o === 'number') return 1;
        return 2;
      },
      _2037: o => o,
      _2038: o => {
        if (o === undefined || o === null) return 0;
        if (typeof o === 'boolean') return 1;
        return 2;
      },
      _2039: o => o,
      _2040: b => !!b,
      _2041: o => o.length,
      _2043: (o, i) => o[i],
      _2044: f => f.dartFunction,
      _2045: () => ({}),
      _2046: () => [],
      _2048: () => globalThis,
      _2049: (constructor, args) => {
        const factoryFunction = constructor.bind.apply(
            constructor, [null, ...args]);
        return new factoryFunction();
      },
      _2051: (o, p) => o[p],
      _2052: (o, p, v) => o[p] = v,
      _2053: (o, m, a) => o[m].apply(o, a),
      _2055: o => String(o),
      _2056: (p, s, f) => p.then(s, (e) => f(e, e === undefined)),
      _2057: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._2057(f,arguments.length,x0) }),
      _2058: (module,f) => finalizeWrapper(f, function(x0,x1) { return module.exports._2058(f,arguments.length,x0,x1) }),
      _2059: o => {
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
      _2060: o => [o],
      _2061: (o0, o1) => [o0, o1],
      _2062: (o0, o1, o2) => [o0, o1, o2],
      _2063: (o0, o1, o2, o3) => [o0, o1, o2, o3],
      _2064: (exn) => {
        if (exn instanceof Error) {
          return exn.stack;
        } else {
          return null;
        }
      },
      _2065: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI8ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2066: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI8ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2069: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI32ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2070: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI32ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2071: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmF32ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2072: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmF32ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2073: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmF64ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2074: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmF64ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2075: x0 => new ArrayBuffer(x0),
      _2076: s => {
        if (/[[\]{}()*+?.\\^$|]/.test(s)) {
            s = s.replace(/[[\]{}()*+?.\\^$|]/g, '\\$&');
        }
        return s;
      },
      _2078: x0 => x0.index,
      _2080: x0 => x0.flags,
      _2081: x0 => x0.multiline,
      _2082: x0 => x0.ignoreCase,
      _2083: x0 => x0.unicode,
      _2084: x0 => x0.dotAll,
      _2085: (x0,x1) => { x0.lastIndex = x1 },
      _2086: (o, p) => p in o,
      _2087: (o, p) => o[p],
      _2088: (o, p, v) => o[p] = v,
      _2089: (o, p) => delete o[p],
      _2114: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._2114(f,arguments.length,x0) }),
      _2115: (module,f) => finalizeWrapper(f, function(x0) { return module.exports._2115(f,arguments.length,x0) }),
      _2120: () => new AbortController(),
      _2121: x0 => x0.abort(),
      _2122: (x0,x1,x2,x3,x4,x5) => ({method: x0,headers: x1,body: x2,credentials: x3,redirect: x4,signal: x5}),
      _2123: (x0,x1) => globalThis.fetch(x0,x1),
      _2124: (x0,x1) => x0.get(x1),
      _2125: (module,f) => finalizeWrapper(f, function(x0,x1,x2) { return module.exports._2125(f,arguments.length,x0,x1,x2) }),
      _2126: (x0,x1) => x0.forEach(x1),
      _2127: x0 => x0.getReader(),
      _2128: x0 => x0.cancel(),
      _2129: x0 => x0.read(),
      _2130: (x0,x1) => x0.append(x1),
      _2131: (x0,x1) => x0.append(x1),
      _2132: x0 => ({xhrSetup: x0}),
      _2133: x0 => new Hls(x0),
      _2134: () => globalThis.Hls.isSupported(),
      _2136: (x0,x1) => x0.loadSource(x1),
      _2137: (x0,x1) => x0.attachMedia(x1),
      _2138: x0 => x0.pause(),
      _2139: (x0,x1) => x0.end(x1),
      _2140: x0 => x0.play(),
      _2149: (x0,x1) => x0.canPlayType(x1),
      _2150: (x0,x1) => x0.key(x1),
      _2151: x0 => x0.trustedTypes,
      _2152: (x0,x1) => { x0.text = x1 },
      _2153: o => o instanceof Array,
      _2157: a => a.pop(),
      _2158: (a, i) => a.splice(i, 1),
      _2159: (a, s) => a.join(s),
      _2160: (a, s, e) => a.slice(s, e),
      _2162: (a, b) => a == b ? 0 : (a > b ? 1 : -1),
      _2163: a => a.length,
      _2165: (a, i) => a[i],
      _2166: (a, i, v) => a[i] = v,
      _2168: o => {
        if (o === null || o === undefined) return 0;
        if (o instanceof ArrayBuffer) return 1;
        if (globalThis.SharedArrayBuffer !== undefined &&
            o instanceof SharedArrayBuffer) {
          return 2;
        }
        return 3;
      },
      _2169: (o, offsetInBytes, lengthInBytes) => {
        var dst = new ArrayBuffer(lengthInBytes);
        new Uint8Array(dst).set(new Uint8Array(o, offsetInBytes, lengthInBytes));
        return new DataView(dst);
      },
      _2171: o => {
        if (o === null || o === undefined) return 0;
        if (o instanceof Uint8Array) return 1;
        return 2;
      },
      _2172: (o, start, length) => new Uint8Array(o.buffer, o.byteOffset + start, length),
      _2173: o => {
        if (o === null || o === undefined) return 0;
        if (o instanceof Int8Array) return 1;
        return 2;
      },
      _2174: (o, start, length) => new Int8Array(o.buffer, o.byteOffset + start, length),
      _2175: o => o instanceof Uint8ClampedArray,
      _2176: (o, start, length) => new Uint8ClampedArray(o.buffer, o.byteOffset + start, length),
      _2177: o => o instanceof Uint16Array,
      _2178: (o, start, length) => new Uint16Array(o.buffer, o.byteOffset + start, length),
      _2179: o => o instanceof Int16Array,
      _2180: (o, start, length) => new Int16Array(o.buffer, o.byteOffset + start, length),
      _2181: o => {
        if (o === null || o === undefined) return 0;
        if (o instanceof Uint32Array) return 1;
        return 2;
      },
      _2182: (o, start, length) => new Uint32Array(o.buffer, o.byteOffset + start, length),
      _2183: o => {
        if (o === null || o === undefined) return 0;
        if (o instanceof Int32Array) return 1;
        return 2;
      },
      _2184: (o, start, length) => new Int32Array(o.buffer, o.byteOffset + start, length),
      _2186: (o, start, length) => new BigInt64Array(o.buffer, o.byteOffset + start, length),
      _2187: o => {
        if (o === null || o === undefined) return 0;
        if (o instanceof Float32Array) return 1;
        return 2;
      },
      _2188: (o, start, length) => new Float32Array(o.buffer, o.byteOffset + start, length),
      _2189: o => {
        if (o === null || o === undefined) return 0;
        if (o instanceof Float64Array) return 1;
        return 2;
      },
      _2190: (o, start, length) => new Float64Array(o.buffer, o.byteOffset + start, length),
      _2191: (a, i) => a.push(i),
      _2192: (t, s) => t.set(s),
      _2193: l => new DataView(new ArrayBuffer(l)),
      _2194: (o) => new DataView(o.buffer, o.byteOffset, o.byteLength),
      _2196: o => o.buffer,
      _2197: o => o.byteOffset,
      _2198: Function.prototype.call.bind(Object.getOwnPropertyDescriptor(DataView.prototype, 'byteLength').get),
      _2199: (b, o) => new DataView(b, o),
      _2200: (b, o, l) => new DataView(b, o, l),
      _2201: Function.prototype.call.bind(DataView.prototype.getUint8),
      _2202: Function.prototype.call.bind(DataView.prototype.setUint8),
      _2203: Function.prototype.call.bind(DataView.prototype.getInt8),
      _2204: Function.prototype.call.bind(DataView.prototype.setInt8),
      _2205: Function.prototype.call.bind(DataView.prototype.getUint16),
      _2206: Function.prototype.call.bind(DataView.prototype.setUint16),
      _2207: Function.prototype.call.bind(DataView.prototype.getInt16),
      _2208: Function.prototype.call.bind(DataView.prototype.setInt16),
      _2209: Function.prototype.call.bind(DataView.prototype.getUint32),
      _2210: Function.prototype.call.bind(DataView.prototype.setUint32),
      _2211: Function.prototype.call.bind(DataView.prototype.getInt32),
      _2212: Function.prototype.call.bind(DataView.prototype.setInt32),
      _2215: Function.prototype.call.bind(DataView.prototype.getBigInt64),
      _2216: Function.prototype.call.bind(DataView.prototype.setBigInt64),
      _2217: Function.prototype.call.bind(DataView.prototype.getFloat32),
      _2218: Function.prototype.call.bind(DataView.prototype.setFloat32),
      _2219: Function.prototype.call.bind(DataView.prototype.getFloat64),
      _2220: Function.prototype.call.bind(DataView.prototype.setFloat64),
      _2221: Function.prototype.call.bind(Number.prototype.toString),
      _2222: Function.prototype.call.bind(BigInt.prototype.toString),
      _2223: Function.prototype.call.bind(Number.prototype.toString),
      _2224: (d, digits) => d.toFixed(digits),
      _2235: () => globalThis.console,
      _2274: (x0,x1) => x0.error(x1),
      _2409: x0 => x0.style,
      _2888: (x0,x1) => { x0.srcdoc = x1 },
      _2891: x0 => x0.sandbox,
      _2981: x0 => x0.videoWidth,
      _2982: x0 => x0.videoHeight,
      _2986: (x0,x1) => { x0.playsInline = x1 },
      _3011: x0 => x0.error,
      _3013: (x0,x1) => { x0.src = x1 },
      _3018: (x0,x1) => { x0.crossOrigin = x1 },
      _3021: (x0,x1) => { x0.preload = x1 },
      _3022: x0 => x0.buffered,
      _3025: x0 => x0.currentTime,
      _3026: (x0,x1) => { x0.currentTime = x1 },
      _3027: x0 => x0.duration,
      _3028: x0 => x0.paused,
      _3031: x0 => x0.playbackRate,
      _3032: (x0,x1) => { x0.playbackRate = x1 },
      _3043: (x0,x1) => { x0.controls = x1 },
      _3044: x0 => x0.volume,
      _3045: (x0,x1) => { x0.volume = x1 },
      _3046: x0 => x0.muted,
      _3047: (x0,x1) => { x0.muted = x1 },
      _3063: x0 => x0.message,
      _3137: x0 => x0.length,
      _3641: (x0,x1) => { x0.src = x1 },
      _3643: (x0,x1) => { x0.type = x1 },
      _3647: (x0,x1) => { x0.async = x1 },
      _3651: (x0,x1) => { x0.crossOrigin = x1 },
      _3653: (x0,x1) => { x0.text = x1 },
      _3661: (x0,x1) => { x0.charset = x1 },
      _3686: x0 => x0.width,
      _3687: (x0,x1) => { x0.width = x1 },
      _3688: x0 => x0.height,
      _3689: (x0,x1) => { x0.height = x1 },
      _4110: () => globalThis.window,
      _4153: x0 => x0.location,
      _4172: x0 => x0.navigator,
      _4176: x0 => x0.screen,
      _4434: x0 => x0.trustedTypes,
      _4435: x0 => x0.sessionStorage,
      _4436: x0 => x0.localStorage,
      _4444: x0 => x0.href,
      _4560: x0 => x0.userAgent,
      _4611: x0 => x0.data,
      _4768: x0 => x0.length,
      _6713: x0 => x0.signal,
      _6722: x0 => x0.length,
      _6784: () => globalThis.document,
      _6842: x0 => x0.documentElement,
      _6865: x0 => x0.head,
      _7193: x0 => x0.id,
      _7194: (x0,x1) => { x0.id = x1 },
      _7218: (x0,x1) => { x0.innerHTML = x1 },
      _8539: x0 => x0.value,
      _8541: x0 => x0.done,
      _8963: () => globalThis.Notification.permission,
      _9240: x0 => x0.url,
      _9242: x0 => x0.status,
      _9244: x0 => x0.statusText,
      _9245: x0 => x0.headers,
      _9246: x0 => x0.body,
      _9543: x0 => x0.orientation,
      _11372: (x0,x1) => { x0.border = x1 },
      _11814: (x0,x1) => { x0.height = x1 },
      _12504: (x0,x1) => { x0.width = x1 },
      _12872: x0 => x0.name,
      _12873: x0 => x0.message,
      _13588: () => globalThis.console,
      _13616: x0 => globalThis.Wakelock.toggle(x0),
      _13618: x0 => x0.name,
      _13619: x0 => x0.message,
      _13620: x0 => x0.code,

    };

    const baseImports = {
      dart2wasm: dart2wasm,
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
    dartInstance.exports.$setThisModule(dartInstance);

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
