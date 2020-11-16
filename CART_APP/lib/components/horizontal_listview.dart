import 'package:flutter/material.dart';

// ignore: camel_case_types
class Horizontal_view extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'images/grocs.png',
            image_caption: 'groceries',
          ),
          Category(
            image_location: 'images/beverages.png',
            image_caption: 'beverages',
          ),
          Category(
            image_location: 'images/vege1.png',
            image_caption: 'vegetables',
          ),
          Category(
            image_location: 'images/dia.jpg',
            image_caption: 'diary products',
          ),
          Category(
            image_location: 'images/fruitt.png',
            image_caption: 'fruits',
          ),
          Category(
            image_location: 'images/healthcare.png',
            image_caption: 'healthcare',
          ),
          Category(
            image_location: 'images/house.png',
            image_caption: 'houseware',
          ),
          Category(
            image_location: 'images/icecreams.png',
            image_caption: 'icecreams',
          ),
          Category(
            image_location: 'images/meat.png',
            image_caption: 'meat',
          ),
          Category(
            image_location: 'images/pharmacy.png',
            image_caption: 'pharmacy',
          ),
          Category(
            image_location: 'images/stationary.png',
            image_caption: 'stationary',
          ),
          Category(
            image_location: 'images/bake.jpg',
            image_caption: 'bakery items',
          ),
        ],
      ),
    );
  }
}

//category inside the list view
class Category extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final String image_location;
  // ignore: non_constant_identifier_names
  final String image_caption;

  // ignore: non_constant_identifier_names
  const Category({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 120,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 100,
              height: 100,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(
                image_caption,
                style: new TextStyle(fontSize: 12.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
