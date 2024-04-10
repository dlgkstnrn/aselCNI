$(".return-add-btn").on("click", function(event) {
	const outitem_no = $(".form-control[name='outitem_no']").val();
	const cust_cd = $(".form-control[name='cust_cd']").val();
	const cust_emp = $(".form-control[name='cust_emp']").val();
	const item_cd = $(".form-control[name='item_cd']").val();
	const qty = $(".form-control[name='qty']").val();
	const res_rtn = $(".form-control[name='res_rtn']").val();

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
	const outitem_no = $(".form-control[name='outitem_no']").val();
	const cust_cd = $(".form-control[name='cust_cd']").val();
	const cust_emp = $(".form-control[name='cust_emp']").val();
	const item_cd = $(".form-control[name='item_cd']").val();
	const qty = $(".form-control[name='qty']").val();
	const res_rtn = $(".form-control[name='res_rtn']").val();

	if (outitem_no != '') {
		$(".outitem-no-alert").css("display", "none");
	} 

	if (cust_cd != '') {
		$(".cust-cd-alert").css("display", "none");
	}

	if (cust_emp != '') {
		$(".cust-emp-alert").css("display", "none");
	}

	if (item_cd != '') {
		$(".item-cd-alert").css("display", "none");
	}

	if (qty != '') {
		$(".qty-alert").css("display", "none");
	}

	if (res_rtn != '') {
		$(".res-rtn-alert").css("display", "none");
	}

});

/* 출고 번호 조회 */
let outitem_choice_chk = 0;

$('#outitem-choice-btn').on('click', function () {  
    $('#out-item-no-search-text').val('');
    $('.out-item-choice-box').find('.search-filter').val('all');
    $('.out-item-choice-box').find('.date-search-filter').val('30day');
    outItemList();
});

function outItemList(keyword, searchFilter, dateSearchFilter) {
    $.ajax({
        type: "get",
        url: "/outItemList",
        data: {
            keyword : keyword,
            searchFilter : searchFilter,
            dateSearchFilter : dateSearchFilter
        },
        dataType: "json",
        success: function (outItemList) {
            $('.out-item-list-box ul').empty();
            outItemList.forEach(outItem => {
                $('.out-item-list-box ul').append(`
                    <li class="out-item">
                        <input name="outitem_no" type="hidden" value="${outItem.outitem_no}" />
						<input name="cust_nm" type="hidden" value="${outItem.cust_nm}" />
						<input name="cust_cd" type="hidden" value="${outItem.cust_cd}" />
                        <span class="outitem-no">출고번호: ${outItem.outitem_no}</span>
                        <span> / (주문번호 : ${outItem.order_no}, ${outItem.cust_nm}, ${outItem.user_nm})</span>
                    </li>
                `);
            });
            $('.out-item-choice-box').css('display', 'block');        
        }
    });
}

/* 출고 번호 조회 - 검색 */
$('#out-item-no-search-text').on('keyup', (event) => {
	if (event.keyCode === 13) {
		$('#out-item-no-search-btn').click();
	}
});

$('#out-item-no-search-btn').on('click', function () {  
	const keyword = $('#out-item-no-search-text').val();
	const searchFilter = $('.search-filter').val();
	const dateSearchFilter = $('.date-search-filter').val();

	outItemList(keyword, searchFilter, dateSearchFilter);
});

$('.search-filter, .date-search-filter').on('change', function () {  
	const keyword = $('#out-item-no-search-text').val();
	const searchFilter = $('.search-filter').val();
	const dateSearchFilter = $('.date-search-filter').val();

	outItemList(keyword, searchFilter, dateSearchFilter);
});

/* 출고 번호 조회 - 선택 */
$(".out-item-list-box").on('click', 'li', function () {  
	const outitem_no = $(this).find('input[name=outitem_no]').val();
	const cust_nm = $(this).find('input[name=cust_nm]').val();
	const cust_cd = $(this).find('input[name=cust_cd]').val();

	$('.outitem-no').val(outitem_no);
	$('.cust-cd').val(cust_cd);
	$('.cust-nm').val(cust_nm);

	$('.item-cd').val('');
	$('.item-nm-box').find('input').val('');
	$('.max-qty').val('');
	$('.item_qty').val('');
	$('.item_qty').prop('readonly', true);
	$('.item_qty').addClass('readonly');

	outitem_choice_chk = 1;

	$('.out-item-choice-box').css('display', 'none');
});

/* 출고 번호 조회 - 취소 */
$('.out-item-cancle-btn').on('click', function () {  
    $('.out-item-choice-box').css('display', 'none');
});

/* 제품 선택 */
$('#choose-item-btn').on('click', function () {  

	if(outitem_choice_chk == 1) {
		$('#item-search-text').val('');
		itemList();
		$('.item-choice-box').css('display', 'block');
	} else {
		alert('출고 번호 조회를 먼저 진행 해주세요');
	}
    
});

function itemList(keyword) {
	const outitem_no = $('.outitem-no').val();
    $.ajax({
        type: "get",
        url: "/outItemItemList",
        data: {
			outitem_no : outitem_no,
            keyword : keyword
        },
        dataType: "json",
        success: function (itemList) {
            $('.item-list-box ul').empty();
            itemList.forEach(item => {
                $('.item-list-box ul').append(`
                    <li>
                        <input name="usable_qty" type="hidden" value="${item.usable_qty}"/>
                    	<input name="item_nm" type="hidden" value="${item.item_nm}"/>
                    	<input name="item_cd" type="hidden" value="${item.item_cd}"/>
                    	<input name="qty" type="hidden" value="${item.qty}"/>
                        <span class="item_nm">${item.item_nm}</span>
						<span> / </span>
						<span>${item.item_cd}, 반품 가능수량 : ${item.usable_qty}개</span>
                    </li>
                `);
            });
        }
    });
}

/* 제품 선택 - 검색 */
$('#item-search-text').on('keyup', (event) => {
	if (event.keyCode === 13) {
		$('#item-search-btn').click();
	}
});

$('#item-search-btn').on('click', function () {  
	const keyword = $('#item-search-text').val();
	itemList(keyword);
});

/* 제품 선택 - 선택 */
$('.item-list-box ul').on('click', 'li', function () {  
	const item_nm = $(this).find('input[name=item_nm]').val();
	const item_cd = $(this).find('input[name=item_cd]').val();
	let max_qty = $(this).find('input[name=usable_qty]').val();
	if(max_qty == 0) {
		max_qty = $(this).find('input[name=qty]').val();
	}
	$('.item-nm-box').find('input').val(item_nm);
	$('.item-cd').val(item_cd);
	$('.max-qty').val(max_qty);
	$('.item_qty').val('');
	$('.item_qty').prop('readonly', false);
	$('.item_qty').removeClass('readonly');
	$('.item-choice-box').css('display', 'none');
});

$('.item_qty').on('keyup', function () {  
	if(Number($('.max-qty').val()) < Number($('.item_qty').val())) {
		alert('입력 가능한 최대 수량은 ' + $('.max-qty').val() + '개 입니다.');
		$('.item_qty').val('');
	}
});

/* 제품 선택 - 취소 */
$('.item-cancle-btn').on('click', function () {  
    $('.item-choice-box').css('display', 'none');
});