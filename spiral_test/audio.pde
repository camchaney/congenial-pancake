void startAudio() {
  input = new AudioIn(this, 0);  // Create an Audio input and grab the 1st channel
  input.start();  // start the Audio Input
  loudness = new Amplitude(this);  // create a new Amplitude analyzer
  loudness.input(input);  // Patch the input to an volume analyzer
}
