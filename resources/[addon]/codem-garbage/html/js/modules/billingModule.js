const module = {
    namespaced: true,

    state: {
        billingData: false,
        playerAccount: {
            money: 0,
            name: false,
            avatar: false,
            admin: false
        },
        tax: 0,
        allowJobs: [],
        allowSearchJobs: [],
        playerjob: false,
        playerjoblabel: false,
        personelAccount: true
    },
    mutations: {}
};

export default module;
