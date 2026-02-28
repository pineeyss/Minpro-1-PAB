import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/menu_provider.dart';
import 'pages/menu_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MenuProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.red,
        ),
        home: const MenuListPage(),
      ),
    );
  }
}