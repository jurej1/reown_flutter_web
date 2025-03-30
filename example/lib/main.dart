import 'package:flutter/material.dart';
import 'package:reown_flutter_web/reown_flutter_web.dart' as reown;

void main() {
  runApp(const MaterialApp(title: 'Reown Web3Modal Example', home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    reown.Web3Modal.init(
      projectId: 'a0e1d6c24a654c98c62348e8ae259fd2',
      networks: [1, 56],
      metadata: reown.Web3ModalMetadata(
        name: 'Web3Modal',
        description: 'Web3Modal Example',
        url: 'https://web3modal.com',
        icons: ['https://avatars.githubusercontent.com/u/37784886'],
      ),
      email: false,
      // includeWalletIds: [
      //   'c57ca95b47569778a828d19178114f4db188b89b763c899ba0be274e97267d96',
      //   '4622a2b2d6af1c9844944291e5e7351a6aa24cd7b23099efac1b2fd875da31a0',
      //   '1ae92b26df02f0abca6304df07debccd18262fdf5fe82daa81593582dac9a369',
      //   'c286eebc742a537cd1d6818363e9dc53b21759a1e8e5d9b263d0c03ec7703576',
      // ],
    );

    // Reconnecting when the page refreshes
    Future(() async {
      await reown.Web3Modal.reconnect();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                reown.Web3Modal.open();
              },
              child: Text('Connect Modal'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                reown.Web3Modal.openAccount();
              },
              child: Text('Open Account'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                reown.Web3Modal.openConnect();
              },
              child: Text('Open Connect'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                reown.Web3Modal.disconnect();
              },
              child: Text('Disconnect'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                reown.Web3Modal.getAccount();
              },
              child: Text('get Account'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                reown.Web3Modal.getWalletInfo();
              },
              child: Text('get Connected Wallet INFO'),
            ),
          ],
        ),
      ),
    );
  }
}
