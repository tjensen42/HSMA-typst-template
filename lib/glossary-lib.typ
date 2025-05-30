#import "shared-lib.typ": display, display-link

#let prefix = "glossary-state-"
#let glossary-state = state("glossary", none)

#let init-glossary(glossary) = {
  glossary-state.update(glossary)
}

#let gls(element, link: true) = {
  display("glossary", glossary-state, element, element, link: link)
}

// Print an index of all the acronyms and their definitions.
#let print-glossary(glossary-spacing) = {
  let glossary = glossary-state.get()
  let glossary-keys = glossary.keys()

  let max-width = 0pt
  for key in glossary-keys {
    let result = measure(key).width

    if (result > max-width) {
      max-width = result
    }
  }

  let glossary-list = glossary-keys.sorted()

  for element in glossary-list {
    grid(
      columns: (max-width + 1em, auto),
      gutter: glossary-spacing,
      [*#element#label("glossary-" + element)*], [#glossary.at(element)],
    )
  }
}
