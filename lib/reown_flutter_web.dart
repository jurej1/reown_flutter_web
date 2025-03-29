library;

import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

var _isReady = false;

/// Initializes the lib.
///
/// This must be done before any interaction
/// with the lib.
Future<void> init() async {
  if (_isReady) return;

  final completer = Completer();

  _completeOnReadyEvent(completer);

  await _injectJavascriptModule('assets/main.js');

  _isReady = true;
  return completer.future;
}

void _completeOnReadyEvent(Completer completer) {
  const readyEventName = 'wagmi_flutter_web_ready';

  void readyEventListener(web.EventListener event) {
    web.window.removeEventListener(
      readyEventName,
      readyEventListener.toJS,
    );
    completer.complete();
  }

  web.window.addEventListener(readyEventName, readyEventListener.toJS);
}

Future<void> _injectJavascriptModule(String assetPath) async {
  final scriptPath = 'assets/packages/reown_flutter_web/$assetPath';

  final scriptNode = web.HTMLScriptElement()
    ..type = 'module'
    ..src = scriptPath;

  web.window.document.querySelector('html')!.appendChild(scriptNode);
}
