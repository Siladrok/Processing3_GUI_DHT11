# Processing3_GUI_DHT11

A basic GUI for visualizing DHT11 sensor data collected by Arduino nano. 
Arduino nano reads the sensor data and sends them to PC through serial. The processing sketch reads the serial data from the COM port and draws temperature and humidity meters.

The end result looks like this:

![Screenshot](Screenshot.png)

For this project you need:

Hardware:
1. Arduino Nano
2. DHT11 temperature and humidity sensor
3. 1x10kΩ Resistor
4. Breadboard and jumper cables

Software:
Arduino IDE + Libraries (See below)
Processing 3 IDE + Libraries (See below)

How to Run:
1. Connect the DHT11 sensor to Arduino Nano (Fritzing schematic is included)
2. Upload the Arduino sketch (REQUIRES the following Arduino libraries:  DHT Sensor Library, Adafruit Unified Sensor Lib)
3. Run the processing sketch (REQUIRES the following Processing libraries: ControlP5 Library)
4. Choose the COM port the arduino is connected to from the dropdown list.
