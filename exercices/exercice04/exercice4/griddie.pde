// Griddie
//
// A class defining the behaviour of a single Griddie
// which can move randomly in the window (within the grid),
// loses energy per move, and gains energy from overlapping
// with another Griddie.

class Griddie {
  // Limits for energy level and gains/losses
  //on met dès le départ l'énergie à la valeur 255
  int maxEnergy = 255;
  //cette variable va faire perdre de l'énergie en retirant en continu -1 à la variable maxEnergy (initialisée juste en dessus 
  int moveEnergy = -1;
  //cette variable gère l'énergie à chaque collision
  int collideEnergy = 10;

  // Position, size, energy, and fill color
  int x;
  int y;
  int size;
  int energy;
  color fill = color(255, 0, 0);

  // Griddie(tempX, tempY, tempSize)
  //
  // Set up the Griddie with the specified location and size
  // Initialise energy to the maximum
  Griddie(int tempX, int tempY, int tempSize) {
    //on définit au départ la position, la taille, et l'énergie
    //(les valeurs affectées à x,y,et size sont données lors de la création des objets dans le setup() de l'onglet précédent (voir setup)
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }

  // update()
  //
  // Move the Griddie and update its energy levels
  void update() {

    // QUESTION: What is this if-statement for?
    //si l'enregie est descendue à 0, on quitte directement la fonction update, l'objet ne bougera donc plus
    if (energy == 0) {
      return;
    }

    // QUESTION: How does the Griddie movement updating work?

    //les variables xMoveType et yMoveType tirent au hasard des valeurs pouvant être -1, 0,et 1 (en tirant des nombres au hasard entre -1 et 1,9999999..., 
    //qui seront arrondis au nombre entier le plus proche, ce qui laisse donc comme possibilité uniquement -1, 0 et 1) 
    int xMoveType = floor(random(-1, 2));
    int yMoveType = floor(random(-1, 2));

    //les variables x (horiz) et y (vertic) positionnant les objets griddies bougent alors d'une case de la grille 
    //puisque on multiplie par la taille, les objets vont bouger de -20 pixels -donc aller vers la gauche- (si xMoveType=-1) , de 0 pixels -donc rester sur place(si xMoveType=0) ou 20 pixels -donc aller vers la droite-(si xMoveType=1)
    //de même les objets vont bouger de -20 pixels -donc aller vers le haut- (si yMoveType=-1) , de 0 pixels -donc rester sur place(si yMoveType=0) ou 20 pixels -donc aller vers le bas-(si yMoveType=1)

    x += size * xMoveType;
    y += size * yMoveType;

    // QUESTION: What are these if statements doing?
    // si l'objet disparait à gauche il réapparait à droite
    if (x < 0) {
      x += width;
    } else if (x >= width) {
      //et inversement
      x -= width;
    }
    // si l'objet disparait en haut il réapparait en bas
    if (y < 0) {
      y += height;
    } else if (y >= height) {
      //et inversement
      y -= height;
    }

    // Update the Griddie's energy
    // Note that moveEnergy is negative, so this _loses_ energy
    //on fait donc baisser l'énergie
    energy += moveEnergy;

//mais elle ne peut pas aller en dessous de 0 ou au dessus de 255
    // Constrain the Griddies energy level to be within the defined bounds
    energy = constrain(energy, 0, maxEnergy);
  }

  // collide(other)
  //
  // Checks for collision with the other Griddie
  // and updates energy level

  void collide(Griddie other) {
    // QUESTION: What is this if-statement for?
    //si l'enregie de l'objet ou de l'objet avec lequel il est comparé sont à zero, on quitte la fonction
    if (energy == 0 || other.energy == 0) {
      return;
    }

//si les coordonnées de l'objet correspondent à celles de l'objet avec lequel il est comparé (donc s'il y a collision)
    // QUESTION: What does this if-statement check?
    if (x == other.x && y == other.y) {
      // Increase this Griddie's energy
      //alors l'énergie de l'objet remonte de 10 points
      energy += collideEnergy;
      // Constrain the energy level to be within bounds
      //dans la limite toutefois définie (entre 0 et 255)
      energy = constrain(energy, 0, maxEnergy);
    }
  }

  // display()
  //
  // Draw the Griddie on the screen as a rectangle
  void display() {
    // QUESTION: What does this fill line do?
    //on colorie l'objet, qu idevient ed plus en plus transaparent au fur et à mesure que son énergie baisse
    fill(fill, energy); 
    noStroke();
    rect(x, y, size, size);
  }
}