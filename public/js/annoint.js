$(document).ready(function(){
  $(".line").click(function(event){
    event.preventDefault();
    var $target = $(event.target);
    console.log("Clicked "+$target.attr('id'));
  });
  $(".line").hover(function(event){
    event.preventDefault();
    var $target = $(event.target);
    $target.css('background-color', 'yellow');
  }, function(event){
      event.preventDefault();
      var $target = $(event.target);
      $target.css('background-color', 'white');
  });
});