$(".btn-primary").on("click", function(event) {
	const user_pw = $(".form-control[name='user_pw']").val();
	const user_nm = $(".form-control[name='user_nm']").val();
	const user_phone = $(".form-control[name='user_phone']").val();
	const user_tel = $(".form-control[name='user_tel']").val();
	const user_email = $(".form-control[name='user_email']").val();
	const user_comm_code = $(".form-select").val();
	
	if (user_pw == '') {
		$(".user-pw-alert").css("display", "block");
		event.preventDefault();
	}

	if (user_nm == '') {
		$(".user-nm-alert").css("display", "block");
		event.preventDefault();
	}

	if (user_phone == '') {
		$(".user-phone-alert").css("display", "block");
		event.preventDefault();
	}

	if (user_tel == '') {
		$(".user-tel-alert").css("display", "block");
		event.preventDefault();
	}

	if (user_email == '') {
		$(".user-email-alert").css("display", "block");
		event.preventDefault();
	}

	if (user_comm_code == '0') {
		$(".user-comm-code-alert").css("display", "block");
		event.preventDefault();
	}
});

$(".cancle-btn").on("click", function() {
	window.location.href = '/userManagement';
});

$(".form-control").on("input", function(event) {
	const user_pw = $(".form-control[name='user_pw']").val();
	const user_nm = $(".form-control[name='user_nm']").val();
	const user_phone = $(".form-control[name='user_phone']").val();
	const user_tel = $(".form-control[name='user_tel']").val();
	const user_email = $(".form-control[name='user_email']").val();

	if (user_pw != '') {
		$(".user-pw-alert").css("display", "none");
	}

	if (user_nm != '') {
		$(".user-nm-alert").css("display", "none");
	}

	if (user_phone != '') {
		$(".user-phone-alert").css("display", "none");
	}

	if (user_tel != '') {
		$(".user-tel-alert").css("display", "none");
	}

	if (user_email != '') {
		$(".user-email-alert").css("display", "none");
	}

});

$(".form-select").on('change', function() {
	const user_comm_code = $(".form-select").val();
	
	if (user_comm_code != '0') {
		$(".user-comm-code-alert").css("display", "none");
	}
})