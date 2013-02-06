/*
[generative]FacebookCMU
Meng Shi @ CodeLab CMU
Feb 6,2013
lolaee@gmail.com
Special thanks to Madeline Gannon
*/
import geomerative.*;

// Declare the objects we are going to use, so that they are accesible from setup() and from draw()
RFont f;
RShape grp;
RPoint[] points;
int n=700;
float [] xPos = new float[n];
float [] yPos = new float[n];
float noiseTimeX, noiseTimeY, noiseIncre;
float thres;

void setup() {
  // Initilaize the sketch
  size(1000, 800);
  frameRate(10);

  // Choice of colors
  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this);
  //  Load the font file we want to use (the file must be in the data folder in the sketch floder), with the size 60 and the alignment CENTER
  grp = RG.getText("CMU", "FreeSans.ttf", 250, CENTER);
  // Enable smoothing
  smooth();
  // Set up Noise
  noiseIncre = 0.005;
  thres =28;
}

void draw() {
  // Clean frame
  background(59, 89, 152);
  // Set the origin to draw in the middle of the sketch
  translate(2*width/5+45, 3*height/5);

  getpoints();
  if (points != null) {
    for (int i=0;i<xPos.length;i++) {
      int r ;
      r = int (random( points.length));
      xPos[i] = points[r].x+noise(points[i].x)*50;
      yPos[i] =  points[r].y+noise(points[i].y)*50;
    }

    for (int i=0;i<xPos.length;i++) {
      for (int j=i+1;j<xPos.length;j++) {
        float distance = dist(xPos[i], yPos[i], xPos[j], yPos[j]);
        if (distance<thres) {
          stroke(255, 255-distance*255/thres);
          strokeWeight(3-distance*3/thres);
          line(xPos[i], yPos[i], xPos[j], yPos[j]);
          fill(255, 255-distance*255/thres);
          ellipse(xPos[i], yPos[i], 1.5, 1.5);
        }
      }
    }
    // If there are any points
  }

  noiseTimeX += noiseIncre;
  noiseTimeY += noiseIncre;
}

void getpoints() {
  // Draw the group of shapes
  noFill();
  //  RG.setPolygonizer(RG.ADAPTATIVE);
  RG.setPolygonizerLength(0.05);
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  points = grp.getPoints();
}

void keyPressed() {  
  // If we press r, start or stop recording!
  if (key == 's' || key == 'S') {
    saveFrame("output.png");
  }
}

