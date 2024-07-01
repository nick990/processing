class Circle{
    float x, y, r;
    color colorFill;
    float startAngle, endAngle;
    Circle(float x, float y, float r, color colorFill, float startAngle, float endAngle){
        this.x = x;
        this.y = y;
        this.r = r;
        this.colorFill = colorFill;
        this.startAngle = startAngle;
        this.endAngle = endAngle;
    }
    void draw(){
        fill(colorFill);
        arc(x,y,r*2,r*2,startAngle,endAngle);
    }
}
