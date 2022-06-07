// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:challenge04/themes/app_colors.dart';

import 'package:challenge04/themes/app_styles.dart';

Widget scrollViewVetical(List chatUser, context) {
  String hour(int index) {
    return chatUser[index]['created_at'].toString().split(':')[1];
  }

  String minute(int index) {
    return chatUser[index]['created_at'].toString().split(':')[2].split('.')[0];
  }

  return Container(
    padding: const EdgeInsets.only(left: 15),
    height: 400,
    child: ListView(
        children: List.generate(
            chatUser.length,
            (index) => Container(
                  padding: const EdgeInsets.only(top: 10),
                  height: 90,
                  child: Row(children: [
                    Column(children: [
                      SizedBox(
                        child: Stack(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(chatUser[index]
                                          ['user']['picture']['medium']),
                                      fit: BoxFit.cover)),
                            ),
                            chatUser[index]['unread_count'] > 0
                                ? Positioned(
                                    top: 40,
                                    left: 39,
                                    child: Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: Colors.pink,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColors.textColor,
                                            width: 1),
                                      ),
                                      child: Center(
                                        child: Text(
                                            '${chatUser[index]['unread_count']}'),
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ]),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 10),
                                child: Text(
                                  '${chatUser[index]['user']['name']}',
                                  style: AppStyles.h1,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 15),
                                child: Text(
                                  int.parse(hour(index = index)) < 12
                                      ? '${hour(index = index)} '
                                          ': ${minute(index = index)} AM'
                                      : '0${int.parse(hour(index = index)) - 12} '
                                          ': ${minute(index = index)} PM',
                                  style: AppStyles.h2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 15),
                            child: Wrap(
                                spacing: 5.0,
                                runSpacing: 5.0,
                                direction: Axis.vertical,
                                children: [
                                  Text(
                                    '${chatUser[index]['text']}',
                                    style: AppStyles.h2,
                                    maxLines: 2,
                                  ),
                                ]),
                          ),
                          // ignore: prefer_const_constructors
                          SizedBox(
                            child: Container(
                              color: Colors.black,
                              height: 2,
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
                ))),
  );
}
