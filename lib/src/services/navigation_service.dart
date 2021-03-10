import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/home.dart';
import '../pages/login.dart';

enum Pages {
  home,
  login,
}

final GlobalKey mainGlobalKey = GlobalKey();

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = Get.key;

  Future<dynamic> navigateTo(Pages page, {Object arguments}) {
    final route = _generateRoute(page, arguments);
    return navigatorKey.currentState.push(route);
  }

  Future<dynamic> navigateWithReplacementTo(Pages page, {Object arguments}) {
    final route = _generateRoute(page, arguments);
    return navigatorKey.currentState.pushReplacement(route);
  }

  void goBack() {
    navigatorKey.currentState.pop();
  }

  Route<dynamic> _generateRoute(Pages page, Object arguments) {
    Widget resultPage;

    switch (page) {
      case Pages.home:
        final argument = arguments as String;
        resultPage = HomePage(text: argument);
        break;
      case Pages.login:
        resultPage = LoginPage();
        break;

      default:
        resultPage = LoginPage();
        break;
    }

    return _getRoute(resultPage);
  }

  Route<dynamic> _getRoute(Widget widget, {RouteSettings settings}) {
    return MaterialPageRoute(builder: (_) => widget, settings: settings);
  }
}
