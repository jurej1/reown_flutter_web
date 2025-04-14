import 'dart:js_interop';
import 'dart:js_util' as js_util;

import 'package:reown_flutter_web/reown_flutter_web.dart';
import 'package:reown_flutter_web/src/actions/send_transaction.dart';
import 'package:reown_flutter_web/src/enums/account_status.dart';
import 'package:reown_flutter_web/src/models/account.dart';
import 'package:reown_flutter_web/src/models/connected_wallet_info.dart';

part 'models/bigint.js.dart';
part 'models/connected_wallet_into.js.dart';
part 'models/get_account.js.dart';
part 'models/get_balance.js.dart';
part 'models/jsFunctionToDart.js.dart';
part 'models/send_transaction.js.dart';
part 'reown_web3modal.js.dart';

@JS()
external JSWindow get window;

@JS()
extension type JSWindow(JSObject _) implements JSObject {
  external JSReownWeb3Modal get web3Modal;
}

extension JSArrayExtension<T extends JSAny?> on JSArray<T> {
  external void push(JSAny? _);
}

extension JSArrayNonNullableExtension<T extends JSAny> on JSArray<T> {
  external void push(JSAny _);
}
