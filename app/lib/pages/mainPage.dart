import '../widgets/category.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:smart_cart/main.dart';
import '../widgets/allProducts.dart';

// ignore: camel_case_types

class mainpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        //centerTitle: true,
        title: Text('shopEasy'),
      ),
      body: HomeBody ()
    );
  }
}
