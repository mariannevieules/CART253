// Griddies
// by Pippin Barr
// MODIFIED BY: 
//
// A simple artificial life system on a grid. The "griddies" are squares that move
// around randomly, using energy to do so. They gain energy by overlapping with
// other griddies. If a griddie loses all its energy it dies.

// The size of a single grid element
//= la taille en pixels des côtés des carrés composant la grille
int gridSize = 20;
// An array storing all the griddies
//une liste qui stocke tous les carrés de la grille (il y a donc 100 carrés en tout)
Griddie[] griddies = new Griddie[100];




// pour la classe ajoutée
ObjetQuiFaitChangerDeCouleur obj;

// setup()
//
// Set up the window and the griddies

void setup() {
  // Set up the window size and framerate (lower so we can watch easier)
  size(640, 480);
  frameRate(10);

  // QUESTION: What does this for loop do?
  //création des objets griddies
  //cette boucle initialise les créatures (c'est à dire les objets de la classe griddie)
  //en les positionnant au hasard sur la grille, 
  //mais sur des coordonnées correspondant à un multiple de 20 (=la taille du carré)
  for (int i = 0; i < griddies.length; i++) {
    int x = floor(random(0, width/gridSize));
    int y = floor(random(0, height/gridSize));
    griddies[i] = new Griddie(x * gridSize, y * gridSize, gridSize);
  }

  //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  //on initialise le nouvel objet également sur la grille
  int xpourobjet = floor(random(0, width/gridSize));
  int ypourobjet = floor(random(0, height/gridSize));
  obj=new ObjetQuiFaitChangerDeCouleur(xpourobjet * gridSize, ypourobjet * gridSize, gridSize);
}

// draw()
//
// Update all the griddies, check for collisions between them, display them.

void draw() {
  background(50);




  /*

   
   il l'agit de 2 boucles (ou loop) for imbriquées...
   
   -la première boucle ("int i = 0; i < griddies.length; i++") permet de traiter l'ensemble des griddies d'un coup, 
   pour les mettres à jour (via la fonction "griddies[i].update") et les afficher (via la fonction "griddies[i].display")
   
   -la deuxième boucle ("int j = 0; j < griddies.length; j++") est donc imbriquée dans la première boucle. c'est là que c'est un peu compliqué à expliquer clairement^^
   pour chaque objet "griddie" parcouru par la PREMIERE boucle (avec la variable "i"), on teste s'il est en collision avec TOUS LES AUTRES objets griddies (appelés eux par la variable "j")
   d'où la formulation ci dessous :  "griddies[i].collide(griddies[j])"
   
  
   
   */



  //on gère les objets griddies tous d'un coup grâce à une boucle (=loop) for
  // We need to loop through all the griddies one by one
  //PREMIERE BOUCLE FOR
  for (int i = 0; i < griddies.length; i++) {

    //là on les mets à jours
    // Update the griddies
    griddies[i].update();

    /*
*
     
     
     
     
     *
     */
    //pour chacun des griddies, on vérifie s'il entre en collision avec tous les autres griddies
    //d'où une seconde boucle for imbriquée dans la première
    // Now go through all the griddies a second time...
    //DEUXIEME BOUCLE FOR
    for (int j = 0; j < griddies.length; j++) {
      // QUESTION: What is this if-statement for?
      // là on teste si chaque griddie est en collision avec tous les autres griddies EXCEPTE lui-même,
      //(d'où  ce if-statement "si j est différent de i", j correspondant à l'index dans la liste de tous les griddies (deuxième boucle for), 
      //et i à l'index du griddie qu'on est en train de tester (première boucle for)) 
      if (j != i) {
        // QUESTION: What does this line check?
        //cette ligne check si l'objet que l'on traite via la première boucle et la variable  "i" ("griddies[i]") entre en collision (".collide") avec tous les autres griddies, 
        //traités eux avec la deuxième boucle et la variable "j" ("(griddies[j])")
        griddies[i].collide(griddies[j]);
      }
    }
    /*
*
     *
     */



    //on affiche les griddies
    // Display the griddies
    griddies[i].display();
  }



  
  //on dessine l'objet de la classe "ObjetQuiFaitChangerDeCouleur"
  obj.dessine();
  //on teste s'il entre en contacte avec les griddies, si c'est le cas, le griddie qui l'aura touché deviendra vert
  for (int i = 0; i < griddies.length; i++) {
        obj.testeContact(griddies[i]);
      
    }
  
  
}