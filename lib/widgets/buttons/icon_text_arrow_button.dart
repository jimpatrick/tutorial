import 'package:flutter/material.dart';

class IconArrowButton extends StatelessWidget {
  const IconArrowButton(
      {Key? key,
      required this.textButton,
      this.subtitleTextButton,
      this.height,
      this.width,
      this.icon,
      this.colorIcon,
      this.backgroundColorIcon})
      : super(key: key);

  final String textButton;
  final String? subtitleTextButton;
  final double? height;
  final double? width;
  final IconData? icon;
  final Color? colorIcon;
  final Color? backgroundColorIcon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Container(
              color: backgroundColorIcon ?? Colors.grey,
              width: 70,
              height: 70,
              child: Icon(icon ?? Icons.people_alt,
                  color: colorIcon ?? Colors.white),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(textButton),
                  subtitleTextButton == null
                      ? const SizedBox(height: 0)
                      : Text(subtitleTextButton!,
                          style: const TextStyle(color: Colors.grey))
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.blue),
            const SizedBox(
              width: 10.0,
            )
          ],
        ),
      ),
    );
  }
}
