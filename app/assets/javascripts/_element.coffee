
class App.Element
  constructor: (elem) ->
    @element = $(elem)
    @init()

  init: ->
    true

  databvr: (value) ->
    $("[data-behavior='#{value}']")
