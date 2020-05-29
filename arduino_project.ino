#include <NewPing.h>
#include <NewTone.h>

#define TRIGGER_PIN  12   // 輸出
#define ECHO_PIN     11   // 輸入
#define MAX_DISTANCE 200

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);

int pin3=A3;  // LED_red
int pin4=A4;  // LED_yellow
int pin5=A5;  // LED_green

int beforeMove=0; //Debounce誤差 
int newdate=0; // map轉換
int value;

void setup()
{
  Serial.begin(9600);   
  pinMode(pin3, OUTPUT);
  pinMode(pin4, OUTPUT);
  pinMode(pin5, OUTPUT);
}

void loop()
{
  delay(200);
  
  int uS = sonar.ping();
  newdate=map(uS,0,1023,0,25); 
//  Serial.print("Ping: ");
//  Serial.println( sonar.convert_cm(uS) ); //將回應時間 (微秒) 轉成距離 (公分)  
//  Serial.println( newdate ); 

//  int getPing=sonar.convert_cm(uS);
  int getPing=newdate;

//  LED燈號
  if( getPing > 1 && getPing <= 8 ) { 
    analogWrite(pin4, 255); 
    delay(100);
    analogWrite(pin4, 0);
  }else if( getPing > 8 && getPing <= 25 ) { 
    analogWrite(pin3, 255); 
    delay(100);
    analogWrite(pin3, 0);   
  }else if( getPing > 25 && getPing <= 45 ) { 
    analogWrite(pin5, 255); 
    delay(100);
    analogWrite(pin5, 0);
  }
      
  if(getPing != beforeMove) delay(50); 

  if(getPing > 1 && getPing <= 8) value=4;
  else if(getPing > 8 && getPing <= 25) value=3;
  else if(getPing > 25 && getPing <= 40) value=0;
//  else if(getPing > 31 && getPing <= 40) value=3;
  else value=66666666;
    
  Serial.write(value);
}       
