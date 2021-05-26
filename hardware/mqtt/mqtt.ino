#include <JsonListener.h>
#include <JsonStreamingParser.h>

#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <SPI.h>
#include <SD.h>
#include <ArduinoJson.h>
// WiFi
const char *ssid = "prabodha"; // Enter your WiFi name
const char *password = "1234567kl";  // Enter WiFi password

// MQTT Broker
const char *mqtt_broker = "broker.emqx.io";
const char *topic = "carts/Cart_01/#";  //Assuming this is cart of Id:"Cart_01".Every cart is subscribed to topic related to its CartId.(// ("#" is for wild card (multi-level))  //boolean subscribe(const char* topic, uint8_t qos);
const char *mqtt_username = "emqx";
const char *mqtt_password = "public";
const int mqtt_port = 1883;

//Current Shopper
String currentShopper = "nil"; //initially nil
String billReceiver ;
//Topics??????
//Cart state
int state =1;
/*
 Idle, connected,erroneous(error detected by sensor data), releasable(payment made correctly).
 */
 //bill
const char* Bill_No = "23";
String Customer_Id = "123";//changed to string
const char* Start_Time = "14.30";
const char*  Bill [][3]  = {{"pen","1","10"},{"pencil","1","20"},{"eraser","1","15"}};
const char* Total = "45";

const char* Paid = "No";
const char* Remain_value_Cart = Total;
JsonArray array;
String billRead ; 
WiFiClient espClient;
PubSubClient client(espClient);

void setup() {
 // Set software serial baud to 115200;
 Serial.begin(115200);
 //initialising sd6
 while (!Serial) {}
  
  Serial.print("Initializing SD card...");

  if (!SD.begin(4)) {
    Serial.println("initialization failed!");
    while (1);
  }
  
  Serial.println("initialization done.");
   // re-open the file for reading:
   
 // connecting to a WiFi network
 WiFi.begin(ssid, password);
 while (WiFi.status() != WL_CONNECTED) {
     delay(500);
     Serial.println("Connecting to WiFi..");
 }
 Serial.println("Connected to the WiFi network");
 //connecting to a mqtt broker
 client.setServer(mqtt_broker, mqtt_port);
 client.setCallback(callback);
 while (!client.connected()) {
     String client_id = "esp8266-client-";
     client_id += String(WiFi.macAddress());
     Serial.printf("The client %s connects to the public mqtt broker\n", client_id.c_str());
     if (client.connect(client_id.c_str(), mqtt_username, mqtt_password)) {
         Serial.println("Public emqx mqtt broker connected");
         
     } else {
         Serial.print("failed with state ");
         Serial.print(client.state());
         delay(2000);
     }
 }
// // publish and subscribe
// client.publish(topic, "hello I'm your cart");
  client.subscribe(topic); //boolean subscribe(const char* topic, uint8_t qos);
//client.publish(topic, "hello I'm your cart");
}

void callback(char *topic, byte *payload, unsigned int length) {
 Serial.print("Message arrived in topic: ");
 Serial.println(topic);
 Serial.print("Message:");
 for (int i = 0; i < length; i++) {
     Serial.print((char) payload[i]);
 }
 Serial.println();
 Serial.println("-----------------------");

 //For a connect request from a shopper(payload: uid of the shopper)
 if (strcmp(topic,"carts/Cart_01/connect")==0) {  
  payload[length]='\0';
  currentShopper = String((char*)payload);//?????
  Customer_Id = currentShopper ;
  Serial.println(currentShopper);
  Serial.println();
  Serial.println("-----------------------");
  Serial.println(state);
  if(state==1){
  state=2;}
 }

 //For a connect request for the current bill(from user or dektop app)
 if (strcmp(topic,"carts/Cart_01/bill")==0) { 

  payload[length]='\0';
  billReceiver = String((char*)payload);//?????

  Serial.println(billReceiver);
  Serial.println();
  Serial.println("-----------------------");
 
//  //If requested by current shopper
//  if (strcmp(billReceiver,currentShopper)==0){
//    client.publish(topic, "hello shopper this is your current bill"); 
  if(state==2)  {  
 File   billFile = SD.open("BILL23.TXT");
  if (! billFile) {
    // if the file didn't open, print an error:
    Serial.println("error opening bill");
} 
  else {
Serial.println("opening bill");
StaticJsonDocument <600> doc1;

auto error =deserializeJson(doc1, billFile);

if (error) {
    Serial.print(F("deserializeJson() failed with code "));
    Serial.println(error.c_str());
    return;
}
delay(500);
//Serial.println("came hw");
JsonObject billObj = doc1. as<JsonObject>();
array =billObj["Bill"].as<JsonArray>();
//for(JsonVariant v : array) {//print array
//    Serial.println(v.as<String>());
//}





}
       billFile.close();
        //If requested by current shopper
  if (strcmp(billReceiver.c_str(),currentShopper.c_str())==0){
    char buffer[256];
    size_t n = serializeJson(array,buffer);
    client.publish("carts/Cart_01/user",buffer,n); 
    Serial.println("sent");
  }else if (strcmp(billReceiver.c_str(),"Desktop")==0){
    char buffer[256];
    size_t n = serializeJson(array,buffer);
    client.publish("carts/Cart_01/Desktop",buffer,n); 
    Serial.println("sent2");
    delay(5000);
  }
// 

//  //If requested by current shopper
//  if (strcmp(billReceiver,currentShopper)==0){
//    client.publish(topic_x, "hello manager this is the current shopper's bill");   //topic_x: shoppers/<currentShopper>/bill
//  }

  //If requested by desktop app.....

 }else{Serial.println("no user connected");}
 }
// //Cart state (requested by the Desktop)
// if (strcmp(topic,"carts/Cart_01/state")==0) { 
//    client.publish(topic_y,cart_state); //topic_y: desktop/carts/<cart_id>/state
// 
//  }

  //payment done....

  //publish all state changes to the desktop app

/*
void callback(char *topic, byte *payload, unsigned int length) {
  if (strcmp(topic,"carts/Cart_01/connect")==0) {
    for (int i = 0; i < length; i++) {
      currentShopper = (char) payload;
      Serial.print(currentShopper);
    }
  }
 
  if (strcmp(topic,"blue")==0) {
    // this one is blue...
  }  
 
  if (strcmp(topic,"green")==0) {
    // i forgot, is this orange?
  }

 }
 */
 }


void loop() {
 client.loop();
 switch(state){
  case 1 :
  
    break;
    case 2:{
    Serial.println("connected");
    
   
 File myFile = SD.open("DB/DB.txt");
  if (!myFile) {
    // if the file didn't open, print an error:
    Serial.println("error opening DB.txt");
} 
  else {

//constintcapacity=JSON_OBJECT_SIZE(3)+2*JSON_OBJECT_SIZE(1);
//StaticJsonDocument<capacity>doc;
StaticJsonDocument <400>doc;

auto error =deserializeJson(doc,myFile);

 
if (error) {
    Serial.print(F("deserializeJson() failed with code "));
    Serial.println(error.c_str());
    return;
}
//const char* world = doc["hello"]["2"];
// Serial.println(world);
//JsonObject Item = doc[ID];
JsonObject readDb = doc. as<JsonObject>();
//
if( Serial.available() > 0 ) //  It winll only send data when the received data is greater than 0.  
{ delay(10000);
Serial.println("Recieved");

String ID = Serial.readString();
//char* ID;
//sprintf(ID,"%s",Serial.readString().c_str());
String  item_name=readDb[ID.c_str()]["name"];
delay(10000);
float  item_value=readDb[ID]["value"];delay(5000);
 Serial.println();
  Serial.println("-------------------------");
  Serial.print("item_name  :");
   Serial.println(item_name);
   Serial.print("item_value  :");
   Serial.println(item_value);
delay(10000);
}
      myFile.close();
  }

    break;}
case 3 :
 Serial.println("bill received");
    break;
   case 4 :
    break;
   default:
    break;
  }
} 
