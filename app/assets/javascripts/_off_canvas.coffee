@App ||= {}

class App.OffCanvas extends App.Element
  init: ->
    @name = @element.attr('id')

  open: ->
    $('.app').addClass('js-off_canvas-closed')

  close: ->
    $('.app').removeClass('js-off_canvas-closed')

  toggle: ->
    $('.app').toggleClass('js-off_canvas-closed')


$(document).on 'ready page:load', ->
  App.off_canvas = new App.OffCanvas("[data-behavior='off_canvas']")
  $("[data-behavior='off_canvas_toggle']").on 'click', ->
    App.off_canvas.toggle()
