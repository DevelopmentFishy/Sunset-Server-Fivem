var yPlayer = null;

function getNameFromURL(URL, cb){
    var ytId = getYoutubeUrlId(URL);
    if(ytId === "")
	{
        var audioPlayer = new Audio(URL);
        audioPlayer.loop = false;
        audioPlayer.autoplay = false;
        audioPlayer.volume = 0.0;

        var cleanup = () => {
            if(audioPlayer){
                audioPlayer.pause();
                audioPlayer.src = "";
                audioPlayer.load();
                audioPlayer.onloadedmetadata = null;
                audioPlayer.onerror = null;
                audioPlayer = null;
            }
        }

        audioPlayer.onloadedmetadata = function() {
            cb(editString(URL), audioPlayer.duration);
            cleanup();
        };

        audioPlayer.onerror = function(event) {
            cb(null, null);
            cleanup();
        };
    }
    else
    {
        ValidYoutubeVideo(ytId, function(result) {
            if (result) {
                var test = new YT.Player("trash", {
                    height: '0',
                    width: '0',
                    videoId: ytId,
                    events: {
                        'onReady': function(event) {
                            cb(event.target.getVideoData().title, test.getDuration());
                            test.stopVideo();
                            test.destroy();
                        },
                    }
                });
            } else {
                cb(null, null);
            }
        });
    }
}

function ValidYoutubeVideo(id, cb) {
    fetch("https://img.youtube.com/vi/" + id + "/mqdefault.jpg", { method: 'HEAD' }).then(res => {
        if(res.status == 404){
            cb(false)
            }else{
            cb(true)
        }
    }).catch(err => cb(false));
}

function updateName(url){
    if(getYoutubeUrlId(url) === "")
	{
        $(".nameSong").text(editString(url));
        currentSongName = editString(url);
    }else{
		yPlayer = new YT.Player("trash",
        {
            height: '0',
            width: '0',
            videoId: getYoutubeUrlId(url),
            events:
            {
                'onReady': function(event){
                    currentSongName = event.target.getVideoData().title;
                    getName(event.target.getVideoData().title);
                },
            }
        });
    }
}

function getYoutubeUrlId(url) {
    var videoId = "";

    if (url.indexOf("youtube.com") !== -1) {
        var urlParts = url.split("v=");
        if (urlParts.length > 1) {
            videoId = urlParts[1].substring(0, 11);
        }
    }
    else if (url.indexOf("youtu.be") !== -1) {
        var urlParts = url.replace("//", "").split("/");
        if (urlParts.length > 1) {
            videoId = urlParts[1].substring(0, 11);
        }
    }

    return videoId;
}
function editString(string){
    var str = string;
    var res = str.split("/");
    var final = res[res.length - 1];
    final = final.replace(".mp3", " ");
    final = final.replace(".wav", " ");
    final = final.replace(".wma", " ");
    final = final.replace(".wmv", " ");

    final = final.replace(".aac", " ");
    final = final.replace(".ac3", " ");
    final = final.replace(".aif", " ");
    final = final.replace(".ogg", " ");
    final = final.replace("%20", " ");
    final = final.replace("-", " ");
    final = final.replace("_", " ");
    return final;
}

function getName(name){
    $(".nameSong").text(name);
    if (this.yPlayer) {
        if (typeof this.yPlayer.stopVideo === "function" && typeof this.yPlayer.destroy === "function") {
            yPlayer.stopVideo();
            yPlayer.destroy();
        }
    }
}