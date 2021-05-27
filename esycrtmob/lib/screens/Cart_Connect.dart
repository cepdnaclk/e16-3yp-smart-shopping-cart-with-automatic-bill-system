//when a customer is connectING to a cart testing page

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
//put this line manually

//apply this class on home: attribute at MaterialApp()
class Cart extends StatefulWidget {
  //passed cart Id through the constructr?????
  @override
  State<StatefulWidget> createState() {
    return _CartState(); //create state
  }
}

class _CartState extends State<Cart> {
  String cartID; //varaible for Id of the Cart

  @override
  void initState() {
    cartID = "Cart_01"; //innical value of cartID is "none"
    super.initState();
  }

  Future<MqttServerClient> connect() async {
    MqttServerClient client =
        MqttServerClient.withPort('broker.emqx.io', 'flutter_client', 1883);
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

    client.subscribe("carts/Cart_01", MqttQos.atLeastOnce);
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);

      print('Received message:$payload from topic: ${c[0].topic}>');
    });

    return client;
  }

  void onConnected() {
    print('Connected');
  }

// unconnected
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
          AppBar(title: Text("Connecting...."), backgroundColor: Colors.yellow),
      body: Container(
          alignment: Alignment.topCenter, //inner widget alignment to center
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                  child: Text("You are connecting to the world of carts ")),
              Container(
                  margin: EdgeInsets.only(top: 30),
                  child: FlatButton(
                      //button to start scanning
                      color: Colors.green,
                      colorBrightness: Brightness.dark,
                      onPressed: connect,

                      // setState(() {
                      //   //refresh UI to show the result on app
                      // });
                      //},
                      child: Text("Connect to mqtt")))
            ],
          )),
    );
  }
}
