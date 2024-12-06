#import "../template.typ": *

#let titelpage-font-size = 14pt
#set text(size: titelpage-font-size)

#set image(height: 2.2cm)
#align(left, image("../assets/logo_hochschule_mannheim_farbe.svg"))

#v(4em)

#align(center,
  box(width: 85%,
    par(justify: false, linebreaks: "optimized",
      text(weight: "bold", font: heading-font, size: 18pt, hyphenate: false)[
        #title
      ]
    )
  )
)

#v(3.5em)

#align(center, text(weight: "semibold", author))

#v(3em)

#align(center)[
  #par(leading: 0.8em)[
    Bachelor-Thesis \
    zur Erlangung des akademischen Grades Bachelor of Science (B.Sc.) \
    Studiengang Informatik
  ]
]


#v(3em)

#align(center)[
  #par(leading: 0.8em)[
    Fakultät für Informatik \
    Hochschule Mannheim
  ]
]

#v(2em)

#align(center, date.display("[day].[month].[year]"))


#v(2em)

#align(bottom + center)[
  #par(leading: 0.8em)[
    #text(weight: "semibold", "Betreuer") \
    Prof. Peter Mustermann, Hochschule Mannheim \
    Erika Mustermann, Paukenschlag GmbH
  ]
]

#pagebreak(weak: true)
