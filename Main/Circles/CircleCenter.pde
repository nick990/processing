class CircleCenter extends AbstractCircle{
  CircleCenter(float x, float y, float radius){
    this.x = x;
        this.y = y;
        this.radius = radius;
        this.arcs = new ArrayList<Arc>();

        Arc bgCircle=new Arc(x,y,radius,COLOR_BG,0,TWO_PI,0);
        this.arcs.add(bgCircle);
        color c = COLOR_BG;
        c = changeAlpha(c,random(ALPHA_MIN,ALPHA_MAX));
        float alpha = 0.0;
        float beta = PI;
        this.arcs.add(new Arc(x, y, radius, c, alpha, beta,0));
        float gamma = beta;
        float delta = TWO_PI + alpha;
        c = getRandomColor();
        c = changeAlpha(c,random(ALPHA_MIN,ALPHA_MAX));
        this.arcs.add(new Arc(x, y, radius, c,gamma,delta,0));
    }
  
    void rotate(){
        // do nothing
    }

    void rotate(float angle){
        // do nothing
    }

    void speedUp(float delta){
        // do nothing
    }

    void speedDown(float delta){
    // do nothing
    }
}