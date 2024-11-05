let notifications = []


function GenerateNotification(message, type, timeout) {
    let id = notifications.length + 1;
    let colors = {
        ["succes"]: "#2abdc7",
        ["error"]: "#d4423d",
        ["info"]: "#FBD33F",
    }
    if (type == null) {
        type = "succes";
    }
    if (timeout == null) {
        timeout = 5000;
    }
    if (message == null) {
        message = "UNKOWN";
    }
    // audioPlayer = new Audio("./codemnotify.ogg");
    // audioPlayer.volume = 0.9;
    // audioPlayer.play();
    let html = `
       <div style="transform: translateX(-165px)" class="notify" id="notify-${id}">
       <img src="./images/notfiy-logo.png">
       <div class="notify-container-js">
                <P class="notify-header">Notify</P>
                <P class="notify-text">${message}</P>
        </div>
       <div class="top-line"></div>
       <div class="notify-dots-${type}"></div>
     </div>
   `
    $('.notify-container').append(html)
    anime({
        targets: `#notify-${id}`,
        translateX: "-165",
        duration: 550,
        easing: "spring(1, 70, 100, 10)",
    });
    notifications[id] = setTimeout(() => {
        anime({
            targets: `#notify-${id}`,
            translateX: "165px",
            duration: 550,
            easing: "spring(1, 70, 100, 10)",
        });
        setTimeout(() => {
            $("#notify-" + id).remove();
            notifications[id] = null;
        }, 150);
    }, timeout)
}




window.addEventListener("message", function (event) {
    var item = event.data;

    switch (item.action) {
        case "OPEN_MENU":
              app.showUI();
            app.getData(item.playerTaxiData)
             setTimeout(function () {

                 app.SetProgressBar(2000)
             }, 100)
            break;
        case "GETDATA":
             app.setData(item.playerTaxiData)
             break;
        case "SPOTDATA":
            app.getSpotData(item.value, item.vehicle, item.posData, item.achivements, item.generalLevel, item.keyControl)
            break;
        case "ToggleTaxiMeterMenu":
            app.ToggleTaxiMeterMenu(item.value)
            break
        case "send_response":
            app.GetResponse(item.resourceName)
            break;
        case "LOCALES":
            app.language(item.value)
            break;
        case "CLOSE_MENU":
            app.hideUI()
            break
        case "editModeActive":
            this.setTimeout(function () {
                app.InitDrag();
            }, 1000)
            break;
        case "dragData":
            app.dragData(item.value)
            break;
        case "openKeyMenu":
            app.openKeyMenu(item.val)
            break;
        case "openTaximeterAndcabMenu":
            app.getTaximeterAndCabData(item.value)
            break;
        case "taxiOn":
            app.taximeterIconImg(item.value)
            break;
        case "UPDATE_MILE":
            app.getMileAndPrice(item.mile, item.earning , item.time)
            break;
        case "TIMER_START":
            app.startTimer(item.value);
            break;
        case "REFRESH_ACHIEMENTS":
            app.refreshAchievements(item.value)
            break
        case "NOTIFY":
            app.notify(item.msg)
            break;
        case "SCAMMER_POINT":
            app.changeScammer(item.value)
        break;

        default:

            break;
    }
});




const app = new Vue({
    el: "#app",

    data: {
        show: false,
        page: 'loading',            // sayfaları ayarladığım yer
        categoriesPage: 'stage1',   // kategorileri ayarladığım yer
        languages: {},              // dilleri ayarladığım yer
        progressBar: null,          // progressbarı ayarladığım yer
        continuebutton: false,      // devam etme butonunu ayarladığım yer
        resourceName: '',           // resource ismini ayarladığım yer
        spotData: '',               // Configden gelen SpotData spotları ayarladığım yer
        vehicleData: '',            // Configden gelen VehicleData araçları ayarladığım yer
        buttonArray: {},            // Butonları click olduğunda işlem yaptığım yerler
        goto: 1,                    // Scroll için gerekli
        direction: '',              // Scroll için gerekli
        playerSelectMoney: '',      // Para seçimi için gerekli
        playerMoneySelectMenu: false, // Para seçimi için gerekli olan menünün açılıp kapanmasını ayarladığım yer
        playerTaxiData: '',          // PlayerDatası sqlden gelen
        positionsData: {},          // Taximeterin positionu için
        taxiMeterMenu: false,       // Taximeter menüsünün açılıp kapanmasını ayarladığım yer
        cabMenu: false, // Cab menüsünün açılıp kapanmasını ayarladığım yer
        editModeMenu: false, // Edit mode menüsünün açılıp kapanmasını ayarladığım yer
        taximeterIcon: false, // Npc arabaya bindiğikten sonra taximeterin beyazlaşmasını ayarladığım yer
        selectMission: { // Görev seçimi için gerekli olan yer
            ['route']: null, // Görev seçimi için gerekli olan yer
            ['car']: null, // Görev seçimi için gerekli olan yer
            ['startMission']: false, // Görev seçimi için gerekli olan yer
        },
        goCabArray: {
            ['way']: null,
            ['earnmin']: null,
            ['earnmax']: null,
            ['xpmin']: null,
            ['xpmax']: null,
            ['vehicleText']: null,
            ['vehicleImage']: null,
            ['background']: null,
        },
        npcTaxiWork: false,              // Helper kutularının gösterilip gösterilmemesini ayarladığım yer
        taximeterMile: 0, // Taximeterdeki km yi ayarladığım yer
        taximeterEarning: 0, // Taximeterdeki kazancı ayarladığım yer
        activeTaximeterButton: true, // yapılacak
        npcTimer: null,
        taximeterTime: '00:00',
        leaderBoardData: '',
        firstLeader: '',
        historyData: '',
        firstHistory: '',
        achievementsSwiper: false,
        achievementsData: '',
        generalLevel: '',
        timeoutwithdraw: false,
        calculateXp: 0,
        timeout: false,
        urlImage: '',
        playerAchivements: '',
        parseDataHistory: '',
        playerRank: 0,
        npcCabbing: true,
        addExtra: true,
        keyControl: '',
        npcScammer: 0,
        calculateScammer: 0,

    },
    mounted() {

        document.onkeydown = (evt) => {
            evt = evt || window.event;
            var isEscape = false;
            if ("key" in evt) {
                isEscape = (evt.key === "Escape" || evt.key === "Esc");
            } else {
                isEscape = (evt.keyCode === 27);
            }
            if (isEscape) {
                this.hideUI();

                this.editModeMenu = false;
                this.cabMenu = false;
                if (this.progressBar) {
                    this.progressBar.destroy()
                    this.progressBar = null
                }


            }
        };


        this.UpdateTimesTaxi();
        setInterval(() => {
            this.UpdateTimesTaxi();
            this.$forceUpdate();

        }, 1000)

    },
    watch: {
        npcCabbing(val) {
            this.activeTaximeterButton = true
            this.addExtra = val
            this.taximeterIcon = !val
        },
        taxiMeterMenu(val) {

            $.post(`https://${this.resourceName}/taximeter:visible:changed`, JSON.stringify({
                val,

            }));
        },

    },

    computed: {
     
        historybackground() {
            return (val) => {
                if (val == 'DOWNTWON') {
                    return {
                        ['background-image']: 'url(images/downtwon.png)'
                    }
                }
                if (val == 'SANDY SHORES') {
                    return {
                        ['background-image']: 'url(images/downtwon-sandy.png)'
                    }
                }
                if (val == 'PALETO BAY') {
                    return {
                        ['background-image']: 'url(images/downtwon-paleto.png)'
                    }
                }
            }
        },


    },
    methods: {
        changeScammer(val){
            this.calculateScammer  = val;
        },
        language(val){
            this.languages = val;
      
         
        },
        notify(mesaj){
            GenerateNotification(mesaj, 'error',)
        },

        withdrawMoney() {
            if (!this.timeoutwithdraw && this.playerTaxiData[0].taximoney > 0) {
                this.timeoutwithdraw = true

                if (this.playerTaxiData[0].paytype == '0') {
                    return GenerateNotification(this.languages['CHOOSEAPAYMENT'], 'error',)
                }

                $.post(`https://${this.resourceName}/codemTaxi`, JSON.stringify({
                    action: 'withdrawMoney',
                    paytype: this.playerTaxiData[0].paytype
                }));

                this.playerTaxiData[0].taximoney = 0;

                setTimeout(() => {
                    this.timeoutwithdraw = false
                }, 500)
            }
        },

        photoClick(val) {
            if (val == 'discord') {
                $.post(`https://${this.resourceName}/codemTaxi`, JSON.stringify({
                    action: 'profilePicture',
                    value: val
                }));
            } else if (val == 'delete') {
                $.post(`https://${this.resourceName}/codemTaxi`, JSON.stringify({
                    action: 'profilePicture',
                    value: val
                }));
            } else if (val == 'url') {

                if (this.urlImage) {
                    $.post(`https://${this.resourceName}/codemTaxi`, JSON.stringify({
                        action: 'profilePicture',
                        value: val,
                        url: this.urlImage
                    }));
                    this.urlImage = '';
                }
            }
        },
        setupAchievementsSwiper() {
            if (this.achievementsSwiper) {
              
                this.achievementsSwiper.destroy()
            }
            Vue.nextTick(() => {
                this.achievementsSwiper = new Swiper('.mySwiper', {
                    direction: 'horizontal',
                    rewind: true,

                    slidesPerView: 3,
                    spaceBetween: 30,
                    slidesPerGroup: 3,
                    pagination: {
                        el: ".swiper-pagination",
                        clickable: true,
                    },
                });
            })
        },

        startTimer(value) {
            this.npcTimer = value;
        },

        UpdateTimesTaxi: function () {
            var startDate = new Date()
            if (this.npcTimer) {
                let seconds = this.npcTimer - startDate.getTime() / 1000;
                if (seconds <= 0) {
                    this.npcTimer = null;
                    $.post(`https://${this.resourceName}/codemTaxi`, JSON.stringify({
                        action: 'timerFinish',

                    }));
                    GenerateNotification(this.languages['TIMEISUP'], 'error',)
                }
                seconds = this.toHHMMSStaxi(seconds);
                this.taximeterTime = seconds;
            }
        },

        toHHMMSStaxi: function (secs) {
            var sec_num = parseInt(secs, 10);
            var hours = Math.floor(sec_num / 3600);
            var minutes = Math.floor(sec_num / 60) % 60;
            var seconds = sec_num % 60;
            return [hours, minutes, seconds]
                .map((v) => (v < 10 ? "0" + v : v))
                .filter((v, i) => v !== "00" || i > 0)
                .join(":");
        },

        newNpcRoute(playerlevel, spotlevel, route) {
          
            if (playerlevel >= spotlevel) {
                $.post(`https://${this.resourceName}/codemTaxi`, JSON.stringify({
                    action: 'newCustomer',
                    route: route
                }));
                for (key in this.buttonArray) {
                    this.buttonArray[key] = false
                }
                this.buttonArray[route] = !this.buttonArray[route];
                this.$forceUpdate();
                this.closepage();
                GenerateNotification(this.languages['PASSENGERISWAITING'], 'error',)
            } else {
                GenerateNotification(this.languages['YOUNEEDTO'] + spotlevel + this.languages['TOSTARTMISSION'] , 'error',)
            }
        },

        getMileAndPrice(mile, earning,val3) {
            this.taximeterMile = mile;
            this.taximeterEarning = earning;
            if (val3) {
                this.taximeterTime = val3;
            }
        },

        taximeterIconImg(val) {
            this.taximeterIcon = val;
        },

        setCategories(val) {
            if (val == 'stage2') {
                if (this.selectMission.route) {
                    this.categoriesPage = val
                }
            }
            if (val == 'stage3') {
                if (this.selectMission.route && this.selectMission.car) {
                    this.categoriesPage = val
                }
            }
            this.categoriesPage = val
        },

        getTaximeterAndCabData(val) {
            if (!val) {
                this.taxiMeterMenu = false;
            }
       
            this.npcTaxiWork = val
        },

        editModeBg() {
            this.editModeMenu = false;
            $.post(`https://${this.resourceName}/editModeActive`, JSON.stringify({
                toggle: false
            }));
        },

        defaultPosition() {
            $.post(`https://${this.resourceName}/codemTaxi`, JSON.stringify({
                action: 'deafultPosition'
            }));
        },

        editTaximeterMode() {
            $.post(`https://${this.resourceName}/editModeActive`, JSON.stringify({
                toggle: true
            }));
            this.cabMenu = false;
            this.editModeMenu = true;
            if (!this.taxiMeterMenu) {
                this.taxiMeterMenu = true;
            }
        },
        disableNpcMode() {
            this.npcCabbing = !this.npcCabbing;

            $.post(`https://${this.resourceName}/codemTaxi`, JSON.stringify({
                action: 'npcCabbing',
                toggle: this.npcCabbing
            }));


        },
        ToggleTaxiMeterMenu(val) {
            this.taxiMeterMenu = val
        },
        openKeyMenu(val) {
            if (val == 'cabmenu') {
                this.cabMenu = true;
            } else if (val == 'addextra') {
                this.npcScammer = Math.floor(Math.random() * (30 - 1 + 1)) + 1;
                this.calculateScammer = this.calculateScammer += this.npcScammer;
                GenerateNotification(this.languages['PASSENGERCANUNDER'], 'error',)
                $.post(`https://${this.resourceName}/codemTaxi`, JSON.stringify({
                    action: 'scammerPrice',
                    val: this.calculateScammer
                }));
                if (this.calculateScammer > 100) {
                    this.calculateScammer = 100;
                }
                if (this.calculateScammer > 95) {

                    GenerateNotification(this.languages['PASSENGERCHEATING'], 'error',)
                    $.post(`https://${this.resourceName}/codemTaxi`, JSON.stringify({
                        action: 'scammerPrice',
                        val  : 'scammer'
                    }));
                }


            } else if (val == 'taximeter') {
                this.taxiMeterMenu = !this.taxiMeterMenu
            };
        },

        dragData(val) {
            this.positionsData = val
        },

        InitDrag() {

            $('.taximeter-container').draggable({
                helper: "clone",
                revertDuration: 0,
                revert: "invalid",
                cancel: ".item-nodrag",
                containment: "body",
                scroll: false,
                start: function (event, ui) { },
                drag: function (event, ui) { },
                stop: (event, ui) => {
                    let left = ui.position.left
                    let top = ui.position.top
                    let type = $(event.target).attr('data-type')
                    $.post(`https://${this.resourceName}/codemTaxi`, JSON.stringify({
                        action: "dragData",
                        val: {
                            ...this.positionsData,
                            [type]: {
                                position: 'absolute',
                                left: left + 'px',
                                top: top + 'px'
                            }
                        }
                    }));


                }
            });
        },

        getData(playerdata) {
            this.playerTaxiData = playerdata;
            this.calculateXp = ((this.playerTaxiData[0].xp / this.generalLevel[this.playerTaxiData[0].level]) * 100).toFixed(0);
            if (this.playerTaxiData[0].history) {
                this.parseDataHistory = JSON.parse(this.playerTaxiData[0].history)
            }


        },
        setData(value){
            this.playerTaxiData = value;
        },

        showMoneyMenu() {
            this.playerMoneySelectMenu = !this.playerMoneySelectMenu;
        },

        setChangeMoney(val) {

            $.post(`https://${this.resourceName}/codemTaxi`, JSON.stringify({
                action: 'payType',
                value: val
            }), (data) => {
                this.playerSelectMoney = data;
                this.playerTaxiData[0].paytype = val;
                GenerateNotification(this.languages['PAYMENTOPTION'], 'error',)
            });

            setTimeout(() => {
                this.playerMoneySelectMenu = false;
            }, 1000)
        },

        onWheel: function (event) {
            event.preventDefault();
            if (event.deltaY >= 0) {

                if (this.direction !== 'up') {
                    this.direction = 'up';
                    $('.page-2-middle-profile').addClass('animate__fadeInDown').removeClass('animate__fadeInUp')
                }

            }
            if (event.deltaY > 0) {

                if (this.direction !== 'down') {
                    this.direction = 'down';
                    $('.page-2-middle-profile').addClass('animate__fadeInUp').removeClass('animate__fadeInDown')
                }

            }


            this.goto += event.deltaY * +0.01;
            this.goto = Math.min(Math.max(.0, this.goto), 3);


            if (this.goto <= 0) {
                return this.goto = 1
            }

            if (this.goto == 1) {

                setTimeout(() => {
                    if (this.achievementsSwiper) {
                       this.achievementsSwiper.destroy()
                    }
                 }, 10)
                this.categoriesPage = 'profile1'
                $('.page-3-logo h2').text('PROFILE');
                $('.page-3-logo h3').text('PROFILE');
   
                setTimeout(() => {
                    this.setupAchievementsSwiper();
                }, 11)

            } else if (this.goto == 2) {
                this.categoriesPage = 'profile2';
                $('.page-3-logo h2').text('LEADERBOARD');
                $('.page-3-logo h3').text('LEADERBOARD');

            } else if (this.goto == 3) {
                this.categoriesPage = 'profile3'
                $('.page-3-logo h2').text('CAB HISTORY');
                $('.page-3-logo h3').text('CAB HISTORY');
            }
        },

        changeCategoriesPage(val) {
            this.categoriesPage = val;
            if (val == 'profile1') {
                $('.page-3-logo h2').text('PROFILE');
                $('.page-3-logo h3').text('PROFILE');
                setTimeout(() => {
                    this.setupAchievementsSwiper();
                }, 11)
            }else if (val == 'profile2') {
                $('.page-3-logo h2').text('LEADERBOARD');
                $('.page-3-logo h3').text('LEADERBOARD');
            }else if (val == 'profile3') {
                $('.page-3-logo h2').text('CAB HISTORY');
                $('.page-3-logo h3').text('CAB HISTORY');
            }
        },

        newRoute(playerlevel, spotlevel, route, val, missions, stage, earnmin, earnmax, xpmin, xpmax) {

            if (playerlevel < spotlevel) {
                return GenerateNotification(this.languages['YOUNEEDTO'] + spotlevel + this.languages['TOSTARTMISSION'] , 'error',)
            }
            if (route != 'stage3' && !this.buttonArray[val]) {
                return this.buttonArray[val]
            }
            if (route == 'stage1') {
                this.categoriesPage = stage;
                this.selectMission['route'] = missions;
                if (missions == 'downtwon') {
                    this.goCabArray['way'] = 'DOWNTOWN';
                    this.goCabArray['background'] = './images/spot-cab.png';
                } else if (missions == 'sandy') {
                    this.goCabArray['background'] = './images/spot-sandy.png';
                    this.goCabArray['way'] = 'DOWNTOWN - SANDY SHORES';
                } else {
                    this.goCabArray['background'] = './images/spot-paleto.png';
                    this.goCabArray['way'] = 'DOWNTOWN  - PALETO BAY';
                }
                this.goCabArray['earnmin'] = earnmin;
                this.goCabArray['earnmax'] = earnmax;
                this.goCabArray['xpmin'] = xpmin;
                this.goCabArray['xpmax'] = xpmax;
            } else if (route == 'stage2' && this.selectMission.route) {
                this.categoriesPage = stage;
                this.selectMission['car'] = missions;
                if (missions == 'downtwonvehicle') {
                    this.goCabArray['vehicleText'] = this.languages['YOUWILLUSEDOWNTWON']
                    this.goCabArray['vehicleImage'] = './images/gocab.png'
                } else {
                    this.goCabArray['vehicleText'] = this.languages['YOUWILLUSEVEHICLE']
                    this.goCabArray['vehicleImage'] = './images/ownvehicle.png'
                }
            } else if (route == 'stage3') {
                if (this.selectMission.route && this.selectMission.car) {

                    this.selectMission['startMission'] = true;
                    $.post(`https://${this.resourceName}/codemTaxi`, JSON.stringify({
                        action: 'mission',
                        val: this.selectMission
                    }));
                    this.closepage();
                    this.selectMission['startMission'] = false;
                    this.selectMission['car'] = null;
                    this.selectMission['route'] = null;
                }
            }



        },
        setHover(val, spotlevel, playerlevel) {
            if (playerlevel >= spotlevel) {
                for (key in this.buttonArray) {
                    this.buttonArray[key] = false
                }
                this.buttonArray[val] = !this.buttonArray[val];
                this.$forceUpdate();
            }
        },
        async setHoverAchivements(val, mission) {
            if (this.timeout == false && mission) {
                this.timeout = true;
                const result = await $.post(`https://${this.resourceName}/codemTaxi`, JSON.stringify({
                    action: 'achivements',
                    value: mission
                }));
                if (result.missionAccept !== undefined && result.missionAccept == false) {
                    return GenerateNotification(this.languages['MISSIONISNOTOVER'], 'error',)
                } else if (result.missionAccept !== undefined && result.missionAccept == true) {
    
                }
                if (result.missionComplete) {
                    return GenerateNotification(this.languages['AWARDHASBEEN'], 'error',)
                }
            }
            this.timeout = setTimeout(() => {
                this.timeout = false;
            }, 500)
        },
        setPage(page) {
            
            if (this.continuebutton) {
            
                if (this.progressBar) {
                    this.progressBar.destroy()
                    this.progressBar = null
                }
                if (page == 'profile') {
                   
                    this.categoriesPage = 'profile1';
                  
                    setTimeout(() => {
                        this.setupAchievementsSwiper();
                    }, 100)
                    $.post(`https://${this.resourceName}/codemTaxi`, JSON.stringify({
                        action: 'getLeaderBoard'
                    }), (data) => {
                        for (key in data) {
                            if (data[key].identifier == this.playerTaxiData[0].identifier) {
                                this.playerRank = key
                            }
                        }

                        this.firstLeader = data[0];
                        data.shift();
                        this.leaderBoardData = data;
                    });
                    $.post(`https://${this.resourceName}/codemTaxi`, JSON.stringify({
                        action: 'getHistory'
                    }), (history) => {
                        if (history[0]){
                            this.firstHistory = history[parseInt(history.length - 1)];
                            history.pop();
                            this.historyData = history;
                        }
                      
                    });
                    $.post(`https://${this.resourceName}/codemTaxi`, JSON.stringify({
                        action: 'getAchivements'
                    }), (getachivements) => {
                        this.playerAchivements = getachivements;
                        getachivements = getachivements.filter(item => {
                            return item.missionComplete == true
                        })
                        getachivements.forEach((item) => {
                            this.buttonArray[item.missionname] = true;
                        })
                    });

                } else {
                    this.categoriesPage = 'stage1';
                    setTimeout(() => {
                    if (this.achievementsSwiper) {
                       
                        this.achievementsSwiper.destroy()
                    }
                    }, 100)
                }
                this.page = page;
            }
        },
        refreshAchievements(value) {
            this.playerAchivements = value;
            value = value.filter(item => {
                return item.missionComplete == true
            })
            value.forEach((item) => {

                this.buttonArray[item.missionname] = true;
            })
        },
        getSpotData(data, vehicle, posData, achivements, gLevel, key) {
            this.spotData = data;
            this.vehicleData = vehicle;
            this.positionsData = posData;
            this.achievementsData = achivements;
            this.generalLevel = gLevel;
            this.keyControl = key;


        },

        SetProgressBar(time) {
            if (this.progressBar) {
                this.progressBar.destroy()
                this.progressBar = null
            }
          
            this.progressBar = new ProgressBar.Circle('.page-1-loading-bar', {
                strokeWidth: 4,
                easing: 'easeInOut',
                duration: time,
                color: '#E2BB02',
                trailColor: '#373217',
                trailWidth: 4,

            });
            this.progressBar.animate(1.0); // Number from 0.0 to 1.0
            setTimeout(() => {
                this.continuebutton = true
            }, time)
        },

        GetResponse(resourceName) {
            this.resourceName = resourceName
            $.post(`https://${this.resourceName}/GetResponse`, JSON.stringify({}));

        },

        closepage() {

            // clicksound()
         
            this.show = false
            
            if (this.progressBar) {
                this.progressBar.destroy()
                this.progressBar = null
            }
            this.page = 'loading';
            this.continuebutton = false
            this.editModeMenu = false;
            this.cabMenu = false;
            $.post(`https://${this.resourceName}/close`);
        },

        showUI() {
            this.show = true;
        },

        hideUI() {
        
            this.show = false
            setTimeout(() => {
                if (this.progressBar) {
                    this.progressBar.destroy()
                    this.progressBar = null
                }
            },100)
          
            this.page = 'loading';
            this.continuebutton = false
            this.editModeMenu = false;
            this.cabMenu = false;
            $.post(`https://${this.resourceName}/close`);
        },



    }


})