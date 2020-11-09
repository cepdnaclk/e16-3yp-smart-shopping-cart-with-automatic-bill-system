import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/products.dart';
import './productIcon.dart';


class Allproduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final  productData=Provider.of <Products> (context);
    final pdts =productData.items;
    return GridView.builder(
      physics: ScrollPhysics(),
      shrinkWrap:true,
      itemCount:pdts.length,
      gridDelegate :SilverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2),
      itemBuilder:(ctx, i)=>ChangeNotifierProvider.value(value:pdts[i],
      child:pdtItem(name:pdts[i].name,imagUrl:pdts[i].imgUrl,)),

    );
  }
}
