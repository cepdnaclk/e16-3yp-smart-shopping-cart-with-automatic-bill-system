#include <ArduinoJson.h>
#include <SPI.h>
#include <SD.h>

File myFile;

const char* Bill_No = "23";
const char* Customer_Id = "123";
const char* Start_Time = "14.30";
const char*  Bill [][3]  = {{"pen","1","10"},{"pencil","1","20"},{"eraser","1","15"}};
const char* Total = "45";

const char* Paid = "No";
const char* Remain_value_Cart = Total;
//char filename [40] = {'\0'} ;
//sprintf( filename,"%s%s%s"," TransactionLog/Bill_", Bill_No,".txt");
 
//struct Item {
//  char hostname[64];
//  int port;
//};
//Item item;
void setup() {
  // Initialize Serial port
  Serial.begin(115200);
  while (!Serial) {}

  Serial.print("Initializing SD card...");

  if (!SD.begin(4)) {
    Serial.println("initialization failed!");
    while (1);
  }
 
  Serial.println("initialization done.");

    char filename [40] = {'\0'} ;
sprintf( filename,"TransactionLog/Bill%s.txt",Bill_No);
  Serial.println(filename);
  
   // re-open the file for reading:
 if( SD.exists(filename) ){
  Serial.print("file ");
  Serial.print(filename);
  Serial.print(" already exsist.");
  }
  else{
  myFile = SD.open("Bill23.txt", FILE_WRITE);
  if (!myFile) {
    // if the file didn't open, print an error:
    Serial.println("error creating file");
} 
  else {
    // if the file didn't open, print an error:
//     Serial.println("Data:");
//String temp;
//    // read from the file until there's nothing else in it:
//    while (myFile.available()) {
//    temp+=(char)myFile.read();
//    }
//    Serial.println(temp);
////   while (myFile.available()) {
////      Serial.write(myFile.read());
////    }
//    // close the file:
//
//  // Allocate the JSON document
//  
//  // Inside the brackets, 200 is the RAM allocated to this document.
//  // Don't forget to change this value to match your requirement.
//  // Use arduinojson.org/v6/assistant to compute the capacity.
//
////DynamicJsonDocument doc(200);
//const char* filename=temp.c_str();
//Serial.println(filename);
////const char *filename="DB/DB.txt";
// File file=SD.open(filename);


const int capacity = JSON_OBJECT_SIZE(7)+ sizeof(Bill)* JSON_OBJECT_SIZE(3);
StaticJsonDocument <capacity> doc;
//StaticJsonDocument <400> doc;

  doc["Bill_No"] = Bill_No ;
  doc["Customer_Id"] = Customer_Id ;
  doc["Start_Time"] = Start_Time;
  doc["Bill"] = Total ;
 // Add the "feeds" array
 JsonArray billarr=doc.createNestedArray("Bill");

 JsonObject feed1=billarr.createNestedObject();
 feed1["item"]=Bill[0][0];
 feed1["amount"]=Bill[0][1];
 feed1["value"]=Bill[0][2];

  doc["Total"] =Total;
  doc["Paid"] =Paid;
  doc["Remain_value_Cart"] =Remain_value_Cart;
  
  // Serialize JSON to file
  if ( serializeJsonPretty(doc,myFile ) == 0) {
    Serial.println(F("Failed to write to file"));
    return;
  }
//  while (myFile.available()) {
//      Serial.write(myFile.read());
//    }



      myFile.close();
  }
}
}
void loop() {
  
  // not used in this example
}
