import 'dart:js_interop';

import 'package:js/js_util.dart';

@JS('window.web3Modal')
external JSWeb3Modal get web3Modal;

@JS()
@staticInterop
class JSWeb3Modal {}

extension JSWeb3ModalExt on JSWeb3Modal {
  external void init(String projectId, JSArray<JSNumber> networks);
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

class Web3ModalInterop {
  initReown() {
    web3Modal.init(
      'a0e1d6c24a654c98c62348e8ae259fd2',
      [1, 56, 11155111].jsify() as JSArray<JSNumber>,
    );
  }

  connectReown() {
    web3Modal.open();
  }

  disconnectReown() {
    web3Modal.disconnect();
  }

  getAccount() {
    final account = web3Modal.getAccount();

    print(account.toString());
  }

  switchNetwork(int chainId) async {
    print('Switching chain to $chainId');

    await web3Modal.switchNetwork(chainId.toJS).toDart;
    print('Switching chain to $chainId DONE');
  }

  signMessage() async {
    final response = await web3Modal.signMessage().toDart;
    final stringResponse = response.toDart;
    print('DART $stringResponse');
  }

  getBalance() async {
    final response = await web3Modal
        .getBalance(
          "0x678a415fACA5aDB1f3197ecF7055459Dcc4Fb277".toJS,
          null,
          null,
        )
        .toDart;

    print('DART GET BALANCE: $response');
  }

  reconnect() async {
    print('Reconecting');
    await web3Modal.reconnect().toDart;
    print('Reconnecting DONE');
  }

  void subscribeAccount() {
    final jsCallback =
        // ignore: invalid_runtime_check_with_js_interop_types
        allowInterop((JSString data) {
      final stringData = data.toDart;

      print('DART $stringData');
    }) as JSFunction;

    web3Modal.subscribeAccount(jsCallback);
  }

  void getChains() {
    web3Modal.getChains();
  }

  void subscribeNewtork() {
    final jsCallback =
        // ignore: invalid_runtime_check_with_js_interop_types
        allowInterop((JSString data) {
      final stringData = data.toDart;

      print('DART $stringData');
    }) as JSFunction;
    web3Modal.subscribeNetwork(jsCallback);
  }

  void sendTransaction() {
    web3Modal.sendTransaction(
      "0xd150561ac084956c16328a3988380aec9d19630a",
      1,
      null,
      1000000000000,
    );
  }
}
