import 'package:reown_flutter_web/src/models/account_chain.dart';

class Account {
  final String? address;
  final String status;
  final int? chainId;
  final AccountChain? chain;
  final bool isConnected;
  final bool isReconnecting;
  final bool isConnecting;

  Account({
    required this.address,
    required this.status,
    required this.chainId,
    required this.chain,
    required this.isConnected,
    required this.isReconnecting,
    required this.isConnecting,
  });
}
