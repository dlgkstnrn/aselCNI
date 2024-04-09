	
// 생산일자는 오늘 날짜로 기본값으로 함
const today = document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);


// 중첩모달 닫기 클릭하면 첫번째 모달이 보여지도록
$('#cancle').on('click', function(){
	$('#addItem').modal('hide');

	// 300ms(0.3초) 대기 후 이전 모달 표시
	setTimeout(function() {
		$('#prodplan').modal('show');
	}, 300); 
})



// 날짜 계산 함수
function addDays(today, days) {
	
	
  	//const clone = new Date(date);
  	//clone.setDate(date.getDate() + days)
  	//alert(clone);
  	//document.getElementById('currentDate').value = clone;
  	//return clone;
  	
}

//const today = new Date();
//const tommorow = new Date(today);
//const yesterday = new Date(today);

//tommorow.setDate(today.getDate() + 1);
//yesterday.setDate(today.getDate() - 1);





// 투입품 추가 버튼 누르면 투입품 추가 모달 띄워지고 값 입력받음
$(function () {

    $("#btnSubmit").click(function (e) {
        e.preventDefault();
        $('#addItem').modal("show");
        //
    });

    $("#btn-submit").click(function() {
        // alert("Submit base form!");
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
	let prp_item_nm = document.getElementById('prp_item_nm');
	let prp_qty = document.getElementById('prp_qty');
	let prp_work_dt = document.getElementById('prp_work_dt');
	let prp_remark = document.getElementById('prp_remark');

	// 공정 select box
	let proc_nm = document.getElementById('proc_nm');

	// 투입품
	let in_item_nm = document.getElementById('in_item_nm');
	let in_item_cd = document.getElementById('in_item_cd');
	let in_qty = document.getElementById('in_qty');

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

		// 1. 테이블로 추가
		// $("#prp_item_tr").each(function(index, element){

		//   for(let i=0; i<result.length; i++) {
		  
		//     console.log(result[i]);

		//     // $('#prp_item_tbody').append('<tr><th>'+(i+1)+'</th><td>'+
		//     //                           result[i].item_cd+'</td><td>'+
		//     //                             result[i].item_nm+'</td><td>'+
		//     //                               '<input type="number" value="'+
		//     //                               result[i].in_qty+'"/>'+
		//     //                               '</td></tr>');

		//     $('#prp_item_tbody').append(
		//       '<tr><th>'+
		//         '<button type="button" class="btn-close removeItem" aria-label="Close"></button>'+
		//           '</th><td>'+
		//             result[i].item_cd+'</td><td>'+
		//               result[i].item_nm+'</td><td>'+
		//                 '<input type="number" value="'+
		//                   result[i].in_qty+'"/>'+
		//                     '</td></tr>');

		//   }
		// })

		// 2. ul, li로 추가
		$('#inItemList').empty();

		result.forEach(element => {

		  console.log(result.length);
		  console.log(element.item_cd+element.item_nm+element.in_qty);
		  console.log(element.item_cd);

		  // 2-1. 태그 생성 후 append
		  // $('#inItemList').append(
		  //   `<li>
		  //     <span>${element.item_cd}</span>
		  //     <span>${element.item_nm}</span>
		  //     <input type="number" value=${element.in_qty}>
		  //     <button type="button" class="btn-close removeItem" aria-label="Close"></button>
		  //   </li>`
		  // );

		  // 2-2. 태그 생성 함수 호출
		  $('#inItemList').append(liEle(element));
		  
		});

	  }
	});
  });


  // 버튼 .removeItem 클릭 시 추가된 품목중 일부 제거
  $(document).on('click', '.removeItem', function() {
  // $('.removeItem').on('click', function() {
	console.log('removeItem this: '+this);
	console.log('parent: '+$(this).parent());
	$(this).parent().remove();
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

		result.forEach((element) => {

		  console.log(element);
		  console.log(element.mid_content);

		  $('#mid_no').append('<option value="' + element.mid_no + '">' +
							  element.mid_content + "</option>");
		  
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

		$('#sml_no').empty().append('<option>소분류 선택</option>');;

		result.forEach((element) => {

		  console.log(element);
		  console.log(element.sml_content);

		  $('#sml_no').append('<option value="' + element.sml_no + '">' +
							  element.sml_content + "</option>");

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

		// $('#addItem_tbody').empty().append('<tr><th>엠티 꼭해야함?</th><td>?</td><td>?</td></tr>');

		array.forEach(element => {

		  console.log(element);
		  console.log(element.item_nm);
		  console.log(element.in_qty);

		  $('#addItem_tbody').append('<tr><td>'+
			  '<input type="radio" name="addItem" id="addItem" value="'+element.item_cd+'"/>'+'</td><th>'+
				element.item_cd+'</th><td>'+
				  element.item_nm+'</td><td>'+
					'<input type="number" class="form_control" id="'+
					  element.in_qty+'"/>'+'</td></tr>');
		});

	  }
	});
  });

  // 투입품 저장 버튼 클릭 이벤트
  $('#addItemSave').click(function() {

	// 선택한 radio value
	let addedItem = $('#addItem option:checked').val();
	// 값 잘 가져왓는가 콘솔에 보기
	console.log('선택한 투입품 값: ' + addedItem);

	$('#prp_item_tbody').append('<tr><th>'+('이미존재하는 length+1 연산')+'</th><td>'+
									  result[i].item_cd+'</td><td>'+
										result[i].item_nm+'</td><td>'+
										  '<input type="number" value="'+
										  result[i].in_qty+'"/>'+
										  '</td></tr>');

  });

 
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

	console.log(wprParam);

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
		qty.value = result.qty;
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
	  success : function(result) {
		console.log(result);

		$("#proc_tr").each(function(index, element){

		  for(let i=0; i<result.length; i++) {

			console.log(result[i]);

			$('#proc_tbody').append('<tr><th>'+(i+1)+'</th><td>'+
									result[i].proc_cd+'</td><td>'+
									  result[i].proc_nm+'</td></tr>');

		  }
		})
	  }
	});

	// ajax 3
	  // 등록된 지시내역의 생산지시번호별 투입품 리스트 조회
	$.ajax({
	  url: 'workItemList',
	  type: 'POST',
	  data: JSON.stringify(wprParam),
	  contentType: 'application/json; charset=utf-8',
	  success : function(result) {
		console.log(result);

		$("#in_item_tr").each(function(index, element){

		  for(let i=0; i<result.length; i++) {
		  
			console.log(result[i]);
		  
			$('#in_item_tbody').append('<tr><th>'+(i+1)+'</th><td>'+
									  result[i].item_cd+'</td><td>'+
										result[i].item_nm+'</td><td>'+
										  result[i].in_qty+'</td></tr>');
								  
		  }
		})
	  }
	});

  });



