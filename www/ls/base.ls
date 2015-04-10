tooltip = new Tooltip!watchElements!

container = d3.select ig.containers.base
{kraje, kraje_assoc, metrics} = ig.getData!
map = new ig.Map container, kraje, kraje_assoc
barchart = new ig.Barchart container, kraje
selector = new ig.Selector container, metrics, metrics.0

displayMetric = (metric) ->
  map.displayMetric metric
  barchart.displayMetric metric

displayMetric metrics.0
selector.on \selected displayMetric
barchart.on \highlight map~highlight
map.on \highlight barchart~highlight
barchart.on \downlight map~downlight
map.on \downlight barchart~downlight
