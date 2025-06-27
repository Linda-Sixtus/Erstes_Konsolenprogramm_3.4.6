import "dart:io";
import "dart:math";

void main() {
  /** Konsolenprogramm zum Zahlenraten. zwischen (1 und 1000)
   * mvp: Zahlen werden zufällig generiert und man kann die Zahl eingeben welche man vermutet.
   *      Bei falschem Wert gibt es den Hinweis, ob zu hoch oder zu  niedrig.
   *      Anzahl der Verduche wird bei richtiger Eingabe ausgegeben.
   * 
   * ----------------------------------------------------------------------------------------------------
   * 
   * HasWinner soll rein playerClass und viel in Methoden auslagern.....
   */

  Random randomizer = new Random();
  String input;
  int? number;
  int maxCounter = 10;
  int counter = 0;
  int memorizer = 0;
  int lives = 3;
  bool gameRunning = true;
  /*
Ideen für Multiplayer:

List<int> lives = [3,3];

int player = 0;
int playerCount = 2;

lives[player];
player =  (player + 1) % 2;
*/
  while (gameRunning) {
    lives = 3;
    /**
   * Hier beginnt der Game Lifecycle wenn noch leben übrig sind:
   */
    while (lives > 0) {
      counter = 0;

      memorizer = randomizer.nextInt(999) + 1; // zufallszahl zw. 1 und 1000

      while (counter <= maxCounter) {
        if (counter == maxCounter) {
          print(
            "Deine Wahl war... schlecht.. Du hast verkackt. Die Zahl war $memorizer...",
          );

          print("\x07"); // BEL Code (BEEP)
          lives--;
          break;
        }

        print(
          "Rate eine Zahl zwischen 1 und 1000.(Noch ${maxCounter - counter} Versuche..)",
        );
        print("Du hast noch $lives Leben.");
        input = stdin.readLineSync() ?? "";
        number = int.tryParse(input);
        counter++;

        if (number != null) {
          if (number > memorizer) {
            print("Der Wert $number ist zu hoch..");
          } else if (number < memorizer) {
            print("Der Wert $number ist zu niedrig..");
          } else {
            print("Richtig geraten! Du hast $counter Versuche gebraucht.");
            if (counter <= 5) {
              lives++;
              print("Yaaay! Du hast ein EXTRALEBEN erspielt!");
            }
            break;
          }
        } else {
          print("Das ist keine Zahl. Versuch vergeudet...");
        }
      }
    }
    print("GAME OVER!");

    print("Willst Du weglaufen (J/N)?");
    input = stdin.readLineSync() ?? "";
    if (input.toLowerCase().startsWith("j")) {
      print("Ok, bis dann. Feigling..");
      gameRunning = false;
    }
  }
}
