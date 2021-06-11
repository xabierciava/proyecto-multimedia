String s, dedo;
char modo;

void setup()
{
  pinMode(3, OUTPUT);      // Fija el pin 3 como salida.
  Serial.begin(9600); // Start serial communication at 9600 bps
}

void loop()
{
  while(Serial.available()) { // If data is available to read,
    s = Serial.readStringUntil('\n'); // read it and store it in val
    String dedo = s.substring(0, s.indexOf(','));
    if (dedo == "I") {
      int puerto = s.substring(s.indexOf(',')+1, s.indexOf(',')+3).toInt();
      float tono = s.substring(s.indexOf(',')+3).toFloat();
      tone(puerto, tono);
    } else if (dedo == "C") {
      int puerto = s.substring(s.indexOf(',')+1, s.indexOf(',')+3).toInt();
      float valor = s.substring(s.indexOf(',')+3).toFloat();
      analogWrite(puerto, valor);
    }
    
  }
}
