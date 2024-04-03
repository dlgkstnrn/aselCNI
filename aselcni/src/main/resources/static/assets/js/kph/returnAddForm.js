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
                        <span class="outitem-no">출고번호: ${outItem.outitem_no}</span>
                        <span> / (주문번호 : ${outItem.order_no}, ${outItem.cust_nm}, ${outItem.user_nm})</span>
                    </li>
                `);
            });
            $('.out-item-choice-box').css('display', 'block');        
        }
    });
}

/* 출고 번호 조회 - 취소 */
$('.out-item-cancle-btn').on('click', function () {  
    $('.out-item-choice-box').css('display', 'none');
});

/* 제품 선택 */
$('#choose-item-btn').on('click', function () {  
    $('#item-search-text').val('');
    itemList();
    $('.item-choice-box').css('display', 'block');
});

function itemList(keyword) {
    $.ajax({
        type: "get",
        url: "/itemList",
        data: {
            keyword : keyword
        },
        dataType: "json",
        success: function (itemList) {
            $('.item-list-box ul').empty();
            itemList.forEach(item => {
                $('.item-list-box ul').append(`
                    <li>
                        <input type="hidden" name="item_cd" value=${item.item_cd}/>
                        <span class="item_nm">${item.item_nm}</span>
                        <span class="item_cd">${item.item_cd}</span>
                        <span class="qty">${item.qty}</span>
                    </li>
                `);
            });
        }
    });
}

$('.item-cancle-btn').on('click', function () {  
    $('.item-choice-box').css('display', 'none');
});