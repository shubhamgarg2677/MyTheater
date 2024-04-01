import 'package:flutter/material.dart';

import '../../helpers/theme_colors.dart';
import '../../utils/size/app_size_utils.dart';
import 'action_button.dart';
import 'drop_down_widget.dart';

class ChooseOptionScreen extends StatefulWidget {
  final void Function(int? index) onConfirm;
  final String titleText;
  final String hintText;
  final List<String> dataList;
  final String? value;
  const ChooseOptionScreen({Key? key, required this.onConfirm,
    required this.hintText, required this.titleText, required this.dataList, this.value}) : super(key: key);

  @override
  State<ChooseOptionScreen> createState() => _ChooseOptionScreenState();
}

class _ChooseOptionScreenState extends State<ChooseOptionScreen> {
  bool buttonDisabled = true;
  int? selectedValue;
  @override
  Widget build(BuildContext context) {
    ThemeColors colors = ThemeColors(context);
    return Padding(
      padding: const EdgeInsets.all(AppSizeUtils.wholePadding*1.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.titleText,
            softWrap: true,
            maxLines: 2,
            style: TextStyle(
                color: colors.getTextColor(),
                fontSize: AppSizeUtils.smallTitleSize,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis
            ),
          ),
          const SizedBox(height: AppSizeUtils.wholePadding),
          DropDownWidget(
            items: widget.dataList,
            hintText: widget.hintText,
            labelText: widget.hintText,
            getChangeValue: onChangeValue,
            value: widget.value,
          ),
          const SizedBox(height: AppSizeUtils.wholePadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Expanded(flex: 1,child: SizedBox(),),
              Expanded(flex: 1,
                child: ActionButton(
                  actionTitle: "Confirm",
                  buttonDisabled: buttonDisabled,
                  onClick:(){ widget.onConfirm(selectedValue); },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void onChangeValue(String value) async{
    selectedValue = widget.dataList.indexOf(value);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        buttonDisabled = false;
      });
    });
  }
}
