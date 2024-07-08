abstract class AbstractCircle {
  float x;
  float y;
  float radius;
  ArrayList<Arc> arcs;

  public void draw(){
    for(Arc a: arcs){
        a.draw();
    }
  }

  abstract void rotate();
  abstract void speedUp(float delta);
  abstract void speedDown(float delta);
}