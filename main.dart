import "dart:io";
import "dart:math";

void main() {
  /** Konsolenprogramm zum Zahlenraten. zwischen (1 und 1000)
   * mvp: Zahlen werden zufällig generiert und man kann die Zahl eingeben welche man vermutet.
   *      Bei falschem Wert gibt es den Hinweis, ob zu hoch oder zu niedrig.
   *      Anzahl der Verduche wird bei richtiger Eingabe ausgegeben.
   */

  //Initialisierung der Variablen:
  int? playerCount = null;
  Random randomizer = Random();
  String input;
  int? number;
  int maxCounter = 10;
  List<int> counter = [];
  int memorizer = 0;
  List<int> lives = []; // *
  bool gameRunning = true;
  List<String> pNames = [];
  int currentPlayer = 0;


  while (playerCount == null) {
    print("Wie viele Spieler spielen mit (1-13)?");
    input = stdin.readLineSync() ?? "";
    playerCount = int.tryParse(input);
    if (playerCount == null || playerCount < 1 || playerCount > 13) {
      print("UNGÜLTIGE EINGABE..");
      playerCount = null;
    }
  }

  // Schleife geht Anzahl der Spieler durch und wenn Wert eingegeben, kommt die Aufforderung den Namen einzugeben.
  for (int i = 1; i <= playerCount; i++) {
    counter.add(0);
    lives.add(3);
    print("Spieler $i: Gebe deinen Namen ein.");
    input = stdin.readLineSync() ?? "Spieler $i";
    pNames.add(input);
  }

  while (gameRunning) {
    //lives = 3;
    /**
   * Hier beginnt der Game Lifecycle wenn noch leben übrig sind:
   */

    print("${pNames[currentPlayer]}, Du bist dran!");

    while (lives[currentPlayer] > 0) {
      counter[currentPlayer] = 0;

      memorizer = randomizer.nextInt(999) + 1; // zufallszahl zw. 1 und 1000

      while (counter[currentPlayer] <= maxCounter) {
        if (counter[currentPlayer] == maxCounter) {
          print(
            "Deine Wahl war... schlecht.. Du hast verkackt. Die Zahl war $memorizer...",
          );

          print("\x07"); // BEL Code (BEEP)
          lives[currentPlayer]--;
          break;
        }

        print(
          "Rate eine Zahl zwischen 1 und 1000.(Noch ${maxCounter - counter[currentPlayer]} Versuche..)",
        );
        print("Du hast noch ${lives[currentPlayer]} Leben.");
        input = stdin.readLineSync() ?? "";
        number = int.tryParse(input);
        counter[currentPlayer]++;

        if (number != null) {
          if (number > memorizer) {
            print("Der Wert $number ist zu hoch..");
          } else if (number < memorizer) {
            print("Der Wert $number ist zu niedrig..");
          } else {
            print(
              "Richtig geraten! Du hast ${counter[currentPlayer]} Versuch(e) gebraucht.",
            );
            if (counter[currentPlayer] <= 5) {
              lives[currentPlayer]++;
              print("Yaaay! Du hast ein EXTRALEBEN erspielt!");
            }
            break;
          }
        } else {
          print("Das ist keine Zahl. Versuch vergeudet...");
        }
      }
      // Nächster Spieler ist dran
      currentPlayer = (currentPlayer++) % playerCount;
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
