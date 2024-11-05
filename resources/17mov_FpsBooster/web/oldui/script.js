$(".child").click(function() {
    let value = $(this).attr("id")
    let boolean = false
    if ($(this).hasClass("active")) {
        $(this).removeClass("active")
    } else {
        boolean = true
        $(this).addClass("active")
    }

    $.post(`https://${GetParentResourceName()}/changeOption`, JSON.stringify({ option: value, boolean: boolean}));
});

window.addEventListener('message', function (event) {
    let action = event.data.action
    if (action == "openMenu") {
        let currentOptions = event.data.settings
        for (var k in currentOptions){
            if (currentOptions[k] == true) {
                if (!$("#" + k).hasClass("active")) {
                    $("#" + k).addClass("active")
                }
            } else {
                $("#" + k).removeClass("active")
            }
        }
        $(".hider").fadeIn(250)
    }
})

$(document).keyup(function(e) {
    if (e.keyCode == 27) {
        $(".hider").fadeOut(250)
        $.post(`https://${GetParentResourceName()}/exitMenu`);
    }
});