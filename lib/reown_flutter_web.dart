library;

import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

export 'src/models/get_balance.dart';
export 'src/reown_web3modal.dart';

var _isReady = false;

Future<void> init() async {
  if (_isReady) return;

  final completer = Completer();

  _completeOnReadyEvent(completer);

  final assetsPath = "assets/main.js";
  final script = web.HTMLScriptElement()
    ..type = 'module'
    ..src = 'assets/packages/reown_flutter_web/$assetsPath';

  script.onLoad.listen((_) {
    print('✅ main.js loaded successfully');
  });

  script.onError.listen((_) {
    print('❌ Failed to load main.js');
  });

  web.window.document.getElementsByTagName('html').item(0)!.append(script);

  _isReady = true;

  return completer.future;
}

void _completeOnReadyEvent(Completer completer) {
  const readyEventName = 'reown_flutter_web_ready';

  void readyEventListener(web.Event event) {
    web.window.document.removeEventListener(
      readyEventName,
      readyEventListener.toJS,
    );
    completer.complete();
  }

  web.window.document.addEventListener(
    readyEventName,
    readyEventListener.toJS,
  );
}

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
