import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_scores_api/cubit/cubit.dart';
import 'package:football_scores_api/cubit/states.dart';
import 'package:football_scores_api/screens/main_screen.dart';
import 'package:football_scores_api/shared/local/cache_helper.dart';
import 'package:football_scores_api/shared/network/dio_helper/dio_helper.dart';
import 'my_bloc_observer.dart';


void main() {
  BlocOverrides.runZoned(
        () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
  CacheHelper.init();
  DioHelper.init();


}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FootballCubit>(
        create:(context)=> FootballCubit()..getAllFixtures(),
        child: BlocConsumer<FootballCubit,FootballStates>(
          listener:(context,state) {},
            builder: (context,state){
            var cubit = FootballCubit.get(context);
              return  MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  iconTheme: IconThemeData(
                      color: Colors.white
                  ),
                  bottomSheetTheme: BottomSheetThemeData(
                      backgroundColor: Colors.transparent
                  ),
                  textTheme: TextTheme(
                      caption: TextStyle(
                          color: Colors.grey[300]
                      ),
                      headline6: TextStyle(
                          color: Colors.white
                      ),
                      headline5: TextStyle(
                          color: Colors.white
                      ),
                      headline4: TextStyle(
                          color: Colors.white
                      ),
                      headline3: TextStyle(
                          color: Colors.white
                      ),
                      headline2: TextStyle(
                          color: Colors.white
                      ),
                      headline1: TextStyle(
                          color: Colors.white
                      ),
                      subtitle1: TextStyle(
                          color: Colors.white
                      ),
                      subtitle2: TextStyle(
                          color: Colors.white
                      ),
                      bodyText1: TextStyle(
                          color: Colors.white
                      ),
                      bodyText2: TextStyle(
                          color: Colors.white
                      )
                  ),
                ),
               home: MainScreen(),
              );
            },
            ));
  }
}
