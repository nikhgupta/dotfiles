function addGoogleFont(FontName) {
  $("head").append("<link href='https://fonts.googleapis.com/css?family=" + FontName + "' rel='stylesheet' type='text/css'>");
}
function log(message){
  console.log("[DotJS] " + message);
}

function appendDotJSLogo(){
  $("body").append("<h3 class='dotjs-logo'>Website customized with DotJS.</h3>");
  $("html").css({"padding-top": "40px"});
  $(".dotjs-logo").css({
    "position": "absolute",
    "top": "0",
    "left": "0",
    "color": "#742323",
    "background": "#f8f8f8",
    "padding": "7px 10px",
    "width": "100%",
    "text-align": "center",
    "border-bottom": "1px solid #999",
  });
}
