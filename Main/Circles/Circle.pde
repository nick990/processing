class Circle{
    float x, y, radius;
    color colorFill;
    float startAngle, endAngle;
    float speed;

    Circle (float x, float y, float radius, color colorFill, float startAngle, float endAngle){
        this.x = x;
        this.y = y;
        this.radius = radius;
        this.colorFill = colorFill;
        this.startAngle = startAngle;
        this.endAngle = endAngle;
        this.speed = 0.0;
    }

    Circle(float x, float y, float radius, color colorFill, float startAngle, float endAngle, float speed){
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
}