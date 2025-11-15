class Bead{
  
  int x;
  int y;
  int lifted;
  int id;
  int nei;  
  int firstY;
  Bead(int iniX, int iniY, int iniID){
    x = iniX;
    y = iniY;
    firstY =iniY;
    lifted =0;
    nei = 1;
    id = iniID;
    canvas[x][y]=1;
    if (x-1 >= 0){canvas[x-1][y] -= 1; if (y-1 >=0){canvas[x-1][y-1] -= 1;} if (y+1 <500){canvas[x-1][y+1] -= 1;} }
    if (x+1 < 500){canvas[x+1][y] -= 1; if (y-1 >=0){canvas[x+1][y-1] -= 1;} if (y+1 <500){canvas[x+1][y+1] -= 1;}}
    if (y+1 < 500){canvas[x][y+1] -= 1;}
    if (y-1 >= 0){canvas[x][y-1] -= 1;}}
    
    
  void lift(){
    if (lifted == 0){
          canvas[x][y] = 0;
    if (x-1 >= 0){canvas[x-1][y] += 1; if (y-1 >=0){canvas[x-1][y-1] += 1;} if (y+1 <500){canvas[x-1][y+1] += 1;} }
    if (x+1 < 500){canvas[x+1][y] += 1; if (y-1 >=0){canvas[x+1][y-1] += 1;} if (y+1 <500){canvas[x+1][y+1] += 1;}}
    if (y+1 < 500){canvas[x][y+1] += 1;}
    if (y-1 >= 0){canvas[x][y-1] += 1;
    lifted = 1;}}}
    
    
    
  void place(int newX, int newY){

    x = newX; y = newY;
    canvas[x][y] = 1;
    if (x-1 >= 0){canvas[x-1][y] -= 1; if (y-1 >=0){canvas[x-1][y-1] -= 1;} if (y+1 <500){canvas[x-1][y+1] -= 1;} }
    if (x+1 < 500){canvas[x+1][y] -= 1; if (y-1 >=0){canvas[x+1][y-1] -= 1;} if (y+1 <500){canvas[x+1][y+1] -= 1;}}
    if (y+1 < 500){canvas[x][y+1] -= 1;}
    if (y-1 >= 0){canvas[x][y-1] -= 1;}
    lifted = 0;
  }
  
  void display(){
    if (nei ==0){fill(255,0,0); stroke(255,0,0);}
    ellipse(10+(scaling*x), 700 - (10+ (scaling*y)), 3,3); fill(255,255,255); stroke(255);
        
}} 
