$(document).ready(function() {

      $(".flip").click(function() {
      $(".panel").slideToggle("slow");
    });

 $(document).on('click','.join_button', function(event){

     event.preventDefault();

     var peopleCount = $('.people_needed');
     var notice = $('.notice');

     $('.join_button').hide().delay(400);
     $.post(this.href, function(response){
       peopleCount.text(response.new_people_count);
       notice.text(response.notice);
   })
 })
})