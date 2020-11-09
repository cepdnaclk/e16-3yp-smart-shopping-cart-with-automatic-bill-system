import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/products.dart';
class PdtItem extends StatelessWidget {
  
  final String name;
  final String imagUrl;
  PdtItem({this.name,this.imagUrl});
  
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child:Image.network(imagUrl),
      
    );
  }
}
