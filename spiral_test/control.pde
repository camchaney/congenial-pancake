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
      //noLoop();  //again just for safe measures. (added another one in endPrint)
      break;
    case('p'):
      noLoop();
      delay(100);
      break;
    case('r'):
      loop();
      delay(100);
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
