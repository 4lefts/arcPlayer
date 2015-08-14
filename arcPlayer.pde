Maxim maxim;
Player [] players;
PImage [] images;

int numPlayers = 16;
String audioFile = "tinklyArpsCut.wav";

int numSlices = numPlayers;
ImageSlice [] slices;

float speedSlider = 1;
int sliderHeight = 30;

//colours for drawing
color grey = color(100, 100, 100, 120);
color pink = color(255, 70, 190, 120);


void setup() {

  images = loadImages("beeFrames/movie", ".jpg", 188);

  size(images[0].width, images[0].height);
  //set size to 16:9 aspect ratio.
  //size(800, 450);
  background(255);

  //create audio players
  maxim = new Maxim(this);
  players = new Player[numPlayers];

  float rad = (width / numPlayers) / 2;
  for (int i = 0; i < players.length; i++) {
    players[i] = new Player((i * rad * 2) + rad, height - rad, rad, audioFile, i);
  }

  //create animation players
  slices = new ImageSlice[numSlices];
  for (int i = 0; i < numSlices; i++) {
    slices[i] = new ImageSlice(i);
  }
}

void draw() {

  background(255);

  for (Player p : players) {
    p.run();
  }

  textSize(24);
  fill(255);
  text(audioFile, 24, height - 24);
  drawSlider(speedSlider);
}

void mousePressed() {

  for (Player p : players) {
    p.togglePlay();
  }
}

void mouseDragged() {

  if (mouseY < sliderHeight && mouseX > 0 && mouseX < width) {    
    speedSlider = map(mouseX, 0, width, 0.125, 2);
  }
}

void drawSlider(float spd) {
  noStroke();
  fill(grey);
  rect(0, 0, width, sliderHeight);
  fill(pink);
  rect(0, 0, map(spd, 0.125, 2, 0, width), sliderHeight);
  fill(255);
  textSize(12);
  text("Speed: " + spd, 6, 24);
}

