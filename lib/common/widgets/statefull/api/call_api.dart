import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:challenge04/common/widgets/statefull/test.dart';

import 'package:http/http.dart' as http;
// import 'package:social_api/models/random_user.dart';

import 'package:flutter/foundation.dart';
import '../test_download.dart';

class CallApiDemoPage extends StatefulWidget {
  const CallApiDemoPage({Key? key}) : super(key: key);
  static String id = 'call_api';

  @override
  _CallApiDemoPageState createState() => _CallApiDemoPageState();
}

class _CallApiDemoPageState extends State<CallApiDemoPage>
    with DownloadImgMixinStateful {
      
  final urlString = 'https://randomuser.me/api/?results=20';
  Future<List<RandomUser>?>? _value;
  final double sizeAvatar = 50;

  LogProvider get logger => const LogProvider('⚡️ CallApiDemoPage');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call API Demo'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton(
                // onPressed: _useDio,
                onPressed: _useHttp,
                // onPressed: _useFutureBuilder,
                child: const Text('Call API'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton(
                onPressed: _useDio,
                // onPressed: () {
                //   downloadImg('Ahihihihihi',
                //       'https://randomuser.me/api/portraits/men/75.jpg');
                // },
                child: const Text('Download'),
              ),
            ),
          ),
          // FutureBuilder<List<RandomUser>?>(
          //   // future: _getUsers(),
          //   future: _value,
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const CircularProgressIndicator();
          //     } else if (snapshot.connectionState == ConnectionState.done) {
          //       if (snapshot.hasError) {
          //         return const Text('Something went wrong!!!');
          //       } else if (snapshot.hasData) {
          //         return Expanded(
          //           child: ListView.builder(
          //             itemBuilder: (_, index) {
          //               final user = snapshot.data![index];
          //               return ListTile(
          //                 title: Text(
          //                   user.displayName,
          //                   style: const TextStyle(fontWeight: FontWeight.w600),
          //                 ),
          //                 contentPadding: const EdgeInsets.symmetric(
          //                     vertical: 8, horizontal: 12),
          //                 leading: Container(
          //                   width: sizeAvatar,
          //                   height: sizeAvatar,
          //                   decoration:
          //                       const BoxDecoration(shape: BoxShape.circle),
          //                   child: ClipOval(
          //                     child: CachedNetworkImage(
          //                       imageUrl: user.avatarUrl,
          //                       fit: BoxFit.cover,
          //                       errorWidget: (context, url, error) =>
          //                           const Icon(Icons.error),
          //                     ),
          //                   ),
          //                 ),
          //               );
          //             },
          //             itemCount: snapshot.data?.length ?? 0,
          //           ),
          //         );
          //       }
          //       return const Text('Empty data');
          //     }
          //     return Text('State: ${snapshot.connectionState}');
          //   },
          // ),
        ],
      ),
    );
  }

  Future<void> _useDio() async {
    try {
      final res = await Dio().get(urlString);

      logger.log(res.data);
      logger.log(res.statusMessage.toString());
      logger.log(res.statusCode.toString());
      logger.log(res.data['results']);

      _value =
          res.data['results'].map((json) => RandomUser.fromJson(json)).toList();

      logger.log(_value.toString());
    } catch (e) {
      print('error = $e');
      rethrow;
    }
  }

  Future<void> _useHttp() async {
    try {
      final res = await http.get(Uri.parse(urlString));

      logger.log(res.body);
      logger.log(res.statusCode.toString());

      final users = jsonDecode(res.body)['results']
          .map((json) => RandomUser.fromJson(json))
          .toList();

      print(users);
    } catch (e) {
      print('error = $e');
      rethrow;
    }
  }

  Future<void> _useFutureBuilder() async {
    _value = _getUsers() as Future<List<RandomUser>?>?;
    setState(() {});
  }

  Future<List> _getUsers() async {
    try {
      final res = await Dio().get(urlString);

      return (res.data['results'] as List)
          .map((json) => RandomUser.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}

class RandomUser {
  static fromJson(json) {}

}

class LogProvider {
  final String prefix;

  const LogProvider(this.prefix);

  void log(String content) {
    if (kReleaseMode) {
      return;
    }

    // ignore: avoid_print
    print('$prefix $content');
  }
}
