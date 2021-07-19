import 'package:flutter/material.dart';

class CommonUtils {

  static AppBar myAppBar(String title1,String title2) {
    return AppBar(
      backgroundColor: Colors.transparent,
      // elevation: 0.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title1,
            style: TextStyle(
              color: Colors.amber,
                  fontSize: 22,
            ),
          ),
          Text(
            title2,
            style: TextStyle(
              color: Colors.pink,
              fontSize: 22,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }


}