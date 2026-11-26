#import "template.typ": hausarbeit, author
#import "@preview/glossarium:0.5.6": gls
#import "glossary-entries.typ": entry-list

#show: hausarbeit.with(
  title: "Titel der Arbeit",
  authors: ("Max Mustermann (m100001)", "Erika Musterfrau (m100002)"),
  subtitle: [Untertitel:\ Konzeption und Implementierung],
  semester: "Wintersemester 26/27",
  module: "Web-Services",
  glossary: entry-list,
  bibliography: bibliography("quellen.bib"),
)

= Einleitung
#author("Max Mustermann", "Erika Musterfrau")

`#author("Name")` unter einer Überschrift trägt den Abschnitt in die Tabelle „Arbeitsteilung“ ein;
der Name muss wie in `authors` (ohne Matrikelnummer) geschrieben sein.

== Motivation
#author("Max Mustermann")

Abkürzungen kommen ins Glossar und werden mit `#gls("key")` verwendet: Beim ersten Mal erscheint die
Langform, danach die Kurzform, etwa #gls("kiss") und erneut #gls("kiss"). Vor jeder Frage gilt #gls("rtfm").

Quellen stehen in `quellen.bib` und werden mit `@key` oder `#cite(<key>)` zitiert, z. B. Docker Compose
@docker_compose_2025 oder Git @git_documentation_2025.

== Zielsetzung
#author("Erika Musterfrau")

#figure(
  table(
    columns: (auto, 1fr),
    table.header[*Spalte*][*Inhalt*],
    [A], [Tabellen bekommen die Beschriftung oben und landen im Tabellenverzeichnis],
    [B], [Spaltenbreiten mit `auto` und `1fr` steuern],
  ),
  caption: [Beispieltabelle],
) <tab-beispiel>

#figure(
  ```yaml
  services:
    web:
      image: docker.io/library/nginx:1.27
  ```,
  caption: [Beispielcode],
) <lst-beispiel>

#figure(
  image("images/hs-harz-logo.png", width: 40%),
  caption: [Beispielabbildung],
) <fig-beispiel>

Verweise auf Tabelle, Code und Abbildung: @tab-beispiel, @lst-beispiel, @fig-beispiel.

= Hauptteil
#author("Max Mustermann", "Erika Musterfrau")

= Fazit
#author("Erika Musterfrau")
