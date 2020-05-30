class Obstacle{
  PVector pos;
  float length;
  int height;
  
  Obstacle(float x, float y, float length , int height){
    pos = new PVector(x,y);
    this.length = length;
    this.height = height;
  }
  
  void show(){
    fill(0,0,255);
    rect(pos.x,pos.y,length,height);
  }

}
