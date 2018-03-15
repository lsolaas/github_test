class Part {
  int ix;
  int nLevels;
  int nSticks;
  
  RootStick root;
  Level[] levels;
  
  Part(int _ix, int nL, int nS, PVector a, PVector z) {
    ix = _ix;
    nLevels = nL;
    nSticks = nS;
    
    root = new RootStick(a, z);
    levels = new Level[nLevels];
    for(int l=0; l<nLevels; l++){
      levels[l] = new Level(this, l, nSticks, size);
      levels[l].col = color(cols[l], 255);
    }
  }
  
  void step() {
    for(int l=0; l<nLevels; l++){
      if(go){
        levels[l].slot = l == 0 ? 0 : noise(ix*6+0, l*changeRate.x, t*changeRate.y);
        levels[l].vslot = l == 0 ? 1.0/float(nSticks) : noise(ix*6+1, l*changeRate.x, t*changeRate.y) * 0.4 - 0.2;
        levels[l].peg = noise(ix*6+2, l*changeRate.x, t*changeRate.y);
        levels[l].vpeg = noise(ix*6+3, l*changeRate.x, t*changeRate.y) * 0.4 - 0.2;
        levels[l].rot = noise(ix*6+4, l*changeRate.x, t*changeRate.y) * TWO_PI - PI;
        levels[l].vrot = noise(ix*6+5, l*changeRate.x, t*changeRate.y) * 0.8 - 0.4;
      }
      
      levels[l].step();
    }
  }
  
  void paint() {
    for(int l=0; l<nLevels; l++){
      for(int s=0; s<sides; s++){
        pushMatrix();
        
        translate(width/2, height/2);
        rotate(baseRot + TWO_PI/float(sides) * s);
        translate(-width/2, -height/2);
        if(mirror && s%2 == 1){
          translate(float(width), 0);
          scale(-1, 1);
        }
        
          levels[l].paint();
        
        popMatrix();
      }
    }
    
    if(key == ';') root.paint();
  }
  
  
}
