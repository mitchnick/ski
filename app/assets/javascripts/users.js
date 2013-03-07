$(document).ready(function() {  
  $('#userTabs a').click(function(e) {
    e.preventDefault();
    $(this).tab('show');
  });  
	$("#user_mountain_id").select2({
  	placeholder: "Select Your Home Mountain"
  });
});