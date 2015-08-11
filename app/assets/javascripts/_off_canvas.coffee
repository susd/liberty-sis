@App ||= {}

class App.OffCanvas extends App.Element
  init: ->
    @name = @element.attr('id')

  open: ->
    $('.app').addClass('js-off_canvas-open')

  close: ->
    $('.app').addClass('js-off_canvas-open')

  toggle: ->
    $('.app').toggleClass('js-off_canvas-open')


$(document).on 'ready page:load', ->
  App.off_canvas = new App.OffCanvas("[data-behavior='off_canvas']")
  $("[data-behavior='off_canvas_toggle']").on 'click', ->
    App.off_canvas.toggle()
