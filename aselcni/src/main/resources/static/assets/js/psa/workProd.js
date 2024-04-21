	
// 생산일자는 오늘 날짜로 기본값으로 함
let today = document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);



// date onchange event
function setWorkprod_dt() {

	// 현재 입력된 날짜 값
	let prodplan_dt = document.getElementById('currentDate').value;

	let dateParam = {
		prodplan_dt : prodplan_dt
	}

	console.log('dateParam.prodplan_dt: ' + dateParam.prodplan_dt);

	$.ajax({
		url: 'workprod/workprodTB',
		type: 'post',
		data: JSON.stringify(dateParam),
		contentType: 'application/json; charset=utf-8',

		success: function(array) {

			console.log(array);

			$('#workprodTB tbody tr').empty();
			$('#workprodTB tbody').empty();

			array.forEach(element => {

				console.log('date onchange: ' + element.workprod_no);

			  	$('#workprodTB tbody').append(
					`<tr data-bs-toggle="modal" data-bs-target="#workprod" data-index=${element.workprod_no} >
						<th scope="row">${element.workprod_no}</th>
						<td>${element.seq_no}</td>
						<td>${element.item_nm}</td>
						<td>${element.qty.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")}</td>
						<td>${element.work_dt}</td>
					</tr>`
			  	);
		  	});

			// showWprModal();

			// script 파일을 읽는 시점 차이의 문제로,
			// ajax로 페이지 변경 후에
			// 클릭 이벤트를 다시 입혀줘야 함.

			// 생산지시내역 조회 모달 이벤트
			// tr 클릭했을때 이벤트 발생
			$('#workprodTB tbody tr').click(function() {

				let user_nm = document.getElementById('user_nm');
				let workprod_no = document.getElementById('workprod_no');
				let workprod_dt = document.getElementById('workprod_dt');
				let item_nm = document.getElementById('item_nm');
				let qty = document.getElementById('qty');
				let work_dt = document.getElementById('work_dt');
				let work_cmd = document.getElementById('work_cmd');
				let remark = document.getElementById('remark');
			
				const wprParam = {
				  workprod_no : $(this).data().index
				}
			
				console.log('wprParam.workprod_no: ' + wprParam.workprod_no);
			
				// ajax 1
				// 등록된 지시내역의 생산지시번호별 상세내용 조회 (공정, 투입품 제외)
				$.ajax({
				  url: 'wprInfoModal',
				  type: 'POST',
				  data: JSON.stringify(wprParam),
				  contentType: 'application/json; charset=utf-8',
			
				  success : function(result) {
					console.log(result);
			
					user_nm.value = result.user_nm;
					workprod_no.value = result.workprod_no;
					workprod_dt.value = result.workprod_dt;
					item_nm.value = result.item_nm;
					qty.value = result.qty.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					work_dt.value = result.work_dt;
					work_cmd.value = result.work_cmd;
					remark.value = result.remark;
				  }
				});
			
				// ajax 2
				// 등록된 지시내역의 생산지시번호별 공정 리스트 조회
				$.ajax({
				  url: 'workProcList',
				  type: 'POST',
				  data: JSON.stringify(wprParam),
				  contentType: 'application/json; charset=utf-8',
			
				  success : function(array) {
					console.log(array);
			
					$('#proc_tr').empty();
					$('#proc_tbody').empty();
			
					array.forEach((element, index) => {
			
						console.log(element);
			
						$('#proc_tbody').append(
							`<tr>
								<th>${index + 1}</th>
								<td>${element.proc_cd}</td>
								<td>${element.proc_nm}</td>
							</tr>`
						);
			
					});
				  }
				});
			
				// ajax 3
				// 등록된 지시내역의 생산지시번호별 투입품 리스트 조회
				$.ajax({
				  url: 'workItemList',
				  type: 'POST',
				  data: JSON.stringify(wprParam),
				  contentType: 'application/json; charset=utf-8',
			
				  success : function(array) {
					console.log(array);
			
					$('#in_item_tr').empty();
					$('#in_item_tbody').empty();
			
					array.forEach((element, index) => {
			
						console.log(element);
			
						$('#in_item_tbody').append(
							`<tr>
								<th>${index + 1}</th>
								<td>${element.item_cd}</td>
								<td>${element.item_nm}</td>
								<td>${element.in_qty.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")}</td>
							</tr>`
						);
			
					});
			
				  }
				});
			
			});
			//

		},
		fail: function() {
			alert('fail!!!!');
		},
		error: function() {
			alert('error!!!');
		}
	});

	// $('#FormWorkProd').submit();
}



// 투입품 추가 버튼 누르면 투입품 추가 모달 띄워지고 값 입력받음
$(function () {

    $("#btnSubmit").click(function (e) {
        e.preventDefault();
        $('#addItem').modal("show");
        //
    });

    $("#btn-submit").click(function() {
        $("#btnSubmit").closest("form").submit();
    });
});



// 선택된 투입품 리스트 li 만드는 함수 
const liEle = function (el){
	let liTag = document.createElement("li");
	let spanTag1 = document.createElement("span");
	let spanTag2 = document.createElement("span");
	let inputTag = document.createElement("input")
	inputTag.setAttribute("type","number");
	let btnTag = document.createElement("button")
	btnTag.setAttribute("class","btn-close removeItem");
	btnTag.setAttribute("aria-label","Close");
	spanTag1.innerHTML=el.item_cd;
	spanTag2.innerHTML=el.item_nm;
	inputTag.value = el.in_qty;
	liTag.append(spanTag1);
	liTag.append(spanTag2);
	liTag.append(inputTag);
	liTag.append(btnTag);
	return liTag;
}

// 생산계획내역 조회 모달 이벤트
// tr 클릭했을때 이벤트 발생
$('#prodplanTB tbody tr').click(function() {

	let prodplan_emp_id = document.getElementById('prodplan_emp_id');
	let prp_user_nm = document.getElementById('prp_user_nm');
	let prodplan_no = document.getElementById('prodplan_no');
	let prp_prodplan_dt = document.getElementById('prp_prodplan_dt');
	let prp_item_cd = document.getElementById('prp_item_cd');
	let prp_item_nm = document.getElementById('prp_item_nm');
	let prp_qty = document.getElementById('prp_qty');
	let prp_work_dt = document.getElementById('prp_work_dt');
	let prp_remark = document.getElementById('prp_remark');

	const prpParam = {
	  prodplan_no : $(this).data().index
	}

	console.log(prpParam);

	// ajax 1
	// 생산계획번호별 상세내용 조회 (공정, 투입품 제외)
	$.ajax({
	  url: 'prpInfoModal',
	  type: 'post',
	  data: JSON.stringify(prpParam),
	  contentType: 'application/json; charset=utf-8',
	  success: function(result) {
		console.log(result);

		prodplan_emp_id.value = result.prodplan_emp_id;
		prp_user_nm.value = result.user_nm;
		prodplan_no.value = result.prodplan_no;
		prp_prodplan_dt.value = result.prodplan_dt;
		prp_item_cd.value = result.item_cd;
		prp_item_nm.value = result.item_nm;
		prp_qty.value = result.qty;
		prp_work_dt.value = result.work_dt;
		prp_remark.value = result.remark;
	  }
	});

	// ajax 2
	// 생산계획에서 등록해둔 투입품 리스트 조회
	$.ajax({
	  url: 'planItemList',
	  type: 'post',
	  data: JSON.stringify(prpParam),
	  contentType: 'application/json; charset=utf-8',
	  success: function(result) {
		console.log(result);

		$('#prp_item_tr').empty();
		$('#prp_item_tbody').empty();
		
		// 테이블에 추가
		result.forEach((element, index) => {
			$('#prp_item_tbody').append(
				`<tr class="inItemList">
					<td>${index + 1}</td>
					<td class="inItemCd">${element.item_cd}</td>
					<td>${element.item_nm}</td>
					<td><input type="number" name="in_qty" value=${element.in_qty}>
					<button type="button" class="btn-close removeItem" aria-label="Close"></button></td>
				</tr>`
			);
		});

	  }
	});
});

// 조회된 투입품 리스트 빼기
// 버튼 .removeItem 클릭 시 추가된 품목 하나씩 제거
$(document).on('click', '.removeItem', function() {
	$(this).parent().parent().remove();
});

// 대분류에 맞는 중분류 조회
$('#big_no').on('change', function() {

	let big_no = $("#big_no option:selected").val();

	const bigParam = {
	  big_no : big_no
	}

	$.ajax({
	  url: 'getMidNo',
	  type: 'post',
	  data: JSON.stringify(bigParam),
	  contentType: 'application/json; charset=utf-8',

	  success : function(result) {
		console.log('result: ' + result);

		$('#mid_no').empty().append('<option>중분류 선택</option>');

		result.forEach(element => {

		  console.log(element);
		  console.log(element.mid_content);

		  $('#mid_no').append(
			`<option value=${element.mid_no}>${element.mid_content}</option>`
		  );
		  
		});

		// 속성 추가
		$('#mid_no').attr('bigNo', result[0].big_no);
	  }
	});

});

// 대분류, 중분류에 맞는 소분류 조회
$('#mid_no').on('change',(event) => {

	let mid = event.target;
	let mid_no = mid.value;
	let big_no = mid.getAttribute('bigNo');

	console.log('big_no:', big_no);
	console.log('mid_no:', mid_no);

	const midParam = {
	  big_no : big_no,
	  mid_no : mid_no
	}

	$.ajax({
	  url: 'getSmlNo',
	  type: 'post',
	  data: JSON.stringify(midParam),
	  contentType: 'application/json; charset=utf-8',

	  success : function(result) {
		console.log('result: ' + result);

		$('#sml_no').empty().append('<option>소분류 선택</option>');

		result.forEach(element => {

		  	console.log(element);
		  	console.log(element.sml_content);

			$('#sml_no').append(
				`<option value=${element.sml_no}>${element.sml_content}</option>`
			);

		});

		// 속성 추가
		$('#sml_no').attr('bigNo', result[0].big_no);
		$('#sml_no').attr('midNo', result[0].mid_no);

	  }
	});
});

// 대분류, 중분류, 소분류에 맞는 품목 리스트 조회 radio
$('#sml_no').on('change', function() {

	let big_no = $("#big_no option:selected").val();
	let mid_no = $("#mid_no option:selected").val();
	let sml_no = $("#sml_no option:selected").val();

	const itemParam = {
	  big_no : big_no,
	  mid_no : mid_no,
	  sml_no : sml_no
	}

	$.ajax({
	  url: 'addItemList',
	  type: 'post',
	  data: JSON.stringify(itemParam),
	  contentType: 'application/json; charset=utf-8',

	  success: function(array) {
		console.log(array);

		$('#addItem_tr').empty();
		$('#addItem_tbody').empty();

		array.forEach(element => {

		  	console.log(element);

			$('#addItem_tbody').append(
				`<tr>
					<td><input type="checkbox" name="addItemList" id="addItemList" value=${element.item_cd}></td>
					<td class="ele_item_cd">${element.item_cd}</td>
					<td class="ele_item_nm">${element.item_nm}</td>
				</tr>`
			);
		});

	  }
	});
});



// 선택한 투입품 리스트 임시저장할 배열
let tempSave = [];

// 투입품 저장 버튼 클릭 이벤트
$('#addItemSave').click(function() {

	// row 값 모두 담을 배열
	var rowData = new Array();

	// 각각 td의 값을 담을 배열
	var tdArr = new Array();

	// 체크된 체크박스 담을 변수
	var checkbox = $("input[name=addItemList]:checked");

	// 체크박스의 체크된 수만큼 반복
	checkbox.each(function(i) {

		// checkbox.parent() : checkbox의 부모는 <td>       
		// checkbox.parent().parent() : <td>의 부모이므로 <tr>
		var tr = checkbox.parent().parent().eq(i);
		var td = tr.children();

		// 체크된 row의 모든 값을 배열에 저장
		rowData.push(tr.text());

		// td.eq(0)은 체크박스
		var item_cd = td.eq(1).text();
		var item_nm = td.eq(2).text();

		// 가져온 값을 td 배열에 저장
		tdArr.push(item_cd);
		tdArr.push(item_nm);

		console.log('rowData'+rowData);
		console.log('tdArr item_cd:'+item_cd);
		console.log('tdArr item_nm:'+item_nm);

		// 객체화
		let addedItem = {
			item_cd : $('#addItemList:checked').val(),
			item_nm : item_nm
		};

		console.log('선택한 투입품 값: ' + addedItem);

		// 투입품 리스트 배열에 저장
		tempSave.push(addedItem);

	});

	// 배열에 저장된 길이만큼 반복
	tempSave.forEach(element => {

		$('#prp_item_tbody').append(
			`<tr class="inItemList">
				<td>+</td>
				<td class="inItemCd">${element.item_cd}</td>
				<td>${element.item_nm}</td>
				<td><input type="number" name="in_qty">
				<button type="button" class="btn-close removeItem" aria-label="Close"></button></td>
			</tr>`
		);

	});

	// 투입품 모달 닫기
	$('#addItem').modal('hide');

	// 생산지시 등록 모달 띄우기
	$('#prodplan').modal('show');

});



// 생산지시 등록 모달 form 전송
// $('form').on('submit', function(e){
$('#insertDataBtn').on('click', function(e){

	// form 전송 막기
	e.preventDefault(); 

	alert('수정할 수 없습니다. 등록 하시겠습니까?');

	// 1. 일단 투입품, 공정 제외
	// 생산지시번호도 제외하고 - 컨트롤러 처리
	// 담당자 아이디도 제외하고 - 컨트롤러 처리
	let data = {
		prodplan_no : $('#prodplan_no').val(),
		workprod_dt : $('#prp_prodplan_dt').val(),
		item_cd : $('#prp_item_cd').val(),
		item_nm : $('#prp_item_nm').val(),
		qty : $('#prp_qty').val(),
		work_dt : $('#prp_work_dt').val(),
		work_cmd : $('#prp_work_cmd').val(),
		remark : $('#prp_remark').val()
	}



	// 2. 공정 check box 값들 담을 배열
	var procArr = [];

	// 체크된 공정리스트 배열에 저장
	$("input[name=procList]:checked").each(function() {
		var chkProcList = $(this).val();
		procArr.push(chkProcList);
	});

	console.log('공정 배열 '+procArr);



	// 3. 투입품 값 배열

	// 3-1. item_cd 담을 배열
	let itemCdArr = [];

	// item_cd 값을 가진 td 개수만큼 순회하며 배열에 담음
	$('.inItemList td.inItemCd').each(function(index, item) {
		itemCdArr.push($(this).text());
	})

	console.log('코드 배열 '+itemCdArr);



	// 3-2. in_qty 담을 배열
	let inQtyArr = [];

	// input 개수만큼 순회하며 배열에 담음
	$("input[name=in_qty]").each(function(index, item) {
		inQtyArr.push($(item).val());
	});

	console.log('수량 배열 '+inQtyArr);



	// ajax로 컨트롤러에 form 전송
	// ajax Promise 1-2-3
	new Promise((succ, fail) => {

		// ajax 1. 공정, 투입품 제외한 것
		$.ajax({

			url: 'workprodInsert',
			type: 'post',
			data: JSON.stringify(data),
			contentType: 'application/json; charset=utf-8',

			success: function(result) {
				console.log(result);
				succ(result);
			},
			fail: function(error) {
				fail(error);
				alert('ajax 1단계 실패');
			},
			error: function() {
				alert('ajax 1단계 에러');
			}
		});

	}).then((result) => {

		return new Promise((resolve, reject) =>{

			// ajax 2. 공정 배열 전송
			$.ajax({

				url: 'workprocInsert',
			  	type: 'post',
			  	data: {
					workprod_no : result.workprod_no ,
					"procArr" : procArr
				},

				// ajax로 배열 전송 시 필요한 설정
			  	traditional: true,

			  	success: function(result2) {
					console.log(result2);
					resolve(result2);
				},
				fail: function(error) {
					reject(error);
					alert('ajax 2단계 실패');
				},
				error: function() {
					reject();
					alert('ajax 2단계 에러');
				}
			});
		});

	}).then((result2) => {

		return new Promise((resolve, reject) =>{

			// ajax 3. 투입품 코드 배열, 투입 수량 배열 전송
			$.ajax({

				url: 'workItemInsert',
				type: 'post',
				data: {
					workprod_no : result2.workprod_no ,
					"itemCdArr" : itemCdArr,
					"inQtyArr" : inQtyArr
				},

				// ajax로 배열 전송 시 필요한 설정
				traditional: true,

				success: function(result3) {
					console.log(result3);
					resolve(result3);

					// 생산지시 등록 모달 닫기
					$('#prodplan').modal('hide');

					// 페이지 reload
					window.location.href = 'workprod';
				},
				fail: function(error) {
					reject(error);
					alert('ajax 3단계 실패');
				},
				error: function() {
					reject();
					alert('ajax 3단계 에러');
				}
			});

		});

	});

});



// 생산지시내역 조회 모달 이벤트
// tr 클릭했을때 이벤트 발생
$('#workprodTB tbody tr').click(function() {
// function showWprModal() {

	let user_nm = document.getElementById('user_nm');
	let workprod_no = document.getElementById('workprod_no');
	let workprod_dt = document.getElementById('workprod_dt');
	let item_nm = document.getElementById('item_nm');
	let qty = document.getElementById('qty');
	let work_dt = document.getElementById('work_dt');
	let work_cmd = document.getElementById('work_cmd');
	let remark = document.getElementById('remark');

	const wprParam = {
	  workprod_no : $(this).data().index
	}

	console.log('wprParam.workprod_no: ' + wprParam.workprod_no);

	// ajax 1
	// 등록된 지시내역의 생산지시번호별 상세내용 조회 (공정, 투입품 제외)
	$.ajax({
	  url: 'wprInfoModal',
	  type: 'POST',
	  data: JSON.stringify(wprParam),
	  contentType: 'application/json; charset=utf-8',
	  success : function(result) {
		console.log(result);

		user_nm.value = result.user_nm;
		workprod_no.value = result.workprod_no;
		workprod_dt.value = result.workprod_dt;
		item_nm.value = result.item_nm;
		qty.value = result.qty.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		work_dt.value = result.work_dt;
		work_cmd.value = result.work_cmd;
		remark.value = result.remark;
	  }
	});

	// ajax 2
	// 등록된 지시내역의 생산지시번호별 공정 리스트 조회
	$.ajax({
	  url: 'workProcList',
	  type: 'POST',
	  data: JSON.stringify(wprParam),
	  contentType: 'application/json; charset=utf-8',

	  success : function(array) {
		console.log(array);

		$('#proc_tr').empty();
		$('#proc_tbody').empty();

		array.forEach((element, index) => {

			console.log(element);

			$('#proc_tbody').append(
				`<tr>
					<th>${index + 1}</th>
					<td>${element.proc_cd}</td>
					<td>${element.proc_nm}</td>
				</tr>`
			);

		});
	  }
	});

	// ajax 3
	// 등록된 지시내역의 생산지시번호별 투입품 리스트 조회
	$.ajax({
	  url: 'workItemList',
	  type: 'POST',
	  data: JSON.stringify(wprParam),
	  contentType: 'application/json; charset=utf-8',

	  success : function(array) {
		console.log(array);

		$('#in_item_tr').empty();
		$('#in_item_tbody').empty();

		array.forEach((element, index) => {

			console.log(element);

			$('#in_item_tbody').append(
				`<tr>
					<th>${index + 1}</th>
					<td>${element.item_cd}</td>
					<td>${element.item_nm}</td>
					<td>${element.in_qty.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")}</td>
				</tr>`
			);

		});

	  }
	});

});
// };



// 생산지시 내용 중 '비고' 수정
$('#updateWorkBtn').on('click', function() {

	let param = {
		workprod_no : $('#workprod_no').val(),
		remark : $('#remark').val()
	}

	let workprod_dt = $('#workprod_dt').val();
	
	// 문자열인 생산시작일을 yyyymmdd 형식의 number 타입으로 변환
	let date = new Date(workprod_dt);

	// yyyy
	let year = date.getFullYear();

	// mm
	let month = (date.getMonth() + 1).toString().padStart(2, '0');

	// dd
	let day = date.getDate().toString().padStart(2, '0');

	// yyyymmdd
	const yyyymmdd = `${year}${month}${day}`;
	const numTypeDate = Number(yyyymmdd);


	// 오늘 날짜를 yyyymmdd 형식의 number 타입으로 변환
	let today = new Date();

	// yyyy
	let today_year = today.getFullYear();

	// mm
	let today_month = (today.getMonth() + 1).toString().padStart(2, '0');

	// dd
	let today_day = today.getDate().toString().padStart(2, '0');

	// yyyymmdd
	const today_yyyymmdd = `${today_year}${today_month}${today_day}`;
	const today_numTypeDate = Number(today_yyyymmdd);

	// 생산시작일이 오늘 날짜 후일 때만 수정 가능함
	if (numTypeDate > today_numTypeDate) {

		$.ajax({

			url: 'updateWork',
			type: 'post',
			data: JSON.stringify(param),
			contentType: 'application/json; charset=utf-8',

			success: function() {
				alert('수정 완료!');
			}
		});

	} else {
		alert('생산시작일이 오늘 날짜 후인 것만 수정 할 수 있습니다.');
	}

});



// 등록된 지시 내역 삭제
$('#deleteWorkBtn').on('click', function() {
	// 삭제 해야할까??
});
