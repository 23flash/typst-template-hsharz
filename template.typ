// Hausarbeit layout, Hochschule Harz. Usage: #show: hausarbeit.with(title: …, …)
#import "@preview/codly:1.3.0": codly, codly-init
#import "@preview/codly-languages:0.1.1": codly-languages
#import "@preview/glossarium:0.5.6": make-glossary, register-glossary, print-glossary

// First installed family wins. Helvetica Neue is licensed and not shipped: see fonts/README.md.
#let fonts = ("Helvetica Neue", "TeX Gyre Heros", "Liberation Sans", "Arial")
#let accent = rgb("#96BEB4")

// Marks who wrote a section. Place directly after the heading: #author("Name A", "Name B")
#let author(..names) = [#metadata(names.pos()) <author>]

// Table "section × author" from all #author marks. Names must match the part of `authors` before "(".
#let arbeitsteilung(authors) = context {
  let team = authors.map(a => a.split("(").at(0).trim())
  let elems = query(selector(heading).or(<author>))
  let rows = ()
  for (i, e) in elems.enumerate() {
    if e.func() != heading or i + 1 >= elems.len() or elems.at(i + 1).func() != metadata { continue }
    let number = if e.numbering != none { numbering(e.numbering, ..counter(heading).at(e.location())) }
    rows.push((level: e.level, label: [#number #e.body], names: elems.at(i + 1).value))
  }
  if rows.len() > 0 {
    heading[Arbeitsteilung]
    figure(
      table(
        columns: (1fr,) + (auto,) * team.len(),
        align: (left,) + (center,) * team.len(),
        table.header([*Abschnitt*], ..team.map(n => [*#n*])),
        ..rows.map(r => (pad(left: (r.level - 1) * 1.2em, r.label), ..team.map(n => if n in r.names [x]))).flatten(),
      ),
      caption: [Arbeitsteilung],
    )
  }
}

#let hausarbeit(
  title: "",
  authors: (),
  subtitle: "",
  semester: "",
  faculty: "FB Automatisierung und Informatik",
  module: "",
  logo: "images/hs-harz-logo.png",
  glossary: (),
  bibliography: none,
  body,
) = {
  set document(title: title)
  set text(lang: "de", font: fonts, size: 12pt)
  set par(justify: true)

  show: codly-init
  codly(languages: codly-languages, zebra-fill: none, number-format: none)
  show: make-glossary
  register-glossary(glossary)

  show figure: set block(breakable: true)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set block(breakable: false)
  show figure.where(kind: raw): set figure(supplement: [Code])
  set table(align: left, inset: (x: 5pt, y: 4pt))
  show table: set par(justify: false)
  show table: set text(size: 10.5pt)
  show raw.where(block: false): box.with(fill: luma(240), inset: (x: 2pt), outset: (y: 2pt), radius: 2pt)

  let logo-image(height) = image(logo, alt: "Hochschule Harz", height: height)

  // Title page
  page(fill: accent, footer-descent: 10%, footer: stack(dir: ltr, spacing: 4%,
    logo-image(30%),
    line(angle: 90deg, length: 100%),
    {
      set text(size: 10pt)
      [#semester: #title]
      parbreak()
      if authors.len() > 0 { authors.join(", "); parbreak() }
      [#faculty · Modul #module]
    },
  ))[
    #logo-image(8%)
    #align(center)[
      #v(2cm)
      #text(size: 34pt, weight: "bold", title)

      #text(size: 22pt, subtitle)
    ]
  ]

  set page(
    margin: (x: 2.5cm, y: 2.5cm),
    footer-descent: 5%,
    header: logo-image(50%),
    footer: grid(columns: (1fr, auto), align: (left, right + bottom),
      [#semester: #title \ #faculty],
      [Seite #context counter(page).display()],
    ),
  )
  counter(page).update(1)

  outline()
  pagebreak()

  set heading(numbering: "1.1")
  body

  set heading(numbering: none)
  pagebreak()
  if authors.len() > 0 { arbeitsteilung(authors) }
  if bibliography != none {
    set std.bibliography(title: "Quellenverzeichnis", full: true, style: "institute-of-electrical-and-electronics-engineers")
    bibliography
  }

  heading[Abbildungsverzeichnis]
  outline(target: figure.where(kind: image), title: none)
  heading[Tabellenverzeichnis]
  outline(target: figure.where(kind: table), title: none)
  heading[Codeverzeichnis]
  outline(target: figure.where(kind: raw), title: none)
  heading[Glossar]
  print-glossary(glossary, disable-back-references: true)
}
