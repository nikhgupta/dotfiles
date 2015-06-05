# Author: Nikhil Gupta
# Package: Ubersicht
#
# Ubersicht widget that displays the karma graph for Todoist, along with tasks
# completed in the last week. Chart can be clicked upon to open the Todoist app.
#
# Widget requires environment variable TODOIST_TOKEN specifying the API token
# to use.
#
# Widget refreshes itself every 10 minutes.

command: "echo"
refreshFrequency: 10 * 60 * 1000
render: (output) -> """
  <span class='title info' data-state=0></span>
  <span class='points'></span>
  <span class='legend'></span>
  <div class='graph'></div>
"""
afterRender: (domEl) ->
  window.components or= {}
  window.components.todokarma = $(domEl)

# Verify that a given component is loaded and visible on screen.
isVisible: (component) ->
  window.components.hasOwnProperty(component) and
    window.components[component].css("display") != "none"

update: (output, domEl) ->
  if @isVisible("itunes") then return ''

  @queryTodoistKarma (data) =>
    if @isVisible("itunes") then return ''
    if data
      # update title
      $(domEl).find('span.title').html("Todoist Karma")

      # update karma points
      html  = "#{data.karma} <i class='fa #{@getKarmaIcon(data)}'></i>"
      color = @karmaChartOptions().colors[@getKarmaColor(data)]
      $(domEl).find("span.points").css("color", color).html(html)

      # update graph
      element = $(domEl).find("div.graph")
      $.plot element, @formatKarmaData(data), @karmaChartOptions()
      element.bind "plotclick", (event, pos, item) => @run "open -a 'Todoist'"

      $(domEl).fadeIn ->
        $(window).trigger("todokarma:loaded")
        $(domEl).find(".info").attr("data-state", 1)
    else
      $(domEl).fadeOut ->
        $(window).trigger("todokarma:unloaded")
        $(domEl).find(".info").attr("data-state", 0)

# Query the Todoist API to fetch the productivity stats for the user.
queryTodoistKarma: (callback) ->
  @run "zsh -cl 'echo $TODOIST_TOKEN'", (err, env_var) =>
    command = "curl -sS 'https://todoist.com/API/v6/get_productivity_stats' -d token=#{env_var}"
    @run command, (stderr, stdout) =>
      if stderr?.indexOf("curl: (6)") == -1
        data = null
        @logError "when querying todoist.com: #{stderr}"
      else if !stderr?
        try
          data = JSON.parse(stdout)
        catch err
          data = null
          @logError "when parsing response: #{stderr}"

      callback data

# Chart options for Flot charts.
karmaChartOptions: ->
  legend:
    container: window.components.todokarma.find(".legend")
  xaxis:
    mode: "time",
    timeformat: "%d/%m"
  yaxis:
    show: false
  series:
    lines: { show: true, fill: false, lineWidth: 3 }
    points: { show: true, fill: true, radius: 1 }
  grid:
    borderWidth: 1
    borderColor: "rgba(51,51,51,0.5)"
    clickable: true
  colors: [
    "rgba(51,153,51,0.7)",
    "rgba(153,51,51,0.7)",
    "rgba(153,153,51,0.9)",
    "rgba(153,153,153,0.4)"
  ]

getKarmaColor: (data) ->
  return 0 if data.karma_trend == "up"
  return 1 if data.karma_trend == "down"
  return 2

getKarmaIcon: (data) ->
  return "fa-angle-double-up"   if data.karma_trend == "up"
  return "fa-angle-double-down" if data.karma_trend == "down"
  return "fa-exchange"

# Sanitize the data returned by the API to format that Flot understands.
formatKarmaData: (data) ->
  _data = [
    {label: "Avg. Karma", data: [], yaxis: 1, color: @getKarmaColor(data)},
    {label: "Tasks Done", data: [], yaxis: 2, color: 3},
  ]

  for x in data.karma_update_reasons
    date = new Date(x.time).getTime()
    _data[0].data.push [date, x.new_karma]

  for x in data.days_items
    date = new Date(x.date).getTime()
    _data[1].data.push [date, x.total_completed]

  return _data

# When an error occurs, log that error on console, as well as in noties widget.
logError: (message) ->
  console.log "#error [todokarma]: #{message}"
  window.helpers.notify "<strong>TodoKarma Error</strong><br>#{message}", type: "error"

style: """
  right 0
  font-family: "Oswald", Berlin, Helvetica Neue
  color: #9da3a4
  width calc(30% - 40px)
  padding 40px 20px 0 20px
  text-align right
  height 170px
  overflow hidden
  background rgba(0,0,0,0.7)
  border-left 4px solid rgba(0,0,0,0.55)

  .title
    float left
    position relative
    top -20px
    left 20px
  .points
    float right
    position relative
    top -20px
    right 20px
  .graph
    width 100%
    height 150px
  .legend
    position relative
    top   4px
    right 80px
    float right
    padding 2px 8px
    background rgba(0,0,0,0.4)
    border 2px solid rgba(0,0,0,0.8)
"""
