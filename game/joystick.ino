const u8 SW = 2; //Switch PIN
const u8 X = 0;  //X축 PIN
const u8 Y = 1;  //Y축 PIN
 
void setup() {
  //스위치 포트 입력 및 풀업 셋팅
  pinMode(SW, INPUT);   
  digitalWrite(SW, HIGH);

  //모니터 프로그램 셋팅
  Serial.begin(9600);
}
 
void loop() {
// 스위치가 눌리면 Push
// 떨어지면 Pull
  int p;
  if (digitalRead(SW))
    p = 10;
  else 
    p = 20;
  Serial.print(",");
  Serial.print(p);
  Serial.print(",");

// X축 읽어오기 
//  Serial.print("X : "); 
  int x = map(analogRead(X), 0, 1023, 0, 200);
  Serial.print(x);
  Serial.print(",");
  
// Y축 읽어오기
//  Serial.print("Y : ");
  int y = map(analogRead(Y), 0, 1023, 320, 400);
  Serial.print(y);
  Serial.println(".");
  
//  delay();
}

