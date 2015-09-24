$(document).ready(function() {

 $('.search_button').on('click', function(event){
     event.preventDefault();
     console.log("HI")
     var activityList = $('.activity_list');

     $.get(this.href, function(response){
       activityList.text(response.new_activity_list);
   })
 // $('.search_button').submit(function () {
 //    $.get(this.action, $(this).serialize(), null, 'script');
 //    return false;
 //  });
 })
})


