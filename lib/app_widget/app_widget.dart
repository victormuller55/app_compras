import 'package:aula_01/telas/home_page.dart';
import 'package:flutter/material.dart';
import 'package:muller_package/app_consts/app_context.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppContext.navigatorKey,
      home: const HomePage(),
    );
  }
}
