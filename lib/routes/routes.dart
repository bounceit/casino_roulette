import 'package:casino/pages/auth_pages/first_auth_page.dart';
import 'package:casino/pages/auth_pages/first_page.dart';
import 'package:casino/pages/auth_pages/first_wight_page.dart';
import 'package:casino/pages/auth_pages/initializer_widget.dart';
import 'package:casino/pages/auth_pages/last_auth_page.dart';
import 'package:casino/pages/auth_pages/registration_pages/registration_page.dart';
import 'package:casino/pages/game_page/game_page.dart';
import 'package:casino/pages/main_of_main.dart';
import 'package:casino/pages/rating_page/rating_page.dart';
import 'package:casino/pages/settings_page/setting_page.dart';
import 'package:casino/pages/splash_page/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? arguments = settings.arguments;
    WidgetBuilder builder;

    switch (settings.name) {
      case SplashScreen.routeName:
        builder = (_) => const SplashScreen();
        break;
      case FirstPage.routeName:
        builder = (_) => const FirstPage();
        break;
      case GamePage.routeName:
        builder = (_) => const GamePage();
        break;
      case RatingPage.routeName:
        builder = (_) => const RatingPage();
        break;
      case SettingPage.routeName:
        builder = (_) => const SettingPage();
        break;
      case MainPage.routeName:
        builder = (_) => const MainPage();
        break;

      case LastAuthorizationPage.routeName:
        builder = (_) => const LastAuthorizationPage();
        break;
      case FirstWightPage.routeName:
        builder = (_) => const FirstWightPage();
        break;
      case InitializerWidget.routeName:
        builder = (_) => const InitializerWidget();
        break;
      case FirstAuthorizationPage.routeName:
        builder = (_) => const FirstAuthorizationPage();
        break;
      case RegistrationPage.routeName:
        builder = (_) => RegistrationPage();
        break;
      default:
        throw Exception('Invalid route: ${settings.name}');
    }

    return MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
  }
}
