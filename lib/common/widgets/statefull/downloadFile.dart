import 'dart:convert';
import 'dart:io';
import 'package:challenge04/models/user_model.dart';
import 'package:challenge04/themes/app_styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';

class DownloadFile extends StatefulWidget {
  const DownloadFile({Key? key}) : super(key: key);
  static String id = 'download_file';

  @override
  _DownloadFileDemoState createState() => _DownloadFileDemoState();
}

class _DownloadFileDemoState extends State<DownloadFile> {
  @override
  void initState() {
    super.initState();
    _useHttp();
    setState(() {});
  }

  List list = [];
  List _user = [];

  LogProvider get logger => const LogProvider('⚡️ CallApiDemoPage');
  final urlString = 'https://randomuser.me/api/?results=20';
  double _progressBarValue = 0;
  String paste = '';
  TextEditingController controller = TextEditingController();
  var imageUrl =
      "https://image.thanhnien.vn/w1024/Uploaded/2022/tnabtw/2021_12_09/ta03-7305.jpg";
  bool downloading = true;
  String downloadingStr = "No data";
  String savePath = "";
  double size = 200;

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.black),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Download File"),
            backgroundColor: Colors.black,
          ),
          body: Column(
            children: [
              scrollViewHorizontal(list, 80, 80, 5),
              Center(
                child: downloading
                    ? SizedBox(
                        height: size,
                        width: size,
                        child: Card(
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
                padding: const EdgeInsets.all(2),
                child: Center(child: Text(downloadingStr)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: LinearProgressIndicator(
                  value: _progressBarValue,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: downloadFile,
                        child: const Text('Download'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: _useHttp,
                        child: const Text('Call API'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future downloadFile() async {
    try {
      final dio = Dio();
      debugPrint(imageUrl);

      final fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);

      savePath = await getFilePath(fileName);
      await dio.download(imageUrl, savePath, onReceiveProgress: (rec, total) {
        setState(() {
          downloading = true;
          _progressBarValue = (rec / total);
          var download = _progressBarValue * 100;
          downloadingStr = "Downloading Image : ${download.toInt()} %";

          debugPrint(download.toString());
        });
      });
      setState(() {
        downloading = false;
        downloadingStr = "Completed";

        if (downloadingStr == 'Completed') {
          showSimpleNotification(
              background: Colors.blue,
              Text(
                'The image was saved on your photo gallery',
                style: AppStyles.h2,
              ));
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    final dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName';

    return path;
  }

  Future<void> _useHttp() async {
    try {
      final res = await http.get(Uri.parse(urlString));

      // logger.log(res.body);
      // logger.log(res.statusCode.toString());

      final users = await jsonDecode(res.body);

      _user = users['results'];
      print(_user);
      list = _user.map((data) => Results.fromJson(data)).toList();

      print(list[0].name.first);

      // print(Results.fromJson(users).gender);

      // final list =
      //     (users['results'] as List).map((e) => Model.fromJson(e)).toList();
      // final result = Results.fromJson(users);
      // debugPrint('result=${list[0].toString()}');
      // debugPrint(users.toString());

      // print(_user);
      // debugPrint(_user[0].toString());
      // debugPrint(_user[0]['picture']['medium']);
    } catch (e) {
      debugPrint('error = $e');
      rethrow;
    }
    setState(() {});
  }
}

class LogProvider {
  final String prefix;

  const LogProvider(this.prefix);

  void log(String content) {
    // ignore: avoid_print
    print('$prefix $content');
  }
}

SingleChildScrollView scrollViewHorizontal(
    List user, double height, double width, double size) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: user.isNotEmpty
        ? Row(
            children: List.generate(user.length, (index) {
              return Padding(
                padding: EdgeInsets.only(top: size, bottom: size, left: size),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Column(
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  height: height,
                                  width: width,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              user[index].picture.medium),
                                          fit: BoxFit.cover)),
                                ),
                                Text(
                                  user[index].name.first.toString(),
                                  style: const TextStyle(
                                      color: Colors.black, height: 10),
                                  textAlign: TextAlign.center,
                                ),
                                // user[index]['status'].toString() == 'online'
                                //     ? Positioned(
                                //         top: 45,
                                //         left: 42,
                                //         child: Container(
                                //           width: 15,
                                //           height: 15,
                                //           decoration: BoxDecoration(
                                //             color: Colors.green,
                                //             shape: BoxShape.circle,
                                //             border: Border.all(
                                //                 color: AppColors.textColor,
                                //                 width: 2.5),
                                //           ),
                                //         ),
                                //       )
                                //     : Container()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          )
        : Container(),
  );
}
