//couleur de fond
color backgroundColor = color(200, 150, 150);
//déclaration du premier objet de la classe "Bouncer"
Bouncer bouncer;
//déclaration du deuxième objet de la classe "Bouncer"
Bouncer bouncer2;

void setup() {
  size(640, 480);
  //couleur de fond affichée une seule fois au démarage 
  //pas de rafraîchissement ensuite pour avoir l'effet "trace"
  background(backgroundColor);

  /*initialisation du permier objet de la classe "bouncer"
   on passe en paramètre (voir le constructeur de la classe dans l'onglet suivant) :
   une position xy de départ,une vitesse x et une vitesse y, une taille de cercle, une couleur par défaut, une couleur si l'objet est survolé par la souris
   */
  bouncer = new Bouncer(width/2, height/2, 2, 2, 50, color(150, 0, 0, 50), color(255, 0, 0, 50));
  //idem pour le 2E objet de la classe "bouncer"
  bouncer2 = new Bouncer(width/2, height/2, -2, 2, 50, color(0, 0, 150, 50), color(0, 0, 255, 50));
}

void draw() {

  //on appelle ici la fonction update de chaque objets "bouncer"
  bouncer.update();
  bouncer2.update();
  //on appelle ici la fonction draw de chaque objets "bouncer"
  bouncer.draw();
  bouncer2.draw();
}



//si on clique
void mouseClicked() {

  //juste pour cleaner, un coup de background pour effacer les traces antérieures
  //background(backgroundColor);   

  //on télétransporte l'objet 1 à l'horizontale
  bouncer.x=(int)random(width);
  //on télétransporte l'objet 1 à la verticale
  bouncer.y=(int)random(height);

  //on télétransporte l'objet 2 à l'horizontale
  bouncer2.x=(int)random(width);
  //on télétransporte l'objet 2 à la verticale
  bouncer2.y=(int)random(height);
}