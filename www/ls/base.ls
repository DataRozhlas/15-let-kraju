stats =
  * id: "počet obyvatel"
    name: "počet obyvatel"
    unit: ""
    text: "Obyvatel"
  * id: "nezaměstnanost"
    name: "nezaměstnanost"
    unit: "%"
    text: "Nezaměstnaných"
  * id: "HDP na obyvatele"
    name: "HDP na obyvatele"
    text: "HDP na obyvatele"
    unit: "Kč"
  * id: "Průměrná mzda"
    name: "průměrná mzda"
    text: "Průměrná mzda"
    unit: "Kč"
  * id: "Firmy na obyv"
    name: "firmy"
    text: "Firem na 100 obyvatel"
    unit: ""
  * id: "Fyzickéosobypodnikající na obyv"
    name: "podnikatelé"
    unit: ""
    text: "Podnikatelů na 100 obyvatel"
  * id: "Nehody pod vlivem na obyvatele"
    name: "nehody pod vlivem alkoholu"
    text: "Nehod pod vlivem alkoholu na 1000 obyv."
    unit: ""
  * id: "rozvody"
    name: "rozvodovost"
    unit: ""
    text: "Rozvodů na 1000 obyvatel"
  * id: "trestných činů na obyvatele"
    name: "kriminalita"
    unit: ""
    text: "Trestných činů na 1000 obyv."
  * id: "spotřeba elektřiny"
    name: "spotřeba elektřiny"
    text: "Celková spotřeba elektrické energie"
    unit: "MWh"
  * id: "délka železničních tratí"
    name: "délka železnic"
    text: "Celková délka železnic"
    unit: "km"
  * id: "nemocenska"
    name: "pracovní neschopnost"
    text: "Průměrný roční počet dnů na nemocenské"
    unit: ""
  * id: "Počet lékařů na obyvatele"
    name: "lékaři"
    text: "Počet lékařů na 1000 obyvatel"
    unit: ""
  * id: "studentů na obyvatele"
    name: "studenti"
    text: "Počet studentů na 1000 obyv."
    unit: ""
  * id: "průměrný počet přenocování"
    name: "noclehy turistů"
    text: "Průměrný počet noclehů v hotelu"
    unit: ""

container = d3.select ig.containers.base
{kraje, kraje_assoc, metrics} = ig.getData!
map = new ig.Map container, kraje, kraje_assoc
barchart = new ig.Barchart container, kraje
selector = new ig.Selector container, metrics, metrics.0, stats

displayMetric = (metric) ->
  map.displayMetric metric
  barchart.displayMetric metric

displayMetric stats.0
selector.on \selected displayMetric
barchart.on \highlight map~highlight
map.on \highlight barchart~highlight
barchart.on \downlight map~downlight
map.on \downlight barchart~downlight
