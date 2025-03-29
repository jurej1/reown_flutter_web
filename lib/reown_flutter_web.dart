library;

export 'src/reown_web3modal.dart';

// TODO DYNAMICALLY ADD THE INIT WHICH IS BASICALLY GOING TO
// INSERT THE main.js into the INDEX

// Future<void> init() async {
//   final script = web.HTMLScriptElement()
//     ..type = 'text/javascript'
//     ..src = 'assets/packages/reown_flutter_web/assets/main.js';

//   script.onLoad.listen((_) {
//     print('✅ main.js loaded successfully');
//   });

//   script.onError.listen((_) {
//     print('❌ Failed to load main.js');
//   });

//   web.window.document.head!.appendChild(script);
// }

// OLD VERSION DOES NOT WORK
// // THIS IS NOT USED AND IDK WHY NOT
// /// Initializes the lib.
// ///
// /// This must be done before any interaction
// /// with the lib.
// Future<void> init() async {
//   if (_isReady) return;

//   final completer = Completer();

//   _completeOnReadyEvent(completer);

//   await _injectJavascriptModule('assets/main.js');

//   _isReady = true;
//   return completer.future;
// }

// void _completeOnReadyEvent(Completer completer) {
//   const readyEventName = 'reown_flutter_web_ready';

//   void readyEventListener(web.EventListener event) {
//     web.window.removeEventListener(
//       readyEventName,
//       readyEventListener.toJS,
//     );
//     completer.complete();
//   }

//   web.window.addEventListener(readyEventName, readyEventListener.toJS);
// }

// Future<void> _injectJavascriptModule(String assetPath) async {
//   final scriptPath = 'assets/packages/reown_flutter_web/$assetPath';

//   final scriptNode = web.HTMLScriptElement()
//     ..type = 'module'
//     ..src = scriptPath;

//   web.window.document.querySelector('html')!.appendChild(scriptNode);
// }
