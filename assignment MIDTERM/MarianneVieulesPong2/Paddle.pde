// Paddle
//
// A class that defines a paddle that can be moved up and down on the screen
// using keys passed through to the constructor.

class Paddle {

  /////////////// Properties ///////////////

  // Default values for speed and size
  int SPEED = 5;
  int HEIGHT = 70;
  int WIDTH = 16;

  int SCOREUP = 0;
  int SCOREDOWN = 0;
  int PLAYERSCORE = 0;

  // The position and velocity of the paddle (note that vx isn't really used right now)
  int x;
  int y;
  int vx;
  int vy;

  // The fill color of the paddle
  color paddleColor = color(255);

  // The characters used to make the paddle move up and down, defined in constructor
  char upKey;
  char downKey;

  //variable pour score
  int score;
  //variable pour counter décroissant
  int counter=1000;



  /////////////// Constructor ///////////////

  // Paddle(int _x, int _y, char _upKey, char _downKey)
  //
  // Sets the position and controls based on arguments,
  // starts the velocity at 0

    Paddle(int _x, int _y, char _upKey, char _downKey) {
    x = _x;
    y = _y;
    vx = 0;
    vy = 0;

    upKey = _upKey;
    downKey = _downKey;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // Updates position based on velocity and constraints the paddle to the window

  void update() {
    // Update position with velocity (to move the paddle)
    x += vx;
    y += vy;

    //si le paddle monte augmente le scoreup
    if (vy > 0) {
      SCOREUP ++;
    }
    //si le paddle descend augmenter le scoredown
    if (vy < 0) {
      SCOREDOWN ++;
    }

    // Constrain the paddle's y position to be in the window
    y = constrain(y, 0 + HEIGHT/2, height - HEIGHT/2);
  }

  // display()
  //
  // Display the paddle at its location

  void display() {
    // Set display properties
    noStroke();
    fill(paddleColor);
    //rectMode(CENTER);

    //UNIQUEMENT SI ON AFFICHE LE PONG DE FOND
    if (disp) {

      //dessin paddles
      textSize(18);
      text(counter, x, y); 
      pushStyle();
      pushMatrix();
      translate(x, y);
      rotate(PI/2);
      fill(255);
      textAlign(CENTER, CENTER);
      text(counter, 0, 0); 
      popMatrix();
      popStyle();
    }

    //on fait décroître le compteur du paddle
    counter--;

    //display valeur touche
    if (x<width/2) {
      //du paddle gauche s
      if (ball.y<y&&ball.vx<0)fill(255, 0, 0);
      else fill(255);
      text("S :"+SCOREDOWN, textX, height/4+90);
    }
    //du paddle droit k
    if (x>width/2) {
      if (ball.y<y&&ball.vx>0)fill(255, 0, 0);
      else fill(255);
      text("K :"+SCOREDOWN, textX, height/4+150);
    }
    //du paddle gauche d
    if (x<width/2) {
      if (ball.y>y&&ball.vx<0)fill(255, 0, 0);
      else fill(255);
      text("D :"+SCOREUP, textX, height/4+120);
    }
    //du paddle droit l
    if (x>width/2) {
      if (ball.y>y&&ball.vx>0)fill(255, 0, 0);
      else fill(255);
      text("L :"+SCOREUP, textX, height/4+180);
    }
  }

  // keyPressed()
  //
  // Called when keyPressed is called in the main program

  void keyPressed() {
    // Check if the key is our up key
    if (key == upKey) {
      // If so we want a negative y velocity
      vy = -SPEED;
    } // Otherwise check if the key is our down key 
    else if (key == downKey) {
      // If so we want a positive y velocity
      vy = SPEED;
    }
  }

  // keyReleased()
  //
  // Called when keyReleased is called in the main program

  void keyReleased() {
    // Check if the key is our up key and the paddle is moving up
    if (key == upKey && vy < 0) {
      // If so it should stop
      vy = 0;
    } // Otherwise check if the key is our down key and paddle is moving down 
    else if (key == downKey && vy > 0) {
      // If so it should stop
      vy = 0;
    }
  }
}