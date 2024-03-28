import 'package:flutter/material.dart';
import 'package:my_theater/presentation/utils/colors/app_colors_util.dart';
import 'package:my_theater/presentation/utils/size/app_size_utils.dart';

class DropDownWidget extends StatefulWidget {
  final String? Function(String?)? validator;
  final String? labelText;
  final String? hintText;
  final Color? fillColor;
  final String? value;
  final void Function(String)? getChangeValue;
  final List<String>? items;

  const DropDownWidget({Key? key, this.fillColor, this.validator,
    this.labelText, this.hintText,this.items, this.getChangeValue,
    this.value}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  //void Function(String)? getChangeValue;
  String? _value;
  List<String>? _items;
  String? _hintText;
  String? _labelText;
  String? Function(String?)? _validator;
  Color? _fillColor;

  @override
  void initState() {
    _value = widget.value;
    _items = widget.items;
    _hintText = widget.hintText;
    _validator = widget.validator;
    _labelText = widget.labelText;
    _fillColor = widget.fillColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: _validator,
        value: _value,
        isExpanded: false,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColorsUtils.darkBackColor),
            borderRadius:  BorderRadius.all(Radius.circular(AppSizeUtils.roundCornerSize),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColorsUtils.appColor),
            borderRadius: BorderRadius.all(Radius.circular(AppSizeUtils.roundCornerSize),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColorsUtils.disabledColor),
            borderRadius: const BorderRadius.all(Radius.circular(AppSizeUtils.roundCornerSize),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColorsUtils.errorColor),
            borderRadius: BorderRadius.all(Radius.circular(AppSizeUtils.roundCornerSize),),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColorsUtils.appColor),
            borderRadius: BorderRadius.all(Radius.circular(AppSizeUtils.roundCornerSize),),
          ),
          labelText: _labelText,
          hintText: _hintText,
          hintStyle: TextStyle(color: AppColorsUtils.disabledColor,),
          errorStyle: const TextStyle(color: AppColorsUtils.errorColor,),
          iconColor: AppColorsUtils.darkBackColor,
          fillColor: _fillColor,
          filled: _fillColor!=null?true:false,
        ),
        items: _items?.map(
                (e) => DropdownMenuItem(value: e, child: Text(e),),
        ).toList(),
        onChanged: onChanged
    );
  }

  void onChanged(String? update){
    if(update!=null){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //setState(() {
          _value = update;
        //});
        widget.getChangeValue != null ?  widget.getChangeValue!(update) : null;
      });
    }
  }
}
