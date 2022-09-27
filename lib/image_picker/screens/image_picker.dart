import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:tutorial/image_picker/screens/source_code.dart';
import 'package:tutorial/widgets/buttons/elevated_button.dart';
import 'package:tutorial/widgets/space.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tutorial/widgets/expandable_fab.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      '${await appPath}/$fileName';

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
      debugPrint('Exception error: $e');
    }
  }

  Future<File> savePermanent(XFile image) async {
    String path = await filePath(image.name);
    final newImageFile = File(path);
    return File(image.path).copy(newImageFile.path);
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
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
      floatingActionButton: expandableFab(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  ExpandableFab expandableFab(BuildContext context) {
    return ExpandableFab(
      distance: 90.0,
      icon: Icons.code,
      children: [
        ActionButton(
          onPressed: () {},
          icon: const FaIcon(FontAwesomeIcons.youtube),
        ),
        ActionButton(
          onPressed: () {
            _launchInBrowser(Uri.parse('https://github.com/jimpatrick/tutorial'));
          },
          icon: const FaIcon(FontAwesomeIcons.github),
        ),
        ActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SourceCodeImagePicker(),
              ),
            );
          },
          icon: const FaIcon(FontAwesomeIcons.code),
        ),
      ],
    );
  }

  Widget containerImage(File? image) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      elevation: 0.5,
      child: SizedBox(
        height: 30.h,
        width: 80.w,
        child: image == null
            ? SvgPicture.asset('assets/images/placeholder_view_image.svg',
                fit: BoxFit.cover)
            : Image.file(
                image,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}