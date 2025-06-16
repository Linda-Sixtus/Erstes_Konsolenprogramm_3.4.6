
import "dart:io";
import "dart:math";
void main (){

/** Konsolenprogramm zum Zahlenraten. zwischen (1 und 1000)
 * mvp: Zahlen werden zufällig generiert und man kann die Zahl eingeben welche man vermutet.
 *      Bei falschem Wert gibt es den Hinweis, ob zu hoch oder zu  niedrig.
 *      Anzahl der Verduche wird bei richtiger Eingabe ausgegeben.
 */

Random randomizer = new Random ();
String input;
int? number;
int maxCounter = 20;
int counter = 0;
int memorizer = randomizer.nextInt(999)+1;

while( counter <= maxCounter){



  print ("Rate eine Zahl zwischen 1 und 1000.(Noch ${maxCounter-counter} Versuche..)");

  input = stdin.readLineSync()?? "";
  number = int.tryParse(input);
  counter++;
  if (number != null){
    if (number > memorizer){
      print ("Der Wert $number ist zu hoch..");
    }
    else if (number < memorizer){
      print("Der Wert $number ist zu niedrig..");
    }
    else {
      print("Richtig geraten! Du hast $counter Versuche gebraucht.");
    }
  }
 else{
  print("Das ist keine Zahl. Versuch vergeudet...");
 }
}
}