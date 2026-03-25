// Make image figures span both columns
#show figure.where(kind: "quarto-float-fig"): set block(breakable: false)
#show figure.where(kind: "quarto-float-fig"): fig => place(top + center, scope: "parent", float: true, fig)

// Make table figures breakable across pages and span full page width.
// Switches to single-column layout for the table pages, then back to
// two columns. Requires the custom typst-template.typ that uses
// set page(columns:) instead of columns() container.
#show figure.where(kind: "quarto-float-tbl"): fig => {
  pagebreak(weak: true)
  set page(columns: 1)
  set block(breakable: true)
  fig
}
