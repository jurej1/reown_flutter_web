enum AccountStatus {
  connected,
  reconnecting,
  connecting,
  disconnected,
  unknown,
}

extension AccountStatusExtension on AccountStatus {
  static AccountStatus fromString(String value) {
    switch (value) {
      case 'connected':
        return AccountStatus.connected;
      case 'reconnecting':
        return AccountStatus.reconnecting;
      case 'connecting':
        return AccountStatus.connecting;
      case 'disconnected':
        return AccountStatus.disconnected;
      default:
        return AccountStatus.unknown;
    }
  }
}
