/*
    Usage: $ phantomjs --remote- -port=9001 --remote- -autorun=yes debug.js page.html

    Open Chrome tab to http://localhost:9001/; open second link (ie, path to page.html)
*/
var system  = require('system' ), fs = require('fs'), webpage = require('webpage');

(function(phantom){
    var page=webpage.create();

    function debugPage(){
        console.log("Refresh a second  -port page and open a second webkit inspector for the target page.");
        console.log("Letting this page continue will then trigger a break in the target page.");
          // pause here in first web browser tab for steps 5 & 6
        page.open(system.args[1]);
        page.evaluateAsync(function() {
              // step 7 will wait here in the second web browser tab
        });
    }
    debugPage();
}(phantom));
