//final int CIRCLE_SPEED = 7;//vitesse du cercle =7
final int CIRCLE_SPEED = 1;//vitesse du score =1
final color NO_CLICK_FILL_COLOR = color(250, 100, 100,10); // couleur sans clic=rose
final color CLICK_FILL_COLOR = color(100, 100, 250); // couleur avec clic = bleue
final color BACKGROUND_COLOR = color(250, 150, 150); // couleur du fond = rose
final color STROKE_COLOR = color(250, 150, 150); // couleur du contour du cercle = rose
final int CIRCLE_SIZE = 50; //taille du cercle=50


int circleX;//position  coordonnée horizontale du cercle/du score
int circleY;//position  coordonnée verticale du cercle/du score
int circleVX;//vitesse sur l'axe horizontal du cercle/du score
int circleVY;//vitesse sur l'axe vertical du cercle/du score
int score;//variable du score

void setup() {
  size(640, 480); //taille du fond 
  circleX = width/2; //position de départ du cercle/du score
  circleY = height/2; //position de départ du cercle/du score
  circleVX = CIRCLE_SPEED; //position définie par la vitesse du cercle/du score
  circleVY = CIRCLE_SPEED; //position définie par la vitesse du cercle/du score
  stroke(STROKE_COLOR);//couleur de contour du cercle/du score au départ de l'animation
  fill(NO_CLICK_FILL_COLOR);//couleur du cercle/du score au départ de l'animation
  background(BACKGROUND_COLOR);//couleur de fond au départ de l'animation
}

void draw() {
  
 //background(BACKGROUND_COLOR);//rafraichissement en continu du fond pour pouvoir lire le score
  score++;//le score augmente
  
    if (dist(mouseX, mouseY, circleX, circleY) < CIRCLE_SIZE/2) {//si la souris passe dans le cercle/le score
    fill(CLICK_FILL_COLOR);//alors le cercle/le score devient bleu
  }
  else {//sinon
    fill(NO_CLICK_FILL_COLOR);//le cercle/le score reste rose
  }
  //ellipse(circleX, circleY, CIRCLE_SIZE, CIRCLE_SIZE);//dessin du cercle
  text(score,circleX, circleY);//dessin du score
  
  circleX += circleVX;//position axe horizontal augmente de la vitesse horizontale à chaque cycle du programme
  circleY += circleVY;//position axe vertical augmente de la vitesse horizontale à chaque cycle du programme
  if (circleX + CIRCLE_SIZE/2 > width || circleX - CIRCLE_SIZE/2 < 0) {//si le cercle/le score touche le bord droit ou le bord gauche, 
    circleVX = -circleVX;//il change de direction
  }
  if (circleY + CIRCLE_SIZE/2 > height || circleY - CIRCLE_SIZE/2 < 0) {//si le cercle/le score touche le bord bas ou le bord haut, 
    circleVY = -circleVY;//il change de direction
  }
}

void mousePressed() {
  background(BACKGROUND_COLOR);//si on clique avec la souris, on rafraichit l'écran 
}

//I wanted to make a game without shape representations, only score. 
//But for now, if I don't write this // background(BACKGROUND_COLOR); in the draw it's a little bit abstract. 
//If // background(BACKGROUND_COLOR); I wish the blue scores can stay like a reminder of the evolution like "at this moment I had a high score! Yeah!"
//and "My score can be forever a better score!"
// So now if you want to see your score you have to be really fast! 
