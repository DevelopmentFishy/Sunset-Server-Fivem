let divIdCounter = 0;

class SoundPlayer {
    static yPlayer = null;
    youtubeIsReady = false;
    lowpassEffect = null;

    constructor() {
        this.url = "test";
        this.name = "";
        this.dynamic = false;
        this.distance = 10;
        this.volume = 1.0;
        this.pos = [0.0, 0.0, 0.0];
        this.max_volume = -1.0;
        this.div_id = "myAudio_" + divIdCounter++;
        this.loop = false;
        this.isYoutube = false;
        this.load = false;
        this.isMuted_ = false;
        this.audioContext = new (window.AudioContext || window.webkitAudioContext)();
        this.audioSource = null;
    }

    isYoutubeReady(result) {
        this.youtubeIsReady = result;
    }

    getDistance() { return this.distance; }
    getLocation() { return this.pos; }
    getVolume() { return this.volume; }
    getMaxVolume() { return this.max_volume; }
    getUrlSound() { return this.url; }
    isDynamic() { return this.dynamic; }
    getDivId() { return this.div_id; }
    isLoop() { return this.loop; }
    getName() { return this.name; }
    loaded() { return this.load; }
    getAudioPlayer() { return this.audioElement; }
    getYoutubePlayer() { return this.yPlayer; }

    setLoaded(result) { this.load = result; }
    setName(result) { this.name = result; }
    setDistance(result) { this.distance = result; }
    setDynamic(result) { this.dynamic = result; }
    setLocation(x_, y_, z_) { this.pos = [x_, y_, z_]; }
    setSoundUrl(result) { this.url = result.replace(/<[^>]*>?/gm, ''); }
    setLoop(result) {
        if (!this.isYoutube) {
            if (this.audioElement != null) {
                this.audioElement.loop = result;
            }
        }
        this.loop = result;
    }
    setMaxVolume(result) { this.max_volume = result; }
    setVolume(result) {
        this.volume = result;
        if (this.max_volume == -1) this.max_volume = result;
        if (this.max_volume > (this.volume - 0.01)) this.volume = this.max_volume;
        if (this.isMuted_) {
            if (!this.isYoutube) {
                if (this.audioElement != null) this.audioElement.volume = 0;
            } else {
                if (this.yPlayer && this.youtubeIsReady) { this.yPlayer.setVolume(0); }
            }
        } else {
            if (!this.isYoutube) {
                if (this.audioElement != null) this.audioElement.volume = result;
            } else {
                if (this.yPlayer && this.youtubeIsReady) { this.yPlayer.setVolume(result * 100); }
            }
        }
    }

    create() {
        $.post('https://rcore_radiocar/events', JSON.stringify({
            type: "onLoading",
            id: this.getName(),
        }));
        var link = getYoutubeUrlId(this.getUrlSound());
        if (link === "") {
            this.isYoutube = false;
            this.audioElement = new Audio(this.getUrlSound());
            this.audioElement.loop = false;
            this.audioElement.autoplay = false;
            this.audioElement.volume = 0.00;
            this.audioElement.onended = () => {
                ended(null);
            };

            this.audioElement.onplay = () => {
                this.audioSource = this.audioContext.createMediaElementSource(this.audioElement);
                this.initLowpass();
            };

            this.audioElement.onloadedmetadata = () => {
                isReady("nothing", true);
            };
        } else {
            this.isYoutube = true;
            this.isYoutubeReady(false);
            $("#" + this.div_id).remove();
            $("body").append("<div id='"+ this.div_id +"'></div>");

            this.yPlayer = new YT.Player(this.div_id, {
                videoId: link,
                origin: window.location.href,
                enablejsapi: 1,
                width: "0",
                height: "0",
                playerVars: {
                    controls: 0,
                },
                events: {
                    "onReady": (event) => {
                        event.target.setVolume(0);
                        event.target.playVideo();
                    },
                    "onStateChange": (event) => {
                        if (event.data == YT.PlayerState.ENDED) {
                            isLooped(event.target.getIframe().id);
                            ended(event.target.getIframe().id);
                        }

                        if (event.data == YT.PlayerState.PLAYING && this.youtubeIsReady == false) {
                            let video = null;
                            const iframe = document.getElementById(this.div_id);
                            const iframeDocument = iframe.contentDocument || iframe.contentWindow.document;

                            const interval = setInterval(() => {
                                video = iframeDocument.querySelector("video");
                                if (video !== null) {
                                    clearInterval(interval);
                                    if(this.audioSource == null){
                                        this.audioSource = this.audioContext.createMediaElementSource(video);
                                        this.initLowpass();
                                        isReady(event.target.getIframe().id);
                                    }
                                }
                            }, 50);
                        }
                    }
                }
            });
        }
    }

    destroyYoutubeApi() {
        if (this.yPlayer) {
            if (typeof this.yPlayer.stopVideo === "function" && typeof this.yPlayer.destroy === "function") {
                this.yPlayer.stopVideo();
                this.yPlayer.destroy();
                this.youtubeIsReady = false;
                this.yPlayer = null;
            }
        }
    }

    getAudioContext(){
        return this.audioSource;
    }

    delete() {
        if (this.audioElement) {
            this.audioElement.pause();
            this.audioElement.src = '';
            this.audioElement.load();
            this.audioElement = null;
        }
        $("#" + this.div_id).remove();
    }

    updateVolume(dd, maxd) {
        var d_max = maxd;
        var d_now = dd;
        var vol = 0;
        var distance = (d_now / d_max);
        if (distance < 1) {
            distance = distance * 100;
            var far_away = 100 - distance;
            vol = (this.max_volume / 100) * far_away;
            this.setVolume(vol);
            this.isMuted_ = false;
        } else {
            this.setVolume(0);
            this.isMuted_ = true;
        }
    }

    play() {
        if (this.audioElement) {
            this.audioElement.play();
        } else if (this.isYoutube && this.youtubeIsReady) {
            this.yPlayer.playVideo();
        }
    }

    pause() {
        if (this.audioElement) {
            this.audioElement.pause();
        } else if (this.isYoutube && this.youtubeIsReady) {
            this.yPlayer.pauseVideo();
        }
    }

    resume() {
        if (this.audioElement) {
            this.audioElement.play();
        } else if (this.isYoutube && this.youtubeIsReady) {
            this.yPlayer.playVideo();
        }
    }

    isMuted() {
        return this.isMuted_;
    }

    mute() {
        this.setVolume(0);
        this.isMuted_ = true;
    }

	unmute()
	{
	    this.setVolume(this.getVolume())
        this.isMuted_ = false;
	}

    unmuteSilent() {
        this.isMuted_ = false;
    }

    setTimeStamp(time) {
        if (!this.isYoutube && this.audioElement) {
            this.audioElement.currentTime = time;
        } else if (this.isYoutube && this.youtubeIsReady) {
            this.yPlayer.seekTo(time);
        }
    }

    isPlaying() {
        if (this.isYoutube) return this.youtubeIsReady && this.yPlayer.getPlayerState() == 1;
        else return this.audioElement && !this.audioElement.paused;
    }

    initLowpass(){
        if (!this.lowpassEffect) {
            this.lowpassEffect = this.audioContext.createBiquadFilter();
            this.audioSource.connect(this.lowpassEffect);
            this.lowpassEffect.connect(this.audioContext.destination);
            this.lowpassEffect.frequency.value = 17500;
        }
    }

    enableLowpass() {
        if (!this.youtubeIsReady && this.isYoutube || this.audioSource == null) {
            return;
        }
        this.lowpassEffect.frequency.linearRampToValueAtTime(intensityLowPass, this.audioContext.currentTime + 0.3);
    }

    disableLowpass() {
        if (!this.youtubeIsReady && this.isYoutube || this.audioSource == null) {
            return;
        }
        this.lowpassEffect.frequency.linearRampToValueAtTime(17500, this.audioContext.currentTime + 0.3);
    }
}