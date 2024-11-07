import 'package:flutter/material.dart';
import 'package:flutter_test_app/router/router.dart';
import 'package:flutter_test_app/theme/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class FlutterDemoApp extends StatefulWidget {
  const FlutterDemoApp({super.key});

  @override
  State<FlutterDemoApp> createState() => _FlutterDemoAppState();
}

class _FlutterDemoAppState extends State<FlutterDemoApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FlutterDemoApp',
      theme: mainTheme,
      routerConfig: _appRouter.config(
          navigatorObservers: () => [TalkerRouteObserver(GetIt.I<Talker>())]),
    );
  }
}
