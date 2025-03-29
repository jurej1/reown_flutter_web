part of 'reown.js.dart';

@JS()
extension type JSReownWeb3Modal(JSObject _) implements JSObject {
  external void init(
    String projectId,
    JSArray<JSNumber> networks,
  );
  external void open();
  external void disconnect();
  external JSString getAccount();
  external JSPromise<JSAny?> switchNetwork(JSNumber chainId);
  external JSPromise<JSString> signMessage();
  external JSPromise<JSString> getBalance(
    JSString address,
    JSString? blockTag,
    JSNumber? chainId,
  );
  external JSPromise reconnect();
  external void subscribeAccount(JSFunction callback);
  external void getChains();
  external void subscribeNetwork(JSFunction callback);

  external JSPromise sendTransaction(
    String to,
    num? chainId,
    String? data,
    num? valueWei,
  );
}

@JS()
extension type PublicStateControllerState._(JSObject _) implements JSObject {
  external JSBoolean loading;
  external JSBoolean open;
  external JSString? selectedNetworkId;
  external JSString? activeChain;
}
