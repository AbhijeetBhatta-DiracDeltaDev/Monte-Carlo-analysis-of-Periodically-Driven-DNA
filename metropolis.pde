import grafica.*;

public GPlot plot;
public GPointsArray points;
public GPlot plot2;
public GPointsArray points2;
//bond fluctiation model


int[][] canvas;
int i = 0, j = 0;
int Nbeads = 60;
Bead[] beads = new Bead[Nbeads];
Bead[] staticbeads = new Bead[Nbeads];
int  scaling = 4;
float energy = -Nbeads;
float T =0.18;
float dist = 2;
int time = 0; 
float amp = 1.5;
float time_period = 1*50000;
int init_timeperiod = int(time_period);
float force = amp*sin(PI*time/time_period);
float[] avg_array;
float area1 =0;

void setup(){
  size(800,700);
  frameRate(60);
    int nPoints = 500;
    int nPoints2 = 10000;
  points = new GPointsArray(nPoints);
   plot = new GPlot(this);
   points2= new GPointsArray(nPoints2);
   plot2 = new GPlot(this);
  plot.setPos(100,225);
  plot.setDim(400,200);
  plot2.setPos(200,225);
  plot2.setDim(400,200);
  canvas = new int[500][500];
  avg_array = new float[init_timeperiod];
  for(i=0;i<init_timeperiod;i++){avg_array[i] = 0;}
  for( i=0; i<500;i++){
      for( j=0; j<500;j++){
        canvas[i][j] = 0;}}
  for(i=0; i<Nbeads;i+=1){
    beads[i] = new Bead(2,2*i,1);
    staticbeads[i] = new Bead(0,2*i,0);
    canvas[0][2*i] = 1;}
    plot2.beginDraw();
}

float bond_length( int a , int b){
  return sqrt(pow((beads[a].x - beads[b].x),2) + pow((beads[a].y - beads[b].y),2));
      }


void area(){
  area1=0;
  int l2=0;
  for(int l =0 ; l<int(time_period) - 4;l+=4){ l2 = l+4;
  area1+= ((amp/2)*(sin(PI*l2/time_period)- sin(PI*l/time_period))) * ((avg_array[l]/1000)  + (avg_array[l2]/1000));
} 
  println("area");println(area1);
  points2.add(2*PI/time_period, area1); plot2.setPoints(points2);
}


void move(int a){
  int neighbours = 0;
  int[][] move_arr = new int[4][2];
  for (i=0; i<4; i++){for(j=0; j<2; j++){move_arr[i][j]=-1;}}
  int prevx = beads[a].x, prevy = beads[a].y;
  int energy_change = 0;
  
  
  float up=-1,down=-1;
  if (a!=0){down = bond_length(a-1,a);}
  if (a!=Nbeads-1){up = bond_length(a,a+1);}  
  beads[a].lift();
  
  if (beads[a].x - 1 >=0){if (canvas[beads[a].x -1][beads[a].y] ==0){
    neighbours++;
    move_arr[neighbours -1][0] = beads[a].x -1; move_arr[neighbours -1][1] = beads[a].y ;
    
    beads[a].place((beads[a].x -1),beads[a].y);
    if (a<Nbeads-1){
    if (bond_length(a-1,a)>=4 || bond_length(a,a+1)>=4){
      move_arr[neighbours -1][0] =-1; move_arr[neighbours -1][1] = -1 ;    
      neighbours--;
    }}
    
    else if (a==Nbeads-1){
    if (bond_length(a-1,a)>=4){
      move_arr[neighbours -1][0] =-1; move_arr[neighbours -1][1] = -1 ;    
      neighbours--;}}
    
    beads[a].lift(); 
    beads[a].x = prevx; beads[a].y =prevy;
    //beads[a].place(prevx,prevy);
    //    beads[a].lift();
}}   
    
  if (beads[a].y - 1 >=0){if (canvas[beads[a].x][beads[a].y-1] ==0){
    neighbours++;
    move_arr[neighbours -1][0] = beads[a].x; move_arr[neighbours -1][1] = beads[a].y -1 ;
    
    beads[a].place(beads[a].x, beads[a].y -1);
    if (a<Nbeads-1){
    if (bond_length(a-1,a)>=4 || bond_length(a,a+1)>=4){
      move_arr[neighbours -1][0] =-1; move_arr[neighbours -1][1] = -1 ;    
      neighbours--;
    }}
    
    else if (a==Nbeads-1){
    if (bond_length(a-1,a)>=4){
      move_arr[neighbours -1][0] =-1; move_arr[neighbours -1][1] = -1 ;    
      neighbours--;}}
    
    beads[a].lift();
    beads[a].x = prevx; beads[a].y =prevy;
    //beads[a].place(prevx,prevy);
    //    beads[a].lift();
  }}
  
  if (beads[a].x + 1 <500){if (canvas[beads[a].x +1][beads[a].y] ==0){
    neighbours++;
    move_arr[neighbours -1][0] = beads[a].x +1; move_arr[neighbours -1][1] = beads[a].y ;
    
    beads[a].place((beads[a].x+1),beads[a].y);
    if (a<Nbeads-1){
    if (bond_length(a-1,a)>=4 || bond_length(a,a+1)>=4){
      move_arr[neighbours -1][0] =-1; move_arr[neighbours -1][1] = -1 ;    
      neighbours--;
    }}
    
    else if (a== Nbeads-1 ){
    if (bond_length(a-1,a)>=4){
      move_arr[neighbours -1][0] =-1; move_arr[neighbours -1][1] = -1 ;    
      neighbours--;}}
    
    beads[a].lift(); 
    beads[a].x = prevx; beads[a].y =prevy; 
        //beads[a].place(prevx,prevy);
        //beads[a].lift();
  }}
   
   
   
  if (beads[a].y + 1 <500){if (canvas[beads[a].x][beads[a].y+1] ==0){
    neighbours++;
    move_arr[neighbours -1][0] = beads[a].x; move_arr[neighbours -1][1] = beads[a].y +1;
    
    beads[a].place((beads[a].x),beads[a].y + 1);
    if (a<Nbeads-1){
    if (bond_length(a-1,a)>=4 || bond_length(a,a+1)>=4){
      move_arr[neighbours -1][0] =-1; move_arr[neighbours -1][1] = -1 ;    
      neighbours--;
    }}
    
    else if (a==Nbeads-1){
    if (bond_length(a-1,a)>=4){
      move_arr[neighbours -1][0] =-1; move_arr[neighbours -1][1] = -1 ;    
      neighbours--;}}
    
    beads[a].lift();
    beads[a].x = prevx; beads[a].y =prevy;
        //beads[a].place(prevx,prevy);
        //beads[a].lift();    
        
  }}
  
  
  int Nx = prevx, Ny = prevy;

  if (neighbours>0){
    //print(neighbours);
  int R = int(floor(random(0,neighbours)));
  Nx = move_arr[R][0]; Ny = move_arr[R][1]; beads[a].nei = 1;}
  else{  
    //print(neighbours);
  beads[a].nei = 0;}
  beads[a].place(Nx,Ny);
  //if (bond_length(a-1,a)>=4){beads[a].lift();beads[a].place(prevx,prevy);}
  //if (a<Nbeads-1){if(bond_length(a,a+1)>=4){beads[a].lift();beads[a].place(prevx,prevy);}}
  float newup =-1,newdown=-1;
  float newdist = beads[Nbeads-1].x;
  if (a!=0){newdown = bond_length(a-1,a);}
  if (a!=Nbeads-1){newup = bond_length(a,a+1);}
  
  
    //if (a!= Nbeads-1){
    //if (newup>up && up ==2){energy_change++;}
    //if (newup<up && newup ==2){energy_change--;}}
    
    //if (a!= 0){
    //if (newdown>down && down ==2){energy_change++;}
    //if (newdown<down && newdown ==2){energy_change--;}}
    
    //energy_change += force*(dist - newdist);
    //if(prevx !=2 && beads[a].x==2){energy_change -=1;}    
    //    if(prevx ==2 && beads[a].x!=2){energy_change +=1;} 
    //if (energy_change <=0){  // some link made
    //energy += energy_change; dist = newdist;
    
            energy_change += force*(dist - newdist);
    if((beads[a].x==2 && beads[a].y==beads[a].firstY) && (prevx!=2 || prevy!=beads[a].firstY)){energy_change -=1;}    
        if((prevx ==2 && prevy==beads[a].firstY) && (beads[a].y!=beads[a].firstY || beads[a].x!=2)){energy_change +=1;} 
    if (energy_change <=0){  // some link made
    energy += energy_change; dist = newdist;
      } 
    
    
    else if (energy_change >0){ // some link broken
    float q = random(0,1);
    if (q> exp(-1*energy_change/ T)){ beads[a].lift(); beads[a].place(prevx,prevy);}
    else{energy += energy_change; dist = newdist;
        }
    }
   //println(dist);
}
int count = 0;
void draw(){ 
  background(0);

  stroke(255);
  
  
  for(int r =0; r<100;r++){
    for(i=0;i< init_timeperiod;i++){avg_array[i] = 0;}
    
    
  //while(count<1000){
  
  force = amp*sin(PI*time/time_period);
  
  for (int s =Nbeads-1; s>=1; s--){move(s);}
  avg_array[time] += (dist-2);
  time = (time + 4)% (int(time_period)); if(time==0){count++;}}
                                                                              
                                                                                                                                    
  //for (i =0 ; i<Nbeads ; i++){
     
  //  beads[i].display();
  //  staticbeads[i].display();}
  
  
  ///////////////////////////////////////////////////////////////////////////////////////////////
  //if(count == 1000){
  ////println(avg_array[4]/1000); println(avg_array[128]/1000); println(avg_array[252]/1000); 
  //for(i =0; i<time_period;i+= 4){println(avg_array[i]/1000); 
  //points.add(amp*sin(PI*i/time_period),avg_array[i]/1000);
  ////else{points.add(amp*sin(PI*i/time_period),avg_array[i]/10000);}
  //plot.setPoints(points);}
  //plot.beginDraw();
  //plot.drawBackground();
  //plot.drawBox();
  //plot.drawXAxis();
  //plot.drawYAxis();
  //plot.drawTopAxis();
  //plot.drawRightAxis();
  //plot.drawPoints();
  //plot.drawLines();
  ////plot.drawTitle();
  //plot.endDraw();
  //}
  /////////////////////////////////////////////////////////////////////////////////////////////////
  //if (count==1000){
  //area();}
  //plot2.drawBackground();
  //plot2.drawBox();
  //plot2.drawXAxis();
  //plot2.drawYAxis();
  //plot2.drawTopAxis();
  //plot2.drawRightAxis();
  //plot2.drawPoints();
  //plot2.drawLines();
  ////plot.drawTitle();
  //}
  //  plot2.endDraw();
  ////noLoop();
  
  
   for (i =0; i<Nbeads-1;i++){
     beads[i].display();
     if (bond_length( i, i+1)>=4){stroke(255,0,0);}
  line(10+ scaling*(beads[i].x),700 - (10+(scaling*beads[i].y)), 10+ scaling*(beads[i+1].x),700 - (10+(scaling*beads[i+1].y))); stroke(255);}   
   for(int i=0; i<500;i++){
   for(int j=0; j<500;j++){
      if (canvas[i][j] == -1){
     fill(0,255,0);
  //     stroke(0,255,0);
  //ellipse(10+(scaling*i), 700 - (10+ (scaling*j)), 3,3);
          fill(255,255,255); stroke(255);}}}
          
          
  stroke(255,0,0);
  ellipse(10, 700-10, 3,3);
  ellipse(10+(scaling*2), 700-10, 3,3);
  line(10+(scaling*1), 0 , 10+(scaling*1),700);  
  stroke(0,255,0);
  line(10+ (scaling*beads[Nbeads-1].x), 700 -10 - (scaling*beads[Nbeads-1].y), 10+ (scaling*beads[Nbeads-1].x)+ force*10, 700 -10 - (scaling*beads[Nbeads-1].y));
  stroke(255);
}
//int iter = 0;
//void keyPressed(){
//amp = 0;
////T = 0.2;
//if (iter%2 ==0){noLoop(); iter++;}
//else if (iter%2 ==1){loop(); iter++;}}
  
  
