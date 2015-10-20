@App ||= {}
# callback = -> $.getScript(url)
# timeoutID = window.setTimeout callback, 3000

class App.JobPoller
  constructor: (elem) ->
    @element = $(elem)
    @url = @element.data('check-url')

  start: ->
    @element.button('loading')
    @setInterval()

  finish: (url) ->
    if url?
      window.clearInterval @interval
      @element.attr('href', url)
      @element.removeAttr('data-remote data-method')
      @element.button('finish')

  checkStatus: ->
    $.getScript(@url)

  setInterval: =>
    func = ->
      App.poller.checkStatus()
    @interval = window.setInterval(func, 4000)


$(document).on 'page:change', ->
  if $('[data-behavior="job_poller"]').length > 0
    App.poller = new App.JobPoller('[data-behavior="job_poller"]')
