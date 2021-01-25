import 'package:esycrt/pages/product_details.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  // ignore: non_constant_identifier_names
  var product_list = [
    {
      "name": "happy cow cheese",
      "picture": "images/happy_cow.jpg",
      "category": "Diary products",
      "old price": "330",
      "price": "330",
      "about":
          "Happy Cow cheese triangles are especially soft and creamy.Produced from the finest ingredients, their taste can vary from mild to spicy.Flavours: Natural, Cream, Light, Paprika and Ham."
    },
    {
      "name": "Munchee super cream cracker 500g ",
      "picture": "images/cream.jpeg",
      "category": "groceries",
      "old price": "220",
      "price": "200",
      "about":
          "The iconic vitamin enriched Super Cream Cracker is light and flaky, baked to contain air pockets on its surfaces for the perfect crisp to make it Super."
    },
    {
      "name": "Elephant house wonder bar ",
      "picture": "images/wonder.jpg",
      "category": "Icecream",
      "old price": "55",
      "price": "50",
      "about":
          "The Elephant House Wonder Bar range comes in your favourite Chocolate, Vanilla or Berry flavours. Made with rich, creamy ice cream coated with a thick layer of decadent chocolate that adds a sensuous crunch to every bite."
    },
    {
      "name": "Marina rice flour 1kg ",
      "picture": "images/rice.jpg",
      "category": "groceries",
      "old price": "220",
      "price": "180",
      "about": "Marina rice flour 1kg is the best"
    },
    {
      "name": "Maliban cheese bits 170g",
      "picture": "images/cheesebits.jpg",
      "category": "groceries",
      "old price": "180",
      "price": "180",
      "about":
          "Our very own party starter: This assortment of fun-filled and exciting range of snacks including Chick Bits, Cheese Bits and Kritz comes in a range of varied flavours to entice the taste buds and be the life of any occasion. Also available in different sizes and come in ready-to-eat sachets and tins."
    },
    {
      "name": "Munchee snack crackers 260g",
      "picture": "images/snackcracker.jpg",
      "category": "groceries",
      "old price": "310",
      "price": "310",
      "about":
          "Dipped, topped or served with accompaniments, this crispy golden coloured cracker is great for any snack!"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (BuildContext context, int index) {
          return Single_product(
            product_name: product_list[index]['name'],
            product_picture: product_list[index]['picture'],
            product_category: product_list[index]['category'],
            product_oldprice: product_list[index]['old price'],
            product_price: product_list[index]['price'],
            product_about: product_list[index]['about'],
          );
        });
  }
}

class Single_product extends StatelessWidget {
  final product_name;
  final product_picture;
  final product_category;
  final product_oldprice;
  final product_price;
  final product_about;

  const Single_product({
    this.product_name,
    this.product_picture,
    this.product_category,
    this.product_oldprice,
    this.product_price,
    this.product_about,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: product_name,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  //passing values to product details
                  builder: (context) => new ProductDetais(
                        productdetais_name: product_name,
                        productdetais_picture: product_picture,
                        productdetais_category: product_category,
                        productdetais_oldprice: product_oldprice,
                        productdetais_newprice: product_price,
                        productdetais_about: product_about,
                      ))),
              child: GridTile(
                footer: Container(
                    color: Colors.white,
                    child: new Row(
                      children: [
                        Expanded(
                          child: Expanded(
                            child: Text(
                              product_name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                        Expanded(
                          child: new Text('Rs${product_price}',
                              textAlign: TextAlign.center),
                        )
                      ],
                    )),
                child: Image.asset(product_picture),
              ),
            ),
          )),
    );
  }
}
