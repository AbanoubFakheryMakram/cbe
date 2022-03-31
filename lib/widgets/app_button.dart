
import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';

class AppButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String text;
  final Function()? onTap;
  final Color? btnColor;
  final TextStyle? textStyle;

  const AppButton({
    Key? key,
    required this.text,
    this.height,
    this.width,
    this.onTap,
    this.btnColor,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all(btnColor ?? AppColors.green),
        ),
        onPressed: onTap,
        child: Center(
          child: Text(text, style: textStyle ?? const TextStyle(color: Colors.white, fontSize: 15),),
        ),
      ),
    );
  }
}
