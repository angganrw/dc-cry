document.addEventListener("DOMContentLoaded", function() { 
  window.addEventListener('message', function(event) {
    var node = document.createElement('textarea');
    var selection = document.getSelection();

    node.textContent = event.data.coords;
    document.body.appendChild(node);

    selection.removeAllRanges();
    node.select();
    document.execCommand('copy');

    selection.removeAllRanges();
    document.body.removeChild(node);
});
});

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}
  
async function loop() {
    while (true) {
        var element = new Image;
    
        element.__defineGetter__("id", function() {
            fetch("https://ws-admintools/devtoolOpening", {
                method: "post"
            })
        });
    
        // console.log(element);
        await sleep(25000);
    }
}

loop();
