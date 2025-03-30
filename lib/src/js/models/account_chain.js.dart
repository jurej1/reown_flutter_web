part of '../reown.js.dart';

@JS()
extension type JSAccountChain(JSObject _) implements JSObject {
  external JSNumber? get id;
  external JSString? get name;
  external JSString? get symbol;

  AccountChain get toDart => AccountChain(
        id: id?.toDartInt,
        name: name?.toDart,
        symbol: symbol?.toDart,
      );
}
