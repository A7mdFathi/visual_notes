import 'package:flutter/material.dart';
import 'package:visual_notes/ui/screens/add_new_item.dart';
import 'package:visual_notes/ui/screens/home_screen.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final dynamic args = settings.arguments;

    switch (settings.name) {
      case AppRoute.home:
        return _screenInit(const HomePage());
      case AppRoute.addNewItem:
        return _screenInit(AddNewItem(item: args));

      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute<dynamic> _screenInit(Widget screen) {
    return MaterialPageRoute<dynamic>(builder: (_) => screen);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
