//Connected to cart..can go for viewing bill/checkout options
//flutter_client is assumed to be uid

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_int2/screens/Sync_With_Cart/Mqtt_Connection.dart';
//import 'package:ecommerce_int2/screens/Sync_With_Cart/Reconnect_with_cart.dart';
//put this line manually

//apply this class on home: attribute at MaterialApp()
class CartSynced extends StatefulWidget {
  // //passed cart Id through the constructr????? //https://stackoverflow.com/questions/50818770/passing-data-to-a-stateful-widget
  // final MqttServerClient client;
  // CartSynced({this.client});

  //const ServerIpText ({ Key key, this.serverIP }): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CartSyncedState(); //create state
    //return _CartConnectState(); //create state
  }
}

class _CartSyncedState extends State<CartSynced> {
  String
      cartID; //varaible for Id of the Cart //should be obtained after QR scanning
  //MqttServerClient client;

  String bill;

  @override
  void initState() {
    cartID = "Cart_01"; //innical value of cartID is "none"//
    bill = "Bill not received yet. Use 'View Bill' to receive the bill";

    // client = widget.client;
    //client.onDisconnected = onDisconnected;

    super.initState();
  }

  void getBill() {
    bill = Provider.of<MqttManager>(context).bill;
    print('--------Message in Synced with cart---------');
    print('Received bill: $bill');
    print('-----------------');

    //Navigate to checkout
    //do we need bill model
  }

  void onDisconnected() {
    ///////////
    //Navigate to Reconnect page

    Provider.of<MqttManager>(context).onDisconnected();
    // print('Disconnected');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Synced...."), backgroundColor: Colors.yellow),
      body: Container(
          alignment: Alignment.topCenter, //inner widget alignment to center
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(child: Text("You are connected to the cart ")),
              Container(
                  margin: EdgeInsets.only(top: 30),
                  child: FlatButton(
                      //button to start scanning
                      color: Colors.green,
                      colorBrightness: Brightness.dark,
                      onPressed: getBill,
                      //Navigate to bill/checkout

                      // setState(() {
                      //   //refresh UI to show the result on app
                      // });
                      //},
                      child: Text("View Bill")))
            ],
          )),
    );
  }
}
