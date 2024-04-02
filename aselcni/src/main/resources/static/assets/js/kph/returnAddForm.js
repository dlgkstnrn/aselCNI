let is_outitem_chk_count;

$(".return-add-btn").on("click", function(event) {
	const outitem_no = $(".form-control[name='outitem_no']").val();
	const cust_cd = $(".form-control[name='cust_cd']").val();
	const cust_emp = $(".form-control[name='cust_emp']").val();
	const item_cd = $(".form-control[name='item_cd']").val();
	const qty = $(".form-control[name='qty']").val();
	const res_rtn = $(".form-control[name='res_rtn']").val();

	if(is_outitem_chk_count != 1) {
		event.preventDefault();
		alert('출고번호 조회를 진행하세요');
	}

	if (outitem_no == '') {
		$(".outitem-no-alert").css("display", "block");
		event.preventDefault();
	} 

	if (cust_cd == '') {
		$(".cust-cd-alert").css("display", "block");
		event.preventDefault();
	}

	if (cust_emp == '') {
		$(".cust-emp-alert").css("display", "block");
		event.preventDefault();
	}

	if (item_cd == '') {
		$(".item-cd-alert").css("display", "block");
		event.preventDefault();
	}

	if (qty == '') {
		$(".qty-alert").css("display", "block");
		event.preventDefault();
	}

	if (res_rtn == '') {
		$(".res-rtn-alert").css("display", "block");
		event.preventDefault();
	}
});

$('.return-cancle-btn').on('click', function () {  
    window.location.href = '/return';
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

/* 출고 번호 조회 */
$('#is-outitem-btn').on('click', function () {  
	const outitem_input = $(this).closest('.outitem-box').find('input'); 
	const outitem_no = $(outitem_input).val();

	$.ajax({
		type: "get",
		url: "/isOutItem",
		data: {
			outitem_no : outitem_no
		},
		dataType: "text",
		success: function (response) {
			if(response == '없음') {
				alert('출고번호가 존재하지 않습니다');
				$(outitem_input).val('');
			} else {
				alert('사용 가능한 출고 번호 입니다.');
				$(outitem_input).prop("readonly", true);
				$(outitem_input).css('background-color', 'rgba(128, 128, 128, 0.227)');
				is_outitem_chk_count = 1;
			}
		}
	});
	
});

/* 고객사 조회 */
const ul = $('.cust-choice-box').find('.cust-list-box').find('ul');

$('#choose-cust-btn').on('click', function () {
    $('#cust-search-text').val('');
    getCustList();
    $('.cust-choice-box').css('display', 'block');
});

function getCustList(keyword) {
    $.ajax({
        type: "get",
        url: "/getCustList",
        data: {
            keyword : keyword
        },
        dataType: "json",
        success: function (custList) {
            $(ul).empty();
            custList.forEach(cust => {
                $(ul).append(`
                    <li class="cust">
                        <input name="cust_cd" type="hidden" value="${cust.cust_cd}" />
                        <span class="choice-cust-name">${cust.cust_nm}</span>
                        <span>(${cust.cust_cd})</span>
                    </li>
                `);
            });
        }
    });
}

/* 고객사 조회 - 취소 버튼 */
$('.cust-cancle-btn').on('click', function () {  
    $('.cust-choice-box').css('display', 'none');
});

/* 고객사 조회 - 고객사 클릭 */
$('.cust-list-box').on('click', '.cust', function () {  
    const cust_cd = $(this).find('input').val();
    const cust_nm = $(this).find('.choice-cust-name').text();
    $('.cust-box').find('input[name=cust_cd]').val(cust_cd);
    $('.cust-box').find('input[name=cust_nm]').val(cust_nm);
    $('.cust-choice-box').css('display', 'none');
});

/* 고객사 조회 - 고객사 검색 */
$('#cust-search-btn').on('click', function() {
	const keyword = $('#cust-search-text').val();
	getCustList(keyword);
});

$('#cust-search-text').on('keyup', (event) => {
	if (event.keyCode === 13) {
		$('#cust-search-btn').click();
	}
});

/* 아이템 조회 */
const big_category_ul = $('.big-category ul');
const mid_category_ul = $('.mid-category ul');
const small_category_ul = $('.small-category ul');

$('#choose-item-btn').on('click', function () {
    $('#item-search-text').val('');
    $(big_category_ul).find('input:checked').prop('checked', false);
    $(mid_category_ul).empty();
    $(small_category_ul).empty();
    $('.item-choice-box').css('display', 'block');
});

/* 아이템 조회 - 취소 버튼 */
$('.item-cancle-btn').on('click', function () {  
    $('.item-choice-box').css('display', 'none');
});