#import "@preview/codelst:2.0.2": *
#import "package/acronym-lib.typ": init-acronyms, print-acronyms, acr, acrpl, acrs, acrspl, acrl, acrlpl, acrf, acrfpl
#import "package/glossary-lib.typ": init-glossary, print-glossary, gls
#import "package/locale.typ": TABLE_OF_CONTENTS, LIST_OF_FIGURES, LIST_OF_TABLES, CODE_SNIPPETS, APPENDIX, REFERENCES
#import "package/titelpage.typ": *
#import "package/confidentiality-statement.typ": *
#import "package/declaration-of-authorship.typ": *
#import "package/check-attributes.typ": *

// Workaround for the lack of an `std` scope.
#let std-bibliography = bibliography

#let hsma-thesis(
  title: none,
  authors: (:),
  language: none,
  at-university: none,
  confidentiality-marker: (display: false),
  type-of-thesis: none,
  type-of-degree: none,
  show-confidentiality-statement: true,
  show-declaration-of-authorship: true,
  show-table-of-contents: true,
  show-acronyms: true,
  show-list-of-figures: true,
  show-list-of-tables: true,
  show-code-snippets: true,
  show-abstract: true,
  numbering-alignment: center,
  toc-depth: 3,
  acronym-spacing: 5em,
  glossary-spacing: 1.5em,
  abstract: none,
  appendix: none,
  acronyms: none,
  glossary: none,
  header: none,
  confidentiality-statement-content: none,
  declaration-of-authorship-content: none,
  titelpage-content: none,
  university: none,
  university-location: none,
  university-short: none,
  city: none,
  supervisor: (:),
  date: none,
  date-format: "[day].[month].[year]",
  bibliography: none,
  bib-style: "ieee",
  heading-numbering: "1.1",
  math-numbering: "(1)",
  logo-left: image("template/assets/logo_hochschule_mannheim_farbe.svg"),
  logo-right: none,
  logo-size-ratio: "1:1",
  ignored-link-label-keys-for-highlighting: (),
  body-font = "Open Sans",
  heading-font = "Montserrat",
  body,
) = {
  // set the document's basic properties
  set document(title: title, author: authors.map(author => author.name))
  let many-authors = authors.len() > 3

  init-acronyms(acronyms)
  init-glossary(glossary)

  // define logo size with given ration
  let left-logo-height = 2.4cm // left logo is always 2.4cm high
  let right-logo-height = 2.4cm // right logo defaults to 1.2cm but is adjusted below
  let logo-ratio = logo-size-ratio.split(":")
  if (logo-ratio.len() == 2) {
    right-logo-height = right-logo-height * (float(logo-ratio.at(1)) / float(logo-ratio.at(0)))
  }

  // customize look of figure
  set figure.caption(separator: [ --- ], position: bottom)

  // set body font family
  set text(font: body-font, lang: language, 12pt)
  show heading: set text(weight: "semibold", font: heading-font)

  // heading numbering
  set heading(numbering: heading-numbering)

  // math numbering
  set math.equation(numbering: math-numbering)

  // set link style for links that are not acronyms
  let acronym-keys = if (acronyms != none) {
    acronyms.keys().map(acr => ("acronyms-" + acr))
  } else {
    ()
  }
  let glossary-keys = if (glossary != none) {
    glossary.keys().map(gls => ("glossary-" + gls))
  } else {
    ()
  }
  show link: it => if (str(it.dest) not in (acronym-keys + glossary-keys + ignored-link-label-keys-for-highlighting)) {
    text(fill: blue, it)
  } else {
    it
  }

  show heading.where(level: 1): it => {
    pagebreak()
    v(2em) + it + v(1em)
  }
  show heading.where(level: 2): it => v(1em) + it + v(0.5em)
  show heading.where(level: 3): it => v(0.5em) + it + v(0.25em)

  if (titelpage-content != none) {
    titelpage-content
  } else {
    titelpage(
      authors,
      date,
      heading-font,
      language,
      left-logo-height,
      logo-left,
      logo-right,
      many-authors,
      right-logo-height,
      supervisor,
      title,
      type-of-degree,
      type-of-thesis,
      university,
      university-location,
      at-university,
      date-format,
      show-confidentiality-statement,
      confidentiality-marker,
      university-short,
    )
  }

  // set header properties
  let display-header = if (header != none and ("display" in header)) {
    header.display
  } else {
    true
  }

  let header-content = if (header != none and ("content" in header)) {
    header.content
  } else {
    none
  }

  let show-header-chapter = if (header != none and ("show-chapter" in header)) {
    header.show-chapter
  } else {
    true
  }

  let show-header-left-logo = if (header != none and ("show-left-logo" in header)) {
    header.show-left-logo
  } else {
    true
  }

  let show-header-right-logo = if (header != none and ("show-right-logo" in header)) {
    header.show-right-logo
  } else {
    true
  }

  let show-header-divider = if (header != none and ("show-divider" in header)) {
    header.show-divider
  } else {
    true
  }

  set page(
    margin: (top: 8em, bottom: 8em),
    header: context {
      if (display-header) {
        if (header-content != none) {
          header.content
        } else {
          grid(
            columns: (1fr, auto),
            align: (left, right),
            gutter: 2em,
            if (show-header-chapter) {
              align(left + bottom)[
                #let headings = query(heading.where(level: 1))
                #if headings.len() > 0 and not headings.any(it => (it.location().page() == here().page())) {
                  let elems = query(
                    selector(heading.where(level: 1)).before(here()),
                  )

                  if (elems.len() > 0) {
                    let current-heading = elems.last()
                    let heading-counter = if current-heading.numbering == none {
                      none
                    } else {
                      counter(heading).get().first()
                    }

                    [#heading-counter #current-heading.body]
                  }
                } else {
                  let elems = query(
                    selector(heading.where(level: 1)).after(here()),
                  )

                  if (elems.len() > 0) {
                    let current-heading = elems.first()
                    let heading-counter = if current-heading.numbering == none {
                      none
                    } else {
                      counter(heading).get().first() + 1
                    }

                    [#heading-counter #current-heading.body]
                  }
                }
              ]
            },
            stack(
              dir: ltr,
              spacing: 1em,
              if (show-header-left-logo and logo-left != none) {
                set image(height: left-logo-height / 2)
                logo-left
              },
              if (show-header-right-logo and logo-right != none) {
                set image(height: right-logo-height / 2)
                logo-right
              },
            ),
          )
          v(-0.75em)
          if (show-header-divider) {
            line(length: 100%)
          }
        }
      }
    },
  )

  // set page numbering to roman numbering
  set page(
    numbering: "I",
    number-align: numbering-alignment,
  )
  counter(page).update(1)

  if (not at-university and show-confidentiality-statement) {
    pagebreak()
    confidentiality-statement(
      authors,
      title,
      confidentiality-statement-content,
      university,
      university-location,
      date,
      language,
      many-authors,
      date-format,
    )
  }

  if (show-declaration-of-authorship) {
    pagebreak()
    declaration-of-authorship(
      authors,
      title,
      declaration-of-authorship-content,
      date,
      language,
      many-authors,
      at-university,
      city,
      date-format,
    )
  }

  show outline.entry.where(level: 1): it => {
    v(18pt, weak: true)
    strong(it)
  }

  set par(justify: true, leading: 1em)

  if (show-abstract and abstract != none) {
    heading(level: 1, numbering: none, outlined: false)[Abstract]
    text(abstract)
  }

  set par(leading: 0.65em)

  if (show-table-of-contents) {
    outline(
      title: TABLE_OF_CONTENTS.at(language),
      indent: auto,
      depth: toc-depth,
    )
  }

  context {
    let elems = query(figure.where(kind: image))
    let count = elems.len()

    if (show-list-of-figures and count > 0) {
      outline(
        title: LIST_OF_FIGURES.at(language),
        target: figure.where(kind: image),
      )
    }
  }

  context {
    let elems = query(figure.where(kind: table))
    let count = elems.len()

    if (show-list-of-tables and count > 0) {
      outline(
        title: LIST_OF_TABLES.at(language),
        target: figure.where(kind: table),
      )
    }
  }

  context {
    let elems = query(figure.where(kind: raw))
    let count = elems.len()

    if (show-code-snippets and count > 0) {
      outline(
        title: CODE_SNIPPETS.at(language),
        target: figure.where(kind: raw),
      )
    }
  }

  if (show-acronyms and acronyms != none and acronyms.len() > 0) {
    print-acronyms(language, acronym-spacing)
  }

  if (glossary != none and glossary.len() > 0) {
    print-glossary(language, glossary-spacing)
  }

  set par(leading: 1em)
  set block(spacing: 2em)

  // reset page numbering and set to arabic numbering
  set page(
    numbering: "1",
    footer: context align(
      numbering-alignment,
      numbering(
        "1",
        ..counter(page).get(),
      ),
    ),
  )
  counter(page).update(1)

  body

  [#metadata(none)<end>]
  // reset page numbering and set to alphabetic numbering
  set page(
    numbering: "a",
    footer: context align(
      numbering-alignment,
      numbering(
        "a",
        ..counter(page).get(),
      ),
    ),
  )
  counter(page).update(1)

  // Display bibliography.
  if bibliography != none {
    set std-bibliography(
      title: REFERENCES.at(language),
      style: bib-style,
    )
    bibliography
  }

  if (appendix != none) {
    heading(level: 1, numbering: none)[#APPENDIX.at(language)]
    appendix
  }
}