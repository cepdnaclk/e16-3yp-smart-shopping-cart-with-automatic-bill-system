import 'package:flutter/material.dart';
import 'package:smart_cart/pages/mainPage.dart';
import 'package:provider/provider.dart';
import './pages/mainPage.dart';

void main() {
  runApp(shopEasy());
}

// ignore: camel_case_types
class shopEasy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build0
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop Easy',
        theme: ThemeData(
            primaryColor: Colors.lightGreenAccent, accentColor: Colors.white),
        home: mainpage(),
      ),
    );
  }
}
