import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storekeeperapp/provider/item_provider.dart';
import 'package:storekeeperapp/provider/theme_provider.dart';
import 'package:storekeeperapp/screens/Home_page.dart';
import 'package:storekeeperapp/services/db_service.dart';
import 'package:storekeeperapp/theme/custom_dark_theme.dart';
import 'package:storekeeperapp/theme/custom_light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBService.instance.initDB();
  runApp(const AppProvider());
}

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ItemProvider()..loadItem()),
        ChangeNotifierProvider(create: (ctx) => ThemeProvider()..loadTheme()),
      ],
      child: MyApp()
    );
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    final themeProv = context.watch<ThemeProvider>();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeProv.themeMode,
      );
  }
}