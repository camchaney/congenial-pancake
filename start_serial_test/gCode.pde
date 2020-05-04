void gCommand(String command) {  //main gCode command
  gcode.add(command);
  myPort.write(command+"\n");  //writes it instantaneously
  
  while (myPort.available() == 0) {
    delay(10);
  }
  while (myPort.available() > 0) {
    String inBuffer = myPort.readString();
    if (inBuffer != null) {
      println(inBuffer); 
    }
  }
}

void startPrint() {
  gCommand("G91"); //Relative mode (goes to absolute later)
  gCommand("G0 Z4"); //Up four millimeters (we want G0 not G1, so that it won't extrude)
  gCommand("G28 X0 Y0"); //Home X and Y axes
  gCommand("G90"); //Absolute mode
  //gCommand("G1 X117.5 Y125 F8000"); //Go to the center (modify according to your printer)
  //gCommand("G28 Z0"); //Home Z axis (this actually shouldn't be until later)
  
  delay(1000);
  loop();  //starts draw loop
}

void startPrintTEST() {
  gCommand("G91");
  gCommand("G0 Z10");
  gCommand("G28 X0 Y0");
  gCommand("G90");
  //gCommand("G28 Z0"); //Home Z axis (we're not homing just for an "air pass")
}

void endPrint(){
  gCommand("G91"); //Relative mode
  //gCommand("G1 E-4 F3000"); //Retract filament to avoid filament drop on last layer
  //gCommand("G1 X0 Y100 Z20"); //Facilitate object removal
  gCommand("G0 Z10"); //Facilitate object removal
  //gCommand("G1 E4"); //Restore filament position
  //gCommand("M 107"); //Turn fans off
  gCommand("M18");  //motors off
}

void gExport() {
  //Create a unique name for the exported file
  String name_save = "gcode_"+day()+""+hour()+""+minute()+"_"+second()+".g";
  
  //Convert from ArrayList to array (required by saveString function)
  String[] arr_gcode = gcode.toArray(new String[gcode.size()]);
  
  // Export GCODE
  saveStrings(name_save, arr_gcode);
}

void setSpeed(float speed) {
 gCommand("G0 F" + speed);
}
