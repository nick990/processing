
    public void pauseVideo(VideoExport video, int framesCount){
        for(int i=0;i<framesCount;i++)
            video.saveFrame();
    }

    public String getDatetime(){
        String datetime = year()+nf(month(),2)+nf(day(),2)+"-h"+nf(hour(),2)+"m"+nf(minute(),2)+"s"+nf(second(),2); 
        return datetime;
    }

    public int getColorFromPositionInWindow(int x,int y){
        double xComponent = (double)x/((double)width*Globals.COLOR_FACTOR);
        double yComponent = y/((double)height*Globals.COLOR_FACTOR);
        int red = (int)(yComponent*255);
        int  green = (int)(xComponent*255);
        return color(red, green, Globals.BLUE);
    }

    public String ArrayIntToString(ArrayList<Integer> list){
        String s="";
        if(list!=null)
            for(int i:list){
                s+=i+",";
            }
        return s;
    }

    public void saveGlobals(String fileName){
        ArrayList<String> globalsAsStringList = new ArrayList<String>();
        globalsAsStringList.add("TILES_FOLDER="+Globals.TILES_FOLDER);
        globalsAsStringList.add("ALG="+Globals.ALG);
        globalsAsStringList.add("USE_BASE_IMAGE="+Globals.USE_BASE_IMAGE);
        globalsAsStringList.add("BASE_IMAGE="+Globals.BASE_IMAGE);
        globalsAsStringList.add("COLS="+Globals.COLS);
        globalsAsStringList.add("ROWS="+Globals.ROWS);
        globalsAsStringList.add("TILE_SIZE="+Globals.TILE_SIZE);
        globalsAsStringList.add("LEVELS="+Globals.LEVELS);
        globalsAsStringList.add("SPLIT_THRESHOLD="+Globals.SPLIT_THRESHOLD);
        globalsAsStringList.add("SPLIT_RATE="+nf((float)Globals.SPLIT_RATE,1,2));
        globalsAsStringList.add("CORNER="+Globals.CORNER);
        globalsAsStringList.add("SMOOTH="+Globals.SMOOTH);
        globalsAsStringList.add("LAYER_COLOR_TH="+Globals.LAYER_COLOR_TH);
        globalsAsStringList.add("FRAME_RATE="+Globals.FRAME_RATE);
        globalsAsStringList.add("COLOR_FACTOR="+nf((float)Globals.COLOR_FACTOR,1,2));
        globalsAsStringList.add("TILES_INDEXES_VALID="+ArrayIntToString(Globals.TILES_INDEXES_VALID));
        globalsAsStringList.add("STROKE_WEIGHT="+Globals.STROKE_WEIGHT);
        globalsAsStringList.add("DIAMETER="+Globals.DIAMETER);
        globalsAsStringList.add("BICOLOR="+Globals.BICOLOR);
        globalsAsStringList.add("COLOR1="+hex(Globals.COLOR1));
        globalsAsStringList.add("COLOR2="+hex(Globals.COLOR2));
        globalsAsStringList.add("ALPHA="+Globals.ALPHA);
        globalsAsStringList.add("STARTING_NEGATIVE="+Globals.STARTING_NEGATIVE);

        String[] globalsAsStringArray = new String[globalsAsStringList.size()];
        globalsAsStringArray = globalsAsStringList.toArray(globalsAsStringArray);
        saveStrings(fileName, globalsAsStringArray);
    }

       public String getFileName(){
        String datetime = year()+"-"+month()+"-"+day()+"-"+hour()+"-"+minute()+"-"+second();
        return datetime;
      }
