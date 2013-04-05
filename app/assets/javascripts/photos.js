$(document).ready(function() {
	$("#photo_mountain_id").select2({
  	placeholder: "Select a Mountain"
  });

  $('.gnar_describe').tooltip();

  $('#newPhotoTab a').click(function(e) {
    e.preventDefault();
    $(this).tab('show');
  });
});

$(document).ajaxError(function (e, xhr, settings) {
  if (xhr.status == 406) {
  	$('.main-content-container').prepend('<div class="alert"><a class="close" data-dismiss="alert">×</a><span>You must be <a href="/users/sign_up">logged in</a> to use this feature.</span></div>');
  }
});