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
    Future(() async {
      await reown.init();

      reown.Web3Modal.init(
        projectId: '0xd150561ac084956c16328a3988380aec9d19630a',
        networks: [1, 56],
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await reown.Web3Modal.open();
        },
        child: Text('OPEN MODAL'),
      ),
    );
  }
}
