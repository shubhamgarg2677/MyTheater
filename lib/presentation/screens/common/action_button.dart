import 'package:flutter/material.dart';
import 'package:my_theater/presentation/utils/colors/app_colors_util.dart';
import 'package:my_theater/presentation/utils/size/app_size_utils.dart';

class ActionButton extends StatelessWidget {
  final String actionTitle;
  final Function onClick;
  final double? height;
  final Color? buttonColor;
  final bool buttonDisabled;
  const ActionButton({Key? key, required this.actionTitle, required this.onClick,
    this.height, this.buttonColor, this.buttonDisabled = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.only(left: AppSizeUtils.wholePadding,
        right: AppSizeUtils.wholePadding,),
      child: ElevatedButton(
        onPressed: buttonDisabled ? null : (){onClick();},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonDisabled
              ? AppColorsUtils.disabledColor : AppColorsUtils.appColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSizeUtils.roundCornerSize)),
          )),
        ),
        child: Text(
          actionTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColorsUtils.whiteColor,
            fontSize: AppSizeUtils.smallTitleSize
          ),
        ),
      ),
    );
  }
}
