int reculegauche=300;
int reculedroit=600;
//variable réglant le temps avant de changer de bout de phrase
int tempsdelecture=500;
//variable réglant le temps durant lequel défile ts les bouts de phrases avant d'en selectionner un
int tempderecherche=50;

//le premier bout de texte
String s1="It's a pong, ";
//la liste des expressions composant le second segment de texte
String []s2= {
 
  " burning through the sky yeah", 
  "only with sound", 
  "where you work to imagine the future", 
  "with a voice", 
  "where you play with your voice", 
  "without visual representation", 
  "where ball and paddle have a conversation, without you ", 
  "with a timer, when it's over you have to play outside", 
  "where you look at real people playing tennis or not through a surveillance camera", 
  "on twine where you can be, paddle 1, paddle 2 or the ball", 
  "where you can generate pong ideas", 
  "you are sitting in a tin can", 
  "in 3D with the point of view of the paddle", 
  "with only one paddle who need to run to catch the ball"
};
//un numéro(0-1-2) pour associer une couleur aux expressions de la liste ci dessus, selon s'il s'agit d'un extrait de film, de manuel etc...
int[]indexCol= {
  0, 
  0, 
  2, 
  2, 
  2, 
  2, 
  2, 
  2, 
  2, 
  2, 
  2, 
  2, 
  2, 
  2, 
  0, 
  1, 
  1, 
  0, 
  0, 
  0, 
  0, 
  2, 
  2, 
  1, 
  1, 
  1, 
  1, 
  1, 
  1
};
//une string vide
String s="";

int index=1;

String []ts;
//une array liste qui va stocker tous les objets "lettre" (voir la calsse de l'onglet suivant
ArrayList l;
//une string list (=arraylist pour string) qui va stocker les phrases non tirées encore
StringList reservePhrase;
//une int list (=arraylist pour int) qui va stocker les numéros de couleur correspondant aux phrases de la stringlist
IntList reserveIndex;

//la font
PFont f;
//le compteur qui gère le temps
int cp;

/*
*/

void setup() {
  //size(800, 600);
  size(displayWidth, displayHeight);

  //on choisit la font



  //on initialise les listes qui vont êtres utilisées pour ne pas re-tirer une phrase déjà tirée avant épuisement de tous les possibles
  l=new ArrayList();
  reservePhrase=new StringList();
  reserveIndex=new IntList();
  //au démarrage on appelle les méthodes qui chargent les listes ci dessus
  loadReserve();
  load();
}

/*
*/

void loadReserve() {

  //on charge dans les listes... 
  for (int i=0; i<s2.length; i++) {
    //...ici tous les bouts de phrases...
    reservePhrase.append(s2[i]);
    //et ici les numéros de couleur correspondants
    reserveIndex.append(indexCol[i]);
  }
}

/*
*/

void load() {


  //variable stockant la position x de la lettre précédente 
  int prevx=0;
  //variable gardant en mémoire la position x de la lettre précédente 
  int ancprevx;
  //on crée une position y de base
  int y=height/2-15;

  //tant qu'il reste moins de 5 phrases non tirées, on charge les listes avec les phrases et les numéros couleurs non tirées
  if (reserveIndex.size()<=5)loadReserve();

  //on fait en sorte qu'au moment avant le chargement, l'arraylist soit vide
  l.clear();

  //là on ajoute s1("you are an astronaut" à la string vide 
  s=s1;

  //on prélève chaque lettres de la string
  for (int i =0; i<s.length (); i+=1) {
    //qu'on ajoute à la classe lettres, avec un x qui avance, un y statique, et le numéro de couleur zéro
    l.add(new Lettre(prevx, y, s.charAt(i), 0));

    //on transforme chaque lettre en string
    String ss=""+ s.charAt(i);
    //on récupère la largeur en pixel de la lettre
    float sw=textWidth( ss);

    //on vérifie si la lattre n'est pas en bout de ligne, et si le mot est fini (donc si la lettre correspond à une lettre vide)
    if (prevx>width-reculedroit&&s.charAt(i)==' ') {
      //on remetle x en début de ligne
      prevx=-(int)sw;
      //on saute une ligne en y
      y=height/2+15;
    }
    //on ajoute la largeur de la lettre à la position x pour savoir où positionner la prochaine lettre
    prevx=prevx+(int)sw;
  }



  //

//on répète 3 fois la manip à suivre (une pour chaque extrait de phrases à afficher
  for (int j=0; j<3; j++) {

//on tire une phrase parmi les phrases non tirées
    int tir=(int)random(reservePhrase.size());
//on la rajoute à la string à afficher
    s=reservePhrase.get(tir);
    //on rajoute une virgule à cette même string
    s+=", ";
    //on récupère le numéro couleur qui correspond à cette même string
    int n=reserveIndex.get(tir);
//on ajoute les lettres de cette string )à la classe lettre (avec un x, un y et un num de couleur correspondant
    for (int i =0; i<s.length (); i+=1) {
      l.add(new Lettre(prevx, y, s.charAt(i), n));

//même principe pour positionner les lettres que précédemment
      String ss=""+ s.charAt(i);
      float sw=textWidth( ss);

      if (prevx>width-reculedroit&&s.charAt(i)==' '&&y==height/2-15) {
        prevx=-(int)sw;
        y=height/2+15;
      }

      if (prevx>width-reculedroit&&s.charAt(i)==' '&&y==height/2+15) {
        prevx=-(int)sw;
        y=height/2+45;
      }

      if (prevx>width-reculedroit&&s.charAt(i)==' '&&y==height/2+45) {
        prevx=-(int)sw;
        y=height/2+75;
      }






      prevx=prevx+(int)sw;
    }
//on retire de les listes la phrase qui vient d'être tirée et son num de coouleur correspondant
    reservePhrase.remove(tir);
    reserveIndex.remove(tir);

    //
  } 





// meême principe qu'en dessus, mais pour la dernière partie de la phrase à afficher
  int tir=(int)random(reservePhrase.size());
//on rajoute un "and" pour introduire le nouveau bout de phrase à ajouter
  s="and ";
  s+=reservePhrase.get(tir);
  //puis un point final après avoir ajouté le bout de phrase
  s+=".";
  int n=reserveIndex.get(tir);

  for (int i =0; i<s.length (); i+=1) {
    l.add(new Lettre(prevx, y, s.charAt(i), n));

    String ss=""+ s.charAt(i);
    float sw=textWidth( ss);

    //correct y
    if (prevx>width-reculedroit&&s.charAt(i)==' '&&y==height/2-15) {
      prevx=-(int)sw;
      y=height/2+15;
    }

    if (prevx>width-reculedroit&&s.charAt(i)==' '&&y==height/2+15) {
      prevx=-(int)sw;
      y=height/2+45;
    }

    if (prevx>width-reculedroit&&s.charAt(i)==' '&&y==height/2+45) {
      prevx=-(int)sw;
      y=height/2+75;
    }


    prevx=prevx+(int)sw;
  }

  reservePhrase.remove(tir);
  reserveIndex.remove(tir);

 
  for (int i=0; i<l.size (); i++) {

    Lettre ll=(Lettre)l.get(i);
    ll.x=ll.x+reculegauche;
  }
}



/*
*/


void mouseClicked(){
  load();
}

void draw() {
  background(255);
  println(cp);

  for (int i=0; i<l.size (); i++) {

    Lettre ll=(Lettre)l.get(i);

    fill(ll.col);
    text(ll.s, ll.x, ll.y);
  }
}