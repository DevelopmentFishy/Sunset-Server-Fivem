const pages = ["main", "jobselect"]
let allJobs = []

$(document).on('click', '.change-page', (event) => {
    const toPage = $(event.target).attr('data-to-page')
    pages.every((val) => $(`[page="${val}"]`).hide())
    $(`[page="${toPage}"]`).show()
    if(toPage == 'jobselect'){
        $(`[page="${toPage}"]`).css('display', 'flex')

    }

})

$(document).on('input', '.search', function(){

    $('.jobs-wrapper').html("")
    if($(this).val().length > 0){
        const newJobs = allJobs.filter((job) => job.label.toLowerCase().includes($(this).val().toLowerCase()) || job.name.toLowerCase().includes($(this).val().toLowerCase()))
        appendJobs(newJobs)
    }else{
        appendJobs(allJobs)
    }
})

$(document).on('click', '.job-start-button', (event) => {
    const job = $(event.target).attr('data-job') 
    $.post("https://xJobSelector/selectJob", JSON.stringify({
        job
    }))
})

const updatePlayers = (jobs) => {
    let count = 0
    jobs.forEach((job) =>{
        count = count + job.playersCount
    })
    $('.job-counter').text(count)
}

const appendJobs = (jobs) => {
    jobs.forEach((job) => {
        $('.jobs-wrapper').append(`
            <div class="job">
                <div class="job-container" style="background: ${job.theme.bgColor}">
                    <div class="job-header">
                        <div class="job-logo">
                            <img class="test" src="./assets/jobicons/${job.theme.icon}">
                        </div>
                        <div class="job-players">
                            <img src="./assets/images/User_fill.svg">
                            <p>${job.playersCount}</p>
                        </div>
                    </div>
                    <h1 class="job-name">${job.label}</h1>
                    <p class="job-desc">${job.desc}</p>
                </div>
                <div class="job-start">
                    <h1>€${job.payAmountLabel}/U</h1>
                    <div class="job-start-button" data-job="${job.name}">
                        Start Work
                    </div>
                </div>
            </div>
        `)
    })
}

const keyHandler = (e) => {
    if (e.which == 27) {
        $.post("https://xJobSelector/close")
        $('.container').hide()
    }
}

const eventHandler = (event) => {
    const payload = event.data.payload
    switch (event.data.action) {
        case "open":
            const pp = payload.pp
            $('.container[page="main"]').show()
    
            $('.pp-wrapper img').attr('src',pp)
          
       
            break
        case "updateJobs":
            const jobs = payload.jobs
            allJobs = jobs
            $('.jobs-wrapper').html("")
            appendJobs(jobs)
            updatePlayers(jobs)
            break
        default:
            break
    }

}
window.addEventListener("keyup", keyHandler);
window.addEventListener("message", eventHandler);