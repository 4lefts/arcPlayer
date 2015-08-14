//---------------------------
//class to create and display slices of video

class ImageSlice {

  int index; //what number slice is this?
  PImage [] slices;
  int sliceW;
  float currentPosition;

  //constructor
  ImageSlice(int _i) {

    index = _i;
    sliceW = images[0].width/numSlices;
    slices = makeSlices();
    currentPosition = 0;
  }

  //function called by the constructor to create array of images to display
  PImage [] makeSlices() {

    PImage [] tempSlices = new PImage[0];  
    for (int i = 0; i < images.length; i++) {
      PImage thisSlice  = createImage(sliceW, images[i].height, RGB);
      thisSlice.copy(images[i], sliceW * index, 0, sliceW, images[i].height, 0, 0, sliceW, thisSlice.height);
      tempSlices = (PImage [])append(tempSlices, thisSlice);
    }
    return tempSlices;
  }


  void playSlice(float phase) {
    
    //display current image slice
    image(slices[(int)currentPosition], index * sliceW, 0);
    
    //update the frame to play using the phase of the audio player
    currentPosition = map(phase, 0, TWO_PI, 0, slices.length);
  }
}

