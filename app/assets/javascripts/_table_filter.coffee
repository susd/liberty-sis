class App.TableFilter extends App.Element
  init: ->
    @source   = @element.data('source-url')
    @field    = @element.find('[data-behavior="filter-query"]')
    @results  = @element.find('[data-behavior="filter-results"]')
    @orig     = @element.find('[data-behavior="filter-original"]')

  search: ->
    query = @field.val()
    if query.length > 2
      $.ajax {
        url: @source,
        data: {query: query}
        dataType: "script"
        success: @success
      }
    if query.length == 0
      @revert()

  success: ->
    true

  revert: ->
    @results.find('tr').remove()
    @orig.show()
    $('.pagination').show()




$(document).on 'page:change', ->
  if $('[data-behavior="filtered_table"]').length > 0
    App.tfilter = new App.TableFilter(elem) for elem in $('[data-behavior="filtered_table"]')

    debouncedQuery = jQuery.debounce(500, false, => App.tfilter.search() )

    $(document).on 'keyup', App.tfilter.field, debouncedQuery
