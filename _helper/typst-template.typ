
#let orcid-icon = {
  box(
    height: 0.9em,
    baseline: 0.05em,
    image("/_helper/ORCiD.svg"),
  )
}

#let content-to-string(val) = {
  if val == none { return "" }
  if type(val) == str { return val }
  if val.has("text") { return val.text }
  if val.has("children") {
    let result = val.children.map(content-to-string).join("")
    return if result == none { "" } else { result }
  }
  if val.has("body") { return content-to-string(val.body) }
  return ""
}

#let format-author(author) = {
  let orcid-val = author.at("orcid", default: none)
  let orcid-str = content-to-string(orcid-val).trim()
  align(center)[
    #author.name \
    #if orcid-str != "" [
      #link("https://orcid.org/" + orcid-str)[#orcid-icon #orcid-str]
    ] \
    #author.affiliation \
    #author.email
  ]
}

#let article(
  title: none,
  subtitle: none,
  authors: none,
  date: none,
  abstract: none,
  abstract-title: none,
  cols: 1,
  lang: "en",
  region: "US",
  font: "libertinus serif",
  fontsize: 11pt,
  title-size: 1.5em,
  subtitle-size: 1.25em,
  heading-family: "libertinus serif",
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)
  set page(
    margin: (x: 1in, top: 1in, bottom: 1in),
    footer: context {
    block(width: 100%, stroke: (top: 0.5pt + gray), inset: (top: 4pt))[
      #set text(size: 0.75em, fill: gray)
      #grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [#date],
        counter(page).display(),
      )
    ]
  })

  if cols > 1 {
    set page(columns: cols)

    let header = {
      if title != none {
        align(center)[#block(inset: 2em)[
          #set par(leading: heading-line-height)
          #if (heading-family != none or heading-weight != "bold" or heading-style != "normal"
               or heading-color != black) {
            set text(font: heading-family, weight: heading-weight, style: heading-style, fill: heading-color)
            text(size: title-size)[#title]
            if subtitle != none {
              parbreak()
              text(size: subtitle-size)[#subtitle]
            }
          } else {
            text(weight: "bold", size: title-size)[#title]
            if subtitle != none {
              parbreak()
              text(weight: "bold", size: subtitle-size)[#subtitle]
            }
          }
        ]]
      }

      if authors != none {
        let count = authors.len()
        let ncols = calc.min(count, 3)
        grid(
          columns: (1fr,) * ncols,
          row-gutter: 1.5em,
          ..authors.map(author => format-author(author))
        )
      }

      if date != none {
        align(center)[#block(inset: 1em)[
          #date
        ]]
      }

      if abstract != none {
        block(inset: 2em)[
        #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
        ]
      }

      if toc {
        let title = if toc_title == none {
          auto
        } else {
          toc_title
        }
        block(above: 0em, below: 2em)[
        #outline(
          title: toc_title,
          depth: toc_depth,
          indent: toc_indent
        );
        ]
      }
    }

    place(top + center, scope: "parent", float: true, block(width: 100%, header))
    doc
  } else {
    if title != none {
      align(center)[#block(inset: 2em)[
        #set par(leading: heading-line-height)
        #if (heading-family != none or heading-weight != "bold" or heading-style != "normal"
             or heading-color != black) {
          set text(font: heading-family, weight: heading-weight, style: heading-style, fill: heading-color)
          text(size: title-size)[#title]
          if subtitle != none {
            parbreak()
            text(size: subtitle-size)[#subtitle]
          }
        } else {
          text(weight: "bold", size: title-size)[#title]
          if subtitle != none {
            parbreak()
            text(weight: "bold", size: subtitle-size)[#subtitle]
          }
        }
      ]]
    }

    if authors != none {
      let count = authors.len()
      let ncols = calc.min(count, 3)
      grid(
        columns: (1fr,) * ncols,
        row-gutter: 1.5em,
        ..authors.map(author => format-author(author))
      )
    }

    if date != none {
      align(center)[#block(inset: 1em)[
        #date
      ]]
    }

    if abstract != none {
      block(inset: 2em)[
      #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
      ]
    }

    if toc {
      let title = if toc_title == none {
        auto
      } else {
        toc_title
      }
      block(above: 0em, below: 2em)[
      #outline(
        title: toc_title,
        depth: toc_depth,
        indent: toc_indent
      );
      ]
    }

    doc
  }
}

#set table(
  inset: 6pt,
  stroke: none
)
