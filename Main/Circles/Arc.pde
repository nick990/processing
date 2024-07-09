class Arc{
    float x, y, radius;
    color colorFill;
    float startAngle, endAngle;
    float speed;

    Arc(float x, float y, float radius, color colorFill, float startAngle, float endAngle, float speed){
        this.x = x;
        this.y = y;
        this.radius = radius;
        this.colorFill = colorFill;
        this.startAngle = startAngle;
        this.endAngle = endAngle;
        this.speed = speed;
    }

    void draw(){
        fill(colorFill);
        arc(x,y,radius*2,radius*2,startAngle,endAngle);
    }

    void rotate(){
      this.startAngle += this.speed;
      this.endAngle += this.speed;
    }

    void rotate(float angle){
      this.startAngle += angle;
      this.endAngle += angle;
    }

    void speedUp(float delta){
      this.speed += delta;
    }

    void speedDown(float delta){
      this.speed -= delta;
    }
}
