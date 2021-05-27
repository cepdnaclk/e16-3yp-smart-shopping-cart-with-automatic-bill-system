import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/screens/payment/promo_item.dart';
import 'package:flutter/material.dart';

class Bill extends StatefulWidget {
  @override
  _BillState createState() => _BillState();
}

class _BillState extends State<Bill> {
  
  List<String> items = ["1","2","Third","4"];

  @override
  Widget build(BuildContext context) {
      return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('row $index'),
        );
      },
    );  
    
  }
}
