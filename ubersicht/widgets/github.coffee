# Author: Nikhil Gupta Package: Ubersicht
#
# Ubersicht widget to display graphs for Github activities using a custom data
# cruncher that consumes Github API. Graphs are plotted using the `flot` jquery
# library, and when clicked upon open the corresponding URL for the items.
#
# Widget requires environment variable GITHUB_TOKEN specifying the github token
# to use. The username is required in some cases (e.g. contribution data), and
# must be specified below.
#
# Widget refreshes itself every 10 minutes to save on Github API limits.

user: "nikhgupta"
command: "echo"
issueMaxPendingColor: "#ff4143"
issueMaxPendingDurationInDays: 30
refreshFrequency: 10 * 60 * 1000
render: (output) -> """
  <h2 class='title info' data-state=0></h2>
  <div class='issues'></div>
  <span class='legend'></span>
  <div class='graph'></div>
"""
afterRender: (domEl) ->
  window.components or= {}
  window.components.github = $(domEl)
  window.helpers or= {}
  window.helpers.smooth2dGraph = @smooth2dGraph

update: (output, domEl) ->
  @requestData (response) =>
    if response and not response.error?
      $(domEl).find('h2.title').html("Github Stats <span></span>")
      $(domEl).find('h2.title').fadeIn()

      # generate issues list
      issues = @sortIssuesByCreatedAtAscending(response.lists.open_issues)
      html   = "<ul>"
      html += @generateIssueHTML(issue) for issue in issues
      html += "</ul>"
      $(domEl).find(".issues").html(html)
      $(domEl).find("h2.title span").html("Github Issues <small>(#{issues.length})</small>")

      # create charts
      data = @sanitizeResponseAsGraphData(response)
      element = $(domEl).find("div.graph")
      $.plot element, data, @chartOptions()
      element.bind "plotclick", (event, pos, item) => @onChartClick(event, pos, item)
      $(domEl).fadeIn ->
        $(window).trigger("github:loaded")
        $(domEl).find(".info").attr("data-state", 1)
    else
      $(domEl).find('h2.title').fadeOut()
      $(domEl).fadeOut ->
        $(window).trigger("github:unloaded")
        $(domEl).find(".info").attr("data-state", 0)

generateIssueHTML: (issue) ->
  url   = "https://github.com/#{issue.repository.full_name}/issues/#{issue.number}"
  color = @convertTimeAgoToRGB(issue.created_at, 0.6)
  html  = "<li class='issue'>"
  html += "<a href='#{url}' style='color: #{color}'>"
  html += "<i class='fa fa-github'></i> "
  html += "[#{issue.repository.full_name} ##{issue.number}] "
  html += "#{issue.title}"
  html += "</a></li>"
  html

sortIssuesByCreatedAtAscending: (issues) ->
  issues.sort (a,b) -> new Date(a.created_at) - new Date(b.created_at)

convertTimeAgoToRGB: (time, opacity = 1) ->
  time  = (new Date() - new Date(time))/parseFloat(86400000)
  maxd  = @issueMaxPendingDurationInDays
  maxd  = if time > maxd then time else maxd
  color = @lightenColor @issueMaxPendingColor, (1 - time / maxd ) * 255
  color = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(color)
  "rgba(#{parseInt(color[1], 16)},#{parseInt(color[2], 16)},#{parseInt(color[3], 16)},#{opacity})"

convertStringToUniqueRGB: (string, opacity = 1) ->
  rgb = [0, 0, 0]
  for char, index in string
    code = string.charCodeAt(index)
    rgb[code % 3] += code
  "rgba(#{rgb[0] % 192 + 64}, #{rgb[1] % 192}, #{rgb[2] % 128}, #{opacity})"

# Verify that a given component is loaded and visible on screen.
isVisible: (component) ->
  window.components.hasOwnProperty(component) and
    window.components[component].css("display") != "none"

# Sanitize response received from HTTP query to format that Flot understands.
sanitizeResponseAsGraphData: (response) ->
  ly  = new Date()
  ly.setFullYear(ly.getFullYear() - 1)
  ly -= (ly.getHours() * 3600 + ly.getMinutes() * 60 + ly.getSeconds()) * 1000 + ly.getMilliseconds()

  commits = ([parseInt(time), count] for time, count of response.stats.contributions.daily)
  gists   = ([parseInt(time), count] for time, count of response.stats.gists.last_year)
  burnout = (item for item in response.charts.issues_burnout when item[0] >= ly)

  [ { label: "Gists",   data: gists, yaxis: 1, color: 2, points: {show: true, fill: 2, radius: 2} },
    { label: "Commits", data: @smooth2dGraph(commits), yaxis: 2, color: 0, lines: {show: true, fill: false} },
    { label: "Open Issues", data: burnout, yaxis: 3, color: 1, lines: {show: true, fill: true, fillColor: "rgba(153,51,51,0.2)"} } ]

# Request data for Github activities by querying custom application on Heroku.
requestData: (callback) ->
  @run "zsh -cl 'echo $GITHUB_TOKEN'", (err, env_var) =>
    command  = "https://widget-data-feeder.herokuapp.com"
    command += "/github/charts/issues_burnout/stats/gists,contributions/lists/open_issues"
    command += "?user=#{@user}&token=#{$.trim env_var}"
    command = "curl -sS '#{command}'"
    @run command, (stderr, stdout) =>
      if stderr and stderr.indexOf("curl: (6)") == -1
        data = null
        @logError "when executing request: #{stderr}"
      else if !stderr?
        try
          data = JSON.parse(stdout)
        catch err
          data = null
          @logError "when parsing response: #{err.message}"
      callback data

# When chart is clicked upon, open the appropriate URL. Note that, it is
# possible to specify a more suited URL for the item being clicked upon, but it
# was a bit cumbersome to pass custom data to Flot charts.
onChartClick: (event, pos, item) ->
  unless item.series?.label? then return
  url = null
  switch item.series.label
    when "Gists"
      url  = "https://gist.github.com/#{@user}"
    when "Commits"
      date = new Date(item.datapoint[0])
      date = "#{date.getFullYear()}-#{date.getMonth()+1}-#{date.getDate()}"
      url  = "https://github.com/nikhgupta?tab=contributions&from=#{date}"
    when "Open Issues"
      url  = "https://github.com/search?q=user:#{@user}+is:open+is:issue&s=created&o=asc&type=Issues"
  if url then @run("open '#{url}'", ->)

# Chart options for the Flot based charts.
chartOptions: ->
  legend:
    container: window.components.github.find(".legend")
    noColumns: 3
  xaxis:
    mode: "time",
    timeformat: "%d/%m/%y"
  yaxis:
    show: false
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

# When an error occurs (typically, when querying the API/service), log that
# error on the console, as well as in the noties widget.
logError: (message) ->
  console.log "#error [github]: #{message}"
  window.helpers.notify "<strong>Github Error</strong><br>#{message}", type: "error"

# Add additional points to the graph data to produce smoother curves.
smooth2dGraph: (data, expand = 10) ->
  sm = []
  ts = (pair[0] for pair in data)
  vs = (pair[1] for pair in data)
  sv = Smooth(vs, method: Smooth.METHOD_CUBIC)
  st = Smooth(ts, method: Smooth.METHOD_CUBIC)
  i = 0
  while i <= data.length
    sm.push [st(i), sv(i)]
    i = i + 1/expand
  sm

# Lighten (or darken) a color for the given amount.
lightenColor: (col, amt) ->
  usePound = false
  if col[0] == '#'
    col = col.slice(1)
    usePound = true
  num = parseInt(col, 16)
  r = (num >> 16) + amt
  if r > 255
    r = 255
  else if r < 0
    r = 0
  b = (num >> 8 & 0x00FF) + amt
  if b > 255
    b = 255
  else if b < 0
    b = 0
  g = (num & 0x0000FF) + amt
  if g > 255
    g = 255
  else if g < 0
    g = 0
  (if usePound then '#' else '') + (g | b << 8 | r << 16).toString(16)

style: """
  bottom 0
  left 0
  background rgba(0,0,0,0.8)
  width 70%

  .title
    display none
    float left
    position relative
    top 0
    background-color rgba(0,0,0,0.4)
    width calc(100% - 400px)
    margin 0
    padding 5px 200px
    color rgba(#fff, 0.7)
    font-family Oswald
    border-top 4px solid rgba(0,0,0,0.8)
    border-bottom 2px solid rgba(0,0,0,0.8)
    span
      float right
  .graph
    width 50%
    height 178px
    float left
  .legend
    opacity 0.7
    position relative
    top 8px
    left 21px
    float left
    padding 2px 8px
    background rgba(0,0,0,0.4)
    border 2px solid rgba(0,0,0,0.8)
  .issues
    float right
    margin 10px 10px 0 -16px
    height 178px
    width 50%
    overflow-x hidden
    overflow-y auto
    white-space nowrap
    font-family Oswald
    ul
      list-style none
    a
      text-decoration none
"""
