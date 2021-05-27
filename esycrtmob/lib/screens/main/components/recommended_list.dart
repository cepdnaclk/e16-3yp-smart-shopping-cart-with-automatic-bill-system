import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/product/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RecommendedList extends StatelessWidget {
  List<Product> products = [
    Product('assets/Cultura-Cherry-Tomatoes.png', 'Cherry Tomatoes', 'Cherry Tomatoes form Ceylon', 200.00),
    Product('assets/Nature-farms-Baby-spinach.png', 'Nature farms Baby spinach', 'Organic baby spinach from Go Organic – Nature Farms', 160.00),
    Product('assets/Lili-Paneer-Cheese.png', 'Lili Paneer Cheese', 'Paneer cheese from Lili Dairy', 360.00),
    Product('assets/Soul-Food-Almond-Butter.png', 'Almond-Butter', 'Almond butter from Soul Food', 1334.00),
    Product('assets/Innocent-Food-Garlic-Chips.png', 'Baked Garlic Chips', 'Baked garlic chips from Innocent Foods', 350.00),
    Product('assets/Sepra-Acne-Cream.png', 'Ava Anti Acne Cream', 'Ava anti-acne cream from Sepra Natural', 1500.00),
    Product('assets/NewItems/HelintaEco-Aloevera-Soothing-Gel.png', 'Alovera Gel', 'Aloe vera gel from Helinta Eco', 480.00),
    Product('assets/NewItems/Cinnasol-Floor-Cleaner.png', 'Floor Cleaner CSOL', 'Floor cleaner from Cinnasol', 750.00),
    Product('assets/NewItems/Fone-Natural-citronella-candle-small.png', 'Mosquitto Repellent', 'Natural mosquito repellent candle with beeswax and citronella from Fone Natural', 400.00),


  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(left: 16.0, right: 8.0),
                  width: 4,
                  color: mediumYellow,
                ),
              ),
              Center(
                  child: Text(
                'Recommended',
                style: TextStyle(
                    color: darkGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: StaggeredGridView.countBuilder(
    physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 4,
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) => new ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => ProductPage(product:products[index]))),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange),
                            gradient: RadialGradient(
                                //colors: [Colors.grey[500], Colors.grey[700]],
                                colors: [Colors.white, Colors.white],
                                center: Alignment(0, 0),
                                radius: 0.6,
                                focal: Alignment(0, 0),
                                focalRadius: 0.1),
                          ),
                          child: Hero(
                              tag: products[index].image,
                              child: Image.asset(products[index].image))),
                    ),
                  ),
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, index.isEven ? 3 : 2),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          ),
        ),
      ],
    );
  }
}
