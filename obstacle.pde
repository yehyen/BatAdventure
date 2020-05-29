
class Obstacle {
  int x, y, w=10, h=10, speed, dir=-1;
  //fly: 0~5
  String[] imgType={"ghost", "bat", "eyes", "cake_pumpkin", "cake_death", "pumpkin", 
  "cat", "magic", "cross", "candle", "death"
};
  int imgTypeIndex=-1;
  
  PImage img= null;
  int[] imgRangeFrom, imgRangeTo;
  
  
  Obstacle(){
    x=0;
    y=0;
    speed=4;
  }
  
   Obstacle(int x, int y, int w, int h, int speed){
    this.x= x;
    this.y= y;
    this.w= w;
    this.h= h;
    this.speed= speed;
  }
  
  Obstacle(int x, int y, int w, int h, int speed, int imgTypeIndex){
    this.x= x;
    this.y= y;
    this.w= w;
    this.h= h;
    this.imgTypeIndex = imgTypeIndex;
    this.speed= speed;
    imgSetting(imgTypeIndex);
  }
  
  Obstacle(int x, int y, int w, int h, int speed, PImage img){
    this.x= x;
    this.y= y;
    this.w= w;
    this.h= h;
    this.img = img;
    this.speed= speed;
  }
  
  Obstacle(int x, int y, int w, int h,int speed, PImage img, int[] rangeFrom, int[] rangeTo){
    this.x= x;
    this.y= y;
    this.w= w;
    this.h= h;
    this.img = img;
    this.imgRangeFrom = rangeFrom;
    this.imgRangeTo = rangeTo;
    this.speed= speed;
  }
  
  void setSpeed(int speed){
    this.speed= speed;
  }
  
  void setDirection(String dirType){
    this.dir= dirType == "right" ? 1 : -1;
  }
  
  void imgSetting(int imgTypeIndex) {
    if(imgTypeIndex > -1 && imgTypeIndex < imgType.length){
       switch(imgType[imgTypeIndex]){
            case "ghost":
              break;
            case "bat":
              w=200;
              h=40;
              break;
            case "cake_pumpkin": 
              w= 60;
              h= 60;
              break;
            case "cake_death":
              w= 80;
              h= 80;
              break;
            case "pumpkin":
              w= 100;
              h= 100;
              break;
            case "cat":
              w= 150;
              h= 200;
              y= height-h;
              break;
            case "magic":
              w= 150;
              h= 160;
              y= height-h;
              break;
            case "cross":
              h= w*2;
              y= height-h;
              break; 
            case "candle":
              w= 200;
             // h= 280;
              y= height-h;
              break;
            case "death":
              w= 200;
              h= 200;
              y= height-h;
              break;
            case "eyes":
              w= 80;
              h= 80;
              break;
       }
    }
  }
  
  void move() {
     display();
     x+= speed*dir;
  }
  
  void display() {
     //stroke(3);
     //noStroke();
    // rect(x,y,w,h);

    if(imgTypeIndex > -1 && imgTypeIndex < imgType.length){
       switch(imgType[imgTypeIndex]){
        case "ghost":
          image(img_halloween, x, y, w, h, 80, 40, 300, 250);
          //image(img_halloween, x, y, w, h, 80, 40, 300, 250);
          break;
        case "bat":
          image(img_halloween, x, y, w, h, 420, 1040, 930, 1150);
          break;
        case "cake_pumpkin": 
          image(img_halloween, x, y, w, h, 935, 70, 1070, 240);
          break;
        case "cake_death":
          image(img_halloween, x, y, w, h, 370, 235, 505, 405);
          break;
        case "pumpkin":
          image(img_halloween, x, y, w, h, 875, 410, 1105, 640);
          break;
        case "cat":
          image(img_halloween, x, y, w, h, 570, 100, 860, 485);
          break;
        case "magic":
          image(img_halloween, x, y, w, h, 985, 900, 1160, 1135);
          break;
        case "cross":
          image(img_red_cross, x, y, w, h);
          break; 
        case "candle":
          image(img_witch, x, y, w, h, 135, 60, 310, 420);
          break;
        case "death":
          image(img_witch, x, y, w, h, 680, 970, 1000, 1260);
          break;
        case "eyes":
          image(img_witch, x, y, w, h, 700, 60, 990, 450);
          break;
         default:  
            fill(0);
            rect(x,y,w,h);
      }    
    
    }
    else {
        //fill(0);
        //rect(x,y,w,h);
        //image(img_texture, x, y, w, h, 256*3, 256*2, 256*4, 256*3);
         image(img_texture, x, y, w, h, 256*0, 256*1, 256*1, 256*2);
     }
    
  }
  
  boolean detectCollision(int px, int py, int pw, int ph){
    // mode: CORNER
    int[][] obsRange= {
      {x-pw+20, x+w}, //x
      {y-ph, y+h} //y
    };
    if (px>obsRange[0][0] && px<obsRange[0][1] && py>obsRange[1][0] && py<obsRange[1][1]){
      return true;
    }
    return false;
  }

}
