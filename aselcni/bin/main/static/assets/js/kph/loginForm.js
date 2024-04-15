$('.login-btn').on('click', function (event) {  

    const user_id = $('#user-id').val();
    const user_pw = $('#user-pw').val();

    if(user_id == '') {
        $('.id-alert').css('display', 'block');
    }

    if(user_pw == '') {
        $('.pw-alert').css('display', 'block');
    }

    if(user_id !='' && user_pw != '') {
        $.ajax({
            type: "get",
            url: "/loginChk",
            data: {
                user_id: user_id,
                user_pw: user_pw
            },
            dataType: "text",
            success: function (response) {
                if(response == '성공') {
                    window.location.href = '/main';
                } else {
					console.log(response);
                    alert('아이디 또는 비밀번호가 틀렸습니다.');
                }
            }
        });
    }

});


$(".form-control").on('input', function () {  
    const user_id = $(".form-control[name='user_id']").val();
	const user_pw = $(".form-control[name='user_pw']").val();

    if (user_id != '') {
		$(".id-alert").css("display", "none");
	} 
	
	if(user_pw != '') {
		$(".pw-alert").css("display", "none");
	} 
});


$('#user-id, #user-pw').on('keyup', (event) => {
	if (event.keyCode === 13) {
		$('.login-btn').click();
	}
});