import 'dart:convert';

import 'package:atomic_transact_flutter/atomic_transact_flutter.dart';
import 'package:atomic_transact_flutter/platform_interface/atomic_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showingTransact = false;

  @override
  void initState() {
    super.initState();
    // Atomic.transact(
    //   config: AtomicConfig(
    //     publicToken: '',
    //     product: AtomicProductType.deposit,
    //   ),
    // );
    AtomicPlatformInterface.instance.onCompletion = onCompletion;
    AtomicPlatformInterface.instance.onDataRequest = onDataRequest;
    AtomicPlatformInterface.instance.onInteraction;
  }

  onCompletion(AtomicTransactCompletionType type, AtomicTransactResponse? response, AtomicTransactError? error) {
    debugPrint('AtomicTransactCompletionType : $type');
    debugPrint('AtomicTransactResponse : $response');
    debugPrint('AtomicTransactError : $error');
  }

  onDataRequest(AtomicTransactDataRequest request) {
    debugPrint('AtomicTransactDataRequest : $request');
    debugPrint('data : ${request.data}');
    debugPrint('data : ${request.fields}');
  }

  onInteraction(AtomicTransactInteraction interaction) {
    debugPrint('AtomicTransactInteraction : $interaction');
    debugPrint('value: ${interaction.value}');
    debugPrint('Company: ${interaction.company}');
    debugPrint('name: ${interaction.name}');
    debugPrint('description: ${interaction.description}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: SizedBox.shrink(),
      body: buildWebview(),
    );
  }

  Widget buildWebview() {
    String url = 'https://transact.atomicfi.com/initialize/${getBase64()}';
    return WebView(
      initialUrl: url,
      debuggingEnabled: true,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

  String getBase64() {
    String object = '{"publicToken": "","tasks": [{"product": "deposit"}]}';

    return base64Encode(utf8.encode(object));
  }
}
