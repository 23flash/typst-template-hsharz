# HS-Harz-Vorlage (Typst)

Layout für Hausarbeiten der Hochschule Harz: Titelblatt, Kopf- und Fußzeile, Inhaltsverzeichnis,
Quellen-, Abbildungs-, Tabellen- und Codeverzeichnis, Glossar.

```
template.typ           # Layout: Funktionen hausarbeit(…), author(…)
main.typ               # Beispieldokument mit Glossar, Zitaten, Tabelle, Code, Abbildung
glossary-entries.typ   # Glossareinträge (Beispiel)
quellen.bib            # Quellen (Beispiel)
images/hs-harz-logo.png
fonts/README.md        # wohin die Helvetica-Neue-Dateien gehören
```

Beispiel bauen: `typst compile --font-path fonts main.typ`

## Verwendung

```typst
#import "../../h-folien/template.typ": hausarbeit, author   // Pfad relativ zum eigenen Dokument
#import "@preview/glossarium:0.5.6": gls
#import "glossary-entries.typ": entry-list

#show: hausarbeit.with(
  title: "Titel",
  authors: ("Max Mustermann (m100001)", "Erika Musterfrau (m100002)"),
  subtitle: [Untertitel],
  semester: "Wintersemester 26/27",
  module: "Web-Services",
  glossary: entry-list,
  bibliography: bibliography("quellen.bib"),
)

= Einleitung
#author("Max Mustermann", "Erika Musterfrau")
…
```


Pakete (`codly`, `codly-languages`, `glossarium`) lädt Typst beim ersten Kompilieren aus der Typst-Registry.

# Gute Noten Counter
3x 1.0
2x 2.3
