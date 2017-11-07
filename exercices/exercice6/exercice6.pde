import processing.video.*;

// Variable for capture device
Capture video;

// A variable for the color we are searching for.
color trackColor; 

// An array of bouncers to play with
Bouncer[] bouncers = new Bouncer[10];


//un objet paddle
Paddle pad;

void setup() {
  size(640, 480);
  video = new Capture(this, width, height);
  video.start();
  // Start off tracking for blue
  trackColor = color(0, 0, 255);

//on instancie l'obj paddle
pad=new Paddle();

  // Our old friend the for-loop used to go through the length of an
  // array adding new objects to it (Bouncers in this case)
  for (int i = 0; i < bouncers.length; i++) {
    // Each Bouncer just starts with random values 
    bouncers[i] = new Bouncer(random(0, width), random(0, height), random(-10, 10), random(-10, 10), random(20, 50), color(random(255)));
  }
}

void captureEvent(Capture video) {
  // Read image from the camera
  video.read();
}

void draw() {
  video.loadPixels();
  image(video, 0, 0);

  // Before we begin searching, the "world record" for closest color is set to a high number that is easy for the first pixel to beat.
  float worldRecord = 500; 

  // XY coordinate of closest color
  int closestX = 0;
  int closestY = 0;

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      int loc = x + y*video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      // Using euclidean distance to compare colors
      float d = dist(r1, g1, b1, r2, g2, b2); // We are using the dist( ) function to compare the current color with the color we are tracking.

      // If current color is more similar to tracked color than
      // closest color, save current location and current difference
      if (d < worldRecord) {
        worldRecord = d;
        closestX = x;
        closestY = y;
      }
    }
  }



  // Our old friend the for-loop running through the length of an array to
  // update and display objects, in this case Bouncers.
  // If the brightness (or other video property) is going to interact with all the
  // Bouncers, it will need to happen in here.
  for (int i = 0; i < bouncers.length; i++) {
    bouncers[i].update();
    bouncers[i].display();
  }



  // We only consider the color found if its color distance is less than 10. 
  // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
  if (worldRecord < 150) { 
    //si on reconnait du bleu, 
    //on affecte les coord xy de la zone bleue à l'objet pad
    pad.x=closestX;
    pad.y=closestY;
  }
  
  //on dessine l'objet pad
  pad.drawPad();
  
  
}

void mousePressed() {
  // Save color where the mouse is clicked in trackColor variable
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
}