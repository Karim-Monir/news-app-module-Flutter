import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_module/modules/science_screen.dart';
import 'package:news_module/modules/settings_screen.dart';
import 'package:news_module/modules/sports_screen.dart';
import 'package:news_module/shared/cubit/states.dart';

import '../../modules/business_screen.dart';

class NewsAppCubit extends Cubit<NewsAppStates> {
  NewsAppCubit() : super(AppInitialState());

  static NewsAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems =
  [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
      label: 'Science',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
        ),
      label: 'Settings',
    ),
  ];


  List<Widget> screens =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen()
  ];


  List<String> titles =
  [
    'Business',
    'Sports',
    'Science',
    'Settings'
  ];

  void changeIndex(int index){
    currentIndex = index;
    emit(AppChangeNavBarState());
  }

}