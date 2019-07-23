import processing.serial.*;
import controlP5.*;

//Initializing instance of CP5, Dropdownlist and Serial;
ControlP5 cp5;
DropdownList d1;
Serial myPort;



float temp= 0;                       //Initializes the temperature value
float hum =0;
String s = "";
String st = "Choose the Serial Port that the sensor is connected to from the dropdown list";

int x_origin_therm = 80;             //Sets the x,y origin of the thermometer. Origin is considered the bottom left of the drawing
int y_origin_therm = 450;
String therm_symbol = "°";           //Sets the symbol
boolean show_therm_text_box = true;  //Enables the text box

int x_origin_hum = 400;              //Sets the x,y origin of the humidity meter. Origin is considered the bottom left of the drawing
int y_origin_hum = 450;
String hum_symbol = "%";             //Sets the symbol
boolean show_hum_text_box = true;    //Enables the text box


boolean show_note = true;            //Enables intruction notes

String serial_string="";             //These Hold the serial readings
String temp_string="";;    
String hum_string="";  


//Runs once 
void setup(){
  //Sets the size of window
  size(700,500);  
  //Sets the background 
  background(#5CA1F7);
  
  //Creates a DropdownList
  cp5 = new ControlP5(this);
  d1 = cp5.addDropdownList("Choose Serial Port")
          .setPosition(590, 25)
          ;
  
  //Scans the serial ports and fills the Dropdown list
  String a[] = Serial.list();
  int len_a= Serial.list().length; 
  for(int j=1 ;j<=len_a ;j++)  
    d1.addItem(a[j-1], j-1);
  
  //Sets up the Serial (Default at the first Port found)
  myPort = new Serial(this, Serial.list()[0], 9600);
}

//Runs every frame
void draw(){
  
  draw_background(show_note);
  
  draw_meter(x_origin_therm,y_origin_therm,temp,0,50,8,10,therm_symbol);
  
  //Draws the temperature text box
  if   (show_therm_text_box == true){
  s = "Temperature: "+temp +" °C";
  textSize(14);
  fill(255);
  text(s, x_origin_therm, y_origin_therm + 10, 250, 80);
  }
  
  draw_meter(x_origin_hum,y_origin_hum,hum,0,100,4,10,hum_symbol);
  
  //Draws the humidity text box
  if   (show_hum_text_box == true){
  s = "Humidity: "+hum +" %";
  textSize(14);
  fill(255);
  text(s, x_origin_hum+20, y_origin_hum + 10, 250, 80);
  }
  
  //Refreshes the temp with the new value when Serial is availiable
  while (myPort.available() > 0) {
  serial_string = myPort.readString();
  String[] readings = split(serial_string,',');
  temp_string = readings[1];
  hum_string = readings [0];
  //temp_string = myPort.readString();
  temp = float(temp_string);
  hum = float(hum_string);  
  }
}

void draw_meter (float x_origin,float y_origin,float val,int start_value,int end_value,int pixels_per_deegree,int n_lines, String symbol){
  int range = end_value - start_value;
  int box_height = range * pixels_per_deegree;
  
  float bar_y_offset;     //offset of each line from the baseline
  String line_string;     //Saves the line labels  
  
  //Draw the box background
  smooth();
  strokeJoin(ROUND);
  strokeWeight(2);
  stroke(#959EAA);
  fill(#C7CDD6);
  rect(x_origin+20, y_origin, 100, -1*box_height); 
  
  //Draw the baseline
  strokeWeight(5);
  stroke(#263240);
  line(x_origin, y_origin, x_origin+140, y_origin);
  smooth();
  
  //Draw the lines and labels
  strokeWeight(2);
  stroke(255,127);

  int line_distance = box_height/n_lines;   //Distance between the lines in pixels
   
  for (int i = 1; i<n_lines+1; i=i+1){
    bar_y_offset = (y_origin)-(i*line_distance);
    line(x_origin+10,bar_y_offset,x_origin+130,bar_y_offset);
    line_string = ""+(((y_origin - bar_y_offset)/pixels_per_deegree)+start_value) +symbol;
    textSize(12);
    fill(255);
    text(line_string, x_origin+135, bar_y_offset-7, 250, 80);
    }
  
  //Draws the bar
  val = val - start_value;
  float val2pixels = val * pixels_per_deegree;   
  float bar_height = -1* val2pixels;               
  noStroke();
  fill(#002d5a);
  rect(x_origin+31, y_origin-2,80,bar_height);
  
}

//Draws the background
void draw_background(boolean note_IO){

 
  //Refreshes the drawing in each frame - Removes previous drawing
  background(#00979d);    
  fill(255,127);
  strokeWeight(40);
  stroke(255,127);
  line(0,0,0,500);
  noStroke();
  ellipse(700, 500, 150,150);
  
  //Draws the Note
  if (note_IO == true){
  textSize(10);
  fill(#002d5a);
  rect(0,486,700,14); 
  fill(255);
  text(st, 24, 486, 500, 80);
  }
}

//Detects clicks and chooses Port
void controlEvent(ControlEvent theEvent) {
  int ptr = int(theEvent.getController().getValue());
  myPort.stop();
  myPort = new Serial(this, Serial.list()[ptr], 9600);
  st = "Displaying data from "+ Serial.list()[ptr]+".";
  }
