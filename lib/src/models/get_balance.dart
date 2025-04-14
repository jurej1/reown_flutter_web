import 'dart:js_interop';

import 'package:reown_flutter_web/src/js/reown.js.dart';

enum BlockTag {
  latest('latest'),
  earliest('earliest'),
  pending('pending'),
  safe('safe'),
  finalized('finalized');

  const BlockTag(this.value);

  final String value;
}

class GetBalanceParameters {
  const GetBalanceParameters({
    required this.address,
    this.blockNumber,
    this.blockTag,
    this.chainId,
  });

  final String address;
  final BigInt? blockNumber;
  final BlockTag? blockTag;
  final int? chainId;

  JSGetBalanceParams get toJS {
    final jsObject = JSGetBalanceParams(
      address: address.toJS,
    );

    if (blockNumber != null) {
      jsObject.blockNumber = blockNumber!.toJS;
    }

    if (blockTag != null) {
      jsObject.blockTag = blockTag!.value.toJS;
    }

    if (chainId != null) {
      jsObject.chainId = chainId!.toJS;
    }

    return jsObject;
  }
}

class GetBalanceReturnType {
  const GetBalanceReturnType({
    required this.decimals,
    required this.formatted,
    required this.symbol,
    required this.value,
  });

  final int decimals;
  final String formatted;
  final String symbol;
  final BigInt value;
}
