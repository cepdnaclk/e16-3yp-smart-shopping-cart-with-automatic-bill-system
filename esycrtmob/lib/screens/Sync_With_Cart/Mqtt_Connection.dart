//To manage the mqtt connection
//flutter_client is assumed to be uid

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

//apply this class on home: attribute at MaterialApp()
class MqttManager extends ChangeNotifier {
  //class MqttManager{
  //passed cart Id through the constructr?????
  //String cartId;
  MqttServerClient client;

  String bill;

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

    notifyListeners();
    return client;
  }

  void getBill() {
    //publish request for bill to the cart
    doPublish('carts/Cart_01/bill', 'flutter_client');
    // client.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload);

//Listen to shoppers/uid/bill
    //client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    ////??????
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
      if (c[0].topic == "shoppers/flutter_client/bill") {
        bill =
            MqttPublishPayload.bytesToStringAsString(message.payload.message);
        print('--------Message in MqqtManager---------');
        print('Received bill: $bill');
        print('-----------------');
      }
    });
  }

  void onConnected() {
    doSubscribe("shoppers/flutter_client/#");
    listenToMessages();

    // client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    //   ////??????

    doPublish("carts/Cart_01/connect",
        "flutter_client"); //making connection with the cart by sending uid

    print('Connected');
    notifyListeners();
  }

/////Test methods

  void onDisconnected() {
    print('Disconnected');
    notifyListeners();
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
    //notifyListeners();
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
    //notifyListeners();
  }

// unsubscribe succeeded
  void onUnsubscribed(String topic) {
    print('Unsubscribed topic: $topic');
    //notifyListeners();
  }

// PING response received
  void pong() {
    print('Ping response client callback invoked');
    //notifyListeners();
  }
}
