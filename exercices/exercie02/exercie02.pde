//Le fond est noir
color backgroundColor = color(0);

//dessine mille points au hasard en fond
int numStatic = 1000;
//taille minimum des points
int staticSizeMin = 1;
//taille maximum des points
int staticSizeMax = 3;
//couleur des points derrière = presque blanc
color staticColor = color(200);

//coordonnées du paddle
int paddleX;
int paddleY;
//vitesse du paddle = 10
int paddleVX;
int paddleSpeed = 10;

//longueur et largeur du paddle
int paddleWidth = 120;
int paddleHeight = 16;
//couleur du paddle
color paddleColor = color(255);

//positionnement de la balle
int ballX;
int ballY;
//vitesse de la balle =5
int ballVX;
int ballVY;
int ballSpeed = 5;
//taille de la balle=16
int ballSize = 16;
//couleur de la balle= blanche
color ballColor = color(255);




//setup = executé une fois au démarrage

void setup() {
  // taille de l'écran
  size(640, 480);

  setupPaddle();//initialisation des variables du paddle
  setupBall();//initialisation des variables  de la ball
}

//init du paddle
void setupPaddle() {
  paddleX = width/2;//position x au milieu de la fenêtre
  paddleY = height - paddleHeight;//position y tout en bas de la fenêtre moins la hauteur du padle
  paddleVX = 0;//vitesse du paddle initialisée à 0
}

//init de la balle
void setupBall() {
  ballX = width/2;//position x au milieu de la fenêtre
  ballY = height/2;//position y au milieu de la fenêtre
  ballVX = ballSpeed;//vitesse sur l'axe horizontal
  ballVY = ballSpeed;//vitesse sur  l'axe vertical
}

//draw = executé en continu tant que le programme est ouvert
void draw() {
  background(backgroundColor);// on donne la couleur de fond
  //on active le bloc de code dessinant les points au hasard en fond
  drawStatic();
  //on active le bloc de code de mise à jour de la position du paddle
  updatePaddle();
  //on active le bloc de code de mise à jour de la position de la balle
  updateBall();

  //on active le bloc de code dessinant le paddle
  drawPaddle();
  //on active le bloc de code dessinant la balle
  drawBall();
}
//bloc de code dessinant les points aléatoires en fond
void drawStatic() {
  //boucle for executant 1000 fois (numStatic=1000) le positionnement aléatoire et le dessin des points
  for (int i = 0; i < numStatic; i++) {
    float x = random(0, width);// tire position horiz au hasard
    float y = random(0, height);//tire position  vertic au hasard
    float staticSize = random(staticSizeMin, staticSizeMax);//tire taille au hasard entre minimum et maximum
    fill(staticColor);// couleur du point
    rect(x, y, staticSize, staticSize);//dessin du point
  }
}
//mise à jour de la position du paddle
void updatePaddle() {
  paddleX += paddleVX;  //déplacement horizontal : le paddle se déplace selon la valeur de paddleVX (=vitesse)
  paddleX = constrain(paddleX, 0+paddleWidth/2,
width-paddleWidth/2);//on limite la position horiz du paddle entre 1/
//de la fenêtre et 3/4 de la fenêtre
}
//mise à jour de la position de la balle
void updateBall() {
  ballX += ballVX;//position horiz selon vitesse ballVX
  ballY += ballVY;//position vertic selon vitesse ballVY
//activation du bloc de code gérant que faire si la balle touche le paddle
  handleBallHitPaddle();
  //activation du bloc de code gérant que faire si la balle touche les côtés (bords haut, gauche et droite de la fenêtre)
  handleBallHitWall();
  //activation du bloc de code gérant que faire si la balle touche le bas de la fenêtre
  handleBallOffBottom();
}
//dessin du paddle
void drawPaddle() {
  rectMode(CENTER);//paddleX, paddleY=centre du rectangle
  noStroke();//pas de contour
  fill(paddleColor);//couleur blanche
  rect(paddleX, paddleY, paddleWidth, paddleHeight);//dessin
}
//dessin de la balle (idem que pour le paddle)
void drawBall() {
  rectMode(CENTER);
  noStroke();
  fill(ballColor);
  rect(ballX, ballY, ballSize, ballSize);
}
//que faire si la balle touche le paddle
void handleBallHitPaddle() {
  if (ballOverlapsPaddle()) {//vérifie si la balle touche le paddle
    ballY = paddleY - paddleHeight/2 - ballSize/2;//repositionne la balle
    ballVY = -ballVY;//on inverse la vitesse verticale de la balle pour qu'elle parte dans lautre sens
  }
}
//vérifie si la balle touche le paddle, et renvoie une valeur
//boolean (=vrai ou faux)
boolean ballOverlapsPaddle() {
  if (ballX - ballSize/2 > paddleX - paddleWidth/2 && ballX +
ballSize/2 < paddleX + paddleWidth/2) {//si la balle est au niveau du paddle à l'horizontale
    if (ballY > paddleY - paddleHeight/2) {//et si la balle est au niveau du paddle à la verticale
      return true;//renvoie vrai
    }
  }
  return false;//sinon renvoie faux
}
//que faire si la balle touche le bas de la fenêtre
void handleBallOffBottom() {
  if (ballOffBottom()) {//vérifie si la balle touche le bas
  //si oui, on remet la balle au centre
    ballX = width/2;
    ballY = height/2;
  }
}
//vérifie si la balle touche le bas , et renvoie une valeur boolean (=vrai ou faux)
boolean ballOffBottom() {
  //envoie vrai si la coordonnée vertic de la balle (ballY- la moitiéde l'épaisseur de la balle) dépassent l avaleur verticale maxi de la fenêtre
  return (ballY - ballSize/2 > height);
}
//que faire si la balle touche les côtés de la fenêtre
void handleBallHitWall() {
  //si on touche à gauche
  if (ballX - ballSize/2 < 0) {
    ballX = 0 + ballSize/2;// on repositionne légèrement la balle au bord de la fenêtre
    ballVX = -ballVX;//on inverse la vitesse pour que la balle reparte vers la droite
  } else if (ballX + ballSize/2 > width) {//et si on touche à droite
    ballX = width - ballSize/2;// o repositionne légèrement la balle au bord de la fenêtre
    ballVX = -ballVX;//on inverse la vitesse pour que la balle reparte vers la gauche
  }
//si la balle touche le haut de la fenêtre
  if (ballY - ballSize/2 < 0) {// si la valeur horiz de la balle est inférieur à 0 (=bord haut de la fenêtre)
    ballY = 0 + ballSize/2;//on repositionne légèrement la balle sur le bord
    ballVY = -ballVY;//on inverse la vitesse vertic de la balle pour qu'elle reparte vers le bas
  }
}
// si on active les touches claviers...
void keyPressed() {
  // ..flèche gauche
  if (keyCode == LEFT) {
    paddleVX = -paddleSpeed;//le paddle bouge horizontalement vers la gauche (selon la vitesse paddleSpeed
    //... flèche droite
  } else if (keyCode == RIGHT) {
    paddleVX = paddleSpeed;//le paddle bouge horizontalement vers la droite (selon la vitesse paddleSpeed
  }
}

//si on reste appuyé sur les touches...
void keyReleased() {
  // ..flèche gauche et que le paddle dépasse le bord gauche de la fenêtre
  if (keyCode == LEFT && paddleVX < 0) {
    paddleVX = 0;//on le bloque à gauche pour pas qu'il sorte de la fenêtre
    // ..flèche droite et que le paddle dépassele bord droit de la fenêtre
  } else if (keyCode == RIGHT && paddleVX > 0) {
    paddleVX = 0;//on le bloque à droite pour pas qu'il sorte de la fenêtre
  }
}