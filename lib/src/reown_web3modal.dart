import 'dart:js_interop';

import 'package:reown_flutter_web/src/js/reown.js.dart';

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

  static Future<void> getAccount() async {
    // Account
    final response = await window.web3Modal.getAccount().toDart;

    print('Address ${response.address}');
    print('Addresses: ${response.addresses}');
    print('ChainID: ${response.chainId}');
    print('Is Connected: ${response.isConnected}');
    print('Status: ${response.status}');
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
