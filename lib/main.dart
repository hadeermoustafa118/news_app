import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/layout/newsLayout.dart';
import 'package:news_app/shared/cupit/AppCubit/appStates.dart';
import 'package:news_app/shared/cupit/blocObserver.dart';
import 'package:bloc/bloc.dart';
import 'package:news_app/shared/cupit/cubit.dart';
import 'package:news_app/shared/cupit/states.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cupit/Appcubit/AppCubit.dart';
import 'package:news_app/shared/cupit/Appcubit/appStates.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_app/shared/network/local/cashHelper.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  blocObserver: MyBlocObserver();
  DioHelper.init();
await  CashHelper.init();
bool? isDark = CashHelper.getData(key: 'isDark');
  runApp( MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  final bool isDark;
   const MyApp( this.isDark, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        BlocProvider(
          create: ( context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience()
          ..changeModeApp(
            fromShared: isDark,
          ),


      child: BlocConsumer < NewsCubit,NewsStates>(
          listener: (context, state) {},
          builder: ( context,  states) {
            return MaterialApp(
              theme: ThemeData(
                  primarySwatch: Colors.red,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                  //  backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarBrightness: Brightness.dark,
                    ),
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                    backgroundColor: Colors.white,
                    elevation: 5.0,
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    ),
                  ),
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  )),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white,
                    selectedItemColor: Colors.red,
                    unselectedItemColor: Colors.grey,
                    elevation: 20.0,
                  )),
              darkTheme: ThemeData(
                  scaffoldBackgroundColor: HexColor('333739'),
                  primarySwatch: Colors.red,
                  appBarTheme: AppBarTheme(
                  //  backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarBrightness: Brightness.light,
                    ),
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                    backgroundColor: HexColor('333739'),
                    elevation: 5.0,
                    iconTheme: IconThemeData(
                      color: Colors.white,
                    ),
                  ),
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  )),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: HexColor('333739'),
                    selectedItemColor: Colors.red,
                    unselectedItemColor: Colors.grey,
                    elevation: 20.0,
                  )),
              themeMode:  NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              title: 'News app',
              home: NewsLayout(),
            );
          },
    ),
    );
  }
}
