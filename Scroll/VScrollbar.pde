class VScrollbar{
    int swidth, sheight;    // width and height of bar
    float xpos, ypos;       // x and y position of bar
    float spos, newspos;    // y position of slider
    float sposMin, sposMax; // max and min values of slider
    int loose;              // how loose/heavy
    boolean over;           // is the mouse over the slider?
    boolean locked;
    float ratio;

    float cursorHeight;

    VScrollbar(int swidth, int loose) {
        this.swidth = swidth;
        setDimensions();
        //Set the starting position as at the far left
        spos = 0;
        newspos = spos;
        sposMin = 0;
        this.loose = loose;
    }
    
    void setDimensions(){        
        this.sheight = height - swidth;
        this.xpos = width-swidth;
        this.ypos = 0;
        cursorHeight = 100;
        sposMax = sheight - cursorHeight;
    }

    void update() {
        setDimensions();
        if (overEvent()) {
            over = true;
        } else {
            over = false;
        }
        if (firstMousePress && over) {
            locked = true;
        }
        if (!mousePressed) {
            locked = false;
        }
        if (locked) {
            newspos = constrain(mouseY-swidth/2, sposMin, sposMax);
        }
        if (abs(newspos - spos) > 1) {
            spos = spos + (newspos-spos)/loose;
            println(spos);
        }
    }

    float constrain(float val, float minv, float maxv) {
        return min(max(val, minv), maxv);
    }

    boolean overEvent() {
        if (mouseX > xpos && mouseX < xpos+swidth &&
        mouseY > ypos && mouseY < ypos+sheight) {
            return true;
        } else {
            return false;
        }
    }

    void display() {
        noStroke();
        fill(204);
        rect(xpos, ypos, swidth, sheight);
        if (over || locked) {
            fill(0, 0, 0);
        } else {
            fill(102, 102, 102);
        }
        rect(xpos, spos, swidth, cursorHeight);
    }

    float getPos() {
        return spos;
    }

    int getYTranslate(){
        return int(map(spos,sposMin,sposMax,0,CANVAS_HEIGHT-sheight));
    }

}