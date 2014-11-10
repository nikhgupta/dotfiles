log("adding Droid Sans font from Google...");
addGoogleFont("Droid+Sans:400,700");

log("Changing background and text colors..");
$("*").css({
  "color": "#666",
  "background": "#f8f8f8",
  "font-family": "\"Droid Sans\", sans-serif"
});

$(".logo-image").html("<h1>BlackhatWorld Forums</h1>");
$(".logo-image h1").css({
  "font-size": "2.5em",
  "padding": "30px 0 20px"
});

$("h4.threadtitle a").css({
  "font-size": "1.1em",
  "letter-spacing": "0.6px",
});

$("a").css({
  "text-decoration": "none",
  "color": "#339"
})

$(".inlineimg, .forumicon").css({"display": "none"});

appendDotJSLogo();
