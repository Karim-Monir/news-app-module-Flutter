import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_module/shared/cubit/cubit.dart';
import 'package:news_module/shared/cubit/states.dart';
import 'package:news_module/shared/cubit_observer.dart';
import 'package:news_module/shared/network/remote/dio_helper.dart';
import 'layout/news_layout.dart';


void main() {
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(NewsModule());
}

class NewsModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsAppCubit(),
      child: BlocConsumer<NewsAppCubit, NewsAppStates>(
        listener: (context, state){},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // light mode theme data
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 25.0,
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.grey,
              ),
              textTheme: TextTheme(
                bodyMedium: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            themeMode: NewsAppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            // dark mode theme data
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('252526'),
              appBarTheme: AppBarTheme(
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('252526'),
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: HexColor('252526'),
                elevation: 0.0,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 25.0,
                backgroundColor: HexColor('252526'),
                unselectedItemColor: Colors.grey,
              ),
              textTheme: TextTheme(
                bodyMedium: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            home: /*BlocProvider(
            create: (context) => NewsAppCubit(),
            child:*/ NewsLayout(),
          );
        }),
    );
    //);
  }
}
