class ig.Selector
  (container, metrics, selectedMetric) ->
    ig.Events @
    @element = container.append \div
      ..attr \class \selector
    @element.append \h2
      ..html "Vyberte metriku"
    list = @element.append \ul
    @listItems = list.selectAll \li .data metrics .enter!append \li
      ..append \a
        ..html -> it
        ..attr \href \#
        ..on \click ~>
          selectedMetric := it
          @listItems.classed \active -> it is selectedMetric
          d3.event.preventDefault!
          @emit \selected it
      ..classed \active -> it is selectedMetric
