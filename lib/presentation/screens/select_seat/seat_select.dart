import 'package:flutter/material.dart';
import 'package:my_theater/presentation/helpers/theme_colors.dart';

import '../../utils/size/app_size_utils.dart';
import '../common/action_button.dart';
import '../common/drop_down_widget.dart';

class SelectSeatScreen extends StatefulWidget {
  final void Function(String? row, String? seat) onConfirm;
  const SelectSeatScreen({Key? key, required this.onConfirm}) : super(key: key);

  @override
  State<SelectSeatScreen> createState() => _SelectSeatScreenState();
}

class _SelectSeatScreenState extends State<SelectSeatScreen> {
  bool buttonDisabled = true;
  String? selectedRow, selectedSeat;

  @override
  Widget build(BuildContext context) {
    ThemeColors themeColors = ThemeColors(context);
    return Padding(
      padding: const EdgeInsets.all(AppSizeUtils.wholePadding*1.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose Preferred Seat:",
            softWrap: true,
            maxLines: 2,
            style: TextStyle(
                color: themeColors.getTextColor(),
                fontSize: AppSizeUtils.smallTitleSize,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis
            ),
          ),
          const SizedBox(height: AppSizeUtils.wholePadding),
          DropDownWidget(
            items: const ["A","B","C","D","E","F","G","H"],
            hintText: "Select Seat Row",
            labelText: "Select Seat Row",
            getChangeValue: onChangeRowValue,),
          const SizedBox(height: AppSizeUtils.wholePadding),
          DropDownWidget(
            items: const ["1","2","3","4","5","6","7","8","9","10"],
            hintText: "Select Seat",
            labelText: "Select Seat",
            getChangeValue: onChangeSeatValue,),
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
                  onClick: startPayment,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void onChangeRowValue(String value) async{
    selectedRow = value;
  }

  void onChangeSeatValue(String value) async{
    selectedSeat = value;
    if(selectedSeat!=null && selectedRow!=null)
    {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          buttonDisabled = false;
        });
      });
    }
  }


  void startPayment(){
    widget.onConfirm(selectedRow, selectedSeat);
  }
}
