import '../widgets/category_card.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CategoryCard(
              Icon(
                Icons.food_bank_outlined,
                size: 40,
              ),
              'FOOD'),
          CategoryCard(
              Icon(
                Icons.local_grocery_store_rounded,
                size: 40,
              ),
              'GROCERY'),
          CategoryCard(
              Icon(
                Icons.emoji_food_beverage,
                size: 40,
              ),
              'BEVERAGES'),
          CategoryCard(
              Icon(
                Icons.set_meal_outlined,
                size: 40,
              ),
              'MEAT'),
          CategoryCard(
              Icon(
                Icons.sanitizer_sharp,
                size: 40,
              ),
              'PHARMACY'),
          CategoryCard(
              Icon(
                Icons.kitchen,
                size: 40,
              ),
              'HOUSEWARE'),
          CategoryCard(
              Icon(
                Icons.book_rounded,
                size: 40,
              ),
              'STATIONARY'),
          CategoryCard(
              Icon(
                Icons.backpack_outlined,
                size: 40,
              ),
              'DIARY PRODUCTS'),
          CategoryCard(
              Icon(
                Icons.grass_outlined,
                size: 40,
              ),
              'VEGTABLES AND FRUITS'),
          CategoryCard(
              Icon(
                Icons.child_care_outlined,
                size: 40,
              ),
              'BABY PRODUCTS'),
          CategoryCard(
              Icon(
                Icons.donut_large_outlined,
                size: 40,
              ),
              'SNACKS AND CONFECTIONERY')
        ],
      ),
    );
  }
}
