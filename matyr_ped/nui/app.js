PEDS = {}

$(function () {
    function display(bool) {
        if (bool) {
            $("body").fadeIn(0);
        } else {
            $("body").fadeOut(0);
        }
    }
    display(false)

    window.addEventListener('message', (event) => {
        let data = event.data;
        if (data.action == 'showPeds') {
            if (!data.fromServer) {
                $('body').fadeIn(0);
                data.peds.map(e => {
                    new Ped({ ped: e.ped, type: e.type, name: e.label });
                });
            } else {
                display(false)
            }
        }
    });

    $('#default_ped').on('click', () => {
        $('body').fadeOut(0)
        $.post('https://matyr_ped/default_ped', JSON.stringify({}))
    })

    document.onkeyup = function (event) {
        if (event.which == 27) {
            $('body').fadeOut(0, function () {
                $.post("https://matyr_ped/close", JSON.stringify({}));
            });
        }
    };
    
    $('#Home').on('click', () => {
        $('body').fadeOut(0, function () {
            $.post('https://matyr_ped/close', JSON.stringify({}));
        });
    });
    
})