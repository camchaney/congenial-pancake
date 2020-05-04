import processing.serial.*;
ArrayList<String> gcode;

//printer properties
float w_bed = 290; //mm 
float h_bed = 275 - 23; //mm (actually different because the normal extruder sticks out more)
float w_paper = 280; //mm
float h_paper = 215; //mm

float x_center = w_bed/2;
float y_center = h_bed/2;

float travel_speed = 1200;
float draw_speed = 400;

//circle properties
float r = 50;

float x_prev;
float y_prev;

Serial myPort;

void setup() {
  size(290, 215); //same as PAPER now
  noLoop();
  
  gcode = new ArrayList<String>();
  float ratio = h_paper/height;
  
  drawPaper();
  startSerial();
  
  startPrint();
  drawCircle();
  endPrint();
  //gCommand("G0 X"+width/2+" Y252");
  
}

void draw() {
  control();
  
  // draw circle for void draw() function
  beginShape();
  
}

void drawCircle() {
  beginShape();
  float n = 100;
  float revs = 1;
  float dr = revs*TWO_PI/n;
  for (float i = 0; i < n + 1; i++) {
    float th = dr*i;
    float x = width/2 + (r)*cos(th);
    float y = height/2 + (r)*sin(th);
    vertex(x, y);
    gCommand("G0 X"+x+" Y"+y);  //make sure not to do G1 (this will extrude)
    
    if (i < 1) {  //only right after initial move
      gCommand("G28 Z0");
      setSpeed(draw_speed);
    }
    //this can be commented now because we have the while control in gCode
    //delay(100);  //just trying it for kicks
  }
  endShape();
}

void drawPaper() {
  rect(width/2 - w_paper/2, height/2 - h_paper/2, w_paper, h_paper);
}
