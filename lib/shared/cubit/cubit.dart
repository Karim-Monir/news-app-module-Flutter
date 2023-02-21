import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_module/modules/science_screen.dart';
import 'package:news_module/modules/settings_screen.dart';
import 'package:news_module/modules/sports_screen.dart';
import 'package:news_module/shared/cubit/states.dart';
import 'package:news_module/shared/network/remote/dio_helper.dart';

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
    if(index == 1){
      getSportsNews();
    }
    if(index == 2){
      getScienceNews();
    }
    emit(AppChangeNavBarState());
  }


  List<dynamic> business = [];

  void getBusinessNews() {
    emit(AppBusinessNewsLoadingState());
    DioHelper.getData(
        path: 'v2/top-headlines',
        queryParameters:
        {
          'country' : 'eg',
          'category' : 'business',
          'apiKey' : '64392a2842fe4648b0de32eda438e63c',
        }
    ).then((value){
      business = value?.data['articles'];
      emit(AppGetBusinessNewsSuccessState());
    }).catchError((error){
      emit(AppGetBusinessNewsErrorState(error.toString()));
      print(error.toString());
    });
  }



  List<dynamic> sports = [];

  void getSportsNews() {
    emit(AppSportsNewsLoadingState());
    if(sports.length == 0){
      DioHelper.getData(
          path: 'v2/top-headlines',
          queryParameters:
          {
            'country' : 'eg',
            'category' : 'sports',
            'apiKey' : '64392a2842fe4648b0de32eda438e63c',
          }
      ).then((value){
        sports = value?.data['articles'];
        emit(AppGetSportsNewsSuccessState());
      }).catchError((error){
        emit(AppGetSportsNewsErrorState(error.toString()));
        print(error.toString());
      });
    } else {
      emit(AppGetSportsNewsSuccessState());

    }

  }


  List<dynamic> science = [];

  void getScienceNews() {
    emit(AppScienceNewsLoadingState());
    if(science.length == 0){
      DioHelper.getData(
          path: 'v2/top-headlines',
          queryParameters:
          {
            'country' : 'eg',
            'category' : 'science',
            'apiKey' : '64392a2842fe4648b0de32eda438e63c',
          }
      ).then((value){
        science = value?.data['articles'];
        emit(AppGetScienceNewsSuccessState());
      }).catchError((error){
        emit(AppGetScienceNewsErrorState(error.toString()));
        print(error.toString());
      });
    } else {
      emit(AppGetScienceNewsSuccessState());
    }

  }


  bool isDark = false;
  void changeMode(){
    isDark = !isDark;
    emit(AppModeState());
  }

}