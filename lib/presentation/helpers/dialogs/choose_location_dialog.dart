import 'package:flutter/material.dart';
import 'package:my_theater/data/repositories/local_session.dart';

import '../../screens/common/choose_option_screen.dart';

class ChooseLocationDialog{
  void showLocationDialog(BuildContext context, Function(int index) onConfirm){
    List<String> locationList = const ["Gurugram", "Noida", "Delhi", "Bengaluru", "Pune", "Mumbai", "Gwalior"];
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Dialog(
          child:  ChooseOptionScreen(
              onConfirm: (index){
                if(index!=null){
                  LocalSession().currentLocation = locationList[index];
                  onConfirm(index);
                }
              },
              hintText: "Choose Location",
              titleText: "Choose your Location :",
              dataList: locationList)
      ),
    );
  }
}