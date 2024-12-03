#import "../lib.typ": *
#import "acronyms.typ": acronyms
#import "glossary.typ": glossary
#import "abstract.typ": abstract

#show: hsma-thesis.with(
  title: "Exploration of Typst for the Composition of a University Thesis",
  authors: (
    (name: "Max Mustermann", student-id: "7654321", course: "TIS21", course-of-studies: "Informatik", company: (
      (name: "YXZ GmbH", post-code: "70435", city: "Stuttgart")
    )),
    // (name: "Juan Pérez", student-id: "1234567", course: "TIM21", course-of-studies: "Mobile Computer Science", company: (
    //   (name: "ABC S.L.", post-code: "08005", city: "Barcelona", country: "Spain")
    // )),
  ),
  at-university: false, // if true the company name on the title page and the confidentiality statement are hidden
  acronyms: acronyms, // displays the acronyms defined in the acronyms dictionary
  glossary: glossary, // displays the glossary terms defined in the glossary dictionary
  bibliography: bibliography("sources.bib"),
  date: datetime.today(),
  language: "de", // en, de
  supervisor: (company: "John Appleseed"),
  university: "Hochschule Mannheim",
  university-location: "Baden-Württemberg",
  university-short: "HSMA",
  confidentiality-marker: (display: false),
  show-confidentiality-statement: false,
  show-abstract: true,
  abstract: abstract,
  header: (show-right-logo: false, show-left-logo: false)
  // for more options check the package documentation (https://typst.app/universe/package/supercharged-dhbw)
)

= Introduction

#lorem(100)

#lorem(100)

#lorem(100)

= Examples

#lorem(30)

== Acronyms

Use the `acr` function to insert acronyms, which looks like this #acr("HTTP").

#acrlpl("API") are used to define the interaction between different software systems.

#acrs("REST") is an architectural style for networked applications.

== Glossary

Use the `gls` function to insert glossary terms, which looks like this:

A #gls("Vulnerability") is a weakness in a system that can be exploited.

== Lists

Create bullet lists or numbered lists.

- This
- is a
- bullet list

+ It also
+ works with
+ numbered lists!

== Figures and Tables

Create figures or tables like this:

=== Figures

#figure(caption: "Image Example", image(width: 4cm, "assets/logo_hochschule_mannheim_farbe.svg"))

=== Tables

#figure(
  caption: "Table Example",
  table(
    columns: (1fr, 50%, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [],
      [*Area*],
      [*Parameters*],
    ),

    text("cylinder.svg"),
    $ pi h (D^2 - d^2) / 4 $,
    [
      $h$: height \
      $D$: outer radius \
      $d$: inner radius
    ],

    text("tetrahedron.svg"), $ sqrt(2) / 12 a^3 $, [$a$: edge length],
  ),
)<table>

== Code Snippets

Insert code snippets like this:

#figure(
  caption: "Codeblock Example",
  sourcecode[```ts
    const ReactComponent = () => {
      return (
        <div>
          <h1>Hello World</h1>
        </div>
      );
    };

    export default ReactComponent;
    ```],
)

#pagebreak()

== References

Cite like this #cite(form: "prose", <iso18004>).
Or like this @iso18004.

You can also reference by adding `<ref>` with the desired name after figures or headings.

For example this @table references the table on the previous page.

= Conclusion

#lorem(100)

#lorem(120)

#lorem(80)
