  


const store = Vuex.createStore({
    state: {},
    mutations: {},
    actions: {}
});

const app = Vue.createApp({
    data: () => ({
        mainShow : false,
        currentPage : "tuningPage",
        currentSubCategory : "AERO", // AERO , CHASIS
        vehicleName : "",
        // 
        vehicleData :  false,
        currentData : false,
        presetsSaver: false,
        presetName: "",
        customsPageData: [],
        advancedSubPage: "",
        XMLPage: false,
        XMLData: "",
        isClicked: false,
        defaultBack: false,
        tuningTablet: false,
        policeTablet: false,
        isClassActive: false,
        permission: [],
        advanced: true,
        groupName: false,
        authActive : false,
        count: 0
    }),

    methods: {
        deletePreset(veri,index) {
            const selectedData = this.currentData.find(data => data["name"] === veri);
            if (selectedData) {
                postNUI('DELETE_PRESET',{
                    vehicleData : selectedData,
                    }
                )
            }
            this.currentPage = "presetsPage"
            postNUI('GET_CUSTOMS_DATA',{})
        },
        closeXML() {
            this.currentSubCategory = "AERO"
        },
        closePopUP() {
            this.presetsSaver = false
            this.defaultBack = false
            this.currentSubCategory = "AERO"
        },
        openPage(data) {
            this.currentPage = data

            if (data == "presetsPage") {
                postNUI('GET_CUSTOMS_DATA',{})
            } else if (data == "tuningPage") {
                postNUI('GET_ADVANCED_DATA',{})
            } else if (data == "customsPage") {
                postNUI('GET_CUSTOMS_DATA',{})
            } else if (data == "advancedPage") {
                postNUI('GET_ADVANCED_DATA',{})
            }

        },
        tuneChecker() {
            this.isClassActive = !this.isClassActive;
           
            setTimeout(() => {
                this.currentPage = "tuneChecking";
              }, 600);
            
            setTimeout(() => {
                postNUI('GET_VEHICLE_STATUS',{})
              }, 12000);
              this.count = 0; 
            const interval = 100; 
            const duration = 12000; 

            const steps = 100;
            const stepSize = 100 / steps; 

            let currentStep = 0;

            const countingInterval = setInterval(() => {
                if (currentStep >= steps) {
                clearInterval(countingInterval); 
                } else {
                currentStep++;
                this.count = Math.round(currentStep * stepSize); 
                }
            }, interval);
        },
        openSubPage(data) {
            this.currentSubCategory = data
            if (data == "XMLPage") {
                postNUI('GET_XML_DATA',{
                    vehicleData : this.vehicleData
                    }
                )
            }
        },
        InsertXML(veri, index) {
            const selectedData = this.currentData.find(data => data["name"] === veri);
            
            if (selectedData) {
                postNUI('GET_XML_DATA',{
                    vehicleData : selectedData,
                    }
                )
            } else {
              console.log("Veri bulunamadı.");
            }
        },
        onKeyUp(event) {
            if (event.key === 'Escape') {
              this.mainShow  = false;
              this.policeTablet  = false;
              this.tuningTablet  = false;
              postNUI("CLOSE_TABLET")
            }
          },
        maximizeAll() {
          this.vehicleData.powerValue = "0.5"
          this.vehicleData.driveInertiaValue = "3"
          this.vehicleData.shiftUpValue = "10"
          this.vehicleData.brakeBiasValue = "1"
          this.vehicleData.powerBiasValue = "1"
        },
        defaultAll() {
          postNUI("DEFAULT_BACK")
          setTimeout(() => {
            this.tuningTablet = true
            postNUI('GET_ADVANCED_DATA',{})
          }, 300);
        },
        defaultAdvanced() {
         this.defaultBack = true
         this.currentSubCategory = ""
        },
        defaultBackData() {
          this.defaultBack = false
          this.currentSubCategory = "AERO"
          postNUI("DEFAULT_BACK")
        },
        CleanVehicle() {
            postNUI("DEFAULT_BACK")
            this.mainShow = false 
            this.policeTablet = false
            postNUI("CLOSE_TABLET")
        },
          saveData() {
            postNUI('SAVE_DATA',{
                boost : this.vehicleData.powerValue,
                acceleration: this.vehicleData.driveInertiaValue,
                gearchange: this.vehicleData.shiftUpValue,
                breaking: this.vehicleData.brakeBiasValue,
                drivetrain: this.vehicleData.powerBiasValue
                }
            )
          },
          saveAdvancedData() {
            if (this.presetName === '')
            console.log("")
            else {
                postNUI('SAVE_ADVANCED_DATA',{
                    vehicleData : this.vehicleData,
                    DataName : this.presetName
                    }
                )
                this.currentSubCategory = "AERO"
                this.presetsSaver = false
            }
          },
          openSavePopUp() {
            this.presetsSaver = true
            this.currentSubCategory = ""
            this.presetName = ""
          },
          CarModeChange(data) {
            postNUI('CHANGE_MODE',{
                mode : data,
                }
            )
          },
          copyHandling() {
            const textArea = document.createElement('textarea');
            textArea.value = this.XMLData;
            document.body.appendChild(textArea);
            textArea.select();
            document.execCommand('copy');
            document.body.removeChild(textArea);
          },
          
    },  
    computed: {
        slideOutClass() {
            return this.isSlideOut ? 'slide-out-top' : '';
          },
    },

    beforeDestroy() {
        window.removeEventListener('keyup', this.onKeyUp);
     },
    mounted() {
        window.addEventListener("message", event => {
            window.addEventListener('keyup', this.onKeyUp);
            switch (event.data.message) {
                case "OPEN_TABLET":
                    this.mainShow = true
                    this.tuningTablet = true
                    this.vehicleName = event.data.vehName
                    this.customsPageData = []
                    this.Locales = event.data.Locales
                    this.currentPage = "tuningPage"
                    postNUI('GET_ADVANCED_DATA',{})
                    this.policeTablet = false
                    
                break;
                case "OPEN_POLICE_TABLET":
                    this.mainShow = true
                    this.policeTablet = true
                    this.tuningTablet = false
                    this.currentPage = "tuneCheckMain"
                    this.isClassActive = false
                    this.Locales = event.data.Locales
                break;
                case "GET_VEHICLE_DATA":
                    this.vehicleData = event.data.vehicleData
                break;
                case "SET_VEHICLE_STATUS":
                    this.currentPage = event.data.vehiclestatusPage
                break;
                case "GET_CURRENT_DATA":
                    this.currentData = event.data.GetCurrentData
                    this.customsPageData = []
                    if (this.currentData.length) {
                        this.currentData.forEach(dataR => {
                            if (dataR.length) {
                                this.customsPageData.push(dataR[0].name)
                            } else {
                                this.customsPageData.push(dataR.name)
                            }
                        })
                        
                    }
                break;
                case "CLOSE_NUI":
                    this.mainShow = false
                    this.policeTablet = false
                    this.tuningTablet = false
                    this.currentPage = "tuneCheckMain"
                    this.isClassActive = false
                break;
                case "GET_GROUP":
                    this.groupName = event.data.Auth
                    this.authActive = event.data.AuthActive
                break;
                
            }   
        });
    },
    
    destroyed() {
        
    },
});

app.use(store).mount("#app");


var resourceName = "m-tuning";

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

