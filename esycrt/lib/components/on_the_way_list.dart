import 'package:esycrt/components/round_button.dart';
import 'package:flutter/material.dart';

class onthewaylist extends StatefulWidget {
  @override
  _onthewaylistState createState() => _onthewaylistState();
}

class _onthewaylistState extends State<onthewaylist> {
  var products_on_the_way = [
    {
      "name": "happy cow cheese",
      "picture": "images/happy_cow.jpg",
      "price": "330",
      "Qty": "3",
    },
    {
      "name": "super cream cracker",
      "picture": "images/cream.jpeg",
      "price": "330",
      "Qty": "3",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return new single_cart_product(
          on_product_name: products_on_the_way[index]['name'],
          on_product_picture: products_on_the_way[index]['picture'],
          on_product_Qty: products_on_the_way[index]['Qty'],
          on_product_price: products_on_the_way[index]['price'],
        );
      },
    );
  }
}

class single_cart_product extends StatelessWidget {
  final on_product_name;
  final on_product_picture;
  final on_product_price;
  final on_product_Qty;

  const single_cart_product(
      {this.on_product_name,
      this.on_product_picture,
      this.on_product_price,
      this.on_product_Qty});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Row(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset(on_product_picture),
              ),
            ),
            Expanded(
              child: Text(
                on_product_name,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: new Row(children: [
                Padding(
                  padding: EdgeInsets.all(40),
                ),
                new RoundedIconButton(
                  onPress: () {},
                  icon: Icons.remove,
                  iconSize: 20,
                ),
                new Text(on_product_Qty),
                new RoundedIconButton(
                  onPress: () {},
                  icon: Icons.add,
                  iconSize: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
              ]),
            ),
            Expanded(
              child: Text(
                on_product_price,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: MaterialButton(
                  onPressed: () {},
                  color: Colors.green,
                  textColor: Colors.white,
                  elevation: 0.1,
                  child: new Text(
                    "Remove",
                    textAlign: TextAlign.center,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
