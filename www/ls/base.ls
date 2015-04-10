krajeIds =
  "Praha"
  "jihocesky"
  "jihomoravsky"
  "kralovarsky"
  "vysocina"
  "kralovehradecky"
  "liberecky"
  "ostravsky"
  "olomoucky"
  "pardubicky"
  "plzensky"
  "stredocesky"
  "ustecky"
  "zlinsky"
tooltip = new Tooltip!watchElements!

container = d3.select ig.containers.base
{kraje, kraje_assoc, metrics} = ig.getData!
map = new ig.Map container
