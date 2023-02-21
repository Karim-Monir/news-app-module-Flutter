abstract class NewsAppStates {}

class AppInitialState extends NewsAppStates {}


class AppChangeNavBarState extends NewsAppStates {}

class AppBusinessNewsLoadingState extends NewsAppStates {}

class AppGetBusinessNewsSuccessState extends NewsAppStates {}

class AppGetBusinessNewsErrorState extends NewsAppStates {
  final String error;

  AppGetBusinessNewsErrorState(this.error);

}


class AppSportsNewsLoadingState extends NewsAppStates {}

class AppGetSportsNewsSuccessState extends NewsAppStates {}

class AppGetSportsNewsErrorState extends NewsAppStates {
  final String error;

  AppGetSportsNewsErrorState(this.error);
}



class AppScienceNewsLoadingState extends NewsAppStates {}

class AppGetScienceNewsSuccessState extends NewsAppStates {}

class AppGetScienceNewsErrorState extends NewsAppStates {
  final String error;

  AppGetScienceNewsErrorState(this.error);
}