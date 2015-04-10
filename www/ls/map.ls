class ig.Map
  (container) ->
    colors = ['rgb(255,245,240)','rgb(254,224,210)','rgb(252,187,161)','rgb(252,146,114)','rgb(251,106,74)','rgb(239,59,44)','rgb(203,24,29)','rgb(165,15,21)','rgb(103,0,13)']
    map = container.append \div
      ..attr \class \map

    width = map.node!clientWidth
    {features} = topojson.feature ig.data.kraje, ig.data.kraje.objects.data
    for feature in features => feature.centroid = d3.geo.centroid feature
    features[11].centroid.1 += 0.3
    features[11].centroid.0 += 0.2
    features[8].centroid.1 -= 0.1
    {width, height, projection} = ig.utils.geo.getFittingProjection features, {width}
    mesh = topojson.mesh ig.data.kraje, ig.data.kraje.objects.data

    path = d3.geo.path!
      ..projection projection
    mapSvg = map.append \svg
      ..attr \width width
      ..attr \height height

    krajePath = mapSvg.selectAll \path .data features .enter!append \path
      ..attr \class \kraj
      ..attr \d path
      ..attr \fill colors[0]

    mapSvg.append \path
      .attr \class \mesh
      .attr \d path mesh

    mapSvg.selectAll \circle .data features .enter!append \circle
      ..attr \r 2
      ..attr \cx -> projection it.centroid .0
      ..attr \cy -> projection it.centroid .1
