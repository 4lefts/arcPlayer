//---------------------------
//class to create and play slices of audio
class Player {

  //gobal variables
  //variables for x and y position and radius of player
  float x, y, r;
  int index;

  String sample;
  AudioPlayer loop;

  //variables for the audio times in ms
  Boolean isPlaying = false;
  int lenMs; // sample length in ms
  float lenS; // sample length in seconds
  int startPoint;
  int sliceLen;

  //variables for drawing playhead
  float playheadPos;
  float movementPerFrame;
  float playbackSpeed;

  //constructor
  //pass x and y pos, radius, .wav to load and index
  Player(float _x, float _y, float _r, String _sample, int _index) {

    x = _x;
    y = _y;
    r = _r;
    index = _index; 

    sample = _sample;
    loop = maxim.loadFile(sample);

    lenMs = (int)loop.getLengthMs();
    lenS = lenMs/1000;

    sliceLen = lenMs/numPlayers;
    startPoint = sliceLen * index;
    loop.cue(startPoint);

    movementPerFrame = 0;
    playbackSpeed = speedSlider;

  }

  //methods
  void run() {

    updatePlayhead();
    drawArc();
  }

  //------------------------------------

  void updatePlayhead() {
    
    movementPerFrame = calcMovement();
    loop.speed(speedSlider);
    
    if (isPlaying) {

      loop.play();
      
      //local variable to calc whether phase of loop wraps round and needs re-cueing
      float oldPos = playheadPos;
      playheadPos = (playheadPos + movementPerFrame) % TWO_PI;
      if(oldPos > playheadPos){
        reset();
      }
      
    } else {
      loop.stop();
    }
    
    //call the playSlice function using the playhead position from the audio player
    slices[index].playSlice(playheadPos);
  }

  float calcMovement() {
    playbackSpeed = abs(speedSlider - 2);
    float f = TWO_PI / (((lenS / numPlayers) * frameRate) * playbackSpeed);
    return f;
  }

  void reset() {

    loop.cue(startPoint);
  }

  //------------------------------------

  void drawArc() {

    noStroke();
    ellipseMode(RADIUS);
    fill(grey);
    ellipse(x, y, r, r);
    fill(pink);
    arc(x, y, r, r, HALF_PI, HALF_PI + playheadPos);
  }

  //------------------------------------

  void togglePlay() {

    if (mousePressed && dist(mouseX, mouseY, x, y) < r) {
      isPlaying = !isPlaying;
    }
  }
}

