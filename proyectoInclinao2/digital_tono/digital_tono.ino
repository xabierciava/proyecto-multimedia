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
    int puerto = s.substring(0, s.indexOf(',')).toInt();
    float tono = s.substring(s.indexOf(',')+3).toFloat();
    if (puerto == 3) {
      tonoIndice.play(NOTE_B3);
    } else if (puerto == 5) {
      tonoCorazon.play(NOTE_B3);
    } else if (puerto == 6) {
      tonoAnular.play(NOTE_B3);
    } else if (puerto == 9) {
      tonoMenique.play(NOTE_B3);
    }
    
  }
}
