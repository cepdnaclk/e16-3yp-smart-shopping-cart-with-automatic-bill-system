import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/models/category.dart';

import 'package:flutter/material.dart';

import 'category_card.dart';
import 'recommended_list.dart';

class TabView extends StatelessWidget {
  List<Category> categories = [
    Category(
      // Color(0xffFCE183),
      // Color(0xffF68D7F),
      Color(0xff083663),
      Color(0xff5189EA),
      'Produce',
      'assets/NewItems/Category-Produce.png',
    ),
    Category(
      // Color(0xffF749A2),
      // Color(0xffFF7375),
      Color(0xff083663),
      Color(0xff5189EA),
      'Grocery',
      'assets/NewItems/Category-Grocery.png',
    ),
    Category(
      // Color(0xff00E9DA),
      // Color(0xff5189EA),
      Color(0xff083663),
      Color(0xff5189EA),
      'Diary',
      'assets/NewItems/Category-Dairy-and-Eggs.png',
    ),
    Category(
      // Color(0xffAF2D68),
      // Color(0xff632376),
      Color(0xff083663),
      Color(0xff5189EA),
      'Body Care',
      'assets/NewItems/Category-Body-Care.png',
    ),
    Category(
      // Color(0xff36E892),
      // Color(0xff33B2B9),
      Color(0xff083663),
      Color(0xff5189EA),
      'Home',
      'assets/NewItems/Category-Natural-Home.png',
    ),
    Category(
      // Color(0xffF123C4),
      // Color(0xff668CEA),
      Color(0xff083663),
      Color(0xff5189EA),
      'Garden & Pets',
      'assets/NewItems/Category-Garden-and-Pets.png',
    ),
  ];

  final TabController tabController;

  TabView({Key key, this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height / 9);
    return TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height / 9,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (_, index) => CategoryCard(
                              category: categories[index],
                            ))),
                SizedBox(
                  height: 16.0,
                ),
                Flexible(child: RecommendedList()),
              ],
            ),
          ),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList())
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList())
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList())
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList())
          ]),
        ]);
  }
}
