
// Ball
//
// A class that defines a ball that can move around in the window, bouncing
// of the top and bottom, and can detect collision with a paddle and bounce off that.

class Ball {


  /////////////// Properties ///////////////

  // Default values for speed and size
  int SPEED = 1;
  int SIZE = 16;

  // The location of the ball
  int x;
  int y;

  // The velocity of the ball
  int vx;
  int vy;

  // The colour of the ball
  color ballColor = color(200);

  int counter;
  
  int[]reserveDeX=new int[20];
  int[]reserveDeY=new int[20];
  
  int collideCount =0;
  String counterString;


  /////////////// Constructor ///////////////

  // Ball(int _x, int _y)
  //
  // The constructor sets the variable to their starting values
  // x and y are set to the arguments passed through (from the main program)
  // and the velocity starts at SPEED for both x and y 
  // (so the ball starts by moving down and to the right)
  // NOTE that I'm using an underscore in front of the arguments to distinguish
  // them from the class's properties
  


  Ball(int _x, int _y) {
    x = _x;
    y = _y;
    vx = SPEED;
    vy = SPEED;
    
      for(int i=0;i<reserveDeX.length;i++){
    reserveDeX[i]=(int) random(-30,30);
    reserveDeY[i]=(int) random(-30,30);
    }
  }
  
  Ball(int _x, int _y, char in) {
    x = _x;
    y = _y;
    vx = SPEED;
    vy = SPEED;
    
      for(int i=0;i<reserveDeX.length;i++){
    reserveDeX[i]=(int) random(-30,30);
    reserveDeY[i]=(int) random(-30,30);
    counter = Character.getNumericValue(in);
    }
  }


  /////////////// Methods ///////////////

  // update()
  //
  // This is called by the main program once per frame. It makes the ball move
  // and also checks whether it should bounce of the top or bottom of the screen
  // and whether the ball has gone off the screen on either side.

  void update() {
    // First update the location based on the velocity (so the ball moves)
    x += vx;
    y += vy;

    // Check if the ball is going off the top of bottom
    if (y - SIZE/2 < 0 || y + SIZE/2 > height) {
      // If it is, then make it "bounce" by reversing its velocity
      vy = -vy;
    }
  }

  // reset()
  //
  // Resets the ball to the centre of the screen.
  // Note that it KEEPS its velocity


    void reset(Paddle paddle) {
    x = width/2;
    y = height/2;
    /*
    *
     *
     *
     !!!!!!!!!!!!!!!!!!!!!!!!!!!
     *
     *
     *
     */
    //BAISSEE SCORE PADDLE
    paddle.counter=paddle.counter/10;
    /*
    *
     *
     *
     !!!!!!!!!!!!!!!!!!!!!!!!!!!
     *
     *
     *
     */
  }

  // isOffScreen()
  //
  // Returns true if the ball is off the left or right side of the window
  // otherwise false
  // (If we wanted to return WHICH side it had gone off, we'd have to return
  // something like an int (e.g. 0 = not off, 1 = off left, 2 = off right)
  // or a String (e.g. "ON SCREEN", "OFF LEFT", "OFF RIGHT")



  boolean isOffScreen() {

    return (x + SIZE/2 < 0 || x - SIZE/2 > width);
  }


  void checkPlayerScore(Paddle playerLeft, Paddle playerRight) {
    if (isOffScreen()) {
      if (x+SIZE/2 <0) {
        playerRight.PLAYERSCORE += 1;
      }
      if (x - SIZE/2 >width) {
        playerLeft.PLAYERSCORE += 1;
      }
    }
  }

  // collide(Paddle paddle)
  //
  // Checks whether this ball is colliding with the paddle passed as an argument
  // If it is, it makes the ball bounce away from the paddle by reversing its
  // x velocity

  char collide(Paddle paddle) {
    // Calculate possible overlaps with the paddle side by side
    boolean insideLeft = (x + SIZE/2 > paddle.x - paddle.WIDTH/2);
    boolean insideRight = (x - SIZE/2 < paddle.x + paddle.WIDTH/2);
    boolean insideTop = (y + SIZE/2 > paddle.y - paddle.HEIGHT/2);
    boolean insideBottom = (y - SIZE/2 < paddle.y + paddle.HEIGHT/2);
    char charToCapture='a';

    // Check if the ball overlaps with the paddle
    if (insideLeft && insideRight && insideTop && insideBottom) {
      collideCount++;
      charToCapture = counterString.charAt(counterString.length()-1);
      String test =counterString.substring(0,counterString.length()-1);
      counter= Integer.parseInt(test);
       //newBallX = x+reserveDeX[counterString.length()-1];
       //newBallY= x+reserveDeY[counterString.length()-1];
       newBallX = width/2;
       newBallY = width/2;
       //println(newBallX);
      
      // If it was moving to the left
      if (vx < 0) {
        // Reset its position to align with the right side of the paddle
        x = paddle.x + paddle.WIDTH/2 + SIZE/2;
      } else if (vx > 0) {
        // Reset its position to align with the left side of the paddle
        x = paddle.x - paddle.WIDTH/2 - SIZE/2;
      }
      // And make it bounce
      vx = -vx;

    if(paddle.counter < 99999999999999999L ) 
      //MONTE SCORE PADDLE
      paddle.counter=paddle.counter*10;
    }
    return charToCapture;
  }

  // display()
  //
  // Draw the ball at its position

  void display() {
    // Set up the appearance of the ball (no stroke, a fill, and rectMode as CENTER)
    noStroke();
    fill(ballColor);
    rectMode(CENTER);

    // Draw the ball
    //rect(x, y, SIZE, SIZE);
    textSize(18);
    //text(counter, x, y); 
    counter+=10;
    //counter=1;
    
  counterString=str(counter);
    for (int i=0; i<counterString.length()-collideCount; i++) {
      text(counterString.charAt(i), x+reserveDeX[i], y+reserveDeY[i]);
    }
  }
  
}