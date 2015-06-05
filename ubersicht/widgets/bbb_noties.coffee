# Author: Nikhil Gupta
# Package: Ubersicht
#
# Ubersicht widget to show notifications in a clean manner, using the `noty`
# jquery plugin. Successful notifications are auto hidden, while the ones with
# errors are made sticky. This widget automatically hides itself when there are
# no notifications remaining.
#
# Widget refreshes itself OnDemand.
#
# TODO: add event and show number of times some message was triggered on noties.

command: "echo"
refreshFrequency: false
afterRender: (domEl) ->
  window.components or= {}
  window.components.noties = $(domEl)

  window.helpers or= {}
  window.helpers.notify = @notifyWithNoty

  # handlers
  @whenLoaded -> $(window).trigger("noties:loaded")

# Send a notification using this widget with a given message and options.
# If an existing notification exists for the given message, a new notification
# will not be triggered.
#
# Options can be found here: http://ned.im/noty/#/about
# Notable options are:
#   timeout: auto hide the notification after this many seconds
#   force:   send notification to beginning of queue
#   killer:  kill all current notifications before sending this notification
notifyWithNoty: (message, options) =>
  noties = window.components.noties

  notes = noties.find('.noty_text')
  for existing, index in notes
    if $.trim($(existing).html()) == $.trim(message)
      if index == notes.length - 1 then return ''
      $(existing).parent().parent().parent().remove()

  defaults =
    theme: 'relax'
    maxVisible: 10
    callback:
      onShow: ->
        noties.trigger("noties:notified")
      afterClose: ->
        noties.trigger("noties:closed")
        if noties.find(".noty_text").length == 1
          noties.trigger("noties:closed_all")

  noties.noty $.extend(defaults, $.extend(options, text: message))

# Call a callback when the noty library has successfully injected itself into
# the document.
whenLoaded: (callback) ->
  setTimeout (->
    if window.hasOwnProperty("noty") then callback() else @whenLoaded(callback)
  ), 1000

style: """
  top    0
  left   0
  width  30%
  height 100%
  padding 20px
  background rgba(0,0,0,0.7)
  user-select       none
  font-family "Oswald"
  color white
  z-index 99999
  overflow-y auto

  .noty_text
    text-align left !important
"""
