import 'package:flutter/material.dart';
import 'package:dart_code_viewer2/dart_code_viewer2.dart';

class SourceCodeImagePicker extends StatefulWidget {
  const SourceCodeImagePicker({Key? key}) : super(key: key);

  @override
  State<SourceCodeImagePicker> createState() => _SourceCodeImagePickerState();
}

class _SourceCodeImagePickerState extends State<SourceCodeImagePicker> {
  late ThemeMode _themeMode;
  late IconData iconToggle;
  Color _bgColor = Colors.black;

  @override
  initState() {
    super.initState();
    _themeMode = ThemeMode.dark;
    iconToggle = Icons.toggle_off;
  }

  toggleThemeMode() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      iconToggle = Icons.toggle_off;
      _bgColor = Colors.black;
    } else if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.light;
      iconToggle = Icons.toggle_on;
      _bgColor = Colors.white70;
    } else {
      if (Theme.of(context).brightness == Brightness.light) {
        _themeMode = ThemeMode.dark;
        iconToggle = Icons.toggle_off;
      } else {
        _themeMode = ThemeMode.light;
        iconToggle = Icons.toggle_on;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dart Code'),
          actions: [
            IconButton(
              icon: Icon(iconToggle),
              onPressed: () {
                setState(() {
                  toggleThemeMode();
                });
              },
            ),
          ],
        ),
        body: DartCodeViewer(DartCode.sourceCode, showCopyButton: false, backgroundColor: _bgColor, commentStyle: const TextStyle(color: Colors.green, fontSize: 16.0),),
      ),
    );
  }
}

class DartCode {
  static const sourceCode = '''
// Path file: lib/01_image_picker/screens/image_picker.dart
  
  
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:tutorial/01_image_picker/screens/source_code.dart';
import 'package:tutorial/widgets/space.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerApp extends StatefulWidget {
  const ImagePickerApp({super.key});

  @override
  State<ImagePickerApp> createState() => _ImagePickerAppState();
}

class _ImagePickerAppState extends State<ImagePickerApp> {
  File? _imageTemporary;
  File? _imagePermanent;
  final ImagePicker _picker = ImagePicker();

  /// Application directory in file system
  static Future<String> get appPath async =>
      (await getApplicationDocumentsDirectory()).path;

  /// Full path for file
  static Future<String> filePath(String fileName) async =>
      '\${await appPath}/\$fileName';

  /// Get or Take image depend on source
  Future getImage(ImageSource source) async {
    try {
      // Create a XFile
      final XFile? image = await _picker.pickImage(source: source);

      // Check not be null
      if (image == null) {
        return;
      }

      // Our XFile has a name, path, size and ... so create a file with image.path
      // Notice this file in cache directory
      final imageTemporary = File(image.path);

      // Save file permanently
      final imagePermanent = await savePermanent(image);

      // Save file permanently in another way
      String path = await filePath(image.name);
      await image.saveTo(path);

      setState(() {
        _imageTemporary = imageTemporary;
        _imagePermanent = imagePermanent;
      });
    } on PlatformException catch (e) {
      debugPrint('Exception error: \$e');
    }
  }

  Future<File> savePermanent(XFile image) async {
    String path = await filePath(image.name);
    final newImageFile = File(path);
    return File(image.path).copy(newImageFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ImagePicker Package"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            containerImage(_imagePermanent),
            Space(
              height: 5.h,
            ),
            const Text('Choose to load picture:', style: TextStyle(fontSize: 25.0),),
            Space(
              height: 2.h,
            ),
            CustomElevatedButton(
              textButton: 'Gallery',
              minSize: Size(50.w, 6.h),
              function: () => getImage(ImageSource.gallery),
            ),
            Space(
              height: 2.h,
            ),
            CustomElevatedButton(
              textButton: 'Camera',
              minSize: Size(50.w, 6.h),
              function: () => getImage(ImageSource.camera),
            ),
          ],
        ),
      ),
    );
  }

// Author: masoud.saeedi.dev@gmail.com
''';
}
