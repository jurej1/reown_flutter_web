import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:reown_flutter_web/src/web3_modal_interop.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedChain = 1;

  Web3ModalInterop web3modalInterop = Web3ModalInterop();
  @override
  void initState() {
    super.initState();
    // Initializes REOWN
    web3modalInterop.initReown();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      web3modalInterop.subscribeAccount();
      web3modalInterop.reconnect();
      web3modalInterop.subscribeNewtork();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter JS Interop')),
        body: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Wrap(
              //   spacing: 8,
              //   runSpacing: 8,
              //   children: [
              //     ElevatedButton(
              //       onPressed: () {
              //         reownInterop.openConnectModal();
              //       },
              //       child: Text('open connect Modal'),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {
              //         reownInterop.openNetworkModal();
              //       },
              //       child: Text('open Network modal'),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {
              //         reownInterop.disconnectModal();
              //       },
              //       child: Text('Disconnect Modal'),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {
              //         reownInterop.fetchWalletInfo();
              //       },
              //       child: Text('Fetch Wallet Info'),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {
              //         reownInterop.fetchWagmiAccount();
              //       },
              //       child: Text('Wagmi Account'),
              //     ),
              //   ],
              // ),
              Text('REOWN PACKAGE created (TS REOWN x WAGMI)'),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      web3modalInterop.connectReown();
                    },
                    child: Text('Connect REOWN'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      web3modalInterop.disconnectReown();
                    },
                    child: Text('Disconnect REOWN'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      web3modalInterop.getAccount();
                    },
                    child: Text('Get Account'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedChain = selectedChain == 1 ? 56 : 1;
                      });
                      web3modalInterop.switchNetwork(selectedChain);
                    },
                    child: Text(
                      'Switch to chain ${selectedChain == 1 ? '56' : '1'}',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      web3modalInterop.signMessage();
                    },
                    child: Text('sign message'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      web3modalInterop.getBalance();
                    },
                    child: Text('Get balance '),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      web3modalInterop.getChains();
                    },
                    child: Text('Get Chains'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      web3modalInterop.sendTransaction();
                    },
                    child: Text('Send Transaction'),
                  ),
                ],
              ),
              // if (_walletInfo != null)
              //   Column(
              //     children: [
              //       Text('Wallet Name: ${_walletInfo!['name']}'),
              //       Text('Wallet Type: ${_walletInfo!['type']}'),
              //       // Image.network(
              //       //   _walletInfo!['icon'] ?? '',
              //       //   height: 24,
              //       //   width: 24,
              //       // ),
              //     ],
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
