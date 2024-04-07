document.addEventListener("DOMContentLoaded", function () {
    addEventListener("message", function (event) {
        if (event.data && event.data.toggle === true) {
            document.getElementById("data").innerHTML = event.data.html;
            $("#data").show();
        } else {
            $("#data").hide();
        }
    });
});
