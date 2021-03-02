import 'package:authentication/src/pages/home.dart';
import 'package:authentication/src/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

final GlobalKey mainGlobalKey = GlobalKey();

enum Pages {
  login,
  home,
}

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
        final text = arguments as String;
        resultPage = HomePage(
          text: text,
        );
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

  Route<dynamic> _getRoute(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
