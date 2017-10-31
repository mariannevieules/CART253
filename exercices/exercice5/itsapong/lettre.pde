class Lettre {

//on crée une classe pour les lettres à afficher, avec un xy pour les positionner, la lettre en question et quelle couleur associer

  String s="";
  int x, y;
  color col= color(0, 0, 255);


  Lettre(int xx, int yy, char c, int whichcol) {
    x=xx;
    y=yy;
    s+=c;

    if (whichcol==0)col=color(#1000FF);
    if (whichcol==1)col=color(#463CE3);
    if (whichcol==2)col=color(#261CBC);
  }
}