ArrayList<String> gcode;

float w_bed = 290; //mm
float h_bed = 275; //mm
float w_paper = 280; //mm
float h_paper = 215; //mm

float x_center = w_bed/2;
float y_center = h_bed/2;

float travel_speed = 1200;
float draw_speed = 400;

float r = 50;


//import processing.serial.*;  // for serial output

// The serial port:
//Serial myPort;
// Open the port you are using at the rate you want:
//myPort = new Serial(this, Serial.list()[3], 9600);


void setup() {
  //size(100, 100); //default
  size(290, 275); //same as print bed
  gcode = new ArrayList<String>();
  float ratio = h_paper/height;
  
  drawPaper();
  startPrint();
  //startPrintTEST();
  setSpeed(travel_speed);
  drawCircle();
  endPrint();
  //printArray(Serial.list());
}

void draw() {
  if (keyPressed) {
    if (key == 'e') {
      gExport();
    }
  }
}

//void printDraw() {
//  myPort.write();
//}


void drawCircle() {
  beginShape();
  float n = 100;
  float revs = 1;
  float dr = revs*TWO_PI/n;
  float ni = 40; //noise intensity
  float nf = 1; //inner noise factor
  for (float i = 0; i < n + 1; i++) {
    float th = dr*i;
    //r = r - 0.1;
    //float N = ni*noise(nf*sin(nf*th/2));
    float N = ni*noise(sin(nf*th/2));
    float x = width/2 + (r + N)*cos(th);
    float y = height/2 + (r + N)*sin(th);
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
