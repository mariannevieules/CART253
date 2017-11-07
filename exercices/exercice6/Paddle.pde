class Paddle{


int x,y;

Paddle(){
x=width/2;
y=height/2;
}

void drawPad(){

fill(0,0,255);

ellipse(x,y, 50,50);

}


}