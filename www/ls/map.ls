krajeIds =
  "CZ010"
  "CZ031"
  "CZ064"
  "CZ041"
  "CZ063"
  "CZ052"
  "CZ051"
  "CZ080"
  "CZ071"
  "CZ053"
  "CZ032"
  "CZ020"
  "CZ042"
  "CZ072"

class ig.Map
  (container, @kraje, @krajeAssoc) ->
    ig.Events @
    @colors = ['rgb(255,245,240)','rgb(254,224,210)','rgb(252,187,161)','rgb(252,146,114)','rgb(251,106,74)','rgb(239,59,44)','rgb(203,24,29)','rgb(165,15,21)','rgb(103,0,13)']
    map = container.append \div
      ..attr \class \map

    width = map.node!clientWidth
    {features} = topojson.feature ig.data.kraje, ig.data.kraje.objects.data
    {width, height, projection} = ig.utils.geo.getFittingProjection features, {width}
    mesh = topojson.mesh ig.data.kraje, ig.data.kraje.objects.data

    path = d3.geo.path!
      ..projection projection
    mapSvg = map.append \svg
      ..attr \width width
      ..attr \height height

    @krajePath = mapSvg.selectAll \path .data features .enter!append \path
      ..attr \class \kraj
      ..attr \d path
      ..attr \fill @colors[0]
      ..on \mouseover (d, i) ~> @emit \highlight, @krajeAssoc[krajeIds[i]]
      ..on \touchstart (d, i) ~> @emit \highlight, @krajeAssoc[krajeIds[i]]
      ..on \mouseout ~> @emit \downlight

    mapSvg.append \path
      .attr \class \mesh
      .attr \d path mesh
    @scale = d3.scale.linear!
      ..range @colors

  displayMetric: (metric) ->
    extent = d3.extent @kraje.map -> it[metric]
    @scale.domain ig.utils.divideToParts extent, 9

    @krajePath.attr \fill (d, i) ~>
      @scale @krajeAssoc[krajeIds[i]][metric]

  highlight: (kraj) ->
    @krajePath.classed \highlight (d, i) -> krajeIds[i] == kraj.kod

  downlight: ->
    @krajePath.classed \highlight no
