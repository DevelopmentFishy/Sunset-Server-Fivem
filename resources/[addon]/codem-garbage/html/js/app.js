const store = Vuex.createStore({
    components: {},

    state: {},
    getters: {},
    mutations: {},
    actions: {}
});
let audioPlayer = null;

const app = Vue.createApp({
    components: {},
    data: () => ({
        show: false,
        activePage: "main",
        currentPage: "main",
        categories: [
            { name: "main", label: "WM MAIN" },
            { name: "coop", label: "CO-OP" },
            { name: "leaderboard", label: "LEADERBOARD" },
            { name: "profile", label: "PROFILE" }
        ],
        locales: false,
        mainPageSwiperValue: null,
        badgeSwiperValue: null,
        playerData: {},
        headerAnim: "main",
        garbageJobData: {
            requiredXp: 3000
        },
        routes: [],
        mainPageRouteData: {},
        garbageJobStartStep: {
            rentthebus: true,
            selectroute: false,
            startthejob: false,
            lobbyname: "",
            lobbypassword: "",
            joinpassword: ""
        },
        currencyUnit: "$",
        requiredXp: 0,
        dailyMission: [],
        top50: [],
        notifications: [],
        singleCoopData: [],
        coopData: false,
        myteam: {},
        newCoopPageValue: "main", // main , lobby
        openPasswordModal: false,
        openJoinModal: false,
        fakeData: false,
        coopPageRouteData: false,
        showPassword: false,
        badgeData: [],
        configBadgeData: false,
        playerDailyMission: false,
        searchbarValue: ""
    }),
    computed: {
        findMyRank() {
            const index = this.top50.findIndex(item => item.name == this.playerData.allData.profiledata.name);
            return index !== -1 ? index + 1 : "50+";
        },
        filterByTermCoopData() {

            if (this.searchbarValue.length > 0) {
                if (!this.coopData || Object.keys(this.coopData).length === 0) {
                    return [];
                }

                const dataArray = Object.values(this.coopData);
                return dataArray.filter(item => {
                    return (
                        (item.roomData && String(item.roomData.roomName).toLowerCase().includes(this.searchbarValue.toLowerCase())) ||
                        (item.roomData && String(item.roomData.areaName).toLowerCase().includes(this.searchbarValue.toLowerCase())) ||
                        (item.players && String(item.players.name).toLowerCase().includes(this.searchbarValue.toLowerCase())) ||
                        (item.players && String(item.players.level).toLowerCase().includes(this.searchbarValue.toLowerCase())) ||
                        (item.players && String(item.players.identifier).toLowerCase().includes(this.searchbarValue.toLowerCase()))
                    );
                });
            } else {
                return Object.values(this.coopData);
            }
        }
    },

    watch: {},

    beforeDestroy() {},
    mounted() {
        window.addEventListener("keyup", this.keyHandler);
        window.addEventListener("message", this.eventHandler);
    },

    methods: {
        kickPlayer(data) {
            if (this.myteam && this.myteam.length > 0) {
                postNUI("kickPlayer", data);
            }
        },
        getMyTeamPassword() {
            if (this.myteam && this.myteam.length > 0) {
                let hostPlayer = this.myteam.filter(player => player.host === true);
                if (hostPlayer.length > 0) {
                    if (hostPlayer[0].roomData.password.length <= 0) {
                        return this.locales["No_Password"];
                    }
                    return hostPlayer[0].roomData.password;
                } else {
                    return "Undefined Room Password";
                }
            } else {
                return "Undefined";
            }
        },

        selectRouteCoopPage(val) {
            if (this.playerData.allData.profiledata.level >= val.level) {
                this.coopPageRouteData = val;
                this.showPassword = false;
                const dataArray = Object.values(this.coopData);
                dataArray.map(item => {
                    item.roomData.areaName = this.coopPageRouteData.label;
                });
                postNUI("updateArea", this.coopPageRouteData);
                postNUI("updateLobbys", this.coopData);
            } else {
                this.notification("INFO", this.locales["insufficientlevel"]);
            }
        },
        openChangeAreaPage(val) {
            this.showPassword = false;
            this.newCoopPageValue = val;
        },
        isHostPresent() {
            if (this.myteam && this.myteam.length > 0) {
                let hostPlayer = this.myteam.find(player => player.host === true);
                if (hostPlayer && hostPlayer.identifier === this.playerData.allData.profiledata.identifier) {
                    return true;
                } else {
                    return false;
                }
            } else {
                return false;
            }
        },
        startJobMultiplayer() {
            if (this.myteam && this.myteam.length > 0) {
                postNUI("startJobMultiplayer", { routename: this.coopPageRouteData.name });
            } else {
                this.notification("INFO", this.locales["startjoberror"]);
            }
        },
        joinLobbyForPassword() {
            if (this.garbageJobStartStep.joinpassword.length > 0) {
                if (this.fakeData) {
                    postNUI("joinLobbyPassword", { password: this.garbageJobStartStep.joinpassword, roomdata: this.fakeData.roomData });
                    this.openJoinModal = false;
                    this.fakeData = false;
                }
            } else {
                this.notification("INFO", this.locales["joinpassworderror"]);
            }
        },
        passwordModal(val) {
            this.openPasswordModal = val;
            this.openJoinModal = false;
        },
        notification(header, text) {
            const timeout = 3000;
            let id = Date.now();
            if (this.notifications.some(notification => notification.text === text)) {
                return;
            }

            let newNotification = {
                id: id,
                text: text,
                header: header,
                timeout: setTimeout(() => {
                    this.notifications = this.notifications.filter(notification => notification.id != id);
                }, timeout)
            };

            this.notifications.push(newNotification);
            clicksound("notification_sound.mp3");
        },
        calculateProgress(mission, complete) {
            return (mission / complete) * 100;
        },
        keyHandler(event) {
            if (event.keyCode == 27) {
                this.show = false;
                this.activePage = "main";
                this.currentPage = "main";
                this.garbageJobStartStep.selectroute = false;
                this.garbageJobStartStep.startthejob = false;
                postNUI("closeMenu");
                this.garbageJobData.lobbyname = "";
                this.garbageJobData.lobbypassword = "";
                this.garbageJobData.joinpassword = "";
                this.mainPageRouteData = false;
                this.coopPageRouteData = false;
                this.showPassword = false;
            }
        },
        selectRoute(val) {
            clicksound("click.wav");
            if (this.playerData.allData.profiledata.level >= val.level) {
                this.garbageJobStartStep.selectroute = true;
            } else {
                this.notification("INFO", this.locales["insufficientlevel"]);
            }
        },
        changeRouteMainPage(index) {
            clicksound("click.wav");
            const initialSlideData = this.routes[index];
            if (this.playerData.allData.profiledata.level >= initialSlideData.level) {
                this.garbageJobStartStep.selectroute = false;
                this.mainPageRouteData = initialSlideData;
            } else {
                this.notification("INFO", this.locales["insufficientlevel"]);
            }
        },
        startJob() {
            clicksound("click.wav");
            if (!this.garbageJobStartStep.selectroute) {
                this.notification("INFO", this.locales["chooseroutefirst"]);
                return;
            }
            this.garbageJobStartStep.startthejob = true;
            setTimeout(() => {
                postNUI("closeMenu");
                this.show = false;
                this.garbageJobStartStep.selectroute = false;
                this.garbageJobStartStep.startthejob = false;
                postNUI("startJob", {
                    route: this.mainPageRouteData.name
                });
            }, 250);
            // postNUI("closeMenu");
            //
        },
        badgeSwiper() {
            if (this.badgeSwiperValue) {
                this.badgeSwiperValue.destroy();
            }

            this.badgeSwiperValue = new Swiper("#mainswiper3", {
                slidesPerView: 1,
                slidesPerGroup: 1
            });
            const initialSlideIndex = this.badgeSwiperValue.activeIndex;
            const initialSlideData = this.configBadgeData[initialSlideIndex];
            this.badgeData = initialSlideData;

            this.badgeSwiperValue.on("slideChange", () => {
                const activeSlideIndex = this.badgeSwiperValue.activeIndex;
                const activeSlideData = this.configBadgeData[activeSlideIndex];
                this.badgeData = activeSlideData;
            });
        },
        takeBadgeFunc(val) {
            clicksound("click.wav");
            if (this.playerData.allData.profiledata.level >= val.level) {
                postNUI("takeBadge", val);
            } else {
                this.notification("INFO", this.locales["insufficientlevel"]);
            }
        },
        mainPageSwiper() {
            if (this.mainPageSwiperValue) {
                this.mainPageSwiperValue.destroy();
            }

            this.mainPageSwiperValue = new Swiper("#mainswiper", {
                slidesPerView: 4,
                loop: false,
                spaceBetween: 30,
                slidesPerGroup: 2
            });
            const initialSlideIndex = this.mainPageSwiperValue.activeIndex;
            const initialSlideData = this.routes[initialSlideIndex];
            this.mainPageRouteData = initialSlideData;

            this.mainPageSwiperValue.on("slideChange", () => {
                const activeSlideIndex = this.mainPageSwiperValue.activeIndex;
                const activeSlideData = this.routes[activeSlideIndex];
                this.mainPageRouteData = activeSlideData;
            });
        },
        leaveanddeletelobbie() {
            clicksound("click.wav");
            if (this.myteam && this.myteam.length > 0) {
                postNUI("leaveLobby", this.myteam[0].roomData);
                // this.myteam = [];
                // this.newCoopPageValue = "main";
            }
        },
        createLobby() {
            clicksound("click.wav");
            let lobbyname = "undefined";
            if (this.garbageJobStartStep.lobbyname.length > 0) {
                lobbyname = this.garbageJobStartStep.lobbyname;
            } else {
                lobbyname = this.playerData.allData.profiledata.name;
            }

            this.singleCoopData.push({
                name: lobbyname,
                level: this.playerData.allData.profiledata.level,
                avatar: this.playerData.allData.profiledata.avatar,
                password: this.garbageJobStartStep.lobbypassword,
                areaName : this.coopPageRouteData.label
            });
            postNUI("createLobby", this.singleCoopData);
            this.garbageJobData.lobbyname = "";
            this.garbageJobData.lobbypassword = "";
            this.garbageJobData.joinpassword = "";
            this.singleCoopData = [];
            this.newCoopPageValue = "lobby";
        },
        joinLobby(roomdata) {
            clicksound("click.wav");
            if (roomdata.roomData.password.length > 0) {
                this.openJoinModal = true;
                this.fakeData = roomdata;
            } else {
                postNUI("joinLobby", roomdata);
            }
        },

        changePage(val) {
            clicksound("click.wav");
            this.garbageJobStartStep.selectroute = false;
            this.headerAnim = val;
            this.currentPage = false;
            setTimeout(() => {
                if (val == "main") {
                    setTimeout(() => {
                        if (this.mainPageSwiperValue) {
                            this.mainPageSwiperValue.destroy();
                            this.badgeSwiperValue.destroy();
                        }
                    }, 50);

                    setTimeout(() => {
                        this.mainPageSwiper();
                        this.badgeSwiper();
                    }, 100);
                }
                this.currentPage = val;
            }, 250);
        },
        getCategoryStyles(pageName) {
            if (this.currentPage === pageName) {
                return {
                    background:
                        "linear-gradient(0deg, rgba(255, 255, 255, 0.15) 0%, rgba(255, 255, 255, 0.15) 100%), linear-gradient(90deg, #2C683A 0%, #E5B440 100%)",
                    opacity: 1.0
                };
            } else {
                return {
                    color: "#fff",
                    opacity: 0.4
                };
            }
        },
        getTextLobby(val) {
            if (val) {
                return "Driver";
            } else {
                return "Collector";
            }
        },
        roomDataSettingText(val) {
            if (val && val.length > 0) {
                let hostPlayer = val.filter(player => player.host === true);
                if (hostPlayer.length > 0) {
                    return hostPlayer[0].roomData.roomName + " " + this.locales["Lobby"];
                } else {
                    return "Undefined Room Name";
                }
            } else {
                return "Undefined 2 Room Name ";
            }
        },
        deleteLobiText(val) {
            if (val) {
                if (val && val.length > 0) {
                    let hostPlayer = val.filter(player => player.host === true);
                    if (hostPlayer.length > 0 && hostPlayer[0].identifier == this.playerData.allData.profiledata.identifier) {
                        return this.locales["deleteLobiText"];
                    } else {
                        return this.locales["leaveLobiText"];
                    }
                }
            } else {
                return "UNDEFINED";
            }
        },
        getMarginStyle() {
            switch (this.headerAnim) {
                case "main":
                    return {
                        marginLeft: "0vw"
                    };
                case "coop":
                    return {
                        marginLeft: "12vw"
                    };
                case "leaderboard":
                    return {
                        marginLeft: "24.5vw"
                    };
                case "profile":
                    return {
                        marginLeft: "37.5vw"
                    };
            }
        },
        mergeData(sqlData, configData) {
            const mergedData = configData.map(mission => {
                const sqlMissionData = sqlData[mission.name];
                return {
                    ...mission,
                    complete: sqlMissionData ? sqlMissionData.complete : false, 
                    currentCount: sqlMissionData ? sqlMissionData.count : 0,
                    progressbar: sqlMissionData ? this.calculateProgress(sqlMissionData.count, mission.count) : 0
                };
            });
            this.playerDailyMission = mergedData;
        },

        eventHandler(event) {
            switch (event.data.action) {
                case "CHECK_NUI":
                    postNUI("loaded", true);
                    break;
                case "NUI_LOAD_DATA":
                    this.playerData.allData = event.data.payload;
                    break;
                case "OPEN_MENU":
                    this.show = true;
                    this.activePage = "main";
                    this.currentPage = "main";
                    this.headerAnim = "main";
                    this.playerData = event.data.payload.playerData;
                    this.garbageJobData.requiredXp = this.requiredXp[this.playerData.allData.profiledata.level];
                    this.mainPageRouteData = this.routes[0];
                    this.coopPageRouteData = this.routes[0];
                    this.coopData = event.data.payload.coopData;

                    this.mergeData(this.playerData.allData.dailymission, this.dailyMission);
                    setTimeout(() => {
                        this.mainPageSwiper();
                        this.badgeSwiper();
                    }, 350);

                    break;
                case "configRoutes":
                    this.routes = event.data.payload;
                    break;
                case "configCurrencyUnit":
                    this.currencyUnit = event.data.payload;
                    break;
                case "requiredXp":
                    this.requiredXp = event.data.payload;
                    break;
                case "configDailyMission":
                    this.dailyMission = event.data.payload;
                    break;
                case "top50":
                    this.top50 = event.data.payload;
                    break;
                case "INSERT_LOBBY":
                    // if (this.playerData.allData.profiledata && this.playerData.allData.profiledata.identifier) {
                    this.coopData = event.data.payload;
                    const profileIdentifier = this.playerData.allData.profiledata.identifier;
                    Object.values(this.coopData).forEach(data => {
                        if (data.players.identifier == profileIdentifier) {
                            this.myteam = [];
                            this.myteam.push({
                                name: data.players.name,
                                level: data.players.level,
                                avatar: data.players.avatar,
                                host: data.players.host,
                                identifier: data.players.identifier,
                                src: data.players.src,
                                roomData: data.roomData
                            });
                        }
                    });
                    // }
                    break;
                case "UPDATE_LOBBY":
                    // if (this.playerData.allData.profiledata && this.playerData.allData.profiledata.identifier) {
                    this.coopData = event.data.payload;
                    const profileIdentifier2 = this.playerData.allData.profiledata.identifier;
                    this.myteam = [];
                    Object.entries(this.coopData).forEach(([key, value]) => {
                        const foundPlayer = value.players.find(player => player.identifier === profileIdentifier2);
                        if (foundPlayer) {
                            this.myteam = value.players.map(player => ({
                                name: player.name,
                                level: player.level,
                                avatar: player.avatar,
                                host: player.host,
                                src: player.src,
                                identifier: player.identifier,
                                roomData: value.roomData
                            }));
                            this.newCoopPageValue = "lobby";
                        }
                    });

                    
                    // postNUI("updateArea", this.coopPageRouteData);
                    // }
                    break;
                case "UPDATA_LOBBYS":
                        this.coopData = event.data.payload;
                    break;
                case "UPDATE_AREA":
                    this.coopPageRouteData = event.data.payload;
                    break;
                case "notification":
                    this.notification("INFO", event.data.payload);
                    break;
                case "DELETE_TEAMDATA":
                    this.myteam = [];
                    this.newCoopPageValue = "main";
                    this.openPasswordModal = false;
                    this.openJoinModal = false;
                    break;
                case "closeMenu":
                    this.show = false;
                    this.activePage = "main";
                    this.currentPage = "main";
                    this.garbageJobStartStep.selectroute = false;
                    this.garbageJobStartStep.startthejob = false;
                    postNUI("closeMenu");
                    this.garbageJobData.lobbyname = "";
                    this.garbageJobData.lobbypassword = "";
                    this.garbageJobData.joinpassword = "";
                    this.mainPageRouteData = false;
                    this.coopPageRouteData = false;
                    break;
                case "configBadge":
                    this.configBadgeData = event.data.payload;
                    break;
                case "configlocales":
                    this.locales = event.data.payload;
                break;
                default:
                    break;
            }
        }
    }
});

app.use(store).mount("#app");
var resourceName = "codem-lstransit";

if (window.GetParentResourceName) {
    resourceName = window.GetParentResourceName();
}

window.postNUI = async (name, data) => {
    try {
        const response = await fetch(`https://${resourceName}/${name}`, {
            method: "POST",
            mode: "cors",
            cache: "no-cache",
            credentials: "same-origin",
            headers: {
                "Content-Type": "application/json"
            },
            redirect: "follow",
            referrerPolicy: "no-referrer",
            body: JSON.stringify(data)
        });
        return !response.ok ? null : response.json();
    } catch (error) {
        // console.log(error)
    }
};

function clicksound(val) {
    let audioPath = `./sound/${val}`;
    audioPlayer = new Howl({
        src: [audioPath]
    });
    audioPlayer.volume(0.4);
    audioPlayer.play();
}
