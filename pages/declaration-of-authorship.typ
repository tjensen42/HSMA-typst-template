#import "../template.typ": authors, date

#heading(outlined: false, "Selbstständigkeitserklärung")

#v(1em)

Hiermit erkläre ich, dass ich die vorliegende Arbeit selbstständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe.

#v(1em)

#text("Mannheim, " + date.display("[day].[month].[year]"))


#align(left, image("../assets/unterschrift.png", height: 1cm))


#for author in authors [
  #align(left, text(author))
]

#pagebreak(weak: true)
