# wikibash

# sed 's/ /%20/g'
- Bedeutung: Ersetzt alle Leerzeichen ( ) in einem Text durch %20. Dies ist häufig notwendig,    um Leerzeichen in URLs zu kodieren.

# [ $? -ne 0 ]
- Bedeutung: Überprüft, ob der vorherige Befehl fehlerhaft war.


# text=$(echo "$antwort" | jq -r '.query.pages[].extract')
- Bedeutung: Extrahiert den Wert eines JSON-Schlüssels und speichert ihn in der Variable text.
