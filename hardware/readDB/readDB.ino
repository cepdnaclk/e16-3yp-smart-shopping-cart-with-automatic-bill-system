#include <ArduinoJson.h>
#include <SPI.h>
#include <SD.h>

File myFile;

String ID="1";
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
   // re-open the file for reading:
   
  myFile = SD.open("DB/DB.txt");
  if (!myFile) {
    // if the file didn't open, print an error:
    Serial.println("error opening DB.txt");
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
//  //
//  // Inside the brackets, 200 is the RAM allocated to this document.
//  // Don't forget to change this value to match your requirement.
//  // Use arduinojson.org/v6/assistant to compute the capacity.
//
////DynamicJsonDocument doc(200);
//const char* filename=temp.c_str();
//Serial.println(filename);
////const char *filename="DB/DB.txt";
// File file=SD.open(filename);
//StaticJsonDocument<256>filter;
//filter["1"]=true;
const char* json = "{\"hello\":{\"1\":\"world\",\"2\":\"world1\"}}";

//constintcapacity=JSON_OBJECT_SIZE(3)+2*JSON_OBJECT_SIZE(1);
//StaticJsonDocument<capacity>doc;
StaticJsonDocument <400>doc;

auto error =deserializeJson(doc,myFile);

  // StaticJsonObject allocates memory on the stack, it can be
  // replaced by DynamicJsonDocument which allocates in the heap.


  // Add values in the document
  //
// ArduinoJson 6

if (error) {
    Serial.print(F("deserializeJson() failed with code "));
    Serial.println(error.c_str());
    return;
}
//const char* world = doc["hello"]["2"];
// Serial.println(world);
//JsonObject Item = doc[ID];

//
String item_name= doc[ID]["name"];
float  item_value=doc[ID]["value"];
 Serial.println(ID);
  Serial.println("-------------------------");
  Serial.print("item_name  :");
   Serial.println(item_name);
   Serial.print("item_value  :");
   Serial.println(item_value);


      myFile.close();
  }
}

void loop() {
  
  // not used in this example
}
