part of '../reown.js.dart';

extension JSFunctionToDart on JSFunction {
  Function get toDart {
    return js_util.allowInterop(this as Function);
  }
}
