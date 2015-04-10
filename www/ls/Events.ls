# Kudos 2 https://github.com/allouis/minivents
window.ig.Events = (target = null) ->
  events = {}
  target ?= @
  target._events = events

  target.on = (type, func) ->
    events[type] ?= []
    events[type].push func

  target.once = (type, func) ->
    f = ->
      func ...
      target.off type, f
    target.on type, f

  target.off = (type, func) ->
    list = events[type]
    if func
      i = list.length = if func then list.length else 0
      while(i-- > 0)
        if func == list[i] then list.splice i, 1
    else
      list.length = 0

  target.emit = (type, ...args) ->
    list = events[type] || []
    len = list.length
    for i in [list.length - 1 to 0 by -1]
      list[i] ...args
