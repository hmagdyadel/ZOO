import 'package:flutter/material.dart';
import '../providers/language.dart';
import './screens/character_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LanguageProvider>(
        create: (ctx) => LanguageProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZOO',
      theme: theme.copyWith(

        shadowColor: Colors.white,
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.amber),
        canvasColor: Colors.white,
      ),
      home: CharacterListScreen(),
    );
  }
}
