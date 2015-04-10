ig.getData = ->
  kraje = d3.tsv.parse ig.data.stats, (row) ->
    for field, value of row
      continue if field in <[kod nazev]>
      row[field] = parseFloat value
    row
  kraje_assoc = {}

  for kraj in kraje
    kraje_assoc[kraj.kod] = kraj

  metrics = for field, value of kraje.0
    continue if field in <[kod nazev]>
    field
  {kraje, kraje_assoc, metrics}
