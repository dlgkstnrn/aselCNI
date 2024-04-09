$(document).ready(function(){
	console.log("hhh")
	var order_dt;
	var order_end_dt;
	var order_emp_id;
	var cust_emp;
	
	var order_item_cd;
	var item_nm;
	var item_cost;
	var order_qty;
	var oreder_item_cost;
	
	let order_items = new Map();
	var index = 1;
	
	// option 선택했을때 텍스트박스에 해당 물품의 가격 및 제품코드, 단위를 나타나게함
	$("#item_nm").change(function(){
	    var selectedOption = $(this).children("option:selected");
	    item_nm = selectedOption.text()
	   	// console.log(selectedOption.text() + " -  selectOption")
	    order_item_cd = selectedOption.val();
	    if(order_item_cd == "제품명 선택"){
	        $("#selItem_cd").val("");
			console.log("기본")
		} 
	    
	    if (selectedOption.attr('id') == 'order_item_cd') {
			// 선택한 상품의 제품 코드
	        $("#selItem_cd").val(order_item_cd);
	        
	        // ajax 호출
	        //  해당 상품의 단위
	        //  해당 상품의 가격(단가)
	    }
	});
	
	// 수량 입력하면 합계 변함
	$("#order_qty").change(function(){
		item_cost = $("#item_cost").val();
		order_qty = $("#order_qty").val();
		oreder_item_cost = item_cost * order_qty;
		$("#oreder_item_cost").val(oreder_item_cost);
	})
	
	// 물품추가 모달의 저장을 눌렀을때
	$("#order_item_save").click(function(){
		
		// 전부 null이 아니라면 저장하는 코드 실행
		// null 확인 조건문 자리
		// ''' 코드 자리 '''
		
		// item 객체로 만든 후 Map에 저장 (key값은 제품 코드)
		let item = {
			item_nm : item_nm,
			order_qty : order_qty,			
			oreder_item_cost : oreder_item_cost, 
		}
		
		// 이미 존재하는지 확인
		// 존재한다면 수량 증가, 없으면 추가
		if(order_items.has(order_item_cd)){
			alert("이미 존재하는 상품입니다.");
		}else{
			order_items.set(order_item_cd, item);
			index++;
			$("#itemTB").append(
			`<tr>
				<td><input class="form-check-input" type="checkbox" value="${index}" id="items_index" required=""></td>
					<td>${order_item_cd}</td>
					<td>${item_nm}</td>
					<td>박스</td>
					<td><div class="btn-group border-1" role="group">
							<button type="button" class="btn btn-light"><i class="bi bi-dash"></i></button>
							<button type="button" class="btn btn-light" disabled>${order_qty}</button>
			                <button type="button" class="btn btn-light"><i class="bi bi-plus"></i></button>
 						</div></td>
					<td>${oreder_item_cost}</td>
			</tr>`)
			
			// select 초기화 시키는 법??
			
			$("#item_unit").val("");			
			$("#order_qty").val("");
			// $("#item_cost").val("");
			$("#oreder_item_cost").val("");
			
			alert("추가 되었습니다.")
			// 모달 닫기
			$('#disablebackdrop').modal('hide');
		}
//		let check = isNull("order_qty")
		
		
		
		
		// 출력 확인용		
		for (let [key, value] of order_items) {
		  console.log(`Key: ${key}`);
		  for (let prop in value) {
		    console.log(`  ${prop}: ${value[prop]}`);
		  }
		}
	});
	function isNull(key){
		return $(`#${key}`).val() === null || $(`#${key}`).val() === "";
	}
	
	
})