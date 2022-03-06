class Superformula{
    float a,b,m,n1,n2,n3;
    float aStart,bStart,mStart,n1Start,n2Start,n3Start;
    float size;
    float centerX,centerY;
    
    float THETA_START = 0.0;
    float THETA_STEP = 0.012;
    float THETA_STOP = 2*PI;

    ArrayList<Float> xValues;
    ArrayList<Float> yValues;
    color fillColor;
    float delay;

    float last_period=0;

    Superformula(float _centerX, float _centerY, float _a, float _b, float _m, float _n1, float _n2, float _n3, float _size,float _delay){
        centerX = _centerX;
        centerY = _centerY;
        a = _a;
        b = _b;
        m = _m;
        n1 = _n1;
        n2 = _n2;
        n3 = _n3;
        aStart = _a;
        bStart = _b;
        mStart = _m;
        n1Start = _n1;
        n2Start = _n2;
        n3Start = _n3;
        size = _size;
        delay=_delay;
        fillColor=getColorFromPositionInWindow((int)centerX,(int)centerY);
        calcForumla();
    }

    void calcForumla(){         
        xValues = new ArrayList<Float>();
        yValues = new ArrayList<Float>();   
        for(float theta=THETA_START;theta<=THETA_STOP;theta+=THETA_STEP){
            float r = computeR(theta);
            float x = r * cos(theta)*size;
            float y = r * sin(theta)*size;
            xValues.add(x);
            yValues.add(y);
        }
    }

    void calcForumla(float time){    

        // this.a= this.aStart*0.8 + cos(time+delay)*this.aStart*0.2;
        float time_b=time+delay;
        this.b= map(sin(time_b),-1,1,1,1.02);
        float time_n2 = time/2+delay;
        this.n2 =  cos(time_n2)* this.n2Start;
        int period = (int)((time_n2-PI)/(2*PI));
        this.m = this.mStart + period*2;
        this.n1+=0.005;
        if(last_period!=period){
            last_period=period;
            // this.n3=random(-10,-1);
            this.n3++;
            // float n1_direction=+1;
            // this.n1=max(1,this.n1+n1_direction*0.25);
            println("perdiod:"+period);
            println("n3:"+n3);
            println("n1:"+n1);
        }
        calcForumla();
    }


    
    float computeR(float theta){
        return pow(pow(abs(cos(m * theta / 4.0) / a), n2) + pow(abs(sin(m * theta / 4.0) / b), n3),-1.0/n1);
    }

    //shape unica
    void display(){
        translate(centerX,centerY);
        // fill(fillColor);
        strokeWeight(4);
        stroke(fillColor);
                beginShape();
        for(int i=0; i<xValues.size(); i++){
            vertex(xValues.get(i),yValues.get(i));
        }
        endShape();
        translate(-centerX,-centerY);
    }

    //ricalcolo la formula in base al tempo passato
    void display(float time){
        this.calcForumla(time);  
        this.display2();
    }

    // ogni punto è un cerchio
    void display2(){
        translate(centerX,centerY);
        fill(0);
        strokeWeight(4);
        for(int i=0; i<xValues.size(); i++){
            float x=xValues.get(i);
            float y=yValues.get(i);
            fillColor = getColorFromPositionInWindow((int)x,(int)y);
            stroke(fillColor);
            ellipse(x, y, 120, 120);
        }
        translate(-centerX,-centerY);
    }
    
}

class SuperformulaStateful extends Superformula{
    SuperformulaStateful(float _centerX, float _centerY, float _a, float _b, float _m, float _n1, float _n2, float _n3, float _size,float _delay){
        super(_centerX,_centerY,_a,_b,_m,_n1,_n2,_n3,_size,_delay);
    }
}