import 'package:challenge04/common/widgets/statefull/downloadFile.dart';
import 'package:challenge04/common/widgets/statefull/test.dart';

import 'package:flutter/material.dart';
import 'package:challenge04/common/widgets/statefull/MesHomePage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'Home_Page';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final List<String> entries = <String>[
  'MessageHomePage',
  'DownloadFile',
  'download_fileDemo',
  'E',
  'F',
  'G',
  'H',
  'I',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P'
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              color: Colors.blue,
              child: Center(
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(
                    ' ${entries[index]}',
                  ),
                  onPressed: () {
                    if (index == entries.indexOf('MessageHomePage')) {
                      Navigator.pushNamed(context, MesHomePage.id);
                    } else if (index == entries.indexOf('DownloadFile')) {
                      Navigator.pushNamed(context, DownloadFile.id);
                    }else if (index == entries.indexOf('download_fileDemo')) {
                      Navigator.pushNamed(context, TestPage.id);
                    }
                  },
                ),
                // child: Center(child: Text('Entry ${entries[index]}')),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }
}
