export interface UserAccount {
  address: string | undefined;
  status: string;
  chainId: number | undefined;
  chain: AccountChain | undefined;
  isConnected: boolean;
  isReconnecting: boolean;
  isConnecting: boolean;
}
