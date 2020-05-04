
// Example by Tom Igoe

import processing.serial.*;

// The serial port:
Serial myPort;       

// List all the available serial ports:
//printArray(Serial.list());

// Open the port you are using at the rate you want:
myPort = new Serial(this, Serial.list()[3], 115200); // was at 9600
println(myPort);
delay(5000);
  
// Send a capital A out the serial port:
myPort.write("G28 X0 Y0\n");
myPort.write("G0 Z1 F1200\n");
