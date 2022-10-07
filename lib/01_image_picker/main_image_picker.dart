import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tutorial/01_image_picker/screens/image_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("fa", "IR"),
            Locale('ar', 'AE'),
            Locale('en', 'EN')
          ],
          locale: const Locale("en", "EN"),
          title: 'Flutter Tutorial',
          theme: ThemeData(
            fontFamily: 'YekanBakhFaNumRegular',
            primarySwatch: Colors.blue,
          ),
          home: const ImagePickerApp(),
        );
      },
    );
  }
}
