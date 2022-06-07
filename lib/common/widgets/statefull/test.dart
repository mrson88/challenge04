import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);
  static String id = 'download_file_demo';

  @override
  _DownloadFileDemoState createState() => _DownloadFileDemoState();
}

class _DownloadFileDemoState extends State<TestPage> {
  var imageUrl =
      "https://www.itl.cat/pngfile/big/10-100326_desktop-wallpaper-hd-full-screen-free-download-full.jpg";
  bool downloading = true;
  String downloadingStr = "No data";
  String savePath = "";
  double size = 250;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.pink),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Download File"),
          backgroundColor: Colors.pink,
        ),
        body: Column(
          children: [
            Center(
              child: downloading
                  ? SizedBox(
                      height: size,
                      width: size,
                      child: Card(
                        color: Colors.pink,
                        child: Center(
                          child: Text(
                            downloadingStr,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: size,
                      width: size,
                      child: Center(
                        child: Image.file(File(savePath), height: 200),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: downloadFile,
                  child: const Text('Download'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future downloadFile() async {
    try {
      final dio = Dio();

      final fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);

      savePath = await getFilePath(fileName);
      await dio.download(imageUrl, savePath, onReceiveProgress: (rec, total) {
        setState(() {
          downloading = true;
          var download = (rec / total) / 100;
          downloadingStr = "Downloading Image : $download %";
        });
      });
      setState(() {
        downloading = false;
        downloadingStr = "Completed";
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    final dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName';

    return path;
  }
}