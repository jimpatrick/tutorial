import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key, required this.textButton, this.function, this.minSize})
      : super(key: key);

  final String textButton;
  final VoidCallback? function;
  final Size? minSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        shadowColor: Colors.red,
        minimumSize: minSize ?? const Size(0,0),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: Colors.red,
        disabledBackgroundColor: Colors.red,
        disabledForegroundColor: Colors.white,
      ),
      child: Text(textButton, style: const TextStyle(fontFamily: 'YekanBakhFaNumRegular'),),
    );
  }
}
