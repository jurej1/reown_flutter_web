import {
  AppKit,
  ConnectedWalletInfo,
  createAppKit,
  PublicStateControllerState,
  SocialProvider,
} from "@reown/appkit";
import { JSModalMetadata } from "./modal_metadata";
import { WagmiAdapter } from "@reown/appkit-adapter-wagmi";
import { chainFromId, chainsFromIds } from "./chains";
import {
  signMessage as signMessageWagmi,
  getBalance as getBalanceWagmi,
  getAccount,
  reconnect as wagmiReconnect,
  getChains,
  sendTransaction as wagmiSendTransaction,
} from "wagmi/actions";
import { UserAccount } from "./models/user_account";
import { Config } from "wagmi";

import isEqual from "lodash.isequal";
import { BlockTag } from "./models/blockTag";

export class JSWeb3Modal {
  // Modal Instance
  private _modal: AppKit | undefined;
  private _wagmiAdapter: WagmiAdapter | undefined;

  private get modalInstance() {
    if (this._modal === undefined) {
      throw new Error(
        'Reown not initialized. Call "Web3Modal.init" before running anything else'
      );
    }
    return this._modal;
  }

  private get wagmiAdapterInstance() {
    if (this._wagmiAdapter == undefined) {
      throw new Error(
        'wagmi not initialized. Call "Web3Modal.init" before running anything else'
      );
    }
    return this._wagmiAdapter;
  }

  init(
    projectId: string,
    networks: number[],
    metadata: JSModalMetadata,
    email: boolean,
    includeWalletIds: string[],
    excludeWalletIds: string[]
  ) {
    const chains = chainsFromIds(networks);

    // set up wagmi adapter (Config)
    const wagmiAdapter = new WagmiAdapter({
      projectId,
      networks: chains,
    });

    this._wagmiAdapter = wagmiAdapter;

    // email does not work properly, it is always shown
    this._modal = createAppKit({
      projectId,
      metadata: metadata,
      adapters: [wagmiAdapter],
      networks: chains,
      features: {
        email: email,
        socials: false,
      },
      includeWalletIds: includeWalletIds,
      excludeWalletIds: excludeWalletIds,
    });

    console.log("Reown modal is initialised");
  }

  private get wagmiConfig(): Config {
    return this.wagmiAdapterInstance.wagmiConfig;
  }

  private get account(): UserAccount {
    const account = getAccount(this.wagmiConfig);

    return {
      address: account.address,
      status: account.status,
      chainId: account.chainId,
      chain: {
        id: account.chain?.id,
        name: account.chain?.name,
        symbol: account.chain?.nativeCurrency.symbol,
      },
      isConnected: account.isConnected,
      isReconnecting: account.isReconnecting,
      isConnecting: account.isConnecting,
    };
  }

  async open(): Promise<void> {
    // might need waitForFocus() method
    // await setTimeout(async () => await this.modalInstance.open(), 200);

    this.modalInstance.open();
  }

  async openAccount(): Promise<void> {
    // await setTimeout(
    //   async () => await this.modalInstance.open({ view: "Account" }),
    //   200
    // );

    await this.modalInstance.open({ view: "Account" });
  }

  async openConnect(): Promise<void> {
    // await setTimeout(
    //   async () => await this.modalInstance.open({ view: "Connect" }),
    //   200
    // );

    this.modalInstance.open({ view: "Connect" });
  }

  async disconnect(): Promise<void> {
    await this.modalInstance.disconnect();
    await this.wagmiAdapterInstance.disconnect();
  }

  async close(): Promise<void> {
    await this.modalInstance.close();
  }

  getAccount(): UserAccount {
    return this.account;
  }

  getWalletInfo(): ConnectedWalletInfo | undefined {
    return this.modalInstance.getWalletInfo();
  }

  getModalState(): PublicStateControllerState {
    return this.modalInstance.getState();
  }

  getIsConnectedState(): boolean {
    return this.modalInstance.getIsConnectedState();
  }

  async switchNetwork(chainId: number): Promise<void> {
    // ERROR 1:
    // SwitchChainNotSupportedError: "MetaMask" does not support programmatic chain switching.
    // Anwser: This simply means that the wallet was not properly connected and I should disconnect it and then conenct
    // it thru the app
    const chain = chainFromId(chainId);

    if (chain === undefined) {
      throw new Error(
        "Can not switch to selected chain, because ID was not found"
      );
    }

    return this._modal?.switchNetwork(chain);
  }

  async signMessage(): Promise<string> {
    const response = await signMessageWagmi(this.wagmiConfig, {
      message: "Hello World",
    });

    return response;
  }

  // https://wagmi.sh/core/api/actions/getBalance
  async getBalance(
    address: AddressType,
    blockTag: BlockTag | null,
    chainId: number | null
  ) {
    const response = await getBalanceWagmi(this.wagmiConfig, {
      address: address,
      chainId: chainId ?? undefined,
      blockTag: blockTag ?? undefined,
    });

    const returnData = {
      decimals: response.decimals,
      symbol: response.symbol,
      value: response.value.toString(),
    };

    console.log(response);
    return JSON.stringify(returnData);
  }

  // https://wagmi.sh/core/api/actions/reconnect
  async reconnect() {
    await wagmiReconnect(this.wagmiAdapterInstance.wagmiConfig);
  }

  subscribeAccount(callback: (data: any) => void) {
    let lastData: UserAccount | undefined = undefined;

    this.modalInstance.subscribeAccount((_) => {
      const accountData = this.account;

      const hasChanged = !isEqual(accountData, lastData);

      if (hasChanged) {
        lastData = accountData;
        callback(JSON.stringify(accountData));
      }
    });
  }

  subscribeNetwork(callback: (data: any) => void) {
    this.modalInstance.subscribeNetwork((newState) => {
      const newData = {
        chainId: newState.chainId,
        caipNetworkId: newState.caipNetworkId,
      };
      callback(JSON.stringify(newData));
    });
  }

  getChains() {
    const chains = getChains(this.wagmiConfig);
    console.log(chains);
  }

  // https://wagmi.sh/core/api/actions/sendTransaction
  async sendTransaction(
    to: AddressType,
    chainId: number | null,
    data: AddressType | null,
    valueWei: bigint | null
  ) {
    const response: AddressType = await wagmiSendTransaction(this.wagmiConfig, {
      to: to,
      chainId: chainId ?? undefined,
      data: data ?? undefined,
      value: valueWei ?? undefined,
    });

    console.log("TRANSACTION HASH " + response);
  }
}
