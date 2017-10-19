// Pong
//
// A simple version of Pong using object-oriented programming.
// Allows to people to bounce a ball back and forth between
// two paddles that they control.
//
// No scoring. (Yet!)
// No score display. (Yet!)
// Pretty ugly. (Now!)
// Only two paddles. (So far!)

// Global variables for the paddles and the ball
Paddle leftPaddle;
Paddle rightPaddle;
Ball ball;

// The distance from the edge of the window a paddle should be
int PADDLE_INSET = 20;

// The background colour during play (black)
color backgroundColor = color(0);

//variable pour la position x du texte 
int textX;
//variable (oui/non) gerant l'affichage du pong de base
boolean disp;
//variable (oui/non) gerant le mode start
boolean start;
// setup()
//
// Sets the size and creates the paddles and ball

void setup() {
  // Set the size
  size(800, 600);
  textX=width/3;
  // Create the paddles on either side of the screen. 
  // Use PADDLE_INSET to to position them on x, position them both at centre on y
  // Also pass through the two keys used to control 'up' and 'down' respectively
  // NOTE: On a mac you can run into trouble if you use keys that create that popup of
  // different accented characters in text editors (so avoid those if you're changing this)
  leftPaddle = new Paddle(PADDLE_INSET, height/2, 's', 'd');
  rightPaddle = new Paddle(width - PADDLE_INSET, height/2, 'k', 'l');
  //taille du texte
  textSize(18);
  // Create the ball at the centre of the screen
  ball = new Ball(width/2, height/2);
}

// draw()
//
// Handles all the magic of making the paddles and ball move, checking
// if the ball has hit a paddle, and displaying everything.

void draw() {
  // Fill the background each frame so we have animation
  background(backgroundColor);

  //si le jeu a démarré
  if (start) {

    //on récupère l'heure
    int s = second();  // Values from 0 - 59
    int m = minute();  // Values from 0 - 59
    int h = hour();    // Values from 0 - 23
    //on affiche les données
    fill(255);
    //titre
    text( "PONG", textX, height/4);
    //heure
    text( "time : "+h + ":" +m+ ":" +s, textX, height/4+30);
    //score
    text("score : "+leftPaddle.PLAYERSCORE+" : "+rightPaddle.PLAYERSCORE, textX, height/4+60);
    //vitesse de balle
    text("speed : "+ball.SPEED, textX, height/4+210);
    //vent
    text("wind : 0", textX, height/4+240);


    // Update the paddles and ball by calling their update methods
    leftPaddle.update();
    rightPaddle.update();
    ball.update();

    // Check if the ball has collided with either paddle
    ball.collide(leftPaddle);
    ball.collide(rightPaddle);

    ball.checkPlayerScore(leftPaddle, rightPaddle);

    // Check if the ball has gone off the screen
    if (ball.isOffScreen()) {
      // If it has, reset the ball
      ball.reset();
    }
    //check The score



    // Display the paddles and the ball
    leftPaddle.display();
    rightPaddle.display();
    if (disp)ball.display();
  } else {
    //si le jeu n'a pas démarré (start=false)

    //on affiche
    //"pong" et "appuyer sur start"
    fill(255);
    pushStyle();
    textAlign(CENTER);
    text( "PONG", width/2, height/2);
    textSize(12);
    text( "press space to start", width/2, height/2+20);
    popStyle();
  }
}

// keyPressed()
//
// The paddles need to know if they should move based on a keypress
// so when the keypress is detected in the main program we need to
// tell the paddles

void keyPressed() {
  // Just call both paddles' own keyPressed methods
  leftPaddle.keyPressed();
  rightPaddle.keyPressed();


//si on appuie sur ","
  if (key==',') {
    //on peut afficher ou non le pong de base
    if (disp)disp=false;
    else disp=true;
  }
  
  //si on appuie sur espace
  if (key==' ') {
    if (!start) {
    //au démarrage on lance le jeu
      start=true;
    } else {
      //ensuite sinon on remet les scores à zero
      leftPaddle.PLAYERSCORE=0;
      rightPaddle.PLAYERSCORE=0;
    }
  }
}

// keyReleased()
//
// As for keyPressed, except for released!

void keyReleased() {
  // Call both paddles' keyReleased methods
  leftPaddle.keyReleased();
  rightPaddle.keyReleased();
}