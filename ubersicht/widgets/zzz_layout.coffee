# Author: Nikhil Gupta
# Package: Ubersicht
#
# Ubersicht (meta)widget that resizes all widgets depending on which widgets
# have been loaded, and are currently being shown on screen.
#
# Widget refreshes itself OnDemand.

command: "echo"
refreshFrequency: false
sidebar: ["weather", "todokarma", "todolist"]
conn_widgets: ["github", "todokarma", "todolist", "weather", "hackernews"]
# Command to use to query external ip or check connectivity status for this
# machine. Must return "OFFLINE" when not connected.
ip_command: "tail -n1 ../../data/ip-addresses.txt | cut -d '/' -f 3"

afterRender: (_) ->
  # noties
  $(window).on "noties:notified",   => @toggleComponent("noties", "fadeIn")
  $(window).on "noties:closed_all", => @toggleComponent("noties", "fadeOut")

  # on all events
  $(window).on @all_events, =>
    @resizeNotiesAndHackerNews() and @resizeTodoistContainers()

  # when offline notify user and hide all connection based widgets except notify
  $(window).on (@all_events - "noties:notified"), => @hideAllWidgetsAndNotifyWhenOfflineElse()

  # itunes
  @handleLayoutWhenItunesLoadsOrUnloads()

all_events:
  "noties:loaded noties:closed noties:notified " +
  "github:loaded github:unloaded " +
  "todokarma:loaded todokarma:unloaded " +
  "todolist:loaded todolist:unloaded " +
  "weather:loaded weather:unloaded " +
  "hackernews:loaded hackernews:unloaded " +
  "resize"

toggleComponent: (component, state, callback = null) ->
  if window.components.hasOwnProperty(component)
    window.components[component][state] 'fast', ->
      if typeof callback is 'function' then callback()

resizeNotiesAndHackerNews: ->
  # resize hackernews according to github
  offset = if @isVisible("github") then window.components.github.height() else 0
  window.components.hackernews.css "height", $(window).height() - offset if @isVisible("hackernews")

  return unless @isVisible("noties")

  # resize noties according to github contrib
  offset = if @isVisible("github") then window.components.github.height() + 40 else 0
  window.components.noties.css "height", $(window).height() - offset

  # # resize noties according to itunes window
  # offset = if @isVisible("itunes")
  #   window.components.itunes.width()
  # else if @isVisible("weather")
  #   window.components.weather.width() + 40
  # else if @isVisible("todokarma")
  #   window.components.todokarma.width() + 40
  # else 0
  # window.components.noties.css "right", offset

resizeTodoistContainers: ->
  # return if not @isVisible("todolist")

  bottom = if @isVisible("weather") then window.components.weather.height() + 40 else 0
  window.components.todokarma.css "bottom", bottom

  height_offset = if @isVisible("todokarma") then window.components.todokarma.height() + 40 else 0
  height = $(window).height() - bottom - height_offset

  window.components.todolist.find(".tasks").css "height", height - 70

handleLayoutWhenItunesLoadsOrUnloads: ->
  $(window).on "itunes:loaded", =>
    @toggleComponent("itunes", "fadeIn")
    @toggleComponent(widget, "fadeOut") for widget in @sidebar

  $(window).on "itunes:unloaded", =>
    @toggleComponent("itunes", "fadeOut")
    @hideAllWidgetsAndNotifyWhenOfflineElse =>
      @toggleComponent("github", "fadeIn") if @hasData("github")
      @toggleComponent(widget, "fadeIn") for widget in @sidebar when @hasData(widget)

  $(window).on "itunes:mini:loaded", =>
    @toggleComponent("github", "fadeIn") if @hasData("github")

  $(window).on "itunes:fullscreen:loaded", =>
    @toggleComponent("github", "fadeOut")

hideAllWidgetsAndNotifyWhenOfflineElse: (callback) ->
  @run @ip_command, (stderr, stdout) =>
    if not stdout? or $.trim(stdout) is "OFFLINE"
      window.conn_status = window.helpers.notify "<strong>Not connected.</strong>", type: "error" unless window.conn_status?
      for widget in @conn_widgets
        if @isVisible(widget) then @toggleComponent(widget, "fadeOut")
    else
      window.conn_status?.close()
      callback() if typeof callback is 'function'

isVisible: (component) ->
  window.components or= {}
  window.components.hasOwnProperty(component) and
  window.components[component].css("display") != "none"

hasData: (component) ->
  window.components or= {}
  window.components.hasOwnProperty(component) and
  window.components[component].find(".info").attr("data-state") == "1"
