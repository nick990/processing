import java.util.ArrayList;

class Circle extends AbstractCircle{

    boolean clockwise;
    boolean rotate = true;  

    Circle(float x, float y, float radius, boolean clockwise){
        this.x = x;
        this.y = y;
        this.radius = radius;
        this.arcs = new ArrayList<Arc>();
        this.clockwise = clockwise;

        Arc bgCircle=new Arc(x,y,radius,COLOR_BG,0,TWO_PI);
        this.arcs.add(bgCircle);
        color c = getRandomColor();
        c = changeAlpha(c,random(ALPHA_MIN,ALPHA_MAX));
        float speed = random(0.03,0.1);
        if(!clockwise){
            speed = -speed;
        }
        float alpha = random(0,TWO_PI);
        float beta = alpha + random(PI/3.0,PI*4.0/3.0);
        this.arcs.add(new Arc(x, y, radius, c, alpha, beta,speed));
        float gamma = beta;
        float delta = TWO_PI + alpha;
        c = getRandomColor();
        c = changeAlpha(c,random(ALPHA_MIN,ALPHA_MAX));
        this.arcs.add(new Arc(x, y, radius, c,gamma,delta,speed));
    }

    public void rotate(){
        if(!rotate){
            return;
        }
        for(Arc a: arcs){
            a.rotate();
        }
    }
}