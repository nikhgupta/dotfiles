# Author: Nikhil Gupta
# Package: Ubersicht
#
# Ubersicht widget that displays todo list by querying Todoist. Tasks can be
# checked off to mark them as completed, while colors indicate the status of the
# task. Title of the widget can be clicked to quickly add a new task using the
# Todoist app.
#
# Widget displays intelligent views for the tasks, i.e. it will display overdue
# tasks only when there are overdue tasks, and will not display future tasks in
# this case, etc.
#
# Widget requires environment variable TODOIST_TOKEN specifying the API token
# to use.
#
# Widget refreshes itself every 10 minutes.

command: "echo"
refreshFrequency: 10 * 60 * 1000
render: (output) -> """
  <h2 class="title info" data-state=0></h2>
  <ul class="tasks"></ul>
"""
afterRender: (domEl) ->
  window.components or= {}
  window.components.todolist = $(domEl)

  # when the widget title is clicked, open quick entry panel for Todoist app.
  $(domEl).find(".title").click =>
    @run "open 'todoist://addtask'", (stderr, stdout) =>
      if stderr? then @logError stderr

update: (output, domEl) ->
  if @isVisible("itunes") then return ''

  @callTodoistApi "query", "-d queries='[\"view all\"]'", (data) =>
    if @isVisible("itunes") then return ''

    if data?
      data  = @collectByView(@formatTodoData(data))
      views = @viewsToDisplay(data)

      if views.length > 0
        [html, title] = ["", []]

        # construct the html and sub-title for this widget
        for view in @viewsToDisplay(data)
          for task in data[view]
            html += @getTaskHtml(task, view)
          title.push "#{data[view].length} #{view}" if data[view].length > 0

        # update title
        $(domEl).find('.title').html("TodoList <small>( #{title.join(", ")} )</small>")
        $(domEl).find("ul.tasks").html(html)

        # trigger `loaded` event for this widget
        $(domEl).fadeIn ->
          $(window).trigger("todolist:loaded")
          $(domEl).find(".info").attr("data-state", 1)

        # when an item is checked off, mark it as complete.
        that = @
        $(domEl).find("ul.tasks li i.check").off("click").click ->
          $(@).removeClass("fa-square-o").addClass("fa-check-square-o")
          that.markTaskAsComplete $(@).parent()

        # return if we have views and data to display
        return

    # trigger unloaded event if we don't have views or data to display
    $(domEl).fadeOut ->
      $(window).trigger("todolist:unloaded")
      $(domEl).find(".info").attr("data-state", 0)

# Mark a task as completed using the Todoist API.
markTaskAsComplete: (task) ->
  data = ""
  tid  = task.data("id")
  pid  = task.data("project")
  uid  = @generateUUID()
  recurring = task.data("recurring") == 1

  if recurring
    data += "[{\"type\": \"item_update_date_complete\", \"uuid\": \"#{uid}\", \"args\": {\"id\": #{tid}}}]"
  else
    data += "[{\"type\": \"item_complete\", \"uuid\": \"#{uid}\","
    data += " \"args\": {\"project_id\": #{pid}, \"ids\": [#{tid}], \"force_history\": 0}}]"

  @callTodoistApi "sync", "-X POST -d commands='#{data}'", (response) =>
    if response and recurring and response["SyncStatus"]?[uid]? and response["SyncStatus"][uid] == "ok"
      task.slideUp 'slow', -> $(window).trigger("todolist:completed")
    else if response and not recurring and response["SyncStatus"]?[uid]?[tid]? and response["SyncStatus"][uid][tid] == "ok"
      task.slideUp 'slow', -> $(window).trigger("todolist:completed")
    else if response and response["error"]? #if response and not status == "ok"
      task.find("i.check").removeClass("fa-check-square-o").addClass("fa-square-o")
      @logError "Could not mark task as completed. Error: #{response.error}"
    else
      task.find("i.check").removeClass("fa-check-square-o").addClass("fa-square-o")
    @refresh()

# Intelligently decide what views to display to the user. If there are tasks for
# today or overdue tasks, no future tasks are shown. Otherwise, tasks for this
# week are shown. If tasks for this week don't exist, all future tasks with
# a due date are shown. If no such tasks exist, all tasks that don't have any
# due dates with them are shown.
viewsToDisplay: (data) ->
  views = []
  views.push("today")      if data.today.length     > 0
  views.push("overdue")    if data.overdue.length   > 0
  views.push("this_week")  if data.this_week.length > 0 and views.length == 0
  views.push("future")     if data.future.length    > 0 and views.length == 0
  views.push("not_due")    if data.not_due.length   > 0 and views.length == 0
  views

# Get the HTML for the given task with colors and icons.
getTaskHtml: (task, view) ->
  date = new Date(task.due_date)
  monthNames = [ "January", "February", "March", "April", "May", "June", "July",
                 "August", "September", "October", "November", "December" ]
  due_date = "#{monthNames[date.getMonth()]} #{date.getDate()}"
  due_text = if view == "today" then "due today" else "due on #{due_date}"

  data  = "data-id='#{task.id}' data-priority='#{task.priority}' "
  data += "data-status='#{view}' data-project='#{task.project_id}' "
  data += "data-recurring='#{if task.recurring then 1 else 0}'"

  icons = ["check fa-square-o"]
  icons.push switch view
    when "overdue"   then "fa-warning"
    when "today"     then "fa-at"
    when "this_week" then "fa-calendar"
    when "future"    then "fa-calendar"
    when "not_due"   then "fa-calendar-o"

  task_klass = "recurring" if task.recurring
  task_klass = "inbox" if task.project_name == "Inbox"

  fontawesome  = ""
  fontawesome += "<i class='fa #{icon}'></i> &nbsp;" for icon in icons

  "<li class='task #{task_klass}' #{data}>#{fontawesome} &nbsp; <span>#{task.content}</span> <small>#{due_text}</small></li>"

# Request the Todoist API for the given data.
callTodoistApi: (endpoint, query, callback) ->
  @run "zsh -cl 'echo $TODOIST_TOKEN'", (err, env_var) =>
    command = "curl -sS 'https://todoist.com/API/v6/#{endpoint}' -d token=#{$.trim env_var} #{query}"
    @run command, (stderr, stdout) =>
      if stderr?.indexOf("curl: (6)") == -1
        data = null
        @logError "when executing todoist api: #{stderr}"
      else if !stderr?
        try
          data = JSON.parse(stdout)
        catch err
          data = null
          @logError "when parsing response: #{err.message}"
      callback data

# When an error occurs, log that error on console, as well as in noties widget.
logError: (message) ->
  console.log "#error [todolist]: #{message}"
  window.helpers.notify "<strong>TodoList Error</strong><br>#{message}", type: "error"

# Sanitize the data returned by the Todoist API for easy consumption.
formatTodoData: (data) ->
  tasks    = []
  projects = data[0].data
  for project in projects
    for uncompleted in project.uncompleted
      $.extend uncompleted,
        due_date: Date.parse(uncompleted.due_date)
        recurring:  @isRecurringTask(uncompleted)
        project_name: project.project_name
      tasks.push uncompleted

  tasks.sort (a,b) ->
    if a.priority == b.priority
      return -1 if isNaN(a.due_date) and not isNaN(b.due_date)
      return  1 if isNaN(b.due_date) and not isNaN(a.due_date)
      return  0 if isNaN(a.due_date) and isNaN(b.due_date)
      if a.due_date == b.due_date
        if a.recurring < b.recurring then 1 else -1
      else
        if a.due_date > b.due_date then 1 else -1
    else
      if a.priority < b.priority then 1 else -1

# Collect tasks returned by the API into different views.
collectByView: (tasks) ->
  today     = new Date()
  today     = today - (today.getHours() * 3600 + today.getMinutes() * 60 + today.getSeconds()) * 1000 - today.getMilliseconds()
  not_due   = ( task for task in tasks when isNaN(task.due_date))
  overdue   = ( task for task in tasks when not isNaN(task.due_date) and task.due_date < today)
  this_week = ( task for task in tasks when not isNaN(task.due_date) and task.due_date >= today + 86400 * 1000 and task.due_date <= today + 7 * 86400 * 1000)
  future    = ( task for task in tasks when not isNaN(task.due_date) and task.due_date > today + 7 * 86400 * 1000)
  today     = ( task for task in tasks when not isNaN(task.due_date) and task.due_date >= today and task.due_date < today + 86400 * 1000)
  { today: today, overdue: overdue, future: future, this_week: this_week, not_due: not_due }

# Verify that a given component is loaded and visible on screen.
isVisible: (component) ->
  window.components.hasOwnProperty(component) and
    window.components[component].css("display") != "none"

# RFC1422-compliant Javascript UUID function. Generates a UUID from a random
# number (which means it might not be entirely unique, though it should be
# good enough for many uses). See http://stackoverflow.com/questions/105034
generateUUID: ->
  'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, (c) ->
    r = Math.random() * 16 | 0
    v = if c is 'x' then r else (r & 0x3|0x8)
    v.toString(16)
  )

# Check if the given task is a recurring task. Useful to call the appropriate
# API method when marking a method as completed.
isRecurringTask: (task) ->
  date = task.date_string
  identifiers = ["every", "after", "monthly", "daily", "weekly", "yearly"]
  task.date_string
  for identifier in identifiers
    return true if date is $.trim(identifier)
    return true if date[...identifier.length] is identifier
  false

style: """
  top 0
  right 0
  padding 0
  width 30%
  background-color rgba(0,0,0,0.7)
  color: #9da3a4
  font-family "Oswald"
  border-bottom 4px solid rgba(0,0,0,0.4)
  border-left 4px solid rgba(0,0,0,0.4)

  .fa-invisible
    visibility hidden

  .title
    position relative
    left 20px
    height 20px
    padding 10px 0 20px
    margin 0

  .tasks
    white-space nowrap
    overflow-x hidden
    overflow-y auto
    list-style none
    padding 0 20px 20px
    margin 0

    li.task
      text-shadow 1px 1px 1px rgba(0,0,0,0.4)

    li[data-priority="4"] span
      color rgba(255,128,128,0.9)

    li[data-priority="3"] span
      color rgba(255,255,128,0.7)

    li[data-priority="2"] span
      color rgba(255,255,128,0.9)

    li.task.recurring
      color rgba(128,255,255,0.6)

    li.task.inbox
      color rgba(250,200,150,0.6)

    li
      small
        color rgba(255,255,255,0.3)
"""
