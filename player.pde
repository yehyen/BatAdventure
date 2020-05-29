

class Player {
  int x, y, w, h, speed, c= color(250,200,0), direction = -1,
  animationImgNum = 8, imgIndex_fly = 0, imgIndex_death = 0;
  
  PImage[] img_bat_fly = new PImage[animationImgNum], 
            img_bat_death = new PImage[animationImgNum];
 PImage img_ghost;
 /* Player(){
    x= 20;
    y= height/2;
    w= 50;
    h= 40;
    speed= 20;
    c= color(250,200,0);
  }*/
  
  Player(){
    x= 20;
    y= height/2;
    w= 100;
    h= 50;
    speed= 10;
    loadSrc();
  }
  
  Player(int x, int y, int w, int h, int speed){
    this.x= x;
    this.y= y;
    this.w= w;
    this.h= h;
    this.speed= speed;
    loadSrc();
  }
  
  void loadSrc() {
    img_ghost = loadImage("src/img/ghost.png");
    for(int i=0; i<animationImgNum; i++) {
      img_bat_fly[i]=loadImage("src/img/FlyPic/Fly_00"+i+".png");
    }
    for(int i=0; i<animationImgNum; i++)
      img_bat_death[i]=loadImage("src/img/DiePic/Die_00"+i+".png");    
  }
  
  void setColor(color c){
    this.c = c;
  }
  
  void setSpeed(int s){
    speed = s;
  }
  
  int getX(){
    return x;
  }
  
  int getY(){
    return y;
  }
  
  int getWidth(){
    return w;
  }
  
  int getHeight(){
    return h;
  }
  
  void move(){
   //if(value.available() > 0){
   //   direction = value.read();
   //   println(direction);
   //}
   
    if(keyPressed){
        switch(keyCode){
          case DOWN:
            y+=speed;
            break;
          case UP:
            y-=speed;
            break;
        }
     } else {
       switch(direction){
          case 0:
            y+=speed;
            break;
          case 3:
            y-=speed;
            break;
        }
     
     }
     
     if (y<0) y=0;
  }
  
  void display(){
    image(img_bat_fly[imgIndex_fly],x, y, w, h, 20, 55, 510, 310);
    imgIndex_fly = (imgIndex_fly+1) % animationImgNum;  //loop  
  }
  
  void hurt(){
    if(!sound_hit.isPlaying()) sound_hit.play();
    image(img_bat_death[2],x, y, w, h, 20, 55, 510, 310);
    //delay(500);
  }
  
  void death(){
    image(img_bat_death[imgIndex_death], x, y, 80, 70);
    imgIndex_death=(imgIndex_death+1) % animationImgNum;
    if(!sound_death.isPlaying()) sound_death.play();
    
     x += 5;
     y += 15;  //gravity  
    
     if (y > height-50){
       x -= 6;
       y -= 16;  //gravity        
     } 
       image(img_ghost, x-25, y-15, 130, 100);
        x -= 1;
        y -= 20;      
     
     //sound_death.stop();     
  }
       
    /* if (y>=height){
       image(img_ghost, x, y, 125, 95);
        x -= 5;
        y -= 10; 
        sound_death.stop();
        
    } else {
      
      if(!sound_death.isPlaying()) {
          sound_death.play();
        }
      image(img_bat_death[imgIndex_death], x, y, w, h, 20, 55, 510, 310);
      imgIndex_death=(imgIndex_death+1) % animationImgNum;
       x += 5;
       y += 15;  //gravity
       
    }*/
    
  
  void displayRect(){
    fill(c);
    rect(x, y, w, h);
  }
}
