import 'package:blog_app/screens/FavoriteBlogsScreen.dart';
import 'package:blog_app/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'bloc/BlogBloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     // savedThemeMode =AdaptiveTheme.getThemeMode();
    return BlocProvider(
      create: (context) => BlogBloc(),
      child: AdaptiveTheme(
          light: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            secondaryHeaderColor: Colors.blue,
            // primaryColor: Colors.lightBlue[800],
            fontFamily: 'Georgia',
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic),
              headline2: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic,color: Colors.black,fontWeight: FontWeight.bold),
              bodyText2: TextStyle(fontSize: 18.0, fontFamily: 'Hind',color: Colors.black),
            ),
          ),
        dark: ThemeData(
          brightness: Brightness.dark,
          secondaryHeaderColor: Colors.grey[700],
          fontFamily: 'Georgia',
          backgroundColor: Colors.grey,

          textTheme:const  TextTheme(
            headline1: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 18.0, fontFamily: 'Hind',color: Colors.black),
            headline2: TextStyle(fontSize: 20.0,color: Colors.black,fontWeight: FontWeight.bold),
          ),
        ),
        initial:AdaptiveThemeMode.dark,
        builder: (theme,dark){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            darkTheme:theme,

            home: const HomeScreen(),
          );
        }
      ),
    );
  }
}
