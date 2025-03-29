import { JSWeb3Modal } from "./src/web3_modal";
// import { JSWagmiCore } from "./src/wagmi_core";

/// Declaring types on the global window
declare global {
  interface Window {
    web3Modal: JSWeb3Modal;
    // wagmiCore: JSWagmiCore;
  }
}

/// Creating new Window objects
/// Allows for communication (JS to Dart)
window.web3Modal = new JSWeb3Modal();
// window.wagmiCore = new JSWagmiCore();

/// Dispatching the event (DOM event)
document.dispatchEvent(new Event("reown_flutter_web_ready"));
