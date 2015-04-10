class ig.Barchart
  (container, kraje) ->
    @kraje = kraje.slice!
    @element = container.append \div
      ..attr \class \barchart
    @rows = @element.selectAll \div.row .data @kraje .enter!append \div
      ..attr \class \row
      ..append \span
        ..attr \class \name
        ..html ->
          it.nazev
            .replace " kraj" ""
            .replace "Hlavní město " ""
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
    @kraje.sort (a, b) -> b[metric] - a[metric]
    for kraj, index in @kraje => kraj.index = index
    @rows.style \top ~> "#{it.index * @rowHeight}px"
    @labels.html -> ig.utils.formatNumber it[metric]
    labelMaxWidth = @getLabelMaxWidth!
    @scale.domain [0, d3.max @kraje.map -> it[metric]]
    @barContainers.style \padding-right "#{labelMaxWidth}px"
    @bars.style \width ~> "#{@scale it[metric]}%"


  getLabelMaxWidth: ->
    widths = []
    @labels.each -> widths.push @clientWidth
    maxWidth = Math.max ...widths
