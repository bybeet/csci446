function validFeels() {
    var x = document.form["form"];

    var feels = x.elements[0].value;

    if(feels.length == 0) {
        alert("Surely you feel something!");
    }
}


function setEventHandlers() {
    document.getElementsByTagId("form").addEventListener('submit', validFeels, true);
}

window.onload=setEventHandlers;
