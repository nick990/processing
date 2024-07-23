class HScrollbar{
    int swidth, sheight;    // width and height of bar
    float xpos, ypos;       // x and y position of bar
    float spos, newspos;    // x position of slider
    float sposMin, sposMax; // max and min values of slider
    int loose;              // how loose/heavy
    boolean over;           // is the mouse over the slider?
    boolean locked;
    float ratio;

    float cursorWidth;

    HScrollbar(float xpos, float ypos, int sheight, int loose) {
        this.swidth = width;
        this.sheight = sheight;
        this.xpos = xpos;
        this.ypos = ypos-sheight/2;
        //Set the starting position as at the far left
        spos = 0;
        newspos = spos;
        sposMin = xpos;
        sposMax = xpos + swidth - cursorWidth;
        this.loose = loose;
    }

    void update() {
        this.swidth = width;
        sposMax = xpos + swidth - cursorWidth;
        cursorWidth = 100;
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
            newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
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
        rect(spos, ypos, cursorWidth, sheight);
    }

    float getPos() {
        return spos;
    }

    int getXTranslate(){
        return int(map(spos,sposMin,sposMax,0,CANVAS_WIDTH-width));
    }

}