import 'package:flutter/material.dart';
import 'package:flutter_sample_app/src/features/sample_feature/sample_item_list_view.dart';
import 'package:flutter_sample_app/src/features/settings/settings_view.dart';
import 'package:flutter_sample_app/src/utils/routes_names.dart';
import '../utils/globals.dart' as globals;

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings){
    switch (settings.name) {
      case RouteNames.root:
        return MaterialPageRoute(builder: (BuildContext context) => const SampleItemListView());
      case RouteNames.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SampleItemListView());
      case RouteNames.home:
        return MaterialPageRoute(builder: (BuildContext context) => const SampleItemListView());
      case RouteNames.login:
        return MaterialPageRoute(builder: (BuildContext context) => const SampleItemListView());
      case RouteNames.sampleItem:
        return MaterialPageRoute(builder: (BuildContext context) => const SampleItemListView());
      case RouteNames.settings:
        return MaterialPageRoute(builder: (BuildContext context) => SettingsView(controller: globals.globalSettingsController ));
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text("No route is configured"),
              ),
            ),
          );
    }
  }
}