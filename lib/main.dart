import 'package:flutter/material.dart';
import 'package:flutter_sample_app/src/features/sample_feature/sample_item_list_view.dart';
import 'package:flutter_sample_app/src/features/sample_feature/viewModel/stocks_view_model.dart';
import 'package:flutter_sample_app/src/utils/routes.dart';
import 'package:provider/provider.dart';

import 'src/features/settings/settings_controller.dart';
import 'src/features/settings/settings_service.dart';
import 'src/utils/globals.dart' as globals;

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();
  globals.globalSettingsController = settingsController;


  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}

class MyApp extends StatelessWidget {
    const MyApp({super.key, required SettingsController settingsController});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StocksViewModel()),
      ],
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: MaterialApp(
          title: 'Stock Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: SampleItemListView.routeName,
          onGenerateRoute: Routes.generateRoutes,
        ),
      ),
    );
  }
}