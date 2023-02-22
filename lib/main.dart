import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_module/shared/cubit/cubit.dart';
import 'package:news_module/shared/cubit/states.dart';
import 'package:news_module/shared/cubit_observer.dart';
import 'package:news_module/shared/network/local/cache_helper.dart';
import 'package:news_module/shared/network/remote/dio_helper.dart';
import 'layout/news_layout.dart';


void main() async
{
  // To ensure everything before the run is done
  // and is added as long as the main is async
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp(NewsModule(isDark!));
}

class NewsModule extends StatelessWidget {
  final bool isDark;
  const NewsModule(this.isDark, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NewsAppCubit()..getBusinessNews()),
        BlocProvider(create: (BuildContext context) => NewsAppCubit()..changeMode(fromShared: isDark,)),
      ],
        child: BlocConsumer<NewsAppCubit, NewsAppStates>(
          listener: (context, state){},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: NewsAppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
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
