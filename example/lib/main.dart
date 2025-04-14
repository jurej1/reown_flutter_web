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
  Stream? stateStream;

  int chain = 1;

  @override
  void initState() {
    super.initState();

    Future(() async {
      // loading the script file
      await reown.init();

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
        //   'c286eebc742a537cd1d6818363e9dc53b21759a1e8e5d9b263 d0c03ec7703576',
        // ],
      );

      setState(() {
        stateStream = reown.Web3Modal.state;
      });

      // reconnecting on web refresh
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
                final response = reown.Web3Modal.getAccount();

                print('DART: ${response.chainId}');
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
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                final response = reown.Web3Modal.isConnected;

                print('DART isConnected: $response');
              },
              child: Text('Is Connected'),
            ),
            SizedBox(height: 12),
            StreamBuilder(
              stream: stateStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Waiting for state...');
                }

                if (!snapshot.hasData) {
                  return const Text('No state yet');
                }

                final state = snapshot.data as reown.Web3ModalState;
                return Text('Web3Modal state: ${state.selectedNetworkId}');
              },
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                if (chain == 1) {
                  await reown.Web3Modal.switchChain(chainId: 56);
                  setState(() {
                    chain = 56;
                  });
                } else {
                  await reown.Web3Modal.switchChain(chainId: 1);
                  setState(() {
                    chain = 1;
                  });
                }
              },
              child: Text(
                chain == 1 ? 'Switch to chain 56' : "Switch to chain 1",
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                final chains = reown.Web3Modal.getChains();

                chains.forEach((e) {
                  print(e.id);
                  print(e.name);
                  print(e.nativeCurrency?.name);
                });
              },
              child: Text('Get Chains'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                final balance = await reown.Web3Modal.getBalance(
                  reown.GetBalanceParameters(
                    address: '0x678a415fACA5aDB1f3197ecF7055459Dcc4Fb277',
                  ),
                );

                print('BALANCE: ${balance.value}');
              },
              child: Text('Get Balance'),
            ),
          ],
        ),
      ),
    );
  }
}
