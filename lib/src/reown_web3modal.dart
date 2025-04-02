import 'dart:async';
import 'dart:js_interop';

import 'package:reown_flutter_web/src/js/reown.js.dart';
import 'package:reown_flutter_web/src/models/account.dart';
import 'package:reown_flutter_web/src/models/connected_wallet_info.dart';

class Web3Modal {
  static void init({
    required String projectId,
    required List<int> networks,
    required Web3ModalMetadata metadata,
    required bool email,
    List<String>? includeWalletIds,
    List<String>? excludeWalletIds,
  }) {
    window.web3Modal.init(
      projectId,
      networks.map((e) => e.toJS).toList().toJS,
      metadata._toJS(),
      email.toJS,
      includeWalletIds?.jsify() as JSArray<JSString>?,
      excludeWalletIds?.jsify() as JSArray<JSString>?,
    );
  }

  static Future<void> open() async {
    await window.web3Modal.open().toDart;
  }

  static Future<void> openAccount() async {
    await window.web3Modal.openAccount().toDart;
  }

  static Future<void> openConnect() async {
    await window.web3Modal.openConnect().toDart;
  }

  static Future<void> disconnect() async {
    await window.web3Modal.disconnect().toDart;
  }

  static Future<void> reconnect() async {
    await window.web3Modal.reconnect().toDart;
  }

  static Account getAccount() {
    return window.web3Modal.getAccount().toDart;
  }

  static ConnectedWalletInfo getWalletInfo() {
    return window.web3Modal.getWalletInfo().toDart;
  }

  static bool get isConnected {
    return window.web3Modal.isConnected().toDart;
  }

  // when disconnected the state should be NULL
  static Stream<Web3ModalState> get state {
    late StreamController<Web3ModalState> controller;
    late Function? stopListeningFunction;

    void startListening() {
      stopListeningFunction = window.web3Modal
          .subscribeState(
            ((PublicStateControllerState state) {
              controller.add(state.toDart);
            }).toJS,
          )
          .toDart;
    }

    void stopListening() {
      if (stopListeningFunction != null) {
        stopListeningFunction!();
      }
      stopListeningFunction = null;
    }

    controller = StreamController<Web3ModalState>(
      onListen: startListening,
      onPause: stopListening,
      onResume: startListening,
      onCancel: stopListening,
    );

    return controller.stream;
  }

  static Future<void> switchChain({required int chainId}) {
    return window.web3Modal.switchChain(chainId.toJS).toDart;
  }
}

class Web3ModalMetadata {
  Web3ModalMetadata({
    required this.name,
    required this.description,
    required this.url,
    required this.icons,
  });

  final String name;
  final String description;
  final String url;
  final List<String> icons;

  JSModalMetadata _toJS() => JSModalMetadata(
        name: name.toJS,
        description: description.toJS,
        url: url.toJS,
        icons: icons.map((icon) => icon.toJS).toList().toJS,
      );
}

class Web3ModalState {
  Web3ModalState({
    required this.loading,
    required this.open,
    required this.selectedNetworkId,
    required this.activeChain,
  });

  final bool loading;
  final bool open;
  final String? selectedNetworkId;
  final String? activeChain;
}
