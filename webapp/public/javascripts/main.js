$(document).on("ready", function() {
  $("a.star-bucket").on("click", function(e) {
    e.preventDefault();
    $(this).addClass("disabled").attr("disabled", "disabled");
    var that = this
    if ($(this).hasClass("active")) {
      $.post("/buckets/" + $(this).attr("data-bucket-id") + "/unstar", function(data) {
        $(that).removeClass("disabled");
        $(that).removeAttr("disabled");
        $(that).removeClass("btn-warning active");
        $(that).addClass("btn-default");
        $(that).html('<span class="glyphicon glyphicon-star-empty"></span>');
      });
    } else {
      $.post("/buckets/" + $(this).attr("data-bucket-id") + "/star", function(data) {
        $(that).removeClass("disabled");
        $(that).removeAttr("disabled");
        $(that).addClass("btn-warning active");
        $(that).html('<span class="glyphicon glyphicon glyphicon-star"></span>');
      });
    }
    return false;
  });

  $("a.star-object").on("click", function(e) {
    e.preventDefault();
    $(this).addClass("disabled").attr("disabled", "disabled");
    var that = this
    if ($(this).hasClass("active")) {
      $.post("/objects/" + $(this).attr("data-object-id") + "/unstar", function(data) {
        $(that).removeClass("disabled");
        $(that).removeAttr("disabled");
        $(that).removeClass("btn-warning active");
        $(that).addClass("btn-default");
        $(that).html('<span class="glyphicon glyphicon-star-empty"></span>');
      });
    } else {
      $.post("/objects/" + $(this).attr("data-object-id") + "/star", function(data) {
        $(that).removeClass("disabled");
        $(that).removeAttr("disabled");
        $(that).addClass("btn-warning active");
        $(that).html('<span class="glyphicon glyphicon glyphicon-star"></span>');
      });
    }
    return false;
  });
})
