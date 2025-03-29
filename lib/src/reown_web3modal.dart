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
}
