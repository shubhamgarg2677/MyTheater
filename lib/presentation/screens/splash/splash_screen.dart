import 'package:flutter/material.dart';
import 'package:my_theater/data/remote/api_service.dart';
import 'package:my_theater/data/repositories/data_db_repositories.dart';
import 'package:my_theater/domain/models/movie_list/movie_item_model.dart';
import 'package:my_theater/presentation/screens/error/network_error_screen.dart';
import 'package:my_theater/presentation/screens/movie_list/movie_list_screen.dart';
import 'package:my_theater/presentation/utils/text/app_text_utils.dart';
import '../../helpers/dialogs/choose_location_dialog.dart';
import '../common/icon_text_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool onConfirmClick = false;
  bool isShowDialog = false;
  bool networkError = false;
  DataDbRepositories? dataDbRepositories;

  List<MovieItemModel>? dataList;

  @override
  void initState() {
    ApiService apiService = ApiService();
    dataDbRepositories = DataDbRepositories(apiService);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(!isShowDialog){
      chooseLocationDialog(context);
    }
    if(networkError){
      return const NetworkErrorScreen(errorText: AppTextUtils.errorText);
    }
    return const IconTextScreen(
      icon:Icons.movie_outlined,
      text: AppTextUtils.appName,
      isSplashScreen: true,
    );
  }

  void chooseLocationDialog(BuildContext context)
  {
    isShowDialog = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Navigator.push(context, MaterialPageRoute(
      //     builder: (_)=> const TrailerPlayerScreen(trailerKey: "zSWdZVtXT7E")),
      // );
      ChooseLocationDialog().showLocationDialog(context, (index) {
        onConfirmClick = true;
        onClickConfirm(context);
      });
    });
  }

  void onClickConfirm(BuildContext context) async{
    if(onConfirmClick && dataList!=null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (_)=> MovieListScreen(dataList: dataList)),
        );
      });
    } else if(onConfirmClick){
      Navigator.pop(context);
      dataList = await dataDbRepositories?.getUpcomingMovies();
      if(dataList==null){
        setState(() {
          networkError = true;
        });
      }
    }
  }
}
