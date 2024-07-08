import java.util.ArrayList;

class Circle extends AbstractCircle{

    boolean clockwise;
    boolean rotate = true;
    int slices;
    float speed;
    Circle(float x, float y, float radius, boolean clockwise, int slices, float speed){
        this.x = x;
        this.y = y;
        this.radius = radius;
        this.arcs = new ArrayList<Arc>();
        this.clockwise = clockwise;
        this.slices = slices;
        this.speed = speed;
        if(!clockwise){
            this.speed = -speed;
        }
        Arc bgCircle=new Arc(x,y,radius,COLOR_BG,0,TWO_PI,0);
        this.arcs.add(bgCircle);
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

    public void speedUp(float delta){
        if(!clockwise){
            delta = -delta;
        }
        float newSpeed = this.speed + delta;
        //Se la velocità cambia di segno, allora non la cambio
        if((speed >= 0 && newSpeed <= 0) || (speed <= 0 && newSpeed >= 0)){
            return;
        }
        //Se la velocità è troppo bassa, allora non la cambio
        if(abs(newSpeed) < VEL_MIN){
            return;        
        }
        //Se la velocità è troppo alta, allora non la cambio
        if(abs(newSpeed) > VEL_MAX){
            return;        
        }
        this.speed = newSpeed;

        for(Arc a: arcs){
            a.speedUp(delta);
        }
    }

    public void speedDown(float delta){
        this.speedUp(-delta);
    }
}