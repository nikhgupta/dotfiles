preferredSession: "tests"
refreshFrequency: 5000
command: "osascript -e 'tell application \"iTerm\"'
                    -e 'repeat with sess in sessions of current terminal'
                    -e 'if name of sess = \"on desktop (zsh)\" then'
                    -e 'return text of sess'
                    -e 'end if' -e 'end repeat' -e 'end tell' |
                    sed -e '/^$/d' -e 's/$/<br>/'"
render: (output) -> """
  <pre class="output info" data-state=0><code>#{output}</code></pre>
"""
style: """
  top 0
  left 0
  width 70%
  height 500px
  background rgba(0,0,0,0.8)
  color rgba(255,255,255,0.7)
  font-family: monospace;
  overflow: scroll;
  padding: 20px 20px;

  pre
    margin 0
    font-size 12px
    line-height 10px
"""

update: (output, domEl) ->
  console.log output
  $(domEl).find("pre.output code").html(output)
  if output.length > 0
    el = $(domEl).find(".output")
    el.scrollTop(el[0].scrollHeight)
