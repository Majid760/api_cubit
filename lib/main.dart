import 'package:api_cubit/cubit/authentication_cubit.dart';
import 'package:api_cubit/cubit/weather_search_cubit.dart';
import 'package:api_cubit/data/data_provider/database/database_config.dart';
import 'package:api_cubit/data/data_provider/database/database_service.dart';
import 'package:api_cubit/data/repository/repo_search.dart';
import 'package:api_cubit/data/repository/repo_weather.dart';
import 'package:api_cubit/view/screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'cubit/search_cubit.dart';
import 'cubit/weather_cubit.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? databasesPath = await getDatabasesPath();
  var path = join(databasesPath, DatabaseConfig.databaseName);
  // Check if the database exists
  var exists = await databaseExists(path);
  if (!exists) {
    await DatabaseService.instance.database;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>(
            create: (context) => SearchCubit(searchRepo: SearchRepository())),
        BlocProvider<AuthenticationCubit>(
            create: (context) => AuthenticationCubit()),
        BlocProvider<WeatherCubit>(
            create: (context) =>
                WeatherCubit(weatherRepo: WeatherRepository())),
        BlocProvider<WeatherSearchCubit>(
            create: (context) =>
                WeatherSearchCubit(weatherRepo: WeatherRepository())),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SignInScreen(),
      ),
    );
  }
}
