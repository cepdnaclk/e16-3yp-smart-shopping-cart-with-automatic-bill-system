//connect with the page after scanning QR for cart ID
//when a customer is connectING to a cart testing page
//flutter_client is assumed to be uid
import 'package:ecommerce_int2/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
//import 'package:ecommerce_int2/screens/Sync_With_Cart/Synced_with_cart.dart';//???????
//put this line manually

// import 'package:progress_state_button/iconed_button.dart';
// import 'package:progress_state_button/progress_button.dart';
//import 'package:ecommerce_int2/screens/After_qr_scaning/animated_button.dart';
import 'package:ecommerce_int2/screens/After_qr_scaning/animated_button_two.dart';
import 'package:ecommerce_int2/screens/payment/unpaid_page.dart';

//import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter/cupertino.dart';

//Dye
import 'dart:convert';

//apply this class on home: attribute at MaterialApp()
class CartConnect extends StatefulWidget {
  //passed cart Id through the constructr?????
  @override
  State<StatefulWidget> createState() {
    return _CartConnectState(); //create state
  }
}

class _CartConnectState extends State<CartConnect> {
  String
      cartID; //varaible for Id of the Cart //should be obtained after QR scanning
  //MqttServerClient client ;
  MqttServerClient client;
  String bill = "No bill received yet";

  bool connected=false;
  String button_one="Connect";
  


  // ButtonState stateOnlyText = ButtonState.idle;
  // ButtonState stateTextWithIcon = ButtonState.idle;

  //temporay cart id input method?????
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    cartID = "none"; //innical value of cartID is "none"//
    // MqttServerClient client = ///Initializing????
    super.initState();
  }


 _showCupertinoDialog() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("You are going to disconnect with the cart!"),
              content: new Text(""),

              actions: <Widget>[
                FlatButton(
                  child: Text('Disconnect'),
                  onPressed: doDisconnect,
                  // (){
                  //    Navigator.of(context).pop();
                  //   }
                  //doDisconnect,
                  //() {
                    //doDisconnect;/////////////////////////////
                    //Navigator.of(context).pop();
                  //},
                )
              ],
            ));
  }

  Future<MqttServerClient> connect() async {
    //void connect(){
    client = MqttServerClient.withPort('broker.emqx.io', 'flutter_client',
        1883); //flutter_client ciuld be firebase uid
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;

    final connMessage = MqttConnectMessage()
        .authenticateAs('Dye', 'passworRd')
        .keepAliveFor(60)
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce)
        .withClientIdentifier(
            "flutter_client"); //Refer https://stackoverflow.com/questions/66181329/dart-mqtt-client-identifierrejected-and-a-disconnection-origin-of-none
    client.connectionMessage = connMessage;
    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    return client;
  }

  void doSubscribe(String topic) {
    ///////////////////////////////////////////////
    client.subscribe(topic, MqttQos.atLeastOnce);
    //notifyListeners();
  }

  void doPublish(String pubTopic, String msg) {
    //msg is payload

    final builder = MqttClientPayloadBuilder();
    builder.addString(msg);
    client.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload);
  }

  Future<void> listenToMessages() async {
    return client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);

      print('Received message:$payload from topic: ${c[0].topic}>');

      //Getting bill
      if (c[0].topic == "shoppers/uid/bill") {
        bill =
            MqttPublishPayload.bytesToStringAsString(message.payload.message);
        print('Bill in json----------');
        Map valueMap = jsonDecode(
            bill); //check ??????? https://grokonez.com/convert-string-to-json-dart-flutter
        print(valueMap);
        //final  List  lista =
        //String item=valueMap['item'];
        //String price=valueMap['price'];
        //lista.add=[];
        //lista 

        // print('--------Message in MqqtManager---------');
        // print('Received bill: $bill');
        print('-----------------');
      }
    });
  }

  void onConnected() {
    doSubscribe("shoppers/uid/#");
    listenToMessages();

    // client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    //   ////??????

    doPublish("carts/Cart_01/connect",
        "uid"); //making connection with the cart by sending uid

    print('Connected');
  }

  void getBill() {
    doPublish("carts/Cart_01/bill",
        "uid"); //requesting the bill from the cart by sending uid

    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => UnpaidPage()));

    print('Your bill: $bill');

  }

  void doDisconnect() {
    
    doPublish("carts/Cart_01/disconnect",
        "uid"); //disconnecting with the cart by sending uid

    
    print('disconnecting!!!!');
    client.disconnect();
    //WarningAlertBoxCenter(context: context);////////////////////////////////////////////
    

  }

/////Test methods
  ///

  void onDisconnected() {
    print('Disconnected');
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

// unsubscribe succeeded
  void onUnsubscribed(String topic) {
    print('Unsubscribed topic: $topic');
  }

// PING response received
  void pong() {
    print('Ping response client callback invoked');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(
            title: Text('Sync Cart', style: TextStyle(color: darkGrey, fontWeight: FontWeight.bold, fontSize: 20.0),),
            backgroundColor: Colors.transparent),

      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/cartConnectPageBackground.jpg'),
                    fit: BoxFit.cover)),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     color: transparentYellow,
          //   ),
          // ),
      
         Container(
          alignment: Alignment.topCenter, //inner widget alignment to center
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 30),//try setting to 20 or 25???????
                  width : 120,
                  height : 120,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                      color: Colors.green,
                      colorBrightness: Brightness.dark,
                      onPressed: connect,
                      //() {},

                      // setState(() {
                      //   //refresh UI to show the result on app
                      // });
                      //},
                     // child: Text("Connect with cart"))),
                     child: Column(
                      //margin: EdgeInsets.only(top: 30),

                      children: <Widget>[
                        SizedBox(   //Use of SizedBox
                          height: 30,
                        ),
                        Text(
                          'Connect',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                        SizedBox(   //Use of SizedBox
                          height: 10,
                        ),
  
                        Icon(
                          Icons.sync,
                          color: Colors.white,
                          size: 35
                        ),
                      ],
                    ))),

                Container(
                  margin: EdgeInsets.only(top: 30),
                  width : 120,
                  height : 120,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                      color: Colors.orange,
                      colorBrightness: Brightness.dark,
                      onPressed: 
                      //(){
                        getBill
                        // Navigator.of(context)
                        // .push(MaterialPageRoute(builder: (_) => UnpaidPage()));

                  //       Navigator.of(context).push(
                  // MaterialPageRoute(builder: (_) => UnpaidPage())),
  //}
                        ,

                      //() {},

                      // setState(() {
                      //   //refresh UI to show the result on app
                      // });
                      //},
                     // child: Text("Connect with cart"))),
                     child: Column(
                      //margin: EdgeInsets.only(top: 30),

                      children: <Widget>[
                        SizedBox(   //Use of SizedBox
                          height: 30,
                        ),
                        Text(
                          'View Bill',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                        SizedBox(   //Use of SizedBox
                          height: 10,
                        ),
  
                        Icon(
                          Icons.article,
                          color: Colors.white,
                          size: 35
                        ),
                      ],
                    ))),

              Container(
                  margin: EdgeInsets.only(top: 30),
                  width : 120,
                  height : 120,
                  child: RaisedButton(  ///////////////
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                      color: Colors.red,
                      colorBrightness: Brightness.dark,
                      onPressed:                     
                        _showCupertinoDialog,
                      //_showCupertinoDialog,
                      //() {},

                      // setState(() {
                      //   //refresh UI to show the result on app
                      // });
                      //},
                     // child: Text("Connect with cart"))),
                     child: Column(
                      //margin: EdgeInsets.only(top: 30),

                      children: <Widget>[
                        SizedBox(   //Use of SizedBox
                          height: 30,
                        ),
                        Text(
                          'Disconnect',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),
                        ),
                        SizedBox(   //Use of SizedBox
                          height: 10,
                        ),
  
                        Icon(
                          Icons.sync_disabled,
                          color: Colors.white,
                          size: 35
                        ),
                      ],
                    ))),


            ],
          )),
        ]));
  }
}
