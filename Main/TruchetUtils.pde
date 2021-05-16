import java.util.Random;
import java.util.*;
/*
 * Return the flatten tree from the first level tree
*/
public ArrayList<Tile> getFlattenTree(ArrayList<Tile> firstLevel,boolean complete){
    ArrayList<Tile> flattenTree = new ArrayList<Tile>(); 
    for(Tile t:firstLevel)
      flattenTree.addAll(t.getFlattenTree(complete));
    return flattenTree;
}

public ArrayList<Tile> getFlattenTree(ArrayList<Tile> firstLevel){
  return getFlattenTree(firstLevel, false);
}

/*
* Sort the given flatten tree by the layer
*/
public void sortFlattenTree(ArrayList<Tile> tiles){
  for(int i=0;i<tiles.size();i++){
    for(int j=i+1;j<tiles.size();j++){
                Tile t_i = tiles.get(i);
                Tile t_j = tiles.get(j);                
                if(t_i.layer>t_j.layer){
                    Tile aux=t_i.clone();
                    tiles.set(i,t_j);
                    tiles.set(j,aux);
                }
      }
  }

}

public void sortFlattenTreeByX(ArrayList<Tile> tiles, boolean asc){
  for(int i=0;i<tiles.size();i++){
    for(int j=i+1;j<tiles.size();j++){
      Tile t_i = tiles.get(i);
      Tile t_j = tiles.get(j);                
      if(asc){
        if(t_i.x>t_j.x){
        Tile aux=t_i.clone();
        tiles.set(i,t_j);
        tiles.set(j,aux);
      }
      }else{
        if(t_i.x<t_j.x){
          Tile aux=t_i.clone();
          tiles.set(i,t_j);
          tiles.set(j,aux);
       }
      }
    }
  }
}

public void sortFlattenTreeByY(ArrayList<Tile> tiles, boolean asc){
  for(int i=0;i<tiles.size();i++){
    for(int j=i+1;j<tiles.size();j++){
      Tile t_i = tiles.get(i);
      Tile t_j = tiles.get(j);                
      if(asc){
        if(t_i.y>t_j.y){
        Tile aux=t_i.clone();
        tiles.set(i,t_j);
        tiles.set(j,aux);
      }
      }else{
        if(t_i.y<t_j.y){
          Tile aux=t_i.clone();
          tiles.set(i,t_j);
          tiles.set(j,aux);
       }
      }
    }
  }
}

/*
 * Cambia [rate]% immagini tile a tutti i Tile del flatten tree passato
 */
public ArrayList<Tile> changeTileImages(ArrayList<Tile> flattenTree,double rate){
  ArrayList<Tile> tree = new ArrayList<Tile>();
  for(Tile t:flattenTree){
    if(new Random().nextDouble()<rate)
      tree.add(t.cloneWithRandomTile());
    else
      tree.add(t);
  }
  return tree;
}

/*
 * Cambia [num] immagini tile a tutti i Tile del flatten tree passato
 */
public ArrayList<Tile> changeNTileImages(ArrayList<Tile> source,int num){
  ArrayList<Tile> dest = new ArrayList<Tile>();
  int changed=0;
  while(changed<num){
    int indexRandom=new Random().nextInt(source.size());
    dest.add(source.get(indexRandom).cloneWithRandomTile());
    changed++;
    source.remove(indexRandom);
  }
  for(Tile t:source)
    dest.add(t);
  return dest;
}


public ArrayList<Tile> extractLevel(ArrayList<Tile> source,int layer, boolean flatten){
  ArrayList<Tile> dest=new ArrayList<Tile>();
  for(Tile t:source){
    if(t.layer==layer){
      dest.add(t);
    }
  }
  if(flatten)
    return getFlattenTree(dest,false);
  return dest;
}

public ArrayList<Tile> extractLevel(ArrayList<Tile> source,int layer){
  return extractLevel(source,layer,true);
}

public void drawFlattenTree(ArrayList<Tile> tree,boolean tint,VideoExport video){
    for(int i=0;i<tree.size();i++){
      if(i%100==0)
        println(i+"/"+tree.size());
      Tile t = tree.get(i);
      t.draw(tint,video);
    }
}

public void drawLevel(ArrayList<Tile> tree,int layer,boolean tint,VideoExport video){
  for(int i=0;i<tree.size();i++){
    if(i%100==0)
      println(i+"/"+tree.size());
    Tile t = tree.get(i);
    if(t.layer==layer)
      t.draw(tint,video);
  }
}

  public int getColorFromPositionInMosaic(int x,int y){
    int xPadding = (width-Globals.mosaic_width)/2;
    double xComponent = (double)(x-xPadding)/((double)(width-xPadding)*Globals.COLOR_FACTOR);
    int yPadding = (height-Globals.mosaic_height)/2;
    double yComponent = (double)(y-yPadding)/((double)(height-yPadding)*Globals.COLOR_FACTOR);
    int red = (int)(yComponent*255);
    int  green = (int)(xComponent*255);
    return color(red, green, Globals.BLUE);
  }
