part of '../reown.js.dart';

@JS()
extension type JSAccount(JSObject _) implements JSObject {
  external JSString? get address;
  external JSString get status;
  external JSNumber? get chainId;
  external JSAccountChain? get chain;
  external JSBoolean isConnected;
  external JSBoolean isReconnecting;
  external JSBoolean isConnecting;

  Account get toDart => Account(
        address: address?.toDart,
        status: status.toDart,
        chainId: chainId?.toDartInt,
        chain: chain?.toDart,
        isConnected: isConnected.toDart,
        isConnecting: isConnecting.toDart,
        isReconnecting: isReconnecting.toDart,
      );
}
