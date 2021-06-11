#include <Tone.h>

String s, dedo;
char modo;

Tone tonoIndice, tonoCorazon, tonoAnular, tonoMenique;

void setup()
{
  pinMode(3, OUTPUT);pinMode(5, OUTPUT);pinMode(6, OUTPUT);pinMode(9, OUTPUT);      // Fija los pines 3,5,6,9 como salida.
  
  Serial.begin(9600); // Start serial communication at 9600 bps
  tonoIndice.begin(3);
  tonoCorazon.begin(5);
  tonoAnular.begin(6);
  tonoMenique.begin(9);
}

void loop()
{
  while(Serial.available()) { // If data is available to read,
    s = Serial.readStringUntil('\n'); // read it and store it in val
    int dedo = s.substring(0, s.indexOf(',')).toInt();
    float tono = s.substring(s.indexOf(',')+1).toFloat();
    
    if (dedo == 2) {
      tonoIndice.play(tono);
    } else if (dedo == 3) {
      tonoCorazon.play(tono);
    } else if (dedo == 4) {
      tonoAnular.play(tono);
    } else if (dedo == 5) {
      tonoMenique.play(tono);
    }
  }
}
