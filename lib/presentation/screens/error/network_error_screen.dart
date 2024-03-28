import 'package:flutter/material.dart';
import 'package:my_theater/presentation/utils/colors/app_colors_util.dart';
import '../../utils/text/app_text_utils.dart';
import '../common/icon_text_screen.dart';

class NetworkErrorScreen extends StatelessWidget {
  final String errorText;
  const NetworkErrorScreen({Key? key, required this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconTextScreen(
      icon: Icons.report_gmailerrorred_outlined,
      text: errorText,
      iconColor: AppColorsUtils.errorColor,
      isSplashScreen: false,
    );
  }
}
