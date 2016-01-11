// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap

function remove_fields(link) {
   $(link).prev("input[type=hidden]").val("1");
   $(link).closest(".fields").hide();
 }

 function add_fields(link, association, content) {
   var new_id = new Date().getTime();
   var regexp = new RegExp("new_" + association, "g")
   $(link).parent().before(content.replace(regexp, new_id));
 }

function cowntdown(){
  now = new Date();
  diff = end - now;
  diff = new Date(diff);
  var sec = diff.getSeconds();
  var min = diff.getMinutes();
  var hours = diff.getHours();
  if (min < 10){
    min = "0" + min;
  }
  if (sec < 10){
    sec = "0" + sec;
  }
  hours = "00";
  if(now >= end){
    clearTimeout(timerID);
    document.getElementById("finish").click();
  }
  else{
    document.getElementById("cdtime").innerHTML = hours + ":" + min + ":" + sec;
    timerID = setTimeout("cowntdown()", 1000);
  }
}
var ready = function() {
  var minutesleft = 0;
  var secondsleft =  parseInt($("#cdtime").data("duration"));
  end = new Date();
  end.setMinutes(end.getMinutes()+minutesleft);
  end.setSeconds(end.getSeconds()+secondsleft);
  cowntdown();
};

$(document).ready(ready);
$(document).on("page:load", ready);
