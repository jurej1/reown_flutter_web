library;

export 'src/reown_web3modal.dart';

// TODO DYNAMICALLY ADD THE INIT WHICH IS BASICALLY GOING TO
// INSERT THE main.js into the INDEX

// Future<void> init() async {
//   final script = web.HTMLScriptElement()
//     ..type = 'text/javascript'
//     ..src = 'assets/packages/reown_flutter_web/assets/main.js';

//   script.onLoad.listen((_) {
//     print('✅ main.js loaded successfully');
//   });

//   script.onError.listen((_) {
//     print('❌ Failed to load main.js');
//   });

//   web.window.document.head!.appendChild(script);
// }
