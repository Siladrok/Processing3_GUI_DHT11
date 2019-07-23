// Written by ladyada, public domain

// REQUIRES the following Arduino libraries:
// - DHT Sensor Library: https://github.com/adafruit/DHT-sensor-library
// - Adafruit Unified Sensor Lib: https://github.com/adafruit/Adafruit_Sensor

#include "DHT.h"

//Define the data pin
#define DHTPIN 2    

//Define the sensor type
#define DHTTYPE DHT11

// Initialize DHT sensor.
DHT dht(DHTPIN, DHTTYPE);

void setup() {
  Serial.begin(9600);
  dht.begin();
}

void loop() {
  //Delay time between measurements
  delay(5000);
  
  //Read Humidity
  float h = dht.readHumidity();
  
  // Read temperature as Celsius
  float t = dht.readTemperature();
  
  // Check if any reads failed and exit early
  if (isnan(h) || isnan(t)) {
    return;
  }
  //Write on serial humidity , temperature
  Serial.print(h);
  Serial.print(",");
  Serial.print(t);

 
}
