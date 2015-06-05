# Author: Nikhil Gupta
# Package: Ubersicht
#
# Ubersicht (meta)widget that sets up all the necessary dependencies, e.g.
# styles, scripts, fonts etc. to be used by other widgets. This must be loaded
# first by Ubersicht.
#
# `window.components` holds the html element for widgets that have been
# rendered, while `window.helpers` stores the global helper functions, if any.
#
# Widget refreshes itself OnDemand.

command: "echo"
refreshFrequency: false
widgets: ["setup", "noties", "github", "todokarma", "todolist", "weather"]

style: """
  top    0
  right  0
"""

afterRender: (domEl) ->
  window.components or= {}
  window.components.setup = $(domEl)

  window.helpers or= {}

  # inject all styles and scripts into the html document
  @injectAssets()

  # when noties widget has loaded, notify the user about the current status of widgets
  $(window).on "noties:loaded", => @notifyUserOnWidgetUnload()

  # trigger the loaded event for this widget
  $(window).trigger("setup:loaded")

# Inject all assets (styles, and scripts) into the HTML document.
injectAssets: ->
  styles = [
    "style.css",
    "vendor/fonts/oswald.css",
    "vendor/css/font-awesome.min.css",
    # "vendor/css/flipclock.css",
    "vendor/css/jquery.raty.css",
  ]

  scripts = [
    "vendor/js/flot/base.js",
    "vendor/js/flot/time.js",
    "vendor/js/jquery.raty.js",
    "vendor/js/jquery.noty.js",
    "vendor/js/jquery.smooth.js",
    # "vendor/js/flipclock.min.js",
  ]

  for style in styles
    html = "<link rel='stylesheet' href='/#{style}' type='text/css'>"
    $("head link[rel='stylesheet']").last().after(html)

  for script in scripts
    html = "<script src='/#{script}.nouber' type='text/javascript' charset='utf-8'></script>"
    $("body").append(html)

# Notify the user when a widget fails to load for some reason. If all widgets
# (specified by @widgets) have been loaded, close the corresp. notification.
notifyUserOnWidgetUnload: ->
  defer = $.Deferred()
  defer.done ->
    clearInterval(timer)
    $(window).trigger("ubersicht:loaded")
    _noty.setText("Loaded Ubersicht..")
    _noty.setType("success")
    setTimeout (-> _noty.close()), 5000

  timer = setInterval (=>
    not_loaded = []
    for widget in @widgets
      not_loaded.push(widget) if not @isVisible(widget)
    not_loaded -= ["weather", "todokarma"] if @isVisible("itunes")

    if not_loaded.length > 0
      _noty.setText("Widgets not loaded: #{not_loaded.join(", ")}")
      _noty.setType("error")
    else
      defer.resolve()
  ), 2500

  _noty = window.helpers.notify "Loading Ubersicht..", type: "warning"

# Verify that a given component is loaded and visible on screen.
isVisible: (component) ->
  window.components.hasOwnProperty(component) and
  window.components[component].css("display") != "none"
