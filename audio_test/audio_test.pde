import processing.sound.*;

float r = 50;
float n = 200;
float nEnd = 215/2-r;

AudioIn input;
Amplitude loudness;

void setup() {
  size(290, 290); 
  
  // Start listening to the microphone
  input = new AudioIn(this, 0);  // Create an Audio input and grab the 1st channel
  input.start();  // start the Audio Input
  loudness = new Amplitude(this);  // create a new Amplitude analyzer
  loudness.input(input);  // Patch the input to an volume analyzer
}

void draw() {
  float vol = loudness.analyze();
  println(vol);
  int size = int(map(vol, 0, 0.5, 1, nEnd));
  
  float dTh = TWO_PI/n;
  float th = dTh*frameCount;
  float x = width/2 + (r + size)*cos(th);
  float y = height/2 + (r + size)*sin(th);
  point(x, y);
  
}
