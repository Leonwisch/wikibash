#!/bin/bash

echo "Willkommen zur Wikipedia-Artikel-Suche von Leon und Damiano!"
echo "Bitte geben Sie einen Suchbegriff ein:"
read suchbegriff
echo "Bitte geben Sie die Sprache ein (z. B. de für Deutsch, en für Englisch, fr für Französisch):"
read sprache

suchbegriffganz=$(echo "$suchbegriff" | sed 's/ /%20/g')

api_url="https://$sprache.wikipedia.org/w/api.php?action=query&format=json&prop=extracts&explaintext&titles=$suchbegriffganz"
antwort=$(curl -s "$api_url")

text=$(echo "$antwort" | jq '.query.pages[].extract')

if [ -z "$text" ]; then
    echo "Keine Ergebnisse gefunden."
    exit 1
fi

echo -e "Artikelinhalt:\n$text"
echo "Möchten Sie diesen Artikel speichern? (j/n)"
read speichern

if [ "$speichern" == "j" ]; then
    ordner="Wikiartikel"
    if [ ! -d "$ordner" ]; then
        mkdir "$ordner"
        echo "Ordner '$ordner' wurde erstellt."
    fi
    file_name="$ordner/$(echo "$suchbegriff" | sed 's/%20/ /g').txt"
    echo -e "$text" > "$file_name"
    echo "Der Artikel wurde unter '$file_name' gespeichert."
else
    echo "Der Artikel wurde nicht gespeichert."
fi
