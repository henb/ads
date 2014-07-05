jQuery ($) ->
  $(".wysihtml5").each (i, elem) ->
    $(elem).wysihtml5()

$(document).on 'page:load', ->
  window['rangy'].initialized = false
