part of '../reown.js.dart';

@JS()
extension type JSGetAccountReturnType(JSObject _) implements JSObject {
  external JSString status;

  external JSString? get address;
  external JSArray<JSString>? get addresses;

  // external JSChain? get chain;
  // external JSConnector? get connector;
  external JSNumber? get chainId;

  external JSBoolean isConnected;
  external JSBoolean isConnecting;
  external JSBoolean isDisconnected;
  external JSBoolean isReconnecting;

  Account get toDart => Account(
        address: address?.toDart,
        addresses: addresses == null
            ? []
            : addresses!.toDart.map((e) => e.toDart).toList(),
        chainId: chainId?.toDartInt,
        isConnected: isConnected.toDart,
        isConnecting: isConnecting.toDart,
        isDisconnected: isDisconnected.toDart,
        isReconnecting: isReconnecting.toDart,
        status: AccountStatusExtension.fromString(status.toDart),
      );
}
