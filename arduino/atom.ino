void setup() {
  Serial.begin(9600);
  //baud_rate should be same as the baud_rate mentioned in client1.rb
 
  //Set pin 13 to be output pin (connect LED here)
  pinMode(13, OUTPUT);

  digitalWrite(13,LOW); //set it off
  
  
}
 



 
//this function is called when we get a character
//over USB/Serial
void got_char(char x) {
 
  //if we get b over Serial and so on 
  if(x == 'b') {
    //... blink the LED
    digitalWrite(13,HIGH);
   
  }
  
}
 
void loop() {
  //check if there's any data available on serial
  if(Serial.available() > 0) {
    //if there is, we read it
    byte byte_read = Serial.read();
 
    //and call "got_char"
    got_char((char)byte_read);
  }
}
