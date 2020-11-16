import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
//my own imports
import 'package:cart_app/components/horizontal_listview.dart';
import 'package:cart_app/components/Products.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    Widget ImageCarousel = new Container(
      height: 250,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/cas6.jpg'),
          AssetImage('images/cas9.jpg'),
          AssetImage('images/cas3.jpg'),
          AssetImage('images/cas8.jpg'),
          AssetImage('images/cas4.jpg'),
          AssetImage('images/cas7.jpg'),
          AssetImage('images/cas5.jpg'),
        ],
        autoplay: false,
        dotSize: 4.0,
        indicatorBgPadding: 4.0,
        // animationCurve: Curves.fastOutSlowIn,
        // animationDuration: Duration(microseconds: 1000),
      ),
    );
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('EasyCart'),
        actions: <Widget>[
          new IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          new IconButton(
            icon: Icon(
              Icons.shopping_bag_sharp,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          new IconButton(
            icon: Icon(
              Icons.delivery_dining,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            //head
            new UserAccountsDrawerHeader(
              accountName: Text('username'),
              accountEmail: Text('useremail@gmail.com'),
              currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              )),
              decoration: new BoxDecoration(color: Colors.deepOrange),
            ),
            //body
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My account'),
                leading: Icon(Icons.person),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('on the way orders'),
                leading: Icon(Icons.shopping_bag),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('delivery orders'),
                leading: Icon(Icons.delivery_dining),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('shopping list'),
                leading: Icon(Icons.list),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Recent activity'),
                leading: Icon(Icons.history),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Connect with shopping cart'),
                leading: Icon(Icons.connect_without_contact),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('settings'),
                leading: Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('about'),
                leading: Icon(
                  Icons.help,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
      body: new ListView(
        children: <Widget>[
          ImageCarousel,
          new Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Text(
              'Category',
            ),
          ),
          //horizontal categories
          Horizontal_view(),
          new Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Text(
              'products',
            ),
          ),

          //grid view
          Container(
            height: 320.0,
            child: Products(),
          )
        ],
        //padding widget
      ),
    );
  }
}
