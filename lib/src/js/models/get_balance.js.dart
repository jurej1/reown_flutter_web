part of '../reown.js.dart';

@JS()
extension type JSGetBalanceParams._(JSObject _) implements JSObject {
  external JSGetBalanceParams({
    JSString address,
    JSBigInt? blockNumber,
    JSString? blockTag,
    JSNumber? chainId,
  });

  external JSString address;
  external JSBigInt? blockNumber;
  external JSString? blockTag;
  external JSNumber? chainId;
}

@JS()
extension type JSGetBalanceReturnType(JSObject _) implements JSObject {
  external JSNumber decimals;
  external JSString formatted;
  external JSString symbol;
  external JSBigInt value;

  GetBalanceReturnType get toDart => GetBalanceReturnType(
        decimals: decimals.toDartInt,
        formatted: formatted.toDart,
        symbol: symbol.toDart,
        value: value.toDart,
      );
}
