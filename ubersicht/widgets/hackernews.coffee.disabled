# Author: Nikhil Gupta
# Package: Ubersicht
#
# Ubersicht widget template to readily create new widgets.
#
# Widget refreshes itself every 10 minutes.
#
# FIXME: when loaded, gives 2 404 errors for images.
# FIXME: use local storage to store story ids which have been seen
# TODO:  allow favoriting of stories

name: "hackernews"
storyViews: ["", "show"]
command: "echo"
refreshFrequency: 10 * 60 * 1000
render: (_) -> """
  <h2 class='info' data-state=0></h2>
  <ul class='hn-stories'></ul>
"""

afterRender: (domEl) ->
  window.helpers or= {}
  window.components or= {}
  window.components[@name] = $(domEl)
  # helpers, if any:
  # window.helpers.function = @function

hasStories: (domEl) ->
  $(domEl).find("ul.hn-stories").find('[data-id]').length > 0

update: (output, domEl) ->
  storyel = $(domEl).find("ul.hn-stories")
  storyel.fadeOut() unless @hasStories(domEl)
  for kind in @storyViews
    @requestHackerNewsStories kind, (story) =>
      html = @createHtmlFromStory story, "li"

      storyel.find("[data-id=#{story.id}]").remove()
      storyel.append(html)

      # sort stories by score
      storyel.find('[data-id]').sort((a,b) -> b.dataset.score - a.dataset.score).appendTo(storyel)
      # remove duplicate stories
      if @hasStories(domEl) then storyel.fadeIn() else storyel.fadeOut()

      total = $(domEl).find(".story[data-clicked!='1']").length
      $(domEl).find(".info").html("HackerNews#{if total? then " <small>(#{total})</small>"}")
      $(domEl).trigger("hackernews:loaded")

      storyel.find("[data-id=#{story.id}]").on "click", (e) ->
        $(@).slideUp 'slow', ->
          $(@).attr("data-clicked", 1)
          $(@).appendTo(storyel).slideDown()
          total = $(domEl).find(".story[data-clicked!='1']").length
          $(domEl).find(".info").html("HackerNews#{if total? then " <small>(#{total})</small>"}")

  # @requestData url, "", (response) =>
  #   if response and not response.error?
  #     $(domEl).fadeIn ->
  #       $(window).trigger("github:loaded")
  #       $(domEl).find(".info").attr("data-state", 1)
  #   else
  #     $(domEl).fadeOut ->
  #       $(window).trigger("github:unloaded")
  #       $(domEl).find(".info").attr("data-state", 0)

createHtmlFromStory: (story, wrapper="li") ->
  html = """
    <#{wrapper} class='story' data-id='#{story.id}' data-score='#{story.score}'>
      <i class='icon fa fa-#{@getIcon(story)} fa-2x'></i>
      <span class='title'>
        #{if story.url? then "<a href='#{story.url}'>#{story.title}</a>" else story.title}
      </span>
      <br>
      <p class="meta">
        <a class='discussion' href='https://news.ycombinator.com/item?id=#{story.id}'>[discussion]</a>
        <span class='score'>#{story.score} pts.</span>
        #{if story.comments > 0 then "<span class='comments'>#{story.comments} comments</span>" else ""}
        <span class='time'>#{story.time}</span>
      </p>
    </#{wrapper}>
  """

getIcon: (story) ->
  switch story.kind
    when "show" then "wrench"
    when "ask"  then "question-circle"
    else "hacker-news"

requestHackerNewsStories: (kind, callback) ->
  @requestHTML "https://news.ycombinator.com/#{kind}", (html) =>
    stories = []
    data  = $(html).find("#hnmain table tbody")[1]
    parts = $(data).html()?.split('<tr class="spacer" style="height:5px"></tr>')
    unless parts?.length > 0
      console.log "could not request HN stories for '#{kind}'!"
      return

    for part in parts
      link = $(part).find(".title a")
      meta = $(part).find(".subtext")
      continue unless meta.find(".score").attr("id")?

      time = [$(el).text() for el in meta.find("a") when $(el).text().indexOf("ago") != -1][0][0]
      time = if time? then time else "-"

      comments = [$(el).text().split(" ")[0] for el in meta.find("a") when $(el).text().indexOf("comments") != -1][0][0]
      comments = if comments? then parseInt(comments) else 0

      callback
        kind: kind
        url: link.attr("href")
        title: link.text().replace(/^(show|tell|ask)*\s+HN:\s+/i, '')
        id: meta.find(".score").attr("id").split("_")[1]
        score: meta.find(".score").text().split(" ")[0]
        time: time
        comments: comments

# Request html response from a URL via Curl
requestHTML: (url, callback) ->
  @run "curl -sS '#{url}'", (stderr, stdout) =>
    if stderr?.indexOf("curl: (6)") == -1
      @logError "when requesting url #{url}: #{stderr}"
    else if !stderr? and !stdout?
      @logError "received empty response when requesting #{url}"
    else if stdout?
      callback stdout

# Verify that a given component is loaded and visible on screen.
isVisible: (component) ->
  window.components.hasOwnProperty(component) and
    window.components[component].css("display") != "none"

# When an error occurs (typically, when querying the API/service), log that
# error on the console, as well as in the noties widget.
logError: (message) ->
  console.log "#Error in [#{@name}]: #{message}"
  window.helpers.notify "<strong>#{@name} error</strong><br>#{message}", type: "error"

style: """
  top 0
  left 0
  width 30%
  font-family Oswald
  left 40%
  background rgba(0,0,0,0.8)
  color rgba(255,255,255,0.7)

  h2
    text-align center
    padding 10px
    margin 0
    height 30px

  .hn-stories
    white-space nowrap
    overflow-x hidden
    overflow-y auto
    list-style none
    margin 0
    padding 0 0 0 20px
    border-bottom 2px solid rgba(0,0,0,0.8)
    max-height calc(100% - 50px)

    .story
      padding: 5px 0
    .story[data-clicked="1"]
      opacity 0.6

    a
      color rgba(255, 255, 255, 0.7)

    .meta
      font-size 0.85em
      color rgba(255, 255, 255, 0.4)
      padding 6px 0
      margin 0

  i.icon
    float left
    padding 10px 10px 10px 0
"""
