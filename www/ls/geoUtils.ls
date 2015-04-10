window.ig.utils.geo = geoUtils = {}
geoUtils.getFittingProjection = (features, {width, height}:maxDimensions) ->
  bounds = geoUtils.getBounds features
  projection = geoUtils.getProjection bounds, maxDimensions
  {width, height} = geoUtils.getDimensions bounds, projection
  {width, height, projection}

geoUtils.getBounds = (features) ->
  north = -Infinity
  west  = +Infinity
  south = +Infinity
  east  = -Infinity
  for feature in features
    [[w,s],[e,n]] = d3.geo.bounds feature
    if n > north => north = n
    if w < west  => west  = w
    if s < south => south = s
    if e > east  => east  = e
  [[west, south], [east, north]]

geoUtils.getProjection = ([[west, south], [east, north]]:bounds, {width, height}:maxDimensions) ->
  scales = []
  if width
    displayedPercent = (Math.abs west - east) / 360
    scales.push width / (Math.PI * 2 * displayedPercent)
  if height
    displayedPercent = (Math.abs north - south) / 180
    scales.push width / (Math.PI * 2 * displayedPercent)

  projection = d3.geo.mercator!
    ..scale Math.min ...scales
    ..center [west, north]
    ..translate [0 0]

geoUtils.getDimensions = ([[west, south], [east, north]]:bounds, projection) ->
  [x0, y0] = projection [west, north]
  [x1, y1] = projection [east, south]
  width = (x1 - x0)
  height = (y1 - y0)
  {width, height}

