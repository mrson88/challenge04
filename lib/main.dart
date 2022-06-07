import 'package:challenge04/common/widgets/statefull/MesHomePage.dart';
import 'package:challenge04/common/widgets/statefull/test_download.dart';
import 'common/widgets/statefull/downloadFile.dart';
import 'package:flutter/material.dart';
import 'package:challenge04/common/widgets/statefull/test.dart';
import 'package:challenge04/common/widgets/statefull/home.dart';
import 'common/widgets/statefull/api/call_api.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: DownloadFile.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        MesHomePage.id: (context) => const MesHomePage(),
        DownloadFile.id: (context) => const DownloadFile(),
        // DownloadFileDemo.id: (context) => const DownloadFileDemo(),
        TestPage.id: (context) => const TestPage(),
        CallApiDemoPage.id: (context) => const CallApiDemoPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
