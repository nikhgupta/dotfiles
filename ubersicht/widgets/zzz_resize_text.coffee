# Author: Nikhil Gupta
# Package: Ubersicht
#
# Ubersicht (meta)widget that resizes any text that appears on screen to fit its
# container element. Code has been adopted from FontFlex (on Github).
#
# Widget refreshes itself OnDemand.

command: "echo"
refreshFrequency: false

afterRender: (_) ->
  @defineFontFlex()
  setTimeout (=> @resizeText()), 4000
  $(window).on @all_events, =>
    setTimeout (=> @resizeText()), 500

all_events:
  "noties:loaded noties:notified github:loaded todokarma:loaded weather:loaded"

resizeText: ->
  $("body").fontFlex(8, 14, 70)

defineFontFlex: ->
  $.fn.fontFlex = (min, max, mid) ->
    $this = this
    $(window).resize(->
      size = window.innerWidth / mid
      if size < min
        size = min
      if size > max
        size = max
      $this.css 'font-size', size + 'px'
      return
    ).trigger 'resize'

isVisible: (component) ->
  window.components.hasOwnProperty(component) and
  window.components[component].css("display") != "none"
