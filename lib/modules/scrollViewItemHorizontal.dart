// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:challenge04/themes/app_colors.dart';

import 'package:challenge04/themes/app_styles.dart';

SingleChildScrollView scrollViewHorizontal(List user,double height,double width,double size) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: user.isNotEmpty
        ? Row(
            children: List.generate(user.length, (index) {
              return Padding(
                padding:  EdgeInsets.only(top: size, bottom: size, left: size),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Stack(
                        children: [
                          Container(
                            height: height,
                            width: width,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        user[index]['picture']['medium']),
                                    fit: BoxFit.cover)),
                          ),
                          user[index]['status'].toString() == 'online'
                              ? Positioned(
                                  top: 45,
                                  left: 42,
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppColors.textColor,
                                          width: 2.5),
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                    Text(
                      user[index]['name'].toString(),
                      style: AppStyles.h3,
                    )
                  ],
                ),
              );
            }),
          )
        : Container(),
  );
}
