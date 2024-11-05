HSN = {}
HSN.PlayerData = {}
HSN.RoutestList = {}
HSN.VehicleList = {}
HSN.DailyMissions = {}
HSN.SelectedArea = undefined
HSN.SelectedVehicle = undefined
HSN.RemainingTime = undefined
HSN.PlayerPhoto = undefined
HSN.Messages = {}
HSN.XPTable = {}
HSN.ClassList = {}
window.addEventListener('message', function(event) {
    if (event.data.message == "close") {
        HSN.CloseUI()
    } else if (event.data.message == "open") {
        $(".jobinfo").hide()
        HSN.Messages = event.data.innermessages
        HSN.DailyMissions = event.data.DailyMissions
        HSN.RemainingTime = event.data.remainingtime
        HSN.XPTable = event.data.xptable
        HSN.RoutestList = event.data.routeslist
        HSN.VehicleList = event.data.vehiclelist
        HSN.ClassList = event.data.classlist
        HSN.PlayerPhoto = event.data.photo
        HSN.SetRoutes()
        HSN.OpenNUI(event.data.postopData)
        HSN.SetLeaderBoard(event.data.LeaderBoard)
    } else if (event.data.message == "OpenJobDescription") {
        HSN.OpenJobDesc(event.data)
    } else if (event.data.message == "closejob") {
        $(".jobinfo").fadeOut(200)
    }
});

// functions

HSN.CloseUI = function() {
    $(".general").fadeOut(250)
}

HSN.OpenNUI = function(postopData) {
    if (postopData == undefined) {
        return
    }
    $(".toptext1").html('<h1 style="font-size: 1vw; line-height: 90%; color: white; letter-spacing: .02vw;">'+HSN.Messages["welcome"]+' <span>'+postopData.name+'</span></h1>')
    $(".player-info-box-username").html(postopData.name)
    $(".leftclassbg").html('<h1 style="letter-spacing: .08em; font-size: .8vw;">'+postopData.class.label+'</h1>')
    $(".profiletext").html(`
        <h1 style="font-family: Proxima Bold; font-size: 1.1vw; color: white; letter-spacing: .05vw;">`+postopData.name+`</h1>
        <h1 style="font-family: Proxima Bold; font-size: .9vw; line-height: 60%; color: white; opacity: 50%;">Lv.`+postopData.level+`</h1>
    `)
    HSN.PlayerData = postopData
    $(".missions-resettime").find("h1").html(HSN.RemainingTime+' <i class="fas fa-clock"></i>')
    $("#playerLevel-index").html("Lv."+postopData.level)
    $("#playerLevel").html(HSN.PlayerData.leaderboard+".")
    HSN.CheckDailyMissions()
    HSN.SetStatistics()
    HSN.SetLastJobs()
    if(HSN.PlayerPhoto != undefined) {
        $(".profile").html("<img src="+HSN.PlayerPhoto+">")
    }

        $(".uniformcont").css("border", "3px solid white")
        $("#bottomtextbg-wardrobe").css("background", "white")
        $("#bottomtextbg-wardrobe").html('<h1 style="font-size: 0.7vw; text-align: center; letter-spacing: 0.01em;  color: #3F3F3F;;">SELECT TO GO POST OP. BADGE</h1>')
        $('#circle-1').css("background-image" , "none")
        $("#circle-text-1").css("color", "#ffffff8f")
        $(".uniformcont").css("pointer-events", "auto")
        $(".routescont").css("border", "3px solid white")
        $("#bottomtextbg-route").css("background", "white")
        $("#bottomtextbg-route").html('<h1 style="font-size: 0.7vw; text-align: center; letter-spacing: 0.01em;  color: #3F3F3F;;">SELECT A POST OP ROUTE</h1>')
        $('#circle-2').css("background-image" , "none")
        $("#circle-text-2").css("color", "#ffffff8f")
        $(".routescont").css("pointer-events", "auto")
        $(".vehiclescont").css("border", "3px solid white")
        $("#bottomtextbg-vehicle").css("background", "white")
        $("#bottomtextbg-vehicle").html('<h1 style="font-size: 0.7vw; text-align: center; letter-spacing: 0.01em;  color: #3F3F3F;;">SELECT VEHICLE</h1>')
        $('#circle-3').css("background-image" , "none")
        $("#circle-text-3").css("color", "#ffffff8f")
        $('#circle-4').css("background-image" , "none")
        $("#circle-text-4").css("color", "#ffffff8f")
        $(".gopostbtn").css("background-image", "url(./img/gopostop-blocked.png)")
        $(".vehiclescont").css("pointer-events", "auto")
    if (postopData.job != undefined) {
        if (postopData.job.wardrobe) {
            HSN.SetCss("wardrobe")
        }
        if (postopData.job.route != "unknown") {
            HSN.SetCss("route")
        }
        if (postopData.job.vehicle) {
            HSN.SetCss("vehicle")
        }
    }
    $(".general").fadeIn(250)
}





HSN.SetLeaderBoard = function(LeaderBoard) {
    $(".leaderboard-cont").html()
    $(".leaderboard-cont").html(`<div class="flex h-[4.5vh] w-full daily-title justify-center items-center" >
    <p class="flex justify-center items-center w-[70%] h-full" style="text-align: center;">LEADERBOARD</p>
</div>`)
    $.each(LeaderBoard, function(index, valuet){
        order = Number(index) + 1
        $(".leaderboard-cont").append(`
            <div class="flex w-[90%] h-[4vh]" style="background: rgba(0, 0, 0, 0.8); border-radius: 0.25vw;" id=`+index+`>
                <div class="flex justify-center items-center w-1/4 h-full"><p class="leaderboard-number">`+order+`.</p></div>
                <div class="flex items-center w-1/2 h-full" ><p class="leaderboard-playername">`+valuet.name+`</p></div>
                <div class="flex items-center w-1/4 h-full" ><p class="leaderboard-level">Lv.`+valuet.level+`</p></div>
            </div>
        `)
    })
}

HSN.SetLastJobs = function() {
    var completed = 0
    if (HSN.PlayerData.lastjobs) {
        $(".overflow-menu").html("")
        $.each(HSN.PlayerData.lastjobs, function(index, valuet){
            completed = completed +1
            $(".compworksindex").html(completed)
            $(".overflow-menu").prepend(`
            <div class="flex w-[100%] h-[10%] lastwork-list ">
                <div class="flex h-full w-1/2  gap-[2vh] justify-end" >
                    <div class="flex h-full w-[95%] flex-col justify-center" >
                        <p class="work-name">`+valuet.route.jobtype+` WORK - `+valuet.route.route.label+`</p>
                        <p class="work-time">`+valuet.time+`</p>
                    </div>
                </div>
                <div class="flex h-full w-1/2 justify-end" >
                    <div class="flex h-full w-1/3 justify-center items-center" >
                        <p class="work-xp">`+valuet.earnedxp+`XP +</p>
                    </div>
                    <div class="flex h-full w-1/3 items-center">
                        <p class="work-earned">`+valuet.earnedmoney+`$ +</p>
                    </div>
                </div>
            </div>
            `
            )
        })
    }
    
    
}   

HSN.SetRoutes = function() {
    $.each(HSN.RoutestList, function(i, value){
        if (i == "transport") {
            $.each(HSN.RoutestList[i], function(index, valuet){
                $("#transport-"+index+"").find(".route-name").html(valuet.label)
                $("#transport-"+index+"").find(".delivery-amount-index").html(valuet.totalDelivery+ " Packages")
                $("#transport-"+index+"").find("#delivery-amount-price").html(valuet.revenue.price+ "$")
            })
        } else if (i == "cargo") {
            $.each(HSN.RoutestList[i], function(index, valuet){
                $("#area-name-"+index+"").html(valuet.label)
                $("#area-packageinfo-"+index+"").html(valuet.totalDelivery+ " Packages")
                $("#area-revenueinfo-"+index+"").html("$"+valuet.revenue.min+"-"+valuet.revenue.max)
            })
        }
    })
}

HSN.OpenJobDesc = function(data) {
    $("#job-remaining-index").html(data.deliver +" / "+data.totalDeliver)
    $("#vehicle-capacity-index").html(data.vehiclepackages+ " / "+ data.vehicleMaxCapacity)
    $(".jobinfo").fadeIn(200)
}

HSN.SetStatistics = function() {
    if (HSN.PlayerData) {
        $(".compworksindex").html(HSN.PlayerData.statistics.completedworks)
        $("#earnedmoney").html(HSN.PlayerData.statistics.earned+'$')
        $("#levelindex-level").html(HSN.PlayerData.level)
        var tt = HSN.XPTable[HSN.PlayerData.level]
        if (tt == undefined) {
            tt = HSN.PlayerData.xp
        }
        $("#xp-progress").html(HSN.PlayerData.xp+'/'+tt+"XP")
        var now = HSN.PlayerData.class.index

        if (now == 4) {
            $(".bottomtextclass").html(`
            <p class="nextclasstext"><p class="gold">`+HSN.PlayerData.class.label+`</p></p>
        `)
            return
        }
        $.each(HSN.ClassList, function(i, value){
            if (now + 1 == value.index) {
                $(".bottomtextclass").html(`
                    <p class="nextclasstext">Next Class :  <p class="gold">&nbsp; `+value.label+` at Lv.`+value.minlevel+` </p></p>
                `)
            }
        })
    }
}

HSN.DisableButtons = function() {
    $(".uniformcont").css("pointer-events", "none")
    $(".routescont").css("pointer-events", "none")
    $(".vehiclescont").css("pointer-events", "none")
}

HSN.EnableButtons = function() {
    $(".uniformcont").css("pointer-events", "auto")
    $(".routescont").css("pointer-events", "auto")
    $(".vehiclescont").css("pointer-events", "auto")
}

HSN.SetCss = function(dom) {
    if (dom == "wardrobe") {
        $(".uniformcont").css("border", "3px solid #F69401")
        $("#bottomtextbg-wardrobe").css("background", "#F69401")
        $("#bottomtextbg-wardrobe").html('<h1 style="font-size: 0.7vw; text-align: center; letter-spacing: 0.01em;  color: #3F3F3F;;">'+HSN.Messages["done"]+'</h1>')
        
        $('#circle-1').css("background-image" , "url('./img/check.png')")
        $("#circle-text-1").css("color", "white")
        $(".uniformcont").css("pointer-events", "none")
    } else if (dom == "route") {
        $(".routescont").css("border", "3px solid #F69401")
        $("#bottomtextbg-route").css("background", "#F69401")
        $("#bottomtextbg-route").html('<h1 style="font-size: 0.7vw; text-align: center; letter-spacing: 0.01em;  color: #3F3F3F;;">'+HSN.Messages["done"]+'</h1>')
        $('#circle-2').css("background-image" , "url('./img/check.png')")
        $("#circle-text-2").css("color", "white")
        $(".routescont").css("pointer-events", "none")
    } else if (dom == "vehicle") {
        $(".vehiclescont").css("border", "3px solid #F69401")
        $("#bottomtextbg-vehicle").css("background", "#F69401")
        $("#bottomtextbg-vehicle").html('<h1 style="font-size: 0.7vw; text-align: center; letter-spacing: 0.01em;  color: #3F3F3F;;">'+HSN.Messages["done"]+'</h1>')
        
        $('#circle-3').css("background-image" , "url('./img/check.png')")
        $("#circle-text-3").css("color", "white")
        $('#circle-4').css("background-image" , "url('./img/check.png')")
        $("#circle-text-4").css("color", "white")
        $(".gopostbtn").css("background-image", "url(./img/gopostop.png)")
        $(".vehiclescont").css("pointer-events", "none")
    }
}

HSN.CheckDailyMissions = function() {
    if (HSN.PlayerData) {
        if (HSN.PlayerData.DailyMissions) {
            if (HSN.PlayerData.DailyMissions.firstcargo.bool) {
                $("#statusbar-firstcargo").html('<div class="w-[100%] h-full" style="background: linear-gradient(90deg, #FFFFFF 0%, #F69401 101.3%); border-radius: 3vw;"></div>')
                $("#statustext-firstcargo").html("1/1")
                $("#statusbar-firstcargo-m").html('<div class="w-[100%] h-full" style="background: linear-gradient(90deg, #FFFFFF 0%, #F69401 101.3%); border-radius: 3vw;"></div>')
                $("#statustext-firstcargo-m").html("1/1")
            }
            if (HSN.PlayerData.DailyMissions.DeliverCargo.amount > 50) {
                $("#statusbar-delivermission").html('<div class="w-[100%] h-full" style="background: linear-gradient(90deg, #FFFFFF 0%, #F69401 101.3%); border-radius: 3vw;"></div>')
                $("#statustext-delivermission").html("50/50")
                $("#statusbar-delivermission-m").html('<div class="w-[100%] h-full" style="background: linear-gradient(90deg, #FFFFFF 0%, #F69401 101.3%); border-radius: 3vw;"></div>')
                $("#statustext-delivermission-m").html("50/50")
            } else {
                $("#statusbar-delivermission").html('<div class="w-['+HSN.PlayerData.DailyMissions.DeliverCargo.amount*2+'%] h-full" style="background: linear-gradient(90deg, #FFFFFF 0%, #F69401 101.3%); border-radius: 3vw;"></div>')
                $("#statustext-delivermission").html(HSN.PlayerData.DailyMissions.DeliverCargo.amount + "/50")
                $("#statusbar-delivermission-m").html('<div class="w-['+HSN.PlayerData.DailyMissions.DeliverCargo.amount*2+'%] h-full" style="background: linear-gradient(90deg, #FFFFFF 0%, #F69401 101.3%); border-radius: 3vw;"></div>')
                $("#statustext-delivermission-m").html(HSN.PlayerData.DailyMissions.DeliverCargo.amount + "/50")
            }
            if (HSN.PlayerData.DailyMissions.endofWork.bool) {
                $("#statusbar-endofwork").html('<div class="w-[100%] h-full" style="background: linear-gradient(90deg, #FFFFFF 0%, #F69401 101.3%); border-radius: 3vw;"></div>')
                $("#statustext-endofwork").html("1/1")
                $("#statusbar-endofwork-m").html('<div class="w-[100%] h-full" style="background: linear-gradient(90deg, #FFFFFF 0%, #F69401 101.3%); border-radius: 3vw;"></div>')
                $("#statustext-endofwork-m").html("1/1")
            }
            $.each(HSN.DailyMissions, function(i, index){
                $("#missionxp-"+i+"").html(index.xp+"XP")
                $("#missionxp-"+i+"m").html(index.xp+"XP")
            })

        }
    }
}




HSN.Select = function(type) {
    if (type == "route") {
        if (HSN.PlayerData.job) {
            if (HSN.PlayerData.job.wardrobe) {
                HSN.DisableButtons()
                $("#hsnloadbar").fadeIn(200)
                if (HSN.PlayerData) {
                    if (HSN.PlayerData.class.index == 3 || HSN.PlayerData.class.index == 4) {
                       $(".transportwork-main").css("background-image" , "url('./img/transport-work-bg-unreq.png')") 
                       $(".transport-work-requiredtext").fadeOut()
                    }
                }
                setTimeout(function(){
                    $("#hsnloadbar").fadeOut(300)
                    $(".workmain").fadeIn(100)
                    $(".route-firstselect").show()
                }, 1000);
            } else {
                // kiyafetini giy notification
            }
        }

    } else if (type == "cargo-work") {
        $(".route-firstselect").fadeOut(200)
        $("#hsnloadbar").fadeIn(200)
        setTimeout(function(){
            $("#hsnloadbar").fadeOut(100)
            $(".map-main").fadeIn(200)
            $(".select-work-text").html(HSN.Messages["selectroute"])
        }, 300);
    } else if (type == "transport-work") {
        if (HSN.PlayerData.class.index == 3 || HSN.PlayerData.class.index == 4) {
            $(".route-firstselect").fadeOut(200)
            $("#hsnloadbar").fadeIn(200)
            setTimeout(function(){
                $("#hsnloadbar").fadeOut(100)
                $("#transport-work-route").fadeIn(200)
                $(".select-work-text").html(HSN.Messages["selectroute"])
            }, 300);
        }

        
    } else if (type == "area-select-airport") {
        $(".map-main").fadeOut(200)
        $("#hsnloadbar").fadeIn(200)
        setTimeout(function(){
            $("#hsnloadbar").fadeOut(100)
            $("#map-airport").fadeIn(400)
            $(".select-work-text").html(HSN.Messages["selectroute"])
        }, 300);
    }   else if (type == "area-select-downtown") {
        $(".map-main").fadeOut(200)
        $("#hsnloadbar").fadeIn(200)
        setTimeout(function(){
            $("#hsnloadbar").fadeOut(100)
            $("#map-downtown").fadeIn(400)
            $(".select-work-text").html(HSN.Messages["selectroute"])
        }, 300);
    } else if (type == "area-select-sandy") {
        $(".map-main").fadeOut(200)
        $("#hsnloadbar").fadeIn(200)
        setTimeout(function(){
            $("#hsnloadbar").fadeOut(100)
            $("#map-sandy").fadeIn(400)
            $(".select-work-text").html(HSN.Messages["selectroute"])
        }, 300);
    } else if (type == "area-select-paleto") {
        $(".map-main").fadeOut(200)
        $("#hsnloadbar").fadeIn(200)
        setTimeout(function(){
            $("#hsnloadbar").fadeOut(100)
            $("#map-paleto").fadeIn(400)
            $(".select-work-text").html(HSN.Messages["selectroute"])
        }, 300);
    } else if (type == "select-airport") {
        if (HSN.PlayerData.class.index >= HSN.RoutestList["cargo"]["airport"].requiredIndex) {
            $(".cargo-area-index").html(HSN.Messages["areaselected"])
            HSN.SelectedArea = {rtype : "cargo", route : "airport"}
        } else {
            
        }
    } else if (type == "select-downtown") {
        if (HSN.PlayerData.class.index >= HSN.RoutestList["cargo"]["downtown"].requiredIndex) {
            $(".cargo-area-index").html(HSN.Messages["areaselected"])
            HSN.SelectedArea = {rtype : "cargo", route : "downtown"}
        }
    } else if (type == "select-sandy") {
        if (HSN.PlayerData.class.index >= HSN.RoutestList["cargo"]["sandy"].requiredIndex) {
            $(".cargo-area-index").html(HSN.Messages["areaselected"])
            HSN.SelectedArea = {rtype : "cargo", route : "sandy"}
        } else {
            
        }
    } else if (type == "select-paleto") {
        if (HSN.PlayerData.class.index >= HSN.RoutestList["cargo"]["paleto"].requiredIndex) {
            $(".cargo-area-index").html(HSN.Messages["areaselected"])
            HSN.SelectedArea = {rtype : "cargo", route : "paleto"}
        } else {
            
        }
    } else if (type == "transport-airport") {
        HSN.SelectedArea = {rtype : "transport", route : "airport"}
        $.post("https://m-postop/UpdateJobData", JSON.stringify({rtype : HSN.SelectedArea.rtype, route : HSN.SelectedArea.route}));
        $(".workmain").fadeOut(300)
        $("#hsnloadbar").fadeIn(200)
        setTimeout(function(){
            $("#hsnloadbar").fadeOut(100)
            $(".route-firstselect").show()
            $("#transport-work-route").hide();
            HSN.EnableButtons()
        }, 350); 
    } else if (type == "transport-downtown") {
        HSN.SelectedArea = {rtype : "transport", route : "downtown"}
        $.post("https://m-postop/UpdateJobData", JSON.stringify({rtype : HSN.SelectedArea.rtype, route : HSN.SelectedArea.route}));
        $(".workmain").fadeOut(300)
        $("#hsnloadbar").fadeIn(200)
        setTimeout(function(){
            $("#hsnloadbar").fadeOut(100)
            $(".route-firstselect").show()
            $("#transport-work-route").hide();
            HSN.EnableButtons()
        }, 350); 
    } else if (type == "transport-sandy") {
        HSN.SelectedArea = {rtype : "transport", route : "sandy"}
        $.post("https://m-postop/UpdateJobData", JSON.stringify({rtype : HSN.SelectedArea.rtype, route : HSN.SelectedArea.route}));
        $(".workmain").fadeOut(300)
        $("#hsnloadbar").fadeIn(200)
        setTimeout(function(){
            $("#hsnloadbar").fadeOut(100)
            $(".route-firstselect").show()
            $("#transport-work-route").hide();
            HSN.EnableButtons()
        }, 350); 
    } else if (type == "transport-paleto") {
        HSN.SelectedArea = {rtype : "transport", route : "paleto"}
        $.post("https://m-postop/UpdateJobData", JSON.stringify({rtype : HSN.SelectedArea.rtype, route : HSN.SelectedArea.route}));
        $(".workmain").fadeOut(300)
        $("#hsnloadbar").fadeIn(200)
        setTimeout(function(){
            $("#hsnloadbar").fadeOut(100)
            $(".route-firstselect").show()
            $("#transport-work-route").hide();
            HSN.EnableButtons()
        }, 350); 
    } else if (type == "select-main") {
        if (HSN.SelectedArea) {
            $.post("https://m-postop/UpdateJobData", JSON.stringify({rtype : HSN.SelectedArea.rtype, route : HSN.SelectedArea.route}));
            $(".workmain").fadeOut(300)
            setTimeout(function(){
                $(".route-firstselect").show()
                $(".map-main").hide();
                $("#map-airport").hide();
                $("#map-downtown").hide();
                $("#map-sandy").hide();
                $("#map-paleto").hide();
                $(".cargo-area-index").html(HSN.Messages["selectthisarea"])
                HSN.EnableButtons()
            }, 350);
        } else {
            $(".workmain").fadeOut(300)
            setTimeout(function(){
                $(".route-firstselect").show()
                $(".map-main").hide();
                $("#map-airport").hide();
                $("#map-downtown").hide();
                $("#map-sandy").hide();
                $("#map-paleto").hide();
                $(".cargo-area-index").html(HSN.Messages["selectthisarea"])
                HSN.EnableButtons()
            }, 350);
        }
    } else if (type == "vehicle") {
        if (HSN.PlayerData.job.route != "unknown") {
            HSN.SetVehicles()
            $("#hsnloadbar").fadeIn(200)
            setTimeout(function(){
                $("#hsnloadbar").fadeOut(200)
                $(".vehiclemain").fadeIn(200)
                HSN.DisableButtons()
            }, 1000);
        }

    } else if (type == "select-vehicle") {
        if (HSN.SelectedVehicle) {
            $("#hsnloadbar").show()
            setTimeout(function(){
                $("#hsnloadbar").hide()
                $(".vehiclemain").hide()
                // setTimeout(function(){
                    $.post("https://m-postop/DestroyCam", JSON.stringify({}));
                    $.post("https://m-postop/SetVehicle", JSON.stringify({vehicle : HSN.SelectedVehicle}));
                // }, 300);
                HSN.EnableButtons()
                $(".select-work-text").html(HSN.Messages["selectwork"])
            }, 1000);
        }
    } else if (type == "infopage") {
        HSN.CheckDailyMissions()
        $(".main").fadeOut(100)
        setTimeout(function(){
            $(".main-user").fadeIn(200)
        }, 200);
    } else if (type == "backpostop") {
        $(".main-user").fadeOut(100)
        setTimeout(function(){
            $(".main").fadeIn(200)
        }, 200);
    }
}

HSN.GoBack = function(type) {
    if (type == "areaselect") {
        $(".map-main").fadeOut(200)
        $("#hsnloadbar").fadeIn(200)
        setTimeout(function(){
            $("#hsnloadbar").fadeOut(100)
            $(".route-firstselect").fadeIn(200)
            $(".select-work-text").html(HSN.Messages["selectwork"])
            $(".cargo-area-index").html(HSN.Messages["selectthisarea"])
        }, 300);
    } else if (type == "areas-airport") {
        $("#hsnloadbar").fadeIn(200)
        $("#map-airport").fadeOut(200)
        setTimeout(function(){
            $("#hsnloadbar").fadeOut(100)
            $(".map-main").fadeIn(400)
            $(".select-work-text").html(HSN.Messages["selectroute"])
            $(".cargo-area-index").html(HSN.Messages["selectthisarea"])
        }, 300);  
    } else if (type == "areas-downtown") {
        $("#hsnloadbar").fadeIn(200)
        $("#map-downtown").fadeOut(200)
        setTimeout(function(){
            $("#hsnloadbar").fadeOut(100)
            $(".map-main").fadeIn(400)
            $(".select-work-text").html(HSN.Messages["selectroute"])
            $(".cargo-area-index").html(HSN.Messages["selectthisarea"])
        }, 300);  
    } else if (type == "areas-sandy") {
        $("#hsnloadbar").fadeIn(200)
        $("#map-sandy").fadeOut(200)
        setTimeout(function(){
            $("#hsnloadbar").fadeOut(100)
            $(".map-main").fadeIn(400)
            $(".select-work-text").html(HSN.Messages["selectroute"])
            $(".cargo-area-index").html(HSN.Messages["selectthisarea"])
        }, 300);  
    } else if (type == "areas-paleto") {
        $("#hsnloadbar").fadeIn(200)
        $("#map-paleto").fadeOut(200)
        setTimeout(function(){
            $("#hsnloadbar").fadeOut(100)
            $(".map-main").fadeIn(400)
            $(".select-work-text").html(HSN.Messages["selectroute"])
            $(".cargo-area-index").html(HSN.Messages["selectthisarea"])
        }, 300);  
    }
}

HSN.SetVehicles = function() {
    if (HSN.PlayerData) {
        $.each(HSN.VehicleList, function(i, index){
            if (HSN.PlayerData.class.index >= index.requiredIndex) {
                $(".vehiclemain").find("[id="+i+"]").css("background-color", "rgba(246, 148, 1, 0.37)")
                $(".vehiclemain").find("[id="+i+"]").find("h1").css("color", "white")
                $(".vehiclemain").find("[id="+i+"]").find("h1").html(index.label)
            } else {
                $(".vehiclemain").find("[id="+i+"]").css("background-color", "rgba(0, 0, 0, 0.37)")
                $(".vehiclemain").find("[id="+i+"]").find("h1").css("color", "rgba(255, 255, 255, 0.33)")
                $(".vehiclemain").find("[id="+i+"]").find("h1").html(index.label+ " "+'<i class="fas fa-lock" style="color: rgba(255, 255, 255, 0.39);"></i>')
            }
        })
    }
}



HSN.ShowVehicleInfo = function(veh) {
    if (HSN.PlayerData.class.index >= HSN.VehicleList[veh].requiredIndex) {
        $("#hsnloadbar").fadeIn(200)
        $(".select-work-text").html(HSN.Messages["selectvehicle"])
        $("#vehicle-info-pckamount").html(HSN.VehicleList[veh].capacity + " "+ HSN.Messages["package"])
        $(".route-package").html(HSN.RoutestList[HSN.SelectedArea.rtype][HSN.SelectedArea.route].totalDelivery + " "+ HSN.Messages["package"])
        $("#veh-main-route-name").html(HSN.RoutestList[HSN.SelectedArea.rtype][HSN.SelectedArea.route].label)
        HSN.SelectedVehicle = veh
        $.post("https://m-postop/SetVehicleCam", JSON.stringify({vehicle : HSN.SelectedVehicle}));
        setTimeout(function(){
            $("#hsnloadbar").fadeOut(100)
            $(".vehicleinfo").fadeIn(300)
        }, 300);  
    } else {
        // notification
    }
}

HSN.StartJob = function(jobindex) {
    if (!jobindex) {
        return 
    }
    $("#hsnloadbar").fadeIn(200)
    setTimeout(function(){
        $("#hsnloadbar").fadeOut(300)
        $.post("https://m-postop/jobindex", JSON.stringify({index : jobindex}));
    }, 1000);
}




$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESC
            $.post("https://m-postop/CloseUi", JSON.stringify({}));
            break;
        case 113: // ESC
        $.post("https://m-postop/CloseUi", JSON.stringify({}));
            break;
    }
});

