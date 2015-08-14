/*
A Processing Program to chop audio and video - see https://vimeo.com/136348985
Copyright (C) 2015  Stephen Ball

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

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

  textSize(12);
  fill(255);
  text(audioFile, 6, height - 6);
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

