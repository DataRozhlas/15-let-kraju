

class ig.Selector
  (container, metrics, selectedMetric, stats) ->
    ig.Events @
    @element = container.append \div
      ..attr \class \selector
    @element.append \h2
      ..html "Vyberte metriku"
    list = @element.append \ul
    @listItems = list.selectAll \li .data stats .enter!append \li
      ..append \a
        ..html -> it.name
        ..attr \href \#
        ..on \click ({id}:metric) ~>
          selectedMetric := id
          @listItems.classed \active -> it.id is selectedMetric
          d3.event.preventDefault!
          @emit \selected metric
      ..classed \active -> it.id is selectedMetric
