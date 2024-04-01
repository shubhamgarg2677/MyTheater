import 'package:flutter/material.dart';
import 'package:my_theater/domain/models/movie_list/movie_item_model.dart';
import 'package:my_theater/presentation/helpers/dialogs/choose_location_dialog.dart';
import 'package:my_theater/presentation/helpers/theme_colors.dart';
import 'package:my_theater/presentation/screens/bookings_list/bookings_list_screen.dart';
import 'package:my_theater/presentation/screens/error/network_error_screen.dart';
import 'package:my_theater/presentation/screens/movie_list/movie_item_widget.dart';
import 'package:my_theater/presentation/utils/colors/app_colors_util.dart';
import 'package:my_theater/presentation/utils/size/app_size_utils.dart';

import '../../utils/text/app_text_utils.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  List<MovieItemModel>? dataList;

  // @override
  // void initState() {
  //   dataList = widget.dataList;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    dataList = ModalRoute.of(context)!.settings.arguments as List<MovieItemModel>?;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors(context).getBackgroundColor(),
        appBar: AppBar(
          backgroundColor: ThemeColors(context).getBackgroundColor(),
          actions: [
            IconButton(
              onPressed: onTapLocationEdit,
              icon: const Icon(Icons.edit_location_outlined,
                size: AppSizeUtils.iconSize, color: AppColorsUtils.appColor,),
            ),
            IconButton(
              onPressed: onTapBookingCollections,
              icon: const Icon(Icons.collections_bookmark_outlined,
                size: AppSizeUtils.iconSize, color: AppColorsUtils.appColor,),
            ),
          ],
          leading: const Icon(Icons.movie_outlined,
            size: AppSizeUtils.bigIconSize,
            color: AppColorsUtils.appColor,),
          title: Text(AppTextUtils.appName,
            style: TextStyle(
                color: ThemeColors(context).getTextColor(),
                fontSize: AppSizeUtils.smallTitleSize,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                overflow: TextOverflow.ellipsis
            ),
          ),
        ),
        body: dataList!=null
            ? ListView.builder(itemCount: dataList!.length,
            itemBuilder: (_, index){
              return MovieItemWidget(movieItemModel: dataList![index],
                isDetailScreen: false,);
            },) : const NetworkErrorScreen(errorText: AppTextUtils.errorText),
      ),
    );
  }

  void onTapLocationEdit(){
    ChooseLocationDialog().showLocationDialog(context, (index) {
      Navigator.pop(context);
    }, barrierDismissible: true);
  }

  void onTapBookingCollections(){
    Navigator.push(context,
        MaterialPageRoute(builder: (_)=>const BookingsListScreen()));
  }
}
