class ObjetQuiFaitChangerDeCouleur {
  //on aura besoin de coordonnées horizontales et verticales, et d'une taille 
  int x, y, size;

  ObjetQuiFaitChangerDeCouleur(int tempX, int tempY, int tempSize) {
    //on définit au départ la position, la taille,
    //(les valeurs affectées à x,y et size sont données lors de la création des objets dans le setup() de l'onglet précédent (voir setup)
    x = tempX;
    y = tempY;
    size = tempSize;
  }


//on dessine l'objet comme un carré bleu
  void dessine() {
    fill(0, 0, 255); 
    noStroke();
    rect(x, y, size, size);
  }
  //
  
  
  //on teste si les griddies entrent en contact avec l'objet,
  //SI OUI, LE GRIDDIE DEVIENT VERT
  void testeContact(Griddie other){
  if (x == other.x && y == other.y) {
      other.fill=color(0,255,0);
    }
  
  
  }
  
}