# Author: Nikhil Gupta
# Package: Ubersicht
#
# Ubersicht widget that displays the current weather by querying the Forecast
# API. Note that, since there is currently a bug with the Ubersicht reported
# Location data, custom location is being set by hardcoding it.
#
# Widget has been adapted from the official `pretty-weather` widget.
#
# Widget refreshes itself every 10 minutes.

apiKey: "7bfbdd0b2afba249dc155346dc22bfdf"

command: "echo"
refreshFrequency: 10 * 60 * 1000
render: (_) -> """
  <div id='pretty-weather'>
    <div class='icon info' data-state=0></div>
    <p class='meta'>
      <span class='location'></span> <span class='temp'></span><br/>
      <span class='summary'></span>
    </p>
  </div>
"""

afterRender: (domEl) ->
  window.components or= {}
  window.components.weather = $(domEl)

  window.helpers or= {}
  window.helpers.getLocation = @getLocation

# Check if the iTunes widget is loaded and visible.
itunesLoaded: ->
  window.components.hasOwnProperty("itunes") and
    window.components.itunes.css("display") != "none"

update: (output, domEl) ->
  if @itunesLoaded() then return ''

  @getLocation (e) =>
    coords     = e.position.coords
    [lat, lon] = [coords.latitude, coords.longitude]
    query = "#{lat},#{lon}?units=auto&exclude=minutely,hourly,alerts,flags"
    @queryForecastApi query, (data) =>
      today = data?.daily?.data[0]
      if today?
        date = @getDate today.time
        $(domEl).find("span.temp").text Math.round(today.temperatureMax)+'°'
        $(domEl).find('span.summary').text today.summary
        $(domEl).find('div.icon').text @getIcon(today)
        $(domEl).find('span.location').show()
        $(domEl).find('span.location').text e.address.city + ", " + e.address.country
        $(domEl).fadeIn 'fast', ->
          $(window).trigger("weather:loaded")
          $(domEl).find(".info").attr("data-state", 1)
      else
        $(domEl).fadeOut 'fast', ->
          $(window).trigger("weather:unloaded")
          $(domEl).find(".info").attr("data-state", 0)

# Query the Forecast.io API.
queryForecastApi: (query, callback) ->
  command = "curl -sS 'https://api.forecast.io/forecast/#{@apiKey}/#{query}'"
  @run command, (stderr, stdout) =>
    if stderr?.indexOf("curl: (6)") == -1
      data = null
      @logError "when executing forecast.io api: #{stderr}"
    else if !stderr?
      try
        data = JSON.parse(stdout)
      catch err
        data = null
        @logError "when parsing response: #{err.message}"
    callback data

### HELPERS ###########################################################

dayMapping:
  0: 'Sunday'
  1: 'Monday'
  2: 'Tuesday'
  3: 'Wednesday'
  4: 'Thursday'
  5: 'Friday'
  6: 'Saturday'

getDate: (utcTime) ->
  date  = new Date(0)
  date.setUTCSeconds(utcTime)
  date

iconMapping:
  "rain"                :"\uf019"
  "snow"                :"\uf01b"
  "fog"                 :"\uf014"
  "cloudy"              :"\uf013"
  "wind"                :"\uf021"
  "clear-day"           :"\uf00d"
  "mostly-clear-day"    :"\uf00c"
  "partly-cloudy-day"   :"\uf002"
  "clear-night"         :"\uf02e"
  "partly-cloudy-night" :"\uf031"
  "unknown"             :"\uf03e"

getIcon: (data) ->
  return @iconMapping['unknown'] unless data

  if data.icon.indexOf('cloudy') > -1
    if data.cloudCover < 0.25
      @iconMapping["clear-day"]
    else if data.cloudCover < 0.5
      @iconMapping["mostly-clear-day"]
    else if data.cloudCover < 0.75
      @iconMapping["partly-cloudy-day"]
    else
      @iconMapping["cloudy"]
  else
    @iconMapping[data.icon]

# Get data for the user's current location.
# Due to a bug with Ubersicht's location reporting currently, this data is
# hardcoded.
getLocation: (cb) =>
  default_loc =
    position: coords:
      latitude:  26.8836669
      longitude: 75.7347992
      accuracy:  63
    address:
      city:    'Jaipur'
      country: 'India'
  cb default_loc
  # # NOTE: window.geolocation never returns
  # if window.hasOwnProperty("geolocation")
  #   window.geolocation.getCurrentPosition (data) =>
  #     cb(if data then data else default_loc)
  # else
  #   cb(default_loc)

# When an error occurs, log that error on console, as well as in noties widget.
logError: (message) ->
  console.log "#error [weather]: #{message}"
  window.helpers.notify "<strong>Weather Error</strong><br>#{message}", type: "error"

style: """
  bottom 0
  right 0
  font-family: "Oswald", Berlin, Helvetica Neue
  color: #9da3a4
  width calc(30% - 40px)
  padding 20px
  text-align right
  overflow hidden
  background rgba(0,0,0,0.7)
  border-left 4px solid rgba(0,0,0,0.55)
  border-top 4px solid rgba(0,0,0,0.2)
  height 116px

  #pretty-weather
    float right

    @font-face
      font-family Weather
      src url(vendor/fonts/pretty-weather.svg) format('svg')

    div.icon
      font-family Weather
      font-size 48px
      text-anchor middle
      alignment-baseline baseline
      padding-right 20px
      margin-bottom 10px

    p.meta
      margin 0

      span.temp
        font-size: 20px
        text-anchor: middle
        alignment-baseline baseline

      span.summary
        text-align right
        padding 12px 0 0
        margin-top -20px
        font-size 14px
        max-width 200px
        line-height 1.4em
        alignment-baseline baseline
"""
