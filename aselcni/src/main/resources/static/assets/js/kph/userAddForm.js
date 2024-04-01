let duplication_chk_count;

$(".btn-primary").on("click", function(event) {
	const user_id = $(".form-control[name='user_id']").val();
	const user_pw = $(".form-control[name='user_pw']").val();
	const user_nm = $(".form-control[name='user_nm']").val();
	const user_phone = $(".form-control[name='user_phone']").val();
	const user_tel = $(".form-control[name='user_tel']").val();
	const user_email = $(".form-control[name='user_email']").val();
	const user_comm_code = $(".form-select").val();
	
	if(duplication_chk_count != 1) {
		event.preventDefault();
		alert('아이디 중복 체크를 진행하세요');
	}

	if (user_id == '') {
		$(".user-id-alert").css("display", "block");
		event.preventDefault();
	} 

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
	const user_id = $(".form-control[name='user_id']").val();
	const user_pw = $(".form-control[name='user_pw']").val();
	const user_nm = $(".form-control[name='user_nm']").val();
	const user_phone = $(".form-control[name='user_phone']").val();
	const user_tel = $(".form-control[name='user_tel']").val();
	const user_email = $(".form-control[name='user_email']").val();

	if (user_id != '') {
		$(".user-id-alert").css("display", "none");
	}

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

$('.duplication-chk').on('click', function () {  
	const id_input = $(this).closest('.id-box').find('input'); 
	const user_id = $(id_input).val();
	console.log(user_id.length);
	
	if (user_id.length > 15) {
		alert('아이디 길이는 15자 이하입니다.');
	} else {
		$.ajax({
			type: "get",
			url: "/userDuplicationChk",
			data: {
				user_id: user_id
			},
			dataType: "text",
			success: function (response) {
				if(response == '중복') {
					alert('중복된 아이디가 존재합니다.');
					$(id_input).val('');
				} else {
					alert('사용 가능한 아이디 입니다.');
					$(id_input).prop("readonly", true);
					$(id_input).css('background-color', 'rgba(128, 128, 128, 0.227)');
					duplication_chk_count = 1;
				}
			}
		});
	}
});
