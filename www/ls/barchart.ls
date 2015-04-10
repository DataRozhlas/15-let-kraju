class ig.Barchart
  (container, kraje) ->
    ig.Events @
    @kraje = kraje.slice!
    @element = container.append \div
      ..attr \class \barchart
    @header = @element.append \h3
    @rows = @element.selectAll \div.row .data @kraje .enter!append \div
      ..attr \class \row
      ..append \span
        ..attr \class \name
        ..html ->
          it.nazev
            .replace " kraj" ""
            .replace "Hlavní město " ""

      ..on \mouseover ~> @emit \highlight, it
      ..on \touchstart ~> @emit \highlight, it
      ..on \mouseout ~> @emit \downlight
    @barContainers = @rows.append \div
      ..attr \class \bar-container
    @bars = @barContainers.append \div
      ..attr \class \bar
      ..append \div
        ..attr \class \fill
    @labels = @bars.append \div
      ..attr \class \label
    @rowHeight = @rows.node!clientHeight
    @scale = d3.scale.linear!
      ..range [0 100]

  displayMetric: (metric) ->
    @header.html -> metric.text
    @kraje.sort (a, b) -> b[metric.id] - a[metric.id]
    for kraj, index in @kraje => kraj.index = index
    @rows.style \top ~> "#{it.index * @rowHeight}px"
    @labels.html ->
      value = it[metric.id]
      decimals =
        | value < 10 => 2
        | value < 100 => 1
        | otherwise  => 0
      formatted = ig.utils.formatNumber value, decimals
      "#{formatted} #{metric.unit}"

    labelMaxWidth = @getLabelMaxWidth!
    @scale.domain [0, d3.max @kraje.map -> it[metric.id]]
    @barContainers.style \padding-right "#{labelMaxWidth}px"
    @bars.style \width ~> "#{@scale it[metric.id]}%"


  getLabelMaxWidth: ->
    widths = []
    @labels.each -> widths.push @clientWidth
    maxWidth = Math.max ...widths

  highlight: (kraj) ->
    @rows.classed \highlight -> it is kraj

  downlight: ->
    @rows.classed \highlight no
