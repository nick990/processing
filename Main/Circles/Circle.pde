import java.util.ArrayList;

class Circle extends AbstractCircle{

    boolean clockwise;
    boolean rotate = true;
    int slices;

    Circle(float x, float y, float radius, boolean clockwise, int slices){
        this.x = x;
        this.y = y;
        this.radius = radius;
        this.arcs = new ArrayList<Arc>();
        this.clockwise = clockwise;
        this.slices = slices;

        Arc bgCircle=new Arc(x,y,radius,COLOR_BG,0,TWO_PI);
        this.arcs.add(bgCircle);
        
        //float speed = random(0.03,0.1);
        float speed = 0.05;
        if(!clockwise){
            speed = -speed;
        }
       
        float[] startingAngles = new float[slices];
        float[] endingAngles = new float[slices];
        float maxAngle = TWO_PI/slices;
        for(int i=0; i<slices; i++){
            startingAngles[i] = i*maxAngle;
            endingAngles[i] = (i+1)*maxAngle;
        }


        for(int i=0; i<slices; i++){
            color c = getRandomColor();
            c = changeAlpha(c,random(ALPHA_MIN,ALPHA_MAX));
            float alpha = startingAngles[i];
            float beta = endingAngles[i];
            this.arcs.add(new Arc(x, y, radius, c, alpha, beta,speed));
        }
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