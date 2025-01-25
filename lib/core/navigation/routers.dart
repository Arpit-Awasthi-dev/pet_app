import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/presentation/pages/full_screen_image_page.dart';

import '../../presentation/pages/adopted_pets_page/adopted_pets_page.dart';
import '../../presentation/pages/detail_page/pet_detail_page.dart';
import '../../presentation/pages/home_page/home_page.dart';

class Routers {
  static RouteSettings? _settings;

  static Route<dynamic> toGenerateRoute(RouteSettings settings) {
    _settings = settings;

    switch (settings.name) {
      case HomePage.routeName:
        return _pageRoute(builder: (context) {
          return const HomePage();
        });

      case PetDetailPage.routeName:
        return _pageRoute(builder: (context) {
          return PetDetailPage(
            params: (settings.arguments as PetDetailPageParams),
          );
        });

      case AdoptedPetsPage.routeName:
        return _pageRoute(builder: (context) {
          return const AdoptedPetsPage();
        });

      case FullScreenImagePage.routeName:
        return _pageRoute(builder: (context) {
          return FullScreenImagePage(image: settings.arguments as String);
        });

      default:
        throw Exception('Route Not Found');
    }
  }

  static _pageRoute({required WidgetBuilder builder, bool showModal = false}) {
    if(kIsWeb){
      return MaterialPageRoute(
        builder: builder,
        settings: _settings,
      );
    }
    if (Platform.isAndroid) {
      return MaterialPageRoute(
        builder: builder,
        settings: _settings,
      );
    } else if (Platform.isIOS) {
      return CupertinoPageRoute(
        builder: builder,
        settings: _settings,
        fullscreenDialog: showModal,
      );
    }
  }
}
