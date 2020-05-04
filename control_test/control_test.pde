import processing.serial.*;
ArrayList<String> gcode;

float w_bed = 290; //mm 
float h_bed = 275 - 23; //mm (actually different because the normal extruder sticks out more)
float w_paper = 280; //mm
float h_paper = 215; //mm

float x_center = w_bed/2;
float y_center = h_bed/2;

float travel_speed = 1200;
float draw_speed = 400;

float r = 50;

Serial myPort;

void setup() {
  size(290, 215); //same as PAPER
  gcode = new ArrayList<String>();
  float ratio = h_paper/height;
  
  drawPaper();
  startSerial();
  
  //startPrint();
  delay(5000);  //delay after startPrint()
  //endPrint();
  //gCommand("G0 X"+width/2+" Y252");
  
}

void keyPressed() {
  switch (key) {
    case('e'):
      gExport();
      delay(100);
      break;
    case('w'):
      gCommand("G91");  //relative mode
      gCommand("G0 Z1");
      gCommand("G90");  //bringing it back
      println("Z +1");
      delay(100);
      break;
    case('s'):
      gCommand("G91");  //relative mode
      gCommand("G0 Z-1");
      gCommand("G90");  //bringing it back
      println("Z -1");
      delay(100);
      break;
    case('z'):
      gCommand("G28 Z0");
      delay(100);
      println("home Z");
      break;
    case('x'):
      gCommand("G28 X0");
      delay(100);
      println("home X");
      break;
    case('y'):
      gCommand("G28 Y0");
      delay(100);
      println("home Y");
      break;
    case('q'):
      noLoop();
      delay(100);  //what is this delay for?
      endPrint();
      noLoop();  //again just for safe measures.
      break;
  }
  if (key == CODED) {
    switch(keyCode){
      case LEFT:
        gCommand("G91");  //relative mode
        gCommand("G0 X-1");
        gCommand("G90");  //bringing it back
        println("X -1");
        delay(100);
        break;
      case DOWN:
        gCommand("G91");  //relative mode
        gCommand("G0 Y-1");
        gCommand("G90");  //bringing it back
        println("Y -1");
        delay(100);
        break;
      case RIGHT:
        gCommand("G91");  //relative mode
        gCommand("G0 X1");
        gCommand("G90");  //bringing it back
        println("X +1");
        delay(100);
        break;
      case UP:
        gCommand("G91");  //relative mode
        gCommand("G0 Y1");
        gCommand("G90");  //bringing it back
        println("Y +1");
        delay(100);
        break;
    }
  }
  //delay(1000);
}

void drawPaper() {
  rect(width/2 - w_paper/2, height/2 - h_paper/2, w_paper, h_paper);
}
