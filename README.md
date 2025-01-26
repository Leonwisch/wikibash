## WikiBash

WikiBash ist ein Bash-Skript, das es ermöglicht, Wikipedia-Artikel direkt über das Terminal abzurufen und optional zu speichern. Das Skript unterstützt die Auswahl zwischen einer detaillierten und einer zusammengefassten Ansicht des Artikels sowie die Auswahl der Sprache (Deutsch oder Englisch).

Diese Erklärung sollte dir beim Lesen unseres README helfen, die Funktionen und das Hauptziel von diesem Skripts zu verstehen.

### Funktionen

1. **Auswahl der Artikelansicht**:
    - Der Benutzer wird aufgefordert, eine Auswahl zu treffen:
        - `G` für die detaillierte Ansicht des Artikels.
        - `Z` für eine zusammengefasste Ansicht des Artikels.
    - Bei ungültiger Auswahl wird eine Fehlermeldung ausgegeben und das Skript beendet.

2. **Auswahl der Sprache**:
    - Der Benutzer kann auswählen, ob der Artikel in Deutsch (`de`) oder Englisch (`en`) abgerufen werden soll.

3. **Abrufen des Artikels**:
    - Basierend auf der Auswahl wird die entsprechende API-URL formatiert und eine HTTP-Anfrage an die Wikipedia-API gesendet.
    - Wenn die Anfrage fehlschlägt, wird eine Fehlermeldung ausgegeben und das Skript beendet.

4. **Verarbeiten der API-Antwort**:
    - Der relevante Text des Artikels wird aus der API-Antwort extrahiert.
    - Wenn kein Text gefunden wird oder der Text `null` ist, wird eine Fehlermeldung ausgegeben und das Skript beendet.

5. **Anzeigen des Artikels**:
    - Der extrahierte Artikeltext wird im Terminal angezeigt.

6. **Speichern des Artikels**:
    - Der Benutzer wird gefragt, ob der Artikel gespeichert werden soll.
    - Wenn der Benutzer `j` (ja) eingibt:
        - Es wird überprüft, ob das Standardverzeichnis existiert, und gegebenenfalls erstellt.
        - Der Artikel wird in einer Datei gespeichert, deren Name aus dem Suchbegriff generiert wird.
        - Eine Bestätigungsmeldung wird ausgegeben.
    - Wenn der Benutzer `n` (nein) eingibt, wird dieser Artikel nicht Gespeichert.

### Erklärungen zu verwendeten Befehlen

# sed 's/ /%20/g'
- Bedeutung: Ersetzt alle Leerzeichen ( ) in einem Text durch %20. Dies ist häufig notwendig, um Leerzeichen in URLs zu kodieren.

# [ $? -ne 0 ]
- Bedeutung: Überprüft, ob der vorherige Befehl fehlerhaft war.

# text=$(echo "$antwort" | jq -r '.query.pages[].extract')
- Bedeutung: Extrahiert den Wert eines JSON-Schlüssels und speichert ihn in der Variable text.

# [ "$auswahl" = "G" ]
- Bedeutung: Überprüft, ob die Variable 'auswahl' den Wert 'G' hat.

# [ -z "$text" ] || [ "$text" == "null" ]
- Bedeutung: Überprüft, ob die Variable 'text' leer oder gleich 'null' ist.

# echo -e "Artikelinhalt:\n$text"
- Bedeutung: Gibt den Inhalt der Variable 'text' mit einem Zeilenumbruch nach "Artikelinhalt:" aus.

# read speichern
- Bedeutung: Liest die Benutzereingabe und speichert sie in der Variable 'speichern'.

# [ "$speichern" == "j" ]
- Bedeutung: Überprüft, ob die Variable 'speichern' den Wert 'j' hat.

# [ ! -d "$default_ordner" ]
- Bedeutung: Überprüft, ob das Verzeichnis, das in der Variable 'default_ordner' gespeichert ist, nicht existiert.

# mkdir "$default_ordner"
- Bedeutung: Erstellt ein Verzeichnis mit dem Namen, der in der Variable 'default_ordner' gespeichert ist.

# file_name="$default_ordner/$(echo "$suchbegriff" | sed 's/ /_/g').txt"
- Bedeutung: Erstellt einen Dateinamen, indem es den Suchbegriff nimmt, alle Leerzeichen durch Unterstriche ersetzt und die Endung '.txt' hinzufügt.

# echo -e "$text" > "$file_name"
- Bedeutung: Schreibt den Inhalt der Variable 'text' in die Datei, deren Name in der Variable 'file_name' gespeichert ist.

# elif [ "$auswahl" = "Z" ]; then
- Bedeutung: Überprüft, ob die Variable 'auswahl' den Wert 'Z' hat und führt den folgenden Block aus, wenn dies der Fall ist.

# api_url=$(printf "$base_url_summary" "$sprache" "$suchbegriffganz")
- Bedeutung: Formatiert die URL für die API-Anfrage, indem die Basis-URL, die Sprache und der vollständige Suchbegriff eingefügt werden.

# antwort=$(curl -s "$api_url")
- Bedeutung: Führt eine stille (keine Ausgabe) HTTP-Anfrage an die API-URL aus und speichert die Antwort in der Variable 'antwort'.
