#!/usr/bin/env osascript

my dismissActiveNotifications()

on dismissActiveNotifications()
  set nDismissedNotifications to 0

  repeat # until there are none notifications left
    my checkIfNotificationStuck(nDismissedNotifications)

    set notification to my getFirstNotification()
    if notification is missing value then
      log "No notifications, done"
      return
    end if

    # notification have to be closed differently based on type
    tell application "System Events" ¬
      to set notificationType to role description of notification

    if notificationType contains "alert" then
      my dismissAlertNotification(notification)
    else if notificationType contains "banner" then
      my dismissAllBannerNotifications()
    else # something weird
      display notification "Manual closing required" ¬
        with title "Error: non-standard notification"
      error "Error: unknown notification type"
    end if

    set nDismissedNotifications to (nDismissedNotifications + 1)
  end repeat
end dismissActiveNotifications

on getFirstNotification()
  tell application "System Events" ¬
    to set notificationWindows to windows of process "Notification Center"

  if ((count notificationWindows) < 1) then
    return missing value
  end if

  set notification to first item of notificationWindows

  # if notification center is open, then it occupies the first window and
  #+ is a false positive, in that case we try to get the 2nd window
  set isNotificationCenterOpen to ((name of notification) is "Notification Center")
  if isNotificationCenterOpen then
    log "Notification center is open"

    # if another window exists then it is a genuine notification
    if ((count notificationWindows) > 1) then
      set notification to second item of notificationWindows
    else
      return missing value
    end if
  end if

  return notification
end getFirstNotification

on dismissAlertNotification(notification)
  tell application "System Events" ¬
    to set closeButton to a reference to button "Close" of notification

  if closeButton exists then
    log "Dismissing an alert notification"
    tell application "System Events" to click closeButton
    delay 0.2 # wait (approximately) for it to disappear
  else
    # some applications make custom alert notifications without a close
    #+ button (e.g. System Preferences with its update alert)
    display notification "Manual closing required" ¬
      with title "Error: notification has no close button"
    error "Error: can't close alert notification, no close button"
  end if
end dismissAlertNotification

on dismissAllBannerNotifications()
  log "Dismissing all banner notifications"

  # banner notifications don't have any buttons so our
  #+ only option is to "restart" the notification center
  # restarting it removes all banner notifications
  do shell script "killall NotificationCenter"

  # wait for NotificationCenter to "restart" so that we can
  #+ normally process any remaining notifications (i.e. alert
  #+ notifications as they persist restarts)
  delay 1
end dismissAllBannerNotifications

on checkIfNotificationStuck(nDismissedNotifications)
  # if we dismiss (or think we dismissed) more than 20 notifications
  #+ abort as then there is a high probabily that a notification got
  #+ stuck, then abort
  set isNotificationStuck to (nDismissedNotifications > 20)
  if isNotificationStuck then
    display notification "Manual closing required" ¬
      with title "Error: can't close notifications"
    error "Error: can't close notifications, possibly a stuck notification"
  end if
end checkIfNotificationStuck
