import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

bool get isIOS {
  return Platform.isIOS;
}

bool get isAndroid {
  return Platform.isAndroid;
}

extension AnimationContlExt on AnimationController {
  void proceed() {
    if (isAnimating) {
      forward();
    }
  }
}

extension ContextExt on BuildContext {
  bool get keyboardVisible {
    return MediaQuery.of(this).viewInsets.bottom > 0;
  }

  Brightness getThemeMode() {
    var brightness = MediaQuery.of(this).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return isDarkMode ? Brightness.dark : Brightness.light;
  }

  bool isDarkMode() {
    return getThemeMode() == Brightness.dark;
  }
}

extension WidgetExtension on Widget {
  Widget get center {
    return Center(child: this);
  }

  Widget get zeroPadding {
    return Padding(padding: EdgeInsets.zero, child: this);
  }

  Widget get circular {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: this,
    );
  }

  Widget padOnly({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom, top: top, left: left, right: right),
      child: this,
    );
  }

  Widget paddingAll(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  Widget paddingSymmetric({double y = 0, double x = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: x, vertical: y),
      child: this,
    );
  }

  Widget addSpace({double x = 0, double y = 0}) {
    return SizedBox(width: x, height: y);
  }

  Widget replace(Widget widget, bool when) {
    return when ? widget : this;
  }

  Widget hideIf(bool when) {
    return when ? const SizedBox() : this;
  }

  Widget size(double width, double height) {
    return SizedBox(width: width, height: height, child: this);
  }

  Widget width(double width) {
    return SizedBox(width: width, child: this);
  }

  Widget height(double height) {
    return SizedBox(height: height, child: this);
  }

  Widget onTap({VoidCallback? execute}) {
    return GestureDetector(
      onTap: execute,
      child: this,
    );
  }

  Widget align({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return Positioned.fill(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: this,
    );
  }
}

extension StateExt on State {
  void waitAndExec(VoidCallback callback, {Duration? duration}) {
    Future.delayed(duration ?? Duration(milliseconds: 800), callback);
  }

  void back() {
    Navigator.of(context).pop();
  }
}

extension DynamicExt on dynamic {
  String get stringify {
    return "$this";
  }
}

extension VoidCallbackExt on VoidCallback {
  VoidCallback get withHaptic {
    return () => {HapticFeedback.lightImpact(), this()};
  }
}
