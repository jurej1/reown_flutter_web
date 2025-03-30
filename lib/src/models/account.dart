import 'package:reown_flutter_web/src/enums/account_status.dart';

class Account {
  final String? address;
  final List<String>? addresses;
  final int? chainId;
  final bool isConnected;
  final bool isConnecting;
  final bool isDisconnected;
  final bool isReconnecting;
  final AccountStatus status;
  // chain
  // chainID missing

  Account({
    required this.address,
    required this.addresses,
    required this.chainId,
    required this.isConnected,
    required this.isConnecting,
    required this.isDisconnected,
    required this.isReconnecting,
    required this.status,
  });
}
