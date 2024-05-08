var sound = new Audio('sound.mp3'); // Adjust the path to your audio file accordingly
sound.volume = 0.8;

window.addEventListener('message', function (event) {
    switch(event.data.action) {
        case 'shortnotif':
            displayNotification(event.data, 1000);
            break;
        case 'notif':
            displayNotification(event.data, 2500);
            break;
        case 'longnotif':
            displayNotification(event.data, 5000);
            break;
        case 'customnotif':
            displayCustomNotification(event.data);
            break;
        default:
            break;
    }
});

function displayNotification(data, duration) {
    var $notification = $('.notification.template').clone();
    $notification.removeClass('template').addClass(data.type).html(data.text).fadeIn();
    $('.notif-container').append($notification);
    sound.play();
    setTimeout(function() {
        $notification.fadeOut(function() {
            $notification.remove();
        });
    }, duration);
}

function displayCustomNotification(data) {
    var $notification = $('.notification.template').clone();
    $notification.removeClass('template').addClass(data.type).html(data.text).fadeIn();
    $('.notif-container').append($notification);
    sound.play();
    setTimeout(function() {
        $notification.fadeOut(function() {
            $notification.remove();
        });
    }, data.duration);
}
