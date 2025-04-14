part of 'reown.js.dart';

@JS()
extension type JSReownWeb3Modal(JSObject _) implements JSObject {
  external void init(
    String projectId,
    JSArray<JSNumber> networks,
    JSModalMetadata metadata,
    JSBoolean email,
    JSArray<JSString>? includeWalletIds,
    JSArray<JSString>? excludeWalletIds,
  );
  external JSPromise open();
  external JSPromise openAccount();
  external JSPromise openConnect();
  external JSPromise disconnect();
  external JSPromise reconnect();
  external JSPromise close();

  external JSGetAccountReturnType getAccount();
  external JSConnectedWalletInfo getWalletInfo();
  external JSNumber getChainId();
  external JSArray<JSObject> getChains();

  external JSBoolean isConnected();
  external JSFunction subscribeState(JSFunction callback);

  external JSPromise switchChain(JSNumber chainId);
  external JSPromise<JSGetBalanceReturnType> getBalance(
      JSGetBalanceParams params);

  external JSFunction subscribeAccount(JSFunction callback);

  external void subscribeNetwork(JSFunction callback);

  external JSPromise<JSString> sendTransaction(
    JSObject sendTransactionParameters,
  );

  external JSPromise<JSString> signMessage();
}

// @JS()
// extension type PublicStateControllerState._(JSObject _) implements JSObject {
//   external JSBoolean loading;
//   external JSBoolean open;
//   external JSString? selectedNetworkId;
//   external JSString? activeChain;
// }

@JS()
extension type JSModalMetadata._(JSObject _) implements JSObject {
  external JSModalMetadata({
    required JSString name,
    required JSString description,
    required JSString url,
    required JSArray<JSString> icons,
  });

  external JSString name;
  external JSString description;
  external JSString url;
  external JSArray<JSString> icons;
}

@JS()
extension type PublicStateControllerState._(JSObject _) implements JSObject {
  external JSBoolean loading;
  external JSBoolean open;
  external JSString? selectedNetworkId;
  external JSString? activeChain;
}

extension Web3ModalStateFromJS on PublicStateControllerState {
  Web3ModalState get toDart => Web3ModalState(
        loading: loading.toDart,
        open: open.toDart,
        selectedNetworkId: selectedNetworkId?.toDart,
        activeChain: activeChain?.toDart,
      );
}
