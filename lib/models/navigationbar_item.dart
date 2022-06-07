import 'package:flutter/material.dart';
  // ignore: non_constant_identifier_names
  BottomNavigationBarItem button_navigation( {required String iconbar,required Color color, required String label}) {
    return BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(iconbar),
          ),
          backgroundColor: color,
          label: label,
        );
  }