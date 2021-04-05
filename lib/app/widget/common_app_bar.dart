/*
 * @author kevin
 * @date 2020/10/10 1:37 PM
 * @Description: CommonAppBar
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final title;
  final List<Widget> rightWidgets;
  final Function onPressBack;
  final bool isShowLeftIcon;
  final bool isShowCloseIcon;
  final Function onPressCloseIcon;
  final double elevation;

  CommonAppBar(
      {Key key,
      @required this.title,
      this.rightWidgets,
      this.onPressBack,
      this.isShowLeftIcon,
      this.isShowCloseIcon,
      this.onPressCloseIcon,
      this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQueryData.fromWindow(window).padding.top;
    var padding = statusBarHeight + 28 - 14; //状态栏高度 56 Icon size 28
    return Container(
      child: Stack(
        children: <Widget>[
          AppBar(
            title: title is String
                ? Text(
                    title,
                  )
                : title,
            centerTitle: true,
            elevation: elevation ?? 0.8,
            leading: isShowLeftIcon ?? true
                ? IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                    onPressed: () {
                      if (onPressBack != null) {
                        onPressBack();
                      } else {
                       Get.back();
                      }
                    })
                : SizedBox.shrink(),
            actions: rightWidgets ?? [Container()].map((item) => item).toList(),
          ),
          isShowCloseIcon != null
              ? Positioned(
                  child: GestureDetector(
                    onTap: onPressCloseIcon,
                    child: Icon(
                      Icons.close,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  top: padding,
                  left: 65,
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
