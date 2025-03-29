import 'dart:js_interop';

import 'package:reown_flutter_web/src/js/reown_web3modal.js.dart';

@JS()
external JSWindow get window;

@JS()
extension type JSWindow(JSObject _) implements JSObject {
  external JSReownWeb3Modal get web3Modal;
}

extension JSArrayExtension<T extends JSAny?> on JSArray<T> {
  external void push(JSAny? _);
}

extension JSArrayNonNullableExtension<T extends JSAny> on JSArray<T> {
  external void push(JSAny _);
}
