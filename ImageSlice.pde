/*
A class to create and display slices of video - see https://vimeo.com/136348985
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

