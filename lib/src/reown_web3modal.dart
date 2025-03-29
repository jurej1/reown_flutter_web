import 'dart:js_interop';

import 'package:reown_flutter_web/src/js/reown.js.dart';

class Web3Modal {
  static void init({
    required String projectId,
    required List<int> networks,
  }) {
    window.web3Modal.init(
      projectId,
      networks.map((e) => e.toJS).toList().toJS,
    );
  }

  static Future<void> open() async {
    await window.web3Modal.open().toDart;
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
