import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_module/shared/cubit/cubit.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          color: Colors.white,
          elevation: 0.0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
          elevation: 25.0,
        )

      ),
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(),
      home: BlocProvider(
        create: (context) => NewsAppCubit(),
        child: NewsLayout(),
      ),
    );
  }
}
