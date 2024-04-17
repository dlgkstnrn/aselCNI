$('#return-add').on('click', function () {  
	window.location.href = '/returnAddForm';
});

$('.search').on('keyup', 'input', (event) => {
	if (event.keyCode === 13) {
		$('#search-btn').click();
	}
});

$("#search-btn").on("click", () => {
	const start_day = $('.start-day').val();
	const end_day = $('.end-day').val();
	const return_no = $('.return-no-text').val();
	const outitem_no = $('.outitem-no-text').val();
	const cust_nm = $('.cust-nm-text').val();
	const item_nm = $('.item-nm-text').val();
	const return_emp_nm = $('.return-emp-nm-text').val();

	$(".table-nav .table tbody").empty();
	$(".table-nav .page-navigation .pagination").empty();

	$.ajax({
		type: "get",
		url: "/returnSearch",
		data: {
			start_day : start_day,
			end_day : end_day,
			return_no : return_no,
			outitem_no : outitem_no,
			cust_nm : cust_nm,
			item_nm : item_nm,
			return_emp_nm : return_emp_nm
		},
		dataType: 'json',
		success: function(response) {

			let returnList = response.returnList;
			let paging = response.paging;
			let num = paging.start;

			returnList.forEach((returnObj) => {
				$(".table-nav .table tbody").append(`
	                <tr>
						<th>${num}</th>
						<td><div class="return-no">${returnObj.return_no }</div></td>
						<td>${returnObj.outitem_no }</td>
						<td>${returnObj.cust_nm }</td>
						<td>${returnObj.item_nm }</td>
						<td>${returnObj.res_rtn }</td>
						<td>${returnObj.return_dt }</td>
						<td>${returnObj.return_emp_nm }</td>
						<td>${returnObj.qty.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") }</td>
	                </tr>
           	 	`);
				num = num + 1;
			});

			if (paging.startPage > paging.pageBlock) {
				$(".pagination").append(`
					<li class="page-item"><a class="page-link" href="/return?currentPage=${paging.startPage-paging.pageBlock }&start_day=${start_day}&end_day=${end_day}&return_no=${return_no}&outitem_no=${outitem_no}&cust_nm=${cust_nm}&item_no=${item_nm}&return_emp_nm=${return_emp_nm}"><span>&laquo;</span></a></li>
            	`);
			}

			for (let i = paging.startPage; i <= paging.endPage; i++) {
				$(".pagination").append(`
					<li class="page-item"><a class="page-link" href="/return?currentPage=${i}&start_day=${start_day}&end_day=${end_day}&return_no=${return_no}&outitem_no=${outitem_no}&cust_nm=${cust_nm}&item_no=${item_nm}&return_emp_nm=${return_emp_nm}">${i}</a></li>
            	`);
			}

			if (paging.endPage < paging.totalPage) {
				$(".pagination").append(`
					<li class="page-item"><a class="page-link" href="/return?currentPage=${paging.startPage+paging.pageBlock }&start_day=${start_day}&end_day=${end_day}&return_no=${return_no}&outitem_no=${outitem_no}&cust_nm=${cust_nm}&item_no=${item_nm}&return_emp_nm=${return_emp_nm}"><span>&raquo;</span></a></li>
           		`);
			}
			
		}
	});

});

let start_day_pre = $('.start-day').val();;
let end_day_pre = $('.end-day').val();

$('.day-box').on('change', function () {  
	
	const start_day_string = $('.start-day').val();
	const end_day_string = $('.end-day').val();
	const start_day = new Date(start_day_string);
	const end_day = new Date(end_day_string);

	if(start_day > end_day) {
		alert('조회기간 설정이 부적합 합니다.');
		$('.start-day').val(start_day_pre);
		$('.end-day').val(end_day_pre);
	} else {
		start_day_pre = start_day_string;
		end_day_pre = end_day_string;
	}

});

let return_no;

$('.table tbody').on('click', '.return-no', function () {  
	return_no = $(this).text();
	$.ajax({
		type: "get",
		url: "/getReturn",
		data: {
			return_no : return_no
		},
		dataType: "json",
		success: function (returnObj) {
			$('.return-detail-body').empty();
			$('.return-detail-body').append(`
				<div>
					<div class="return-detail-content">
						<span>반품번호 : </span><span>${returnObj.return_no}</span>
					</div>
					<div class="return-detail-content">
						<span>출고번호 : </span><span>${returnObj.outitem_no}</span>
					</div>
				</div>
				<div>
					<div class="return-detail-content">
						<span>고객사 : </span><span>${returnObj.cust_nm}</span>
					</div>
					<div class="return-detail-content">
						<span>제품명 : </span><span>${returnObj.item_nm}</span>
					</div>
				</div>
				<div>
					<div class="return-detail-content">
						<span>반품사유 : </span><span>${returnObj.res_rtn}</span>
					</div>
					<div class="return-detail-content">
						${returnObj.return_remark == null ? `<span>비고 : </span><span>-</span>` : `<span>비고 : </span><span>${returnObj.remark}</span>`}
					</div>
				</div>
				<div>
					<div class="return-detail-content">
						<span>반품 등록일 : </span><span>${returnObj.return_dt}</span>
					</div>
					<div class="return-detail-content">
						${returnObj.return_update == null ? `<span>수정일 : </span><span>-</span>` : `<span>수정일 : </span><span>${returnObj.return_update}</span>`}
					</div>
				</div>
				<div>
					<div class="return-detail-content">
						<span>담당자 : </span><span>${returnObj.return_emp_nm}</span>
					</div>
					<div class="return-detail-content">
						<span>반품 수량 : </span><span>${returnObj.qty.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")}</span>
					</div>
				</div>
			`);
			$('.return-detail').css('display', 'block');
		}
	});
});

$('#return-detail-cancle').on('click', function () {  
	$('.return-detail').css('display', 'none');
});

$('#return-detail-update').on('click', function () {
	window.location.href = '/returnUpdateForm?return_no=' + return_no;
});

$('#return-detail-delete').on('click', function () {  
	$.ajax({
		type: "post",
		url: "/returnDelete",
		data: {
			return_no : return_no
		},
		success: function (response) {
			window.location.reload(true);
		}
	});
});