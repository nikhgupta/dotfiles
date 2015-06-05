# Author: Nikhil Gupta Package: Ubersicht
#
# Ubersicht widget that displays album art, song rating, and lyrics for the song
# (if present) by querying iTunes. Moreover, lyrics can be set to be fullscreen
# by clicking on the album art, while song rating can be changed by clicking the
# appropriate rating (using the jQuery Raty plugin). iTunes mini player can be
# adjusted to superimpose album art, perfectly.
#
# Widget refreshes itself every 10 seconds to check if a song is playing.
#
# TODO: automatically embed youtube-video for the current song

# Query the shell script in the specified location to obtain the widget data.
# Since, the widget is refreshed every 10 seconds, shell script is made to exit
# early when possible.
command: "zsh ./scripts/itunes.sh"
refreshFrequency: 10 * 1000
render: (output) -> """
  <div class="container mini info" data-state=0></div>
  <div class="controls">
    <i class='fa fa-backward fa-2x'></i>&nbsp;&nbsp;
    <i class='fa fa-play     fa-2x'></i>&nbsp;&nbsp;
    <i class='fa fa-forward  fa-2x'></i>
  </div>
"""
afterRender: (domEl) ->
  window.components ||= {}
  window.components.itunes = $(domEl)
  window.components.itunes_mini = $(domEl).find(".mini")
  window.components.itunes_full = $(domEl).find(".fullscreen")

update : (output, domEl) ->
  current    = $.trim($(output).text())
  previous   = $.trim(window.components.itunes.text())
  if (current.length > 0 && current != previous)
    $(domEl).find(".container").html output
    $("div.rating").raty @ratyOptions(domEl)

  if current.length > 0
    $(domEl).find(".info").attr("data-state", 1)
    $(window).trigger("itunes:loaded")
  else
    $(domEl).find(".info").attr("data-state", 0)
    $(window).trigger("itunes:unloaded")

  $(domEl).find(".albumart").off("click").click => @switchContext(domEl)

# Switch from fullscreen to sidebar widget and vice versa.
switchContext: (domEl, context = null) ->
  container = $(domEl).find(".container")
  if context == "mini" || container.hasClass("fullscreen")
    container.removeClass('fullscreen').addClass('mini')
    $(domEl).css('width', "30%")
    $(window).trigger("itunes:mini:loaded")
  else
    container.removeClass('mini').addClass('fullscreen')
    $(domEl).css('width', "100%")
    $(window).trigger("itunes:fullscreen:loaded")

# Update song rating for the current song in iTunes.
updateSongRating: (domEl, score, event) ->
  title    = $.trim($(domEl).find("h1.title").text())
  command  = "osascript -e 'tell application \"iTunes\"' -e 'try'"
  command += " -e 'set trackname to name of current track'"
  command += " -e 'if trackname = \"#{title}\"'"
  command += " -e 'set rating of current track to #{score * 20}'"
  command += " -e 'else' -e 'return \"Song mismatch. Try again in a few seconds.\"'"
  command += " -e 'end if' -e 'on error err' -e 'return err' -e 'end try' -e 'end tell'"
  @run command, (stderr, stdout) =>
    if stdout or stderr
      if stdout then @logError stdout, type: "warning", timeout: 5000
      if stderr then @logError stderr, type: "error"
      $("div.rating").raty @ratyOptions(domEl)
    else
      $(domEl).find('.rating').data("score", score * 20)
    @refresh()

# When an error occurs, log that error on console, as well as in noties widget.
logError: (message) ->
  console.log "#error [itunes]: #{message}"
  window.helpers.notify "<strong>iTunes Error</strong><br>#{message}", type: "error"

# jQuery raty plugin options for this widget.
ratyOptions: (domEl) ->
  starType: 'i'
  round : { full: 0.6 }
  halfShow: false
  precision: false
  cancel: true
  score: => parseInt($("div.rating").data('score')) / 20
  click: (score, event) => @updateSongRating(domEl, score, event)

style: """
  top   0
  right 0
  text-align        center
  height            900px
  font-family       "Oswald"
  color             rgba(255,255,255,0.7)
  background-color  rgba(0,0,0,0.7)
  z-index           1000
  width             30%
  display           none
  user-select       none
  border-left 4px solid rgba(0,0,0,0.55)

  .container
    .albumart
      margin 20px
      height 400px
      width  400px
      position relative
      border-radius 5px
      background-color black
      box-shadow 5px 10px 15px rgba(0,0,0,0.3)
      img
        position absolute
        top : 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width 400px
        border-radius 5px

    .meta
      .rating
        float right
        margin-right 20px
        margin-top   20px
        font-size    0.5em
      .title
        margin 0
        font-size 24px
        text-align left
        padding-left 20px
      .artist
        margin 0
        font-size 18px
        text-align left
        padding-left 20px

    .lyrics
      color rgba(255,255,255,0.6)

  .container.mini
    .meta
      padding 5px 0 5px
      margin-bottom 10px

      .duration
        display none

    .lyrics
      height 367px
      max-height 367px
      overflow-x hidden
      overflow-y auto
      padding 0 10px

  .container.fullscreen
    .albumart
      float right
      margin-right 12px

    div.meta
      float  right
      height 900px
      width  calc(33% - 44px)
      position fixed
      top    446px
      right  0
      text-align right
      .duration
        padding-right 30px

    div.lyrics
      background rgba(20,51,51,0.8)
      width 67%
      padding 30px 20px
      border-right 4px solid rgba(0,0,0,0.4)
      column-count 2
      column-gap 20px
      height 833px
      overflow auto
      font-size 20px
"""
