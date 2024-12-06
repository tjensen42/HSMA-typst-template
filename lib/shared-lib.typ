#let is-in-dict(dict-type, state, element) = {
  state.display(list => {
    if element not in list {
      panic(element + " is not a key in the " + dict-type + " dictionary.")
      return false
    }
  })
  return true
}

#let display-link(dict-type, state, element, text) = {
  if is-in-dict(dict-type, state, element) {
    link(label(dict-type + "-" + element), text)
  }
}

#let display(dict-type, state, element, text, link: true) = {
  if link {
    display-link(dict-type, state, element, text)
  } else {
    text
  }
}

// Workaround for https://github.com/typst/typst/issues/2722
#let is-page-empty() = {
  let page-num = here().page()
  query(<empty-page-start>)
    .zip(query(<empty-page-end>))
    .any(((start, end)) => {
      (start.location().page() < page-num
        and page-num < end.location().page())
    })
}