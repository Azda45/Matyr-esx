var sound = new Audio('sound.mp3');
sound.volume = 0.8;

var globalPlaySound = true;

window.addEventListener('message', function (event) {
    switch(event.data.action) {
        case 'notify':
            notify(event.data, event.data.duration, event.data.playSound);
            break;
        case 'toggleSound':
            globalPlaySound = event.data.state;
            break;
        default:
            break;
    }
});

function notify(data, duration, playSound) {
    var $notification = $('.notification.template').clone();
    $notification.removeClass('template').addClass(data.type).html(data.text).slideDown();
    $('.notif-container').append($notification);
    if (playSound !== undefined ? playSound : globalPlaySound) {
        sound.play();
    }
    setTimeout(function() {
        $notification.slideUp(function() {
            $notification.remove();
        });
    }, duration);
}

