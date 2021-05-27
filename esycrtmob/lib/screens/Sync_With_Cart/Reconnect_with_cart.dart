//connect with the page after scanning QR for cart ID
//when a customer is connectING to a cart testing page
//flutter_client is assumed to be uid

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:ecommerce_int2/screens/Sync_With_Cart/Synced_with_cart.dart'; //???????
import 'package:provider/provider.dart';
import 'package:ecommerce_int2/screens/Sync_With_Cart/Mqtt_Connection.dart';
//put this line manually

//apply this class on home: attribute at MaterialApp()
class ReCartConnect extends StatefulWidget {
  //passed cart Id through the constructr?????
  @override
  State<StatefulWidget> createState() {
    return _ReCartConnectState(); //create state
  }
}

class _ReCartConnectState extends State<ReCartConnect> {
  String
      cartID; //varaible for Id of the Cart //should be obtained after QR scanning
  //MqttManager connec;

  @override
  void initState() {
    cartID = "Cart_01"; //innical value of cartID is "none"//
    // Mqtt connection Initializing????
    //connec= Provider.of<MqttManager>(context);
    ChangeNotifierProvider(
        create: (context) => new MqttManager(),
        child: CartSynced() //????????????????????
        );

    // Mqtt connection Initializing????
    //connec = Provider.of<MqttManager>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("ReConnecting...."), backgroundColor: Colors.yellow),
      body: Container(
          alignment: Alignment.topCenter, //inner widget alignment to center
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                  child: Text("You are reconnecting to the world of carts ")),
              Container(
                  margin: EdgeInsets.only(top: 30),
                  child: FlatButton(
                      //button to start scanning
                      color: Colors.green,
                      colorBrightness: Brightness.dark,
                      onPressed: Provider.of<MqttManager>(context).connect,

                      //connec.connect, /////////????????????

                      // setState(() {
                      //   //refresh UI to show the result on app
                      // });
                      //},
                      child: Text("ReConnect with cart")))
            ],
          )),
    );
  }
}
