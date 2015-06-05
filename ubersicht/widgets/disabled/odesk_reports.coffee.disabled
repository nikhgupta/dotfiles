command: "zsh -c '$HOME/Code/__dotfiles/scripts/jarvis/bin/jarvis odesk preset --currency=INR --target-hours=4 --target-earnings=8000'"

refreshFrequency: 10 * 60 * 1000

style: """
  right 0
  bottom 206px

  .odesk
    color #dedede
    font-family "Oswald"

  h1
    min-width 496px
    background rgba(0,0,0,0.85)
    font-size 26px
    color rgba(255,255,255,0.7)
    text-align center
    margin 0
    padding 10px 10px 4px 10px
    border-bottom 4px solid rgba(0,0,0,0.2)

  .odesk span.title
    font-size 18px
    float right
    color: rgba(255,255,255,0.5)

  .odesk .box
    box-shadow 0 0 2px rgba(#000, 0.1)
    background rgba(0,0,0,0.7)
    padding 10px
    max-width 496px

  .odesk span.total
    min-width 172px
    float left

  .odesk span.habit
    font-size 16px
    float left

  .odesk .hourlies.last-7-days
    position fixed
    right  326px
    bottom 138px
    span.total
      min-width 170px


  .odesk .earnings.last-7-days
    position fixed
    right  0
    bottom 138px

  .odesk .hourlies.last-30-days
    position fixed
    right  0
    bottom 68px

  .odesk .earnings.last-30-days
    position fixed
    right  0
    bottom 0

  .habit .red
    color #f99

  .habit .yellow
    color #dda

  .habit .green
    color #8f8

  .habit .white
    color #fff
"""

render: (output) -> """
  <link href='./vendor/fonts/oswald.css' rel='stylesheet' type='text/css'>
  <div class='odesk report'>
    <h1>Freelancing Work</h1>
    <div class="response" data-response='#{output}'></div>
    <div class='box hourlies last-7-days'>
      <span class='total'>0 hours</span><br/>
      <span class='habit'></span>
    </div>
    <div class='box earnings last-7-days'>
      <span class='title'>oDesk: Last 7 days..</span>
      <span class='total'></span><br/>
      <span class='habit'></span>
    </div>
    <div class='box hourlies last-30-days'>
      <span class='title'>oDesk: Last 30 days..</span>
      <span class='total'>0 hours</span><br/>
      <span class='habit'></span>
    </div>
    <div class='box earnings last-30-days'>
      <span class='total'></span><br/>
      <span class='habit'></span>
    </div>
  </div>
"""

afterRender: (domEl) ->
  response = $(".odesk .response").data("response")

  if response.error
    $(".odesk").css("display", "none")
  else
    response = JSON.parse response
    $(".odesk").css("display", "block")
    $(".hourlies.last-7-days .total").html(response.hourlies.day7.total + " hours")
    $(".hourlies.last-7-days .habit").html(response.hourlies.day7.habit)

    $(".hourlies.last-30-days .total").html(response.hourlies.day30.total + " hours")
    $(".hourlies.last-30-days .habit").html(response.hourlies.day30.habit)

    $(".earnings.last-7-days .total").html(response.earnings.day7.total + " " + response.earnings.day7.currency)
    $(".earnings.last-7-days .habit").html(response.earnings.day7.habit)

    $(".earnings.last-30-days .total").html(response.earnings.day30.total + " " + response.earnings.day30.currency)
    $(".earnings.last-30-days .habit").html(response.earnings.day30.habit)
