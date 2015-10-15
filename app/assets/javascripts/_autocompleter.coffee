class App.Autocompleter extends App.Element
  init: ->
    @findField()
    @element.autocomplete(@options())

  findField: ->
    @field = $("#{@element.data('target')}")

  options: =>
    {
      source: @element.data('source-url')
      minLength: 3
      select: @onSelect
    }

  onSelect: (e, ui) =>
    @field.val(ui.item.id)


$(document).on 'page:change', ->
  new App.Autocompleter(ac) for ac in $('[data-behavior="autocomplete"]')
