import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:overlay_support/overlay_support.dart';

mixin DownloadImgMixin<T extends StatelessWidget> {
  Future<void> downloadImg(
      BuildContext context, String name, String url) async {
    try {
      final response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 80,
          name: name);
      if (result != null) {
        toast('Downloaded');
      }
    } catch (e) {
      return;
    }
  }
}

mixin DownloadImgMixinStateful<T extends StatefulWidget> on State<T> {
  Future<void> downloadImg(String name, String url) async {
    try {
      final response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 80,
          name: name);
      if (result != null) {
        toast('Downloaded');
      }
    } catch (e) {
      debugPrint('e = $e');
      return;
    }
  }
}