import {
  AppKit,
  ConnectedWalletInfo,
  createAppKit,
  PublicStateControllerState,
} from "@reown/appkit";

import { JSModalMetadata } from "./modal_metadata";
import { WagmiAdapter } from "@reown/appkit-adapter-wagmi";
import { chainFromId, chainsFromIds } from "./chains";

import {
  signMessage as wagmiSignMessage,
  getBalance as wagmiGetBalance,
  getAccount as wagmiGetAccount,
  reconnect as wagmiReconnect,
  getChains as wagmiGetChains,
  sendTransaction as wagmiSendTransaction,
  switchChain as wagmiSwitchChain,
  GetAccountReturnType,
  getChainId as wagmiGetChainId,
  GetBalanceParameters,
} from "wagmi/actions";
import { Config } from "wagmi";

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

    console.log("Reown Modal is initialised");
  }

  private wagmiConfig = (): Config => this.wagmiAdapterInstance.wagmiConfig;

  private account = (): GetAccountReturnType =>
    wagmiGetAccount(this.wagmiConfig());

  open = async (): Promise<void> => await this.modalInstance.open();

  openAccount = async (): Promise<void> => {
    await this.modalInstance.open({ view: "Account" });
  };

  openConnect = async (): Promise<void> => {
    await this.modalInstance.open({ view: "Connect" });
  };

  disconnect = async (): Promise<void> => {
    await this.modalInstance.disconnect();
    await this.wagmiAdapterInstance.disconnect();
  };

  close = async (): Promise<void> => {
    await this.modalInstance.close();
  };

  getAccount = (): GetAccountReturnType => this.account();

  getChainId = (): number => {
    return wagmiGetChainId(this.wagmiConfig());
  };
  getChains() {
    return wagmiGetChains(this.wagmiConfig());
  }

  isConnected = (): boolean => this.modalInstance.getIsConnectedState();

  getWalletInfo = (): ConnectedWalletInfo | undefined =>
    this.modalInstance.getWalletInfo();

  subscribeState(
    callback: (newState: PublicStateControllerState) => void
  ): () => void {
    return this.modalInstance.subscribeState(callback);
  }

  async switchChain(chainId: number) {
    const chain = chainFromId(chainId);

    if (chain === undefined) {
      throw new Error(
        "Can not switch to selected chain, because ID was not found"
      );
    }

    return await wagmiSwitchChain(this.wagmiConfig(), { chainId: chain.id });
  }

  getBalance = (params: GetBalanceParameters) => {
    return wagmiGetBalance(this.wagmiConfig(), params);
  };

  // https://wagmi.sh/core/api/actions/reconnect
  async reconnect() {
    await wagmiReconnect(this.wagmiAdapterInstance.wagmiConfig);
  }

  /// BELOWIS NOT IMPLEMENTED YET/////
  /// BELOWIS NOT IMPLEMENTED YET/////
  /// BELOWIS NOT IMPLEMENTED YET/////
  /// BELOWIS NOT IMPLEMENTED YET/////

  getModalState(): PublicStateControllerState {
    return this.modalInstance.getState();
  }

  getIsConnectedState(): boolean {
    return this.modalInstance.getIsConnectedState();
  }

  async signMessage(): Promise<string> {
    const response = await wagmiSignMessage(this.wagmiConfig(), {
      message: "Hello World",
    });

    return response;
  }

  // // https://wagmi.sh/core/api/actions/getBalance
  // async getBalance(
  //   address: AddressType,
  //   blockTag: BlockTag | null,
  //   chainId: number | null
  // ) {
  //   const response = await getBalanceWagmi(this.wagmiConfig(), {
  //     address: address,
  //     chainId: chainId ?? undefined,
  //     blockTag: blockTag ?? undefined,
  //   });

  //   const returnData = {
  //     decimals: response.decimals,
  //     symbol: response.symbol,
  //     value: response.value.toString(),
  //   };

  //   console.log(response);
  //   return JSON.stringify(returnData);
  // }

  subscribeAccount(callback: (data: any) => void) {
    // let lastData: UserAccount | undefined = undefined;
    // this.modalInstance.subscribeAccount((_) => {
    //   const accountData = this.account;
    //   const hasChanged = !isEqual(accountData, lastData);
    //   if (hasChanged) {
    //     lastData = accountData;
    //     callback(JSON.stringify(accountData));
    //   }
    // });
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

  // https://wagmi.sh/core/api/actions/sendTransaction
  async sendTransaction(
    to: AddressType,
    chainId: number | null,
    data: AddressType | null,
    valueWei: bigint | null
  ) {
    const response: AddressType = await wagmiSendTransaction(
      this.wagmiConfig(),
      {
        to: to,
        chainId: chainId ?? undefined,
        data: data ?? undefined,
        value: valueWei ?? undefined,
      }
    );

    console.log("TRANSACTION HASH " + response);
  }
}
