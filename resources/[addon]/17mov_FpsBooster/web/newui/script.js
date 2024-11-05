$(".switchOption").click(function() {
    let value = $(this).attr("id")
    let boolean = false
    if (value.includes("ON")) {
        boolean = true
        value = value.replace("ON", "")
        $(`#${value}`).css("margin-left", "-1px");
        $(`#${value}OFF`).removeClass("selectedOFF");
        $(`#${value}ON`).addClass("selectedON");
    } else {
        value = value.replace("OFF", "")
        $(`#${value}`).css("margin-left", "39px");
        $(`#${value}OFF`).addClass("selectedOFF");
        $(`#${value}ON`).removeClass("selectedON");
        
    }

    $.post(`https://${GetParentResourceName()}/changeOption`, JSON.stringify({ option: value, boolean: boolean}));
});

window.addEventListener('message', function (event) {
    let action = event.data.action
    if (action == "openMenu") {
        let currentOptions = event.data.settings
        for (var k in currentOptions){
            if (currentOptions[k] == true) {
                $(`#${k}`).css("margin-left", "-1px");
                $(`#${k}OFF`).removeClass("selectedOFF");
                $(`#${k}ON`).addClass("selectedON");
            } else {
                $(`#${k}`).css("margin-left", "39px");
                $(`#${k}OFF`).addClass("selectedOFF");
                $(`#${k}ON`).removeClass("selectedON");
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