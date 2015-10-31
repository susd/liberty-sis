
$(document).on 'page:change', ->
  # $('.student_item-inactive').hide();

  $('[data-behavior="toggle_state_visibility"]').on 'click', ->
    $('[data-behavior="state_list"]').toggleClass('js-show-inactives');

    if !$('[data-behavior="state_list"]').hasClass('js-show-inactives')
      $(this).text('Show inactives')
    else
      $(this).text('Hide inactives')

    false
