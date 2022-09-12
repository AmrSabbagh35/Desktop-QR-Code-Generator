import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hisham_qr/qr_gen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(EasyLocalization(
        path: 'assets/translations',
        supportedLocales: [
          Locale('ar'),
          Locale('en'),
        ],
        fallbackLocale: Locale('ar'),
        saveLocale: true,
        startLocale: Locale('ar'),
        child: new MyApp()));
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _windowSize = 'Unknown';

  @override
  void initState() {
    super.initState();
    Platform.isWindows ? _getWindowSize() : null;
  }

  Future _getWindowSize() async {
    var size = await DesktopWindow.getWindowSize();
    await DesktopWindow.setFullScreen(true);
    await DesktopWindow.setMinWindowSize(Size(1280, 720));
    await DesktopWindow.setMaxWindowSize(Size(1920, 1080));

    setState(() {
      _windowSize = '${size.width} x ${size.height}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        home: QrGenScreen());
  }
}
