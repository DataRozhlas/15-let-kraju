tooltip = new Tooltip!watchElements!

container = d3.select ig.containers.base
{kraje, kraje_assoc, metrics} = ig.getData!
map = new ig.Map container, kraje, kraje_assoc
  ..displayMetric metrics.0
barchart = new ig.Barchart container, kraje
  ..displayMetric metrics.0
new ig.Selector container, metrics, metrics.0
