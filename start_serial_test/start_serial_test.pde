import processing.sound.*;
import processing.serial.*;

ArrayList<String> gcode;

//printer properties
float w_bed = 290; //mm 
float h_bed = 275 - 23; //mm (actually different because the normal extruder sticks out more)
float w_paper = 280; //mm
float h_paper = 215; //mm
float x_center = w_bed/2;
float y_center = h_bed/2;
float travel_speed = 1200;  //og 1200
float draw_speed = 1200;

//circle properties
float r = 50;
float n = 200;  //og 100
//dynamic circle properties
float x_prev;
float y_prev;
float i = 0;  //draw() counter
float dTh = TWO_PI/n;
float d0 = TWO_PI*r/n;
float t0 = d0/draw_speed;
float margin = 10;

//serial
Serial myPort;

//audio
AudioIn input;
Amplitude loudness;
float nEnd = ((h_paper/2) - r) - margin;

void setup() {
  size(290, 215); //same as PAPER now
  noLoop();
  
  gcode = new ArrayList<String>();
  
  drawPaper();
  startSerial();
  startAudio();
  
  startPrint();
  //drawCircle();
  //endPrint();
  //gCommand("G0 X"+width/2+" Y252");
  
}

void draw() {
  // noise volume
  float vol = loudness.analyze();
  int size = int(map(vol, 0, 0.5, 0, nEnd));
  
  // draw circle for void draw() function
  float th = dTh*i;
  float x = width/2 + (r + size)*cos(th);
  float y = height/2 + (r + size)*sin(th);
  //println(frameCount);
  //println(i);
  
  if (i > 4) {  //calculating the distance between points to keep speed constant
    float d1 = dist(x, y, x_prev, y_prev);
    println(d1);
    float v = d1/t0;
    println(v);
    float vC = constrain(v, draw_speed, 6000);  //testing upper limits
    setSpeed(vC);
  }
  point(x, y);
  gLoopCommand("G0 X"+x+" Y"+y);
  x_prev = x;
  y_prev = y;
  
  if (i < 1) {  //only right after initial move
    gLoopCommand("G28 Z0");
    setSpeed(draw_speed);
  }
  i ++;
  
}

void drawCircle() {
  beginShape();
  for (float i = 0; i < n + 1; i++) {
    float th = dTh*i;
    float x = width/2 + (r)*cos(th);
    float y = height/2 + (r)*sin(th);
    vertex(x, y);
    gCommand("G0 X"+x+" Y"+y);  //make sure not to do G1 (this will extrude)
    
    if (i < 1) {  //only right after initial move
      gCommand("G28 Z0");
      setSpeed(draw_speed);
    }
  }
  endShape();
}

void drawPaper() {
  rect(width/2 - w_paper/2, height/2 - h_paper/2, w_paper, h_paper);
}
