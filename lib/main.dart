import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reduction_load_rockfort/pages/welcome_page.dart';

import 'model/data_model.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobilePortrait(BuildContext context) {
      return MediaQuery.of(context).size.shortestSide < 600;
    }

    if (isMobilePortrait(context)) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } else {
      //Taplet mode : Landscape
      // SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Load Reduction',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //useMaterial3: true,
        primarySwatch: Colors.green,
      ),
      home: WelcomeScreen(),
    );
  }
}
