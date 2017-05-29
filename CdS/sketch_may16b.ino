void setup() {
  Serial.begin(9600);
}
 
void loop() {
 
  Serial.write("s");        //Start Bit
   
  int sensor_1 = analogRead(A0);         
  Serial.write("a"); 
  Serial.write(lowByte(sensor_1));  
  Serial.write(highByte(sensor_1)); 
}

