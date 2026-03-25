#show raw.where(block: false): it => {
  show ".": "." + sym.zws
  show "_": "_" + sym.zws
  show "(": sym.zws + "("
  show ")": ")" + sym.zws
  it
}
