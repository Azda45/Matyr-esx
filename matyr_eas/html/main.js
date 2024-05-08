var snd = new Audio("alert.mp3");

function alert(volume) {
    snd.volume = volume;
    snd.play();
    setTimeout(function () {
        snd.pause();
        snd.currentTime = 0;
        document.body.style.display = "none";
    }, 30000);
}

function hide() {
    var x = document.getElementById("eas");
    if (document.body.style.display === "none") {
        document.body.style.display = "block";
    } else {
        document.body.style.display = "none";
    }
}

$(function () {
    window.addEventListener('message', function (event) {
        if (event.data.type == "alert") {
            $('.eas_alerter').html('<marquee behavior="scroll" direction="left" scrollamount="15"><p><b>EMERGENCY ALERT SYSTEM &nbsp;&nbsp;Sent BY: ' + event.data.issuer + '</b>&nbsp;&nbsp;&nbsp;&nbsp;' + event.data.message + '</p></marquee>');
            document.body.style.display = event.data.enable ? "block" : "none";
            alert(event.data.volume);
        }
    });
});
