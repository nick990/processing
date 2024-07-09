abstract class AbstractCircle {
  float x;
  float y;
  float radius;
  ArrayList<Arc> arcs;
  float speed;

  public void draw(){
    for(Arc a: arcs){
        a.draw();
    }
  }

  abstract void rotate();
  abstract void rotate(float angle);
  abstract void speedUp(float delta);
  abstract void speedDown(float delta);
}