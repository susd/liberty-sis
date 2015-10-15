window.App = {
  debug: false

  read: (subject) ->
    $bound = jQuery("[data-bind='#{subject}']")
    if $bound.is "input, textarea, select"
      $bound.val()
    else
      $bound.html()

  update: (subject, new_value) ->
    jQuery("[data-bind='#{subject}']").each ->
      $bound = jQuery( this )
      if $bound.is "input, textarea, select"
        $bound.val( new_value )
      else
        $bound.html( new_value )

    if App.debug
      console.log("update:#{subject}")
}
