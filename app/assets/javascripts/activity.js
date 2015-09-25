$(document).ready(function() {

 $(document).on('click','.join_button', function(event){
     event.preventDefault();

     var peopleCount = $('.people_needed');
     var notice = $('.notice');

     $.post(this.href, function(response){
       peopleCount.text(response.new_people_count);
       notice.text(response.notice);

   })
 })
})
