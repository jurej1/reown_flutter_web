part of '../reown.js.dart';

@JS()
extension type JSConnectedWalletInfo(JSObject _) implements JSObject {
  external JSString name;
  external JSString? get icon;
  external JSString? get type;

  ConnectedWalletInfo get toDart => ConnectedWalletInfo(
        name: name.toDart,
        icon: icon?.toDart,
        type: type?.toDart,
      );
}
