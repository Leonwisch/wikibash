#!/bin/bash

default_ordner="Wikiartikel"
base_url_query="https://%s.wikipedia.org/w/api.php?action=query&format=json&prop=extracts&explaintext&titles=%s"
base_url_summary="https://%s.wikipedia.org/api/rest_v1/page/summary/%s"

echo "Willkommen zur Wikipedia-Artikel-Suche von Leon und Damiano!"

while true; do
    echo "Bitte geben Sie einen Suchbegriff ein:"
    read suchbegriff
    if [ -n "$suchbegriff" ]; then
        break
    else
        echo "Der Suchbegriff darf nicht leer sein. Bitte erneut versuchen."
    fi
done

echo "Bitte wählen Sie die Sprache (z.B. 'de' für Deutsch, 'en' für Englisch):"
read sprache

echo "Möchten Sie den ganzen Artikel oder nur die Zusammenfassung? (G für ganzen Artikel, Z für Zusammenfassung):"
read auswahl

suchbegriffganz=$(echo "$suchbegriff" | sed 's/ /_/g')

if [ "$auswahl" = "G" ]; then
    api_url=$(printf "$base_url_query" "$sprache" "$suchbegriffganz")
elif [ "$auswahl" = "Z" ]; then
    api_url=$(printf "$base_url_summary" "$sprache" "$suchbegriffganz")
else
    echo "Ungültige Auswahl. Bitte 'G' oder 'Z' eingeben."
    exit 1
fi

antwort=$(curl -s "$api_url")
if [ $? -ne 0 ]; then
    echo "Fehler beim Abrufen der Daten. Bitte überprüfen Sie Ihre Internetverbindung."
    exit 1
fi

if [ "$auswahl" = "G" ]; then
    text=$(echo "$antwort" | jq -r '.query.pages[].extract')
else
    text=$(echo "$antwort" | jq -r '.extract')
fi

if [ -z "$text" ] || [ "$text" == "null" ]; then
    echo "Keine Ergebnisse gefunden."
    exit 1
fi

echo -e "Artikelinhalt:\n$text"

echo "Möchten Sie diesen Artikel speichern? (j/n)"
read speichern

if [ "$speichern" == "j" ]; then
    if [ ! -d "$default_ordner" ]; then
        mkdir "$default_ordner"
    fi
    file_name="$default_ordner/$(echo "$suchbegriff" | sed 's/ /_/g').txt"
    echo -e "$text" > "$file_name"
    echo "Der Artikel wurde unter '$file_name' gespeichert."
else
    echo "Der Artikel wurde nicht gespeichert."
fi
