import processing.sound.*;
import processing.serial.*;
SoundFile bgm_start, bgm_win, bgm_end, bgm_play, sound_death, sound_hit, bgm_wings; 

PImage img_red_cross, img_halloween, img_witch, img_bg, img_texture, 
img_start, img_title, img_end, img_win, img_spider;

int hp, tmpHp;
Player bat;

Obstacle[] obsArr, obsArrGround;
int obsSpeed, obsGap; 
int[] obsX= new int[2];
int obsStopIndex;

String[] gameModeArr = {"start", "playing", "dead", "win"};
String gameMode;

Serial value;

// gameStart animation
int wx=630, wy=20, 
  px=0, py=64,
  sx=720, sy=35,
  zx=0, zy=64;

void initialize(){
    randomSeed((int)random(1023));
    hp = 3;
    tmpHp=hp;
    bat = new Player();

    obsX[0]=width;
    obsX[1]=width;
    obsSpeed=10;
    obsStopIndex=-1;
    obsArr = new Obstacle[30];
    obsArrGround = new Obstacle[20];
    generateObstacles();
    gameMode = gameModeArr[0];
}

void loadSrc() {
    img_red_cross = loadImage("src/img/red cross.png");
    img_halloween = loadImage("src/img/halloween.png");
    img_witch = loadImage("src/img/witch.png");
    img_texture = loadImage("src/img/texture.jpg");
    img_bg = loadImage("src/img/bg_night-forest.jpg"); 
    img_start= loadImage("src/img/start.jpg");
    img_spider = loadImage("src/img/1.png");
    img_title= loadImage("src/img/title.png");
    img_win= loadImage("src/img/win.jpg");
    sound_death = new SoundFile(this, "src/strangewind.mp3");
    sound_hit = new SoundFile(this, "src/pan.mp3");
    // sound_hit = new SoundFile(this, "src/hit.mp3"); //unable to decode
    bgm_start = new SoundFile(this, "src/MESSAGE-B_Accept.wav");
    bgm_end = new SoundFile(this, "src/music/blackout6.mp3"); //unable to decode
    bgm_play = new SoundFile(this, "src/music/Alexander Ehlers - Waking the devil.mp3");
    bgm_wings = new SoundFile(this, "src/bat Wings flap.wav");
    bgm_win = new SoundFile(this, "src/FINAL FANTASY victory.mp3");
}

void setup(){
    size(800, 600); 
    frameRate(15);
    loadSrc();
    initialize(); 
    surface.setTitle("Bat's Adventure");
    //value = new Serial(this, "COM6", 9600);
}

void draw(){
   
  if(gameMode == gameModeArr[1]){
    gameMode_playing();
  } else if(gameMode == gameModeArr[2]){
    gameMode_dead();
  } else if(gameMode == gameModeArr[3]){
    gameMode_win();
  } else {
    gameMode_start();
  } 
}

void generateObstacles(){
  int imgId; 

  for(int i=0; i<obsArr.length; i++){
      //gap-=20;
      //speed++;
      imgId = (int)random(-2,5);
      obsGap= (int)random(150, 600);
      obsX[0]+= obsGap; 
      
      switch(imgId){
        case 0: 
          obsSpeed=25;
          break;
        case 1:
          obsSpeed=20;
          break;
        case 2:
          obsSpeed=15;
          break;
        case 3:
          obsSpeed=12;
          break;
         default:
          obsSpeed=10;
      }
      
      //img-all
      //obsArr[i]= new Obstacle(obsX[0],(int)random(550)-40, (int)random(20, 150), (int)random(50, 320), obsSpeed, (int)random(-3,11));
      
      //img-fly
      obsArr[i]= new Obstacle(obsX[0], (int)random(0, 200), (int)random(20, 150), (int)random(50, 320), obsSpeed, imgId);
      
      //rect
      //obsArr[i]= new Obstacle(obsX[0], (int)random(550)-40, (int)random(20, 150), (int)random(50, 320), obsSpeed);
  }
  
  for(int i=0; i<obsArrGround.length; i++){
      //gap-=20;
      //speed++;
      obsGap= (int)random(250, 680);
      obsX[1]+= obsGap; 
      obsSpeed=8;     
      //img-ground
      obsArrGround[i]= new Obstacle(obsX[1], (int)random(0, 200), (int)random(20, 150), (int)random(50, 320), obsSpeed, (int)random(6,14));
  }
}

void displayObstacle(Obstacle[] obs, int index) {
    for(int i=0; i<obs.length; i++){
        obs[i].move();     
        if (obs[i].detectCollision(bat.getX(), bat.getY(), bat.getWidth(), bat.getHeight())) {
          if (obsStopIndex != i+index){
             bat.setColor(color(255,0,0));
             obsStopIndex=i+index;
             hp--;
          }
          delay(150);
        } 

     }
}

void gameMode_start(){
  float btn_x = 330.00;
  float btn_y = 500.00;
  float btn_w = 250.00;
  float btn_h = 100.00;
  
  img_start.resize(800, 600);
  background(img_start);
  image(img_title, 0, 0, 800,250);
  //image(img_title, 0, 0, 600, 200, 0, 100, 500, 300);
  image(img_spider, wx, wy, 64, 64, px, py, px+64, py+64);
  image(img_spider, sx, sy, 64, 64, zx, zy, zx+64, zy+64);
  wy-=4; 
  py+=64; 

  sy-=4; 
  zy+=64; 
  if(py>=64)py=0;
  if(wy<-30) wy=120;
  if(wy>120) wy=-30;
  
  if(zy>=64)zy=0;
  if(sy<-30) sy=135;
  if(sy>135) sy=-30; 

   if(!bgm_start.isPlaying()) bgm_start.play();

 // if (keyPressed) gameMode = gameModeArr[1];
 
 if((mouseX-btn_x)*(mouseX-btn_x)/((btn_w/2)*(btn_w/2))+(mouseY-btn_y)*(mouseY-btn_y)/((btn_h/2)*(btn_h/2))<1){
    fill(255,255,77);
    stroke(255,255,153);
    
    if(mousePressed){
      gameMode = gameModeArr[1];
    }
  }else{
      fill(255,0,0);
      stroke(255,77,64);
      strokeWeight(5);
      smooth();
  }
  ellipse(btn_x, btn_y, btn_w, btn_h);
  textAlign(LEFT);
  textSize(32);
  fill(100,0,200);
  text("START GAME", 230, 512); 
}

void gameMode_playing(){
   img_bg.resize(800, 600);
   background(img_bg);
   if(!bgm_play.isPlaying()) bgm_play.play();
   if(!bgm_wings.isPlaying()) bgm_wings.play();
   bat.setColor(color(250,200,0));
   bat.move();
   displayObstacle(obsArr, 0);
   displayObstacle(obsArrGround, obsArr.length);  
   
   showHealthPoints();

   
   if(tmpHp > hp){
     tmpHp = hp;
     bat.hurt();
     
   }
   else if(hp < 1 || (bat.y > height-bat.h-20)){
     bgm_play.stop();
     //bat.death();
     //delay(1000);
     gameMode = gameModeArr[2];
   } 
   else if (obsArr[obsArr.length-1].x < -200 && obsArrGround[obsArrGround.length-1].x < -200) {
     bgm_play.stop();
     delay(1000);
     gameMode = gameModeArr[3];
   } else {
     bat.display(); 
   }
      
}

void showHealthPoints() {
   // hp
    textSize(24);
    fill(200,0,0);
    //text("HP : "+hp, width-150, 50); 
    text("HP : ", width-250, 45);
    for(int i=0; i<hp; i++){
      image(bat.img_bat_fly[0], width-200 + i*40, 20, 60, 30, 20, 55, 510, 310);
    }
    
}

void gameMode_dead(){ 
  background(img_bg);
  bat.death();
  
  if(bat.y < 10){
    sound_death.stop();
    if(!bgm_end.isPlaying()) bgm_end.play();
    background(0);
    textSize(30);
    textAlign(CENTER); 
    fill(237,28,36); 
    text("GAME OVER", width/2-30, height/2+80);            
    image(bat.img_bat_death[bat.imgIndex_death], width/2-100, height/2-100, 150, 120);
    bat.imgIndex_death=(bat.imgIndex_death+1) % bat.animationImgNum;
    delay(100); 
    frameRate(20); 
  } 

  //img_bg.resize(800, 600);
  //background(img_bg);
  //bat.death();
  //textSize(32);
  //fill(200,0,200);
  //text("GAME OVER", width/3, height/3); 
  
  if (mousePressed) initialize();
  
}

void gameMode_win(){
  image(img_win, 0, 0, 800, 630); 
  //if (keyPressed) initialize();
  if(!bgm_win.isPlaying()) bgm_win.play();
  
  float x = 50.00;//firefox618
  float y = 550.00;
  float w = 80.00;
  float h = 80.00;
  if((mouseX-x)*(mouseX-x)/((w/2)*(w/2))+(mouseY-y)*(mouseY-y)/((h/2)*(h/2))<1)
  {
    fill(255,255,77); 
    if(mousePressed){
      initialize();
    }
  }else{
    fill(255,191,0);
    noStroke();
  }
  ellipse(x, y, w, h);
  beginShape(); 
  vertex(10,540); //1
  vertex(30,550); //2
  vertex(55,520); //3
  vertex(70,530); //4
  vertex(50,560); //5
  vertex(75,580); //6
  vertex(25,580); //7
  fill(255,0,0);
  endShape(CLOSE); 
  
}
