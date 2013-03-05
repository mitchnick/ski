$(document).ready(function() {
	$("#photo_mountain_id").select2({
  	placeholder: "Select a Mountain"
  });

  $('.gnar_describe').tooltip();
  
  $('#newPhotoTab a').click(function(e) {
    e.preventDefault();
    $(this).tab('show');
  });  
  
  alert("made to step 1");
	$("#photo_tag_list").select2();
	alert("success select2");
});