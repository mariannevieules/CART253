/*
classe (=modèle) de l'objet "bouncer"
 */

class Bouncer {

  //variables nécessaires pour l'objet bouncer :

  //une position x y
  int x;
  int y;
  //une vitesse en x et en y
  int vx;
  int vy;
  //la taille (=diamètre de l'objet qui sera déssiné)
  int size;
  //des couleurs selon les comportemenst de chaque objets
  color fillColor;
  color defaultColor;
  color hoverColor;


  /*
 CONSTRUCTEUR de la classe :
   on définit quelles variables sont initialisées quand on crée un objet de la classe "bouncer"
   voir l'initialisation de ces objets dans le setup() de l'onglet précédent
   */

  //sur la première ligne on passe les variables en paramètres
  Bouncer(int tempX, int tempY, int tempVX, int tempVY, int tempSize, color tempDefaultColor, color tempHoverColor) {

    //ici on affecte les variables passées en paramètre lors de l'initailisation aux variables de la classe
    x = tempX;
    y = tempY;
    vx = tempVX;
    vy = tempVY;
    size = tempSize;
    defaultColor = tempDefaultColor;
    hoverColor = tempHoverColor;
    fillColor = defaultColor;
  }



  //fonctions définissant les actions de chaque objets de la calsse "bouncer"

  //mise à jour (calcul) des variables
  void update() {
    //on change les positions xy en fonction des vitesses xy
    x += vx;
    y += vy;

    //on appelle la fonction qui gère les rebonds sur les bords
    handleBounce();
    //on appelle la fonction qui gère le survol e la souris
    handleMouse();
  }


  //fonction qui gère les rebonds sur les bords
  void handleBounce() {

//on met en commentaire les rebonds par inversion de direction
    /*
   
     //si on touche le bord gauche ou le bord droit
     if (x - size/2 < 0 || x + size/2 > width) {
     vx = -vx; 
     //la vitesse x est inversée, donc l'objet partira dans l'autre sens
     }
     
     //si on touche le haut ou le bas
     if (y - size/2 < 0 || y + size/2 > height) {
     //la vitesse x est inversée, donc l'objet partira dans l'autre sens
     vy = -vy;
     }
     
     //on limite la position de l'objet à la fenêtre du programme
     x = constrain(x,size/2,width-size/2);
     y = constrain(y,size/2,height-size/2);
     */

//si l'objet touche le bord gauche
    if (x<0) {
      //alors il réapparait à droite
      x=width;
    }
//si l'objet touche le bord droit    
    if (x>width) {
      //alors il réapparait à gauche
      x=0;
    }
    
    
    //si l'objet touche le bord haut
     if (y<0) {
       //alors il réapparait en bas
      y=height;
    }
    //si l'objet touche le bord bas
    if (y>height) {
      //alors il réapparait en haut
      y=0;
    }
  }



  //fonction qui gère le survol de l'objet par la souris
  void handleMouse() {
    //si la distance entre l'objet et la souris est inférieure au rayon de l'objet
    if (dist(mouseX, mouseY, x, y) < size/2) {
      //on change sa couleur
      fillColor = hoverColor;
    } else {
      //sinnon on le dessine avec la couleur par défaut
      fillColor = defaultColor;
    }
  }


  //fonction qui dessine l'objet
  void draw() {
    //pas de countour
    noStroke();
    //on met la bonne couleur
    fill(fillColor);
    //on dessine un rond à la position xy et avec le diamètre correspondant à la variable "size"
    ellipse(x, y, size, size);
  }
}