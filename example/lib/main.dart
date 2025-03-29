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
    );
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
