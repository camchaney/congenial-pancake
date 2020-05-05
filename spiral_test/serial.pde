void startSerial() {
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[3], 115200); // was at 9600
  println(myPort);
  delay(5000);
}
