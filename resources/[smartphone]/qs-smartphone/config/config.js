
// ░██████╗░███████╗███╗░░██╗███████╗██████╗░░█████╗░██╗░░░░░  ░░░░░██╗░██████╗
// ██╔════╝░██╔════╝████╗░██║██╔════╝██╔══██╗██╔══██╗██║░░░░░  ░░░░░██║██╔════╝
// ██║░░██╗░█████╗░░██╔██╗██║█████╗░░██████╔╝███████║██║░░░░░  ░░░░░██║╚█████╗░
// ██║░░╚██╗██╔══╝░░██║╚████║██╔══╝░░██╔══██╗██╔══██║██║░░░░░  ██╗░░██║░╚═══██╗
// ╚██████╔╝███████╗██║░╚███║███████╗██║░░██║██║░░██║███████╗  ╚█████╔╝██████╔╝
// ░╚═════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝  ░╚════╝░╚═════╝░

let Config = []

Config.LockscreenFirstDay = false // if true = Saturday, 22 October, if false = Saturday, October 22 (In app store too).

// Only run this if your country has blocks with YouTube (this disables any sound system, therefore removes spotify or youtube app)
// In this case, you need remove html/js/apps/spotify and html/js/apps/youtube
Config.DisableSounds = false

Config.SmartphoneFPSMeter = false // If you enable this, you will be able to see the Smartphone FPS (ONLY FOR PERFORMANCE TEST!!!!).

Config.DefaultAlbum = 'Album' // This is the prefix for Gallery Albums.

Config.JobsBlockedToContact = [ // Skip this part.
    "police",
    "ambulance",
    "mechanic",
]

// Safari Favorites
Config.SafariFavorite_1 = "https://www.bing.com/"
Config.SafariFavorite_2 = "https://emupedia.net/beta/emuos/"
Config.SafariFavorite_3 = "https://www.elmundo.es/traductor/"
Config.SafariFavorite_4 = "https://www.quasar-store.com/"

// Images routes

// Garage APP
Config.GarageImages = './img/garage/' // Config.GarageImgaes = 'nui://qs-images/html/img/garage_jpg/'
Config.GarageExtension = '.jpg'

// BlackMarket
Config.DarkWebImages = 'img/darkweb_items/' // Config.DarkWebImages = 'nui://qs-images/html/img/BlackMarket/'
Config.DarkWebExtension = '.png'

// Songs that will appear by default in the YouTube App! 
// Some copyrighted videos will not play.
const VideosArray = [
    {
        url: 'https://www.youtube.com/watch?v=DZiaXEIQgkE',
    },
    {
        url: 'https://www.youtube.com/watch?v=2eaIxuJxxm8'
    },
    {
        url: 'https://www.youtube.com/watch?v=K5kD_vYnbe4'
    },
    {
        url: 'https://www.youtube.com/watch?v=8F2s8ivKXNY'
    },
    {
        url: 'https://www.youtube.com/watch?v=xpWIdf-tCFc'
    },
    {
        url: 'https://www.youtube.com/watch?v=ppF08KhVXIk'
    },
    {
        url: 'https://www.youtube.com/watch?v=mpHvHGMZ0jc'
    },
]

// Music and configuration of the Spotify app!
const SpotifyArray = [{ // Don't touch this
    name: 'Liked Songs',
    description: 'Escucha tu musica guardada y favorita!',
    thumbnail: 'https://t.scdn.co/images/3099b3803ad9496896c43f22fe9be8c4.png',
    playlists: []
}, // Don't touch this until here

    {
        name: 'Rock',
        thumbnail: 'https://www.photolari.com/wp-content/uploads/2019/12/foto-0-portada-nevermind-nirvana.jpg',
        playlists: [
            {
                url: "https://www.youtube.com/watch?v=8SbUC-UaAxE",
            },
            {
                url: 'https://www.youtube.com/watch?v=djV11Xbc914'
            },
            {
                url: 'https://www.youtube.com/watch?v=hTWKbfoikeg'
            },
            {
                url: "https://www.youtube.com/watch?v=1w7OgIMMRc4",
            },
            {
                url: "https://www.youtube.com/watch?v=9jK-NcRmVcw",
            },
            {
                url: "https://www.youtube.com/watch?v=OMOGaugKpzs",
            },
            {
                url: "https://www.youtube.com/watch?v=xwtdhWltSIg",
            },
            {
                url: "https://www.youtube.com/watch?v=btPJPFnesV4",
            },
            {
                url: "https://www.youtube.com/watch?v=zRIbf6JqkNc",
            },
            {
                url: "https://www.youtube.com/watch?v=Rbm6GXllBiw",
            },
            {
                url: "https://www.youtube.com/watch?v=ErvgV4P6Fzc",
            },
            {
                url: "https://www.youtube.com/watch?v=NMNgbISmF4I",
            },
            {
                url: "https://www.youtube.com/watch?v=qeMFqkcPYcg",
            },
            {
                url: "https://www.youtube.com/watch?v=UrIiLvg58SY",
            },
            {
                url: "https://www.youtube.com/watch?v=YR5ApYxkU-U",
            },
            {
                url: "https://www.youtube.com/watch?v=rY0WxgSXdEE",
            },
            {
                url: "https://www.youtube.com/watch?v=o1tj2zJ2Wvg",
            },
            {
                url: "https://www.youtube.com/watch?v=JkK8g6FMEXE",
            },
            {
                url: "https://www.youtube.com/watch?v=vabnZ9-ex7o",
            },
            {
                url: "https://www.youtube.com/watch?v=Qt2mbGP6vFI",
            },
            {
                url: "https://www.youtube.com/watch?v=xPU8OAjjS4k",
            },
            {
                url: "https://www.youtube.com/watch?v=S_E2EHVxNAE",
            },
            {
                url: "https://www.youtube.com/watch?v=qfNmyxV2Ncw",
            },
            {
                url: "https://www.youtube.com/watch?v=1Cw1ng75KP0",
            },
            {
                url: "https://www.youtube.com/watch?v=-oqAU5VxFWs",
            },
            {
                url: "https://www.youtube.com/watch?v=etAIpkdhU9Q",
            },
            {
                url: "https://www.youtube.com/watch?v=Lo2qQmj0_h4",
            },
            {
                url: "https://www.youtube.com/watch?v=zSmOvYzSeaQ",
            },
            {
                url: "https://www.youtube.com/watch?v=loWXMtjUZWM",
            },
            {
                url: "https://www.youtube.com/watch?v=a01QQZyl-_I&",
            },
            {
                url: "https://www.youtube.com/watch?v=3wxyN3z9PL4",
            },
            {
                url: "https://www.youtube.com/watch?v=l482T0yNkeo",
            },
            {
                url: "https://www.youtube.com/watch?v=dpmAY059TTY",
            },
            {
                url: "https://www.youtube.com/watch?v=KmWE9UBFwtY",
            },
            {
                url: "https://www.youtube.com/watch?v=NRtvqT_wMeY",
            },
            {
                url: "https://www.youtube.com/watch?v=yRYFKcMa_Ek",
            },
            {
                url: "https://www.youtube.com/watch?v=YgSPaXgAdzE",
            },
            {
                url: "https://www.youtube.com/watch?v=CBTOGVb_cQg",
            }
        ]
    },
    {
        name: 'Jazz',
        thumbnail: 'https://i.discogs.com/YAjlquecpjcTyB32Ps8tocCak_Mbw8XGdpZDFWi_LTQ/rs:fit/g:sm/q:90/h:595/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTQzOTQ4/OC0xMjI2MTYxODEz/LmpwZWc.jpeg',
        playlists: [
            {
                url: "https://www.youtube.com/watch?v=71Gt46aX9Z4",
            },
            {
                url: 'https://www.youtube.com/watch?v=bb1SrngIufQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=H77fRz1rybs'
            },
            {
                url: 'https://www.youtube.com/watch?v=ioOzsi9aHQQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=9Pes54J8PVw'
            },
            {
                url: 'https://www.youtube.com/watch?v=SgXSomPE_FY'
            },
            {
                url: 'https://www.youtube.com/watch?v=GzmS4p3jXvs'
            },
            {
                url: 'https://www.youtube.com/watch?v=0G383538qzQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=zq7hltwb_yc'
            },
            {
                url: 'https://www.youtube.com/watch?v=ZVLEYerz5rc'
            },
            {
                url: 'https://www.youtube.com/watch?v=PsgAHFviYcY'
            },
            {
                url: 'https://www.youtube.com/watch?v=cEXhZ8PwM-Y'
            },
            {
                url: 'https://www.youtube.com/watch?v=WcF8Aos4XDA'
            },
            {
                url: 'https://www.youtube.com/watch?v=5ODL5_djyBI'
            },
            {
                url: 'https://www.youtube.com/watch?v=TTfVNYJxXw8'
            },
            {
                url: 'https://www.youtube.com/watch?v=bSfqNEvykv0'
            },
            {
                url: 'https://www.youtube.com/watch?v=5lrSdW8p4u4'
            },
            {
                url: 'https://www.youtube.com/watch?v=bqQKE4kkrUc'
            },
            {
                url: 'https://www.youtube.com/watch?v=S5NPriAa8so'
            },
            {
                url: 'https://www.youtube.com/watch?v=UiHmeHZAc0s'
            },
            {
                url: 'https://www.youtube.com/watch?v=gUm_VC3vBt4'
            },
            {
                url: 'https://www.youtube.com/watch?v=2A6hG6Xg6zQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=-aRnzKDiIS0'
            },
            {
                url: 'https://www.youtube.com/watch?v=N-KluFB9A8M'
            },
            {
                url: 'https://www.youtube.com/watch?v=4zAThXFOy2c'
            },
            {
                url: 'https://www.youtube.com/watch?v=hC8CH0Z3L54'
            },
            {
                url: 'https://www.youtube.com/watch?v=O_5oXqvxaAk'
            },
            {
                url: 'https://www.youtube.com/watch?v=QcJ2eb3ojPM'
            },
            {
                url: 'https://www.youtube.com/watch?v=rB6OlJqV1rQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=rnQzXv-bbkY'
            },
            {
                url: 'https://www.youtube.com/watch?v=QuHQfC01SKo'
            },
            {
                url: 'https://www.youtube.com/watch?v=UjZzaTo-MYI'
            }
        ]
    },
    {
        name: 'Chill',
        thumbnail: 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/summer-chillout-cd-cover-artwork-template-design-47093542f55e5139ea7173d1c2261c92_screen.jpg?ts=1589615245',
        playlists: [
            {
                url: "https://www.youtube.com/watch?v=JdqL89ZZwFw",
            },
            {
                url: 'https://www.youtube.com/watch?v=lTRiuFIWV54'
            },
            {
                url: 'https://www.youtube.com/watch?v=9FvvbVI5rYA'
            },
            {
                url: 'https://www.youtube.com/watch?v=xocnshwEbrM'
            },
            {
                url: 'https://www.youtube.com/watch?v=ROy57arUE1s'
            },
            {
                url: 'https://www.youtube.com/watch?v=QZTDZFtbrec'
            },
            {
                url: 'https://www.youtube.com/watch?v=6H-PLF2CR18'
            },
            {
                url: 'https://www.youtube.com/watch?v=LsWACxHMWBI'
            },
            {
                url: 'https://www.youtube.com/watch?v=c3suauAz0zQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=c3jb-47ikqY'
            },
            {
                url: 'https://www.youtube.com/watch?v=lf6refTxQs8'
            },
            {
                url: 'https://www.youtube.com/watch?v=liHgt4CbodY'
            },
            {
                url: 'https://www.youtube.com/watch?v=YpGjaJ1ettI'
            },
            {
                url: 'https://www.youtube.com/watch?v=dTuLMnX3Vlw'
            },
            {
                url: 'https://www.youtube.com/watch?v=90QqkQNzMFk'
            },
            {
                url: 'https://www.youtube.com/watch?v=bz5q5gl2uZA'
            },
            {
                url: 'https://www.youtube.com/watch?v=FjHGZj2IjBk'
            },
            {
                url: 'https://www.youtube.com/watch?v=bP9gMpl1gyQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=1fueZCTYkpA'
            },
            {
                url: 'https://www.youtube.com/watch?v=q9p0S7hGcrI'
            },
            {
                url: 'https://www.youtube.com/watch?v=PtIKsk1Qabw'
            },
            {
                url: 'https://www.youtube.com/watch?v=CfPxlb8-ZQ0'
            },
            {
                url: 'https://www.youtube.com/watch?v=r0sjCawEOKk'
            },
            {
                url: 'https://www.youtube.com/watch?v=TGan48YE9Us'
            },
            {
                url: 'https://www.youtube.com/watch?v=4mkNvBWdqFk'
            },
            {
                url: 'https://www.youtube.com/watch?v=TWTV4T3yxzs'
            },
            {
                url: 'https://www.youtube.com/watch?v=spRerxsOLXk'
            },
            {
                url: 'https://www.youtube.com/watch?v=1w9kNO4eq9U'
            },
            {
                url: 'https://www.youtube.com/watch?v=lbpCmN1IqGk'
            },
            {
                url: 'https://www.youtube.com/watch?v=5mv1T3bjq_g'
            },
            {
                url: 'https://www.youtube.com/watch?v=QKUNo8MOzQA'
            },
            {
                url: 'https://www.youtube.com/watch?v=RtWgbht6qe8'
            },
            {
                url: 'https://www.youtube.com/watch?v=2LMiz9NTzVs'
            },
            {
                url: 'https://www.youtube.com/watch?v=UliRWJE0CaI'
            },
            {
                url: 'https://www.youtube.com/watch?v=LhSKG9EeFg8'
            },
            {
                url: 'https://www.youtube.com/watch?v=NJuSStkIZBg'
            }
        ]
    },
    {
        name: 'Electronic / Dance',
        thumbnail: 'https://d2n9ha3hrkss16.cloudfront.net/uploads/stage/stage_image/62032/optimized_large_thumb_stage.jpg',
        playlists: [
            {
                url: 'https://www.youtube.com/watch?v=k3DBmAlUh1A'
            },
            {
                url: 'https://www.youtube.com/watch?v=3pL08H3WFrM'
            },
            {
                url: 'https://www.youtube.com/watch?v=EfWmWlW2PvM'
            },
            {
                url: 'https://www.youtube.com/watch?v=3ztSQh7jh_Q'
            },
            {
                url: 'https://www.youtube.com/watch?v=BtU2xhK5PZo'
            },
            {
                url: 'https://www.youtube.com/watch?v=ssKWFlclNFg'
            },
            {
                url: 'https://www.youtube.com/watch?v=IIUTf007y_w'
            },
            {
                url: 'https://www.youtube.com/watch?v=961v0E3b01g'
            },
            {
                url: 'https://www.youtube.com/watch?v=HvvECHLHKrM'
            },
            {
                url: 'https://www.youtube.com/watch?v=Q22MCFC0CP0'
            },
            {
                url: 'https://www.youtube.com/watch?v=0OKqK8Fr72k'
            },
            {
                url: 'https://www.youtube.com/watch?v=90RLzVUuXe4'
            },
            {
                url: 'https://www.youtube.com/watch?v=S83AQhEWmPY'
            },
            {
                url: 'https://www.youtube.com/watch?v=xkejbXejA-0'
            },
            {
                url: 'https://www.youtube.com/watch?v=BX0lKSa_PTk'
            },
            {
                url: 'https://www.youtube.com/watch?v=ELXuZBD6D_g'
            },
            {
                url: 'https://www.youtube.com/watch?v=T-jNkwesjpk'
            },
            {
                url: 'https://www.youtube.com/watch?v=EXIWlRrkjKE'
            },
            {
                url: 'https://www.youtube.com/watch?v=w8mBplMtwJ8'
            },
            {
                url: 'https://www.youtube.com/watch?v=vdzHlbFItlw'
            },
            {
                url: 'https://www.youtube.com/watch?v=l4UkYBr1NnA'
            },
            {
                url: 'https://www.youtube.com/watch?v=iqVLISbFZPc'
            },
            {
                url: 'https://www.youtube.com/watch?v=1VcFFvqQV8g'
            },
            {
                url: 'https://www.youtube.com/watch?v=MveDLwDIZiI'
            },
            {
                url: 'https://www.youtube.com/watch?v=R4kRgIkpTxQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=Rvc7ZsurcSY'
            },
            {
                url: 'https://www.youtube.com/watch?v=TfbK_sCRapM'
            },
            {
                url: 'https://www.youtube.com/watch?v=r0bhF7SJLYQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=e7HBypw4lhY'
            },
            {
                url: 'https://www.youtube.com/watch?v=PoP2Sa7wYNQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=NkrkAsRVLEA'
            },
            {
                url: 'https://www.youtube.com/watch?v=1_4ELAxKrDc'
            }
        ]
    },
    {
        name: 'Metal',
        thumbnail: 'https://www.revolvermag.com/sites/default/files/styles/original_image__844px_x_473px_/public/media/section-media/81hryxavzjl._sl1425_.jpg?itok=bjKLgbqe&timestamp=1559146162',
        playlists: [
            {
                url: 'https://www.youtube.com/watch?v=l9VFg44H2z8'
            },
            {
                url: 'https://www.youtube.com/watch?v=AkFqg5wAuFk'
            },
            {
                url: 'https://www.youtube.com/watch?v=CSvFpBOe8eY'
            },
            {
                url: 'https://www.youtube.com/watch?v=6fVE8kSM43I'
            },
            {
                url: 'https://www.youtube.com/watch?v=DelhLppPSxY'
            },
            {
                url: 'https://www.youtube.com/watch?v=CD-E-LDc384'
            },
            {
                url: 'https://www.youtube.com/watch?v=HCBPmxiVMKk'
            },
            {
                url: 'https://www.youtube.com/watch?v=X4bgXH3sJ2Q'
            },
            {
                url: 'https://www.youtube.com/watch?v=3nb7DD7vdQ0'
            },
            {
                url: 'https://www.youtube.com/watch?v=W3q8Od5qJio'
            },
            {
                url: 'https://www.youtube.com/watch?v=iywaBOMvYLI'
            },
            {
                url: 'https://www.youtube.com/watch?v=Nco_kh8xJDs'
            },
            {
                url: 'https://www.youtube.com/watch?v=F_6IjeprfEs'
            },
            {
                url: 'https://www.youtube.com/watch?v=94bGzWyHbu0'
            },
            {
                url: 'https://www.youtube.com/watch?v=jRGrNDV2mKc'
            },
            {
                url: 'https://www.youtube.com/watch?v=RFc-2aNZ6VY'
            },
            {
                url: 'https://www.youtube.com/watch?v=UNEDa3Hqnic'
            },
            {
                url: 'https://www.youtube.com/watch?v=JiDnB-CrrNs'
            },
            {
                url: 'https://www.youtube.com/watch?v=6rL4em-Xv5o'
            },
            {
                url: 'https://www.youtube.com/watch?v=Ps0MfBG5-Uo'
            },
            {
                url: 'https://www.youtube.com/watch?v=5ItHNdrPEh0'
            },
            {
                url: 'https://www.youtube.com/watch?v=GurkREc-q4I'
            },
            {
                url: 'https://www.youtube.com/watch?v=IHS3qJdxefY'
            },
            {
                url: 'https://www.youtube.com/watch?v=FNdC_3LR2AI'
            },
            {
                url: 'https://www.youtube.com/watch?v=uhBHL3v4d3I'
            },
            {
                url: 'https://www.youtube.com/watch?v=qw2LU1yS7aw'
            },
            {
                url: 'https://www.youtube.com/watch?v=Fwr1Z7uyXz4'
            },
            {
                url: 'https://www.youtube.com/watch?v=yPNFVj-pISU'
            },
            {
                url: 'https://www.youtube.com/watch?v=-0Ao4t_fe0I'
            },
            {
                url: 'https://www.youtube.com/watch?v=iPW9AbRMwFU'
            },
            {
                url: 'https://www.youtube.com/watch?v=XOzs1FehYOA'
            },
            {
                url: 'https://www.youtube.com/watch?v=viD6JMRGbbM'
            },
            {
                url: 'https://www.youtube.com/watch?v=2s3iGpDqQpQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=labytsb3gfI'
            },
            {
                url: 'https://www.youtube.com/watch?v=vfpgpf6QVnI'
            }
        ]
    },
    {
        name: 'Hip Hop',
        thumbnail: 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/hip-hop-modern-album-cover-video-design-template-feff1ee7028b6c491f3382b8b8932c11_screen.jpg?ts=1649518691',
        playlists: [
            {
                url: 'https://www.youtube.com/watch?v=-jEShhcnxIM'
            },
            {
                url: 'https://www.youtube.com/watch?v=hpK16l6fDsg'
            },
            {
                url: 'https://www.youtube.com/watch?v=NSCZ5awmH1U'
            },
            {
                url: 'https://www.youtube.com/watch?v=Xrk6JQNqM0g'
            },
            {
                url: 'https://www.youtube.com/watch?v=kC8YEw9h2-Q'
            },
            {
                url: 'https://www.youtube.com/watch?v=9dosj6p1DqY'
            },
            {
                url: 'https://www.youtube.com/watch?v=LuKm4L9ryB0'
            },
            {
                url: 'https://www.youtube.com/watch?v=IAJnDmMN5VU'
            },
            {
                url: 'https://www.youtube.com/watch?v=a90gzeTH9MI'
            },
            {
                url: 'https://www.youtube.com/watch?v=a90gzeTH9MI'
            },
            {
                url: 'https://www.youtube.com/watch?v=EgPaU9EBpls'
            },
            {
                url: 'https://www.youtube.com/watch?v=JCf7jrglH6A'
            },
            {
                url: 'https://www.youtube.com/watch?v=m4_9TFeMfJE'
            },
            {
                url: 'https://www.youtube.com/watch?v=tGTKY1dpo_E'
            },
            {
                url: 'https://www.youtube.com/watch?v=GHVDVz5Kcqg'
            },
            {
                url: 'https://www.youtube.com/watch?v=yedPuhzfVGE'
            },
            {
                url: 'https://www.youtube.com/watch?v=_yBh_I5BLRM'
            },
            {
                url: 'https://www.youtube.com/watch?v=Z4N8lzKNfy4'
            },
            {
                url: 'https://www.youtube.com/watch?v=IyDnzuFf9xk'
            },
            {
                url: 'https://www.youtube.com/watch?v=DbjDJLcNvdU'
            },
            {
                url: 'https://www.youtube.com/watch?v=l21wGxlWwPw'
            },
            {
                url: 'https://www.youtube.com/watch?v=t-ibVnD9A7I'
            },
            {
                url: 'https://www.youtube.com/watch?v=CUj2AWEJnwQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=pDFHyA7KgDw'
            },
            {
                url: 'https://www.youtube.com/watch?v=n7rE-Wlo5wg'
            },
            {
                url: 'https://www.youtube.com/watch?v=fUYKSIWKbEQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=vq4hRDnGbDY'
            },
            {
                url: 'https://www.youtube.com/watch?v=UqmUxkRPBS0'
            },
            {
                url: 'https://www.youtube.com/watch?v=_f0ftiBSvRs'
            },
            {
                url: 'https://www.youtube.com/watch?v=pjXdDjUWkjk'
            },
            {
                url: 'https://www.youtube.com/watch?v=qwtyEKTGGQ8'
            },
            {
                url: 'https://www.youtube.com/watch?v=6gUiQ8CqLcY'
            },
            {
                url: 'https://www.youtube.com/watch?v=zLC-7Il-uYg'
            },
            {
                url: 'https://www.youtube.com/watch?v=pSY3i5XHHXo'
            },
            {
                url: 'https://www.youtube.com/watch?v=MtV0aeGEEYk'
            },
            {
                url: 'https://www.youtube.com/watch?v=K0hDSlWGhTE'
            }
        ]
    }
]

Config.ConnectionBypassApps = [ // Applications that you can open without a telephone signal.
    "settings",
    "help",
    "weather",
    "notes",
    "camera",
    "photos",
    "clock",
    "jump",
    "calculator",
    "meos",
    "flappy",
    "kong",
]

// Don't touch this, it won't make any changes.
Config.HeaderDisabledApps = [
    "bank",
    "whatsapp",
    "meos",
    "garage",
    "racing",
    "lawyers",
    "youtube",
]

// Weather translations for your widget.
function WeatherTranslation(x) {
    if (x == "RAIN") { x = "Rain" }
    else if (x == "THUNDER") { x = "Thunder" }
    else if (x == "CLEARING") { x = "Clearing" }
    else if (x == "CLEAR") { x = "Clear" }
    else if (x == "EXTRASUNNY") { x = "Extrasunny" }
    else if (x == "CLOUDS") { x = "Clouds" }
    else if (x == "OVERCAST") { x = "Overcast" }
    else if (x == "SMOG") { x = "Smog" }
    else if (x == "FOGGY") { x = "Foggy" }
    else if (x == "XMAS") { x = "Christmas" }
    else if (x == "SNOWLIGHT") { x = "Snowlight" }
    else if (x == "BLIZZARD") { x = "Blizzard" }
    else if (x == "BILINMIYOR") { x = "Other" } else { x = "Other" }
    return x
}

// Dates of your phone.
Config.January = "January"
Config.February = "February"
Config.March = "March"
Config.April = "April"
Config.May = "May"
Config.June = "June"
Config.July = "July"
Config.August = "August"
Config.September = "September"
Config.October = "October"
Config.November = "November"
Config.December = "December"

Config.Jan = "Jan"
Config.Feb = "Feb"
Config.Mar = "Mar"
Config.Apr = "Apr"
Config.May = "May"
Config.Jun = "Jun"
Config.Jul = "Jul"
Config.Aug = "Aug"
Config.Sept = "Sept"
Config.Oct = "Oct"
Config.Nov = "Nov"
Config.Dec = "Dec"

Config.Sunday = "Sunday"
Config.Monday = "Monday"
Config.Tuesday = "Tuesday"
Config.Wednesday = "Wednesday"
Config.Thursday = "Thursday"
Config.Friday = "Friday"
Config.Saturday = "Saturday"

Config.Everyday = "Every day"
Config.Weekend = "Weekend"
Config.Weekdays = "Weekdays"

// App state, remember to edit the html too.
Config.Job1 = "police" // Default "police"
Config.Job2 = "ambulance" // Default "ambulance"
Config.Job3 = "mechanic" // Default "realestate"
Config.Job4 = "taxi" // Default "taxi"

// Color of the header and home-bar of each application.
Config.HeaderColors = {
    "image-zoom": {
        "top": "#000000",
        "bottom": "#FFFFFF"
    },
    "phone": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "photos": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "messages": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "settings": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "clock": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "camera": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "mail": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "bank": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "weather": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "notes": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "calendar": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "calculator": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "store": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "ping": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "tiktok": {
        "top": "#FFFFFF",
        "bottom": "#000000"
    },
    "spotify": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "business": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "safari": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "advert": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "garage": {
        "top": "#FFFFFF",
        "bottom": "#000000"
    },
    "group-chats": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "instagram": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "tips": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "meos": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "state": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "tinder": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "twitter": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "uber": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "uberDriver": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "weazel": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "whatsapp": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "youtube": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "darkchat": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "darkweb": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "phone-call": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "rentel": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "racing": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "flappy": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "jump": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "kong": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "tower": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "labyrinth": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "crypto": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "radio": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "sellix": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "example": {
        "top": "#000000",
        "bottom": "#000000"
    },
}