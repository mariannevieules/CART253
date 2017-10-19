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

int newBallX;
int newBallY;

// The distance from the edge of the window a paddle should be
int PADDLE_INSET = 20;

// The background colour during play (black)
color backgroundColor = color(0);



//NOUVELLE VARIABLE BOOLEENNE POUR SAVOIR SI ON A PERDU
boolean lost;

//LISTE reserve de balls créées au contact deSs paddles
Ball [] ballList = new Ball[20];

//variable comptant le nomber de balles affichées
int countBalls =1;

//booléen pour start/restart
boolean start;

String loser = "";
String winner = "";


// setup()
//
// Sets the size and creates the paddles and ball

void setup() {
  // Set the size
  size(800, 480);

  // Create the paddles on either side of the screen. 
  // Use PADDLE_INSET to to position them on x, position them both at centre on y
  // Also pass through the two keys used to control 'up' and 'down' respectively
  // NOTE: On a mac you can run into trouble if you use keys that create that popup of
  // different accented characters in text editors (so avoid those if you're changing this)
  leftPaddle = new Paddle(PADDLE_INSET, height/2, 's', 'd');
  rightPaddle = new Paddle(width - PADDLE_INSET, height/2, 'k', 'l');

  // Create the ball at the centre of the screen
  // ball = new Ball(width/2, height/2);
  countBalls =1;
  ballList[0]=new Ball(width/2, height/2);
}

// draw()
//
// Handles all the magic of making the paddles and ball move, checking
// if the ball has hit a paddle, and displaying everything.

void draw() {
  

  if(leftPaddle.counter <=0){
    lost = true;
    loser = "left Player";
    winner = "right Player";
  }
  if(rightPaddle.counter <=0){
    lost = true;
    loser = "right Player";
     winner = "left Player";
  }
  
   //si le jeu est lancé
  if (start) {

    //on récupère l'heure
    int s = second();  // Values from 0 - 59
    int m = minute();  // Values from 0 - 59
    int h = hour();    // Values from 0 - 23
    //line(s, 0, s, 33);
    //line(m, 33, m, 66);
    //line(h, 66, h, 100);


    // jeu
    
    //si on a pas perdu (=si le jeu est en cours)
    if (!lost) {

      // Fill the background each frame so we have animation
      background(backgroundColor);

//on affiche
      textSize(20);
      fill(255);
      //l'heure
      text( h + ":" +m + ":" +s, width/2, height/19);
      text( frameCount%60, width/2+35, height/8-10);


      // Update the paddles and ball by calling their update methods
      leftPaddle.update();
      rightPaddle.update();
      //selon le nombre de balles créées
      for ( int i=0; i<countBalls; i++) {
        //on les mets à jour
        ballList[i].update();

        // Check if the ball has collided with either paddle
        //d'abord paddle gauche
        char test = ballList[i].collide(leftPaddle);
        if ( test!='a' && countBalls<20)
        {
          //si on touche le paddle gauche, on initialise une nouvelle balle
          ballList[countBalls]=new Ball(newBallX, newBallY, test);
          //on fait monter le décompte des balles
          countBalls++;
          //println(countBalls);
        }

//pour tester la collision avec le paddle droit
        char test2 =ballList[i].collide(rightPaddle);

//si on touche le paddle, et qu'on a pas encore 20 balles en jeu
        if ( test2!='a' && countBalls<20)
        {
          //si on touche le paddle, on initialise une nouvelle balle
          ballList[countBalls]=new Ball(newBallX, newBallY, test2);
          //on fait monter le décompte des bales
          countBalls++;
        //  println(countBalls);
        }
//check le score
        ballList[i].checkPlayerScore(leftPaddle, rightPaddle);

        // Check if the ball has gone off the screen
        if (ballList[i].isOffScreen()) {
          // If it has, reset the ball
    //ET DIVISE LE SCORE PAR 10 si la balle sort
          if (ballList[i].x<width/2)ballList[i].reset(leftPaddle);
          if (ballList[i].x>width/2)ballList[i].reset(rightPaddle);
        }
        //on affiche les balles
        ballList[i].display();
      }

      //check The score



      // Display the paddles and the ball
      leftPaddle.display();
      rightPaddle.display();
    }

    // quand on perd
    else
    {
//on affiche game over
      background(155);
      pushStyle();
      textAlign(CENTER);
      text("GAME OVER", width/2, height/2);
      text("the " +winner + " beat the " + loser,width/2,height/2 -30);
      popStyle();
    }
  } else {
    //si start=false (= au début)
    //on affiche les instructions pour démarrer
    background(0);
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
  
  if (key==' ') {
    if (!start) {
      start=true;
    } else {
      lost=false;
      setup();
      leftPaddle.PLAYERSCORE=0;
      rightPaddle.PLAYERSCORE=0;
    }
  }
  if(key!=' '){
  // Just call both paddles' own keyPressed methods
  leftPaddle.keyPressed();
  rightPaddle.keyPressed();
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