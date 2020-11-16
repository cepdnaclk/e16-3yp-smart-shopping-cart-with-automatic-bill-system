import 'package:flutter/material.dart';

class ProductDetais extends StatefulWidget {
  final productdetais_name;
  final productdetais_picture;
  final productdetais_category;
  final productdetais_oldprice;
  final productdetais_newprice;
  final productdetais_about;

  const ProductDetais(
      {this.productdetais_name,
      this.productdetais_picture,
      this.productdetais_category,
      this.productdetais_oldprice,
      this.productdetais_newprice,
      this.productdetais_about});

  @override
  _ProductDetaisState createState() => _ProductDetaisState();
}

class _ProductDetaisState extends State<ProductDetais> {
  @override
  Widget build(BuildContext context) {
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
      body: new Container(
          height: 600.0,
          //width: 600,
          child: new ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.all(20.0),
                width: 500,
                child: Image.asset(
                  widget.productdetais_picture,
                  fit: BoxFit.cover,
                ),
              ),
              Divider(),
              //trailing words
              new Container(
                width: 900,
                height: 600,
                color: Colors.white70,
                padding: const EdgeInsets.all(90.0),
                child: new ListView(
                  children: <Widget>[
                    new Container(
                      child: Text(
                        widget.productdetais_name,
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 25),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.all(20.0),
                    ),
                    new Container(
                      child: Text(
                        "Rs.${widget.productdetais_newprice}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    //add to cart

                    new Container(
                      padding: const EdgeInsets.all(10.0),
                    ),
                    new Container(
                      child: Text(
                        "Rs.${widget.productdetais_oldprice}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.all(10.0),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 80,
                          child: MaterialButton(
                            onPressed: () {},
                            color: Colors.grey,
                            elevation: 0.2,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: new Text("Qty"),
                                ),
                                Expanded(
                                  child: new Icon(Icons.arrow_drop_down),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 120,
                          child: MaterialButton(
                              onPressed: () {},
                              color: Colors.red,
                              textColor: Colors.white,
                              elevation: 0.2,
                              child: new Text("Buy now")),
                        ),
                        new IconButton(
                          icon: Icon(
                            Icons.shopping_bag,
                            color: Colors.red,
                          ),
                          onPressed: () {},
                        ),
                        new IconButton(
                          icon: Icon(
                            Icons.delivery_dining,
                            color: Colors.red,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    new Container(
                      padding: const EdgeInsets.all(20.0),
                    ),
                    new Container(
                      width: 400,
                      child: Text("About this product.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 30,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600)),
                    ),
                    new Container(
                      child: Text(widget.productdetais_about,
                          textAlign: TextAlign.left),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
