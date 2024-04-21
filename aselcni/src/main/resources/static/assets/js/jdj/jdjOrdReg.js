var order_items = new Map(); // 전역 변수로 선언
var totalPrice = 0;
function addCommas(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function increaseCnt(order_item_cd){
	// 인자로 들어온 코드의 value를 찾음
	let find_item = order_items.get(order_item_cd);
	console.log("increse--------")
	// 수량을 증가
	find_item.qty++;
	find_item.cost = find_item.item_cost * find_item.qty;

	// 텍스트값 변경
	$(`#${order_item_cd}`).text(find_item.qty);
	$(`#${order_item_cd}_cost`).text(find_item.cost);
};
function decreaseCnt(order_item_cd){
	
	let find_item = order_items.get(order_item_cd);
	if(find_item.qty == 1){
		alert("최소 주문 수량은 1개입니다");	
	}else{
		find_item.qty--;
		find_item.cost = find_item.item_cost * find_item.qty;
		$(`#${order_item_cd}`).text(find_item.qty);
		$(`#${order_item_cd}_cost`).text(find_item.cost);

	}
};
// null여부 확인
function isNotNull(key){
	console.log("isNotNull check")
	return $(`#${key}`).val() != null && $(`#${key}`).val() !== "";
}
function removeInsert(){
	if(confirm("작성하신 내용은 지워집니다. 진행하시겠습니까?")){
		window.location.href = "/order";
	}
}
$(document).ready(function(){	
	console.log("hhh")
	var order_dt;
	var order_end_dt;
	var order_emp_id;
	var cust_emp;
	
	var order_item_cd;
	var item_nm;
	var item_unit;
	var item_cost;
	var order_qty;
	var order_item_cost;
	
	// const order_items = new Map();
	var index = 1;

	// 선택한 착수일보다 무조건 이후만 선택가능
	$("#order_dt").change(function(){
		order_dt = $("#order_dt").val();			// 착수일
		$("#order_end_dt").attr('min', order_dt);
	})
	
	
	// 주문 등록, 저장 버튼
	$("#ord_saveBtn").click(function(){
		console.log("--- saving ---");
		
		let checkLi = ["order_dt", "order_end_dt", "order_emp_id", "cust_emp"];
		
	    let ordItemsSize = order_items.size;
		
//		null이면 true, 아니면 false	    
//	    console.log(isNull('order_dt') + " null check");
		
		// 필수 요소의 null 여부 확인
		let check_Notnull = checkLi.every(check => isNotNull(check));
	   	
   		console.log(check_Notnull + " -- check_Notnull");
	    console.log(" ordItemsSize => " + ordItemsSize);
	   	
	   	if(check_Notnull && ordItemsSize > 0){
			order_end_dt = $("#order_end_dt").val();	// 납기일
			order_remark = $("#order_remark").val();	// 비고
			order_emp_id = $("#order_emp_id").val();	// 당사 담당자 
			cust_emp = $("#cust_emp").val();			// 거래처 담당자
			
			console.log(order_dt + "  = order_Dt")
			
			let selectedOption = $("#cust_cd").children("option:selected");
		    cust_cd = selectedOption.val();				// 거래처 코드			

			for (let [key, value] of order_items) {
			  console.log(`Key: ${key}`);
			  for (let prop in value) {
			    console.log(`  ${prop}: ${value[prop]}`);
			  }
			}
			let orderItemsArray = [];
			order_items.forEach((item, order_cd) => {
			    let orderItemObj = {
			        [order_cd]: item
			    };
			    orderItemsArray.push(orderItemObj);
			});

			console.log("---post 요청 직전 --")
			
			// post요청
			fetch('/saveOrd', {
				method:'POST',
				headers:{
					'Content-Type' : 'application/json',
				},
				body: JSON.stringify({
					order_dt : order_dt,
					order_end_dt : order_end_dt,
					order_emp_id : order_emp_id,
					cust_emp : cust_emp,
					cust_cd : cust_cd,
					remark : order_remark,
					order_items : orderItemsArray
				})
			})
			.then(response => {
					alert("주문이 완료되었습니다")
			    // 리다이렉트된 URL 확인
			    if (response.redirected) {
			        window.location.href = response.url; // 리다이렉트된 URL로 페이지 리로드
			    } else {
			        // 리다이렉트가 아닌 경우에는 서버의 응답을 처리
			        return response.text();
			    }
			})
			.then(data => {
			    console.log(data); // 서버에서 반환된 데이터 처리
			})			
			.catch((error) => console.error("Error : ", error))
			
		}else{
			if(!check_Notnull) return alert("필수 입력란을 확인해주세요!");
			else return alert("주문 품목을 확인해주세요"); 
		}

		
	});
	
	// null여부 확인
	function isNotNull(key){
		return $(`#${key}`).val() != null && $(`#${key}`).val() !== "";
	}
	
	// option 선택했을때 텍스트박스에 해당 물품의 가격 및 제품코드, 단위를 나타나게함
	$("#item_nm").change(function(){
	    let selectedOption = $(this).children("option:selected");
	    item_nm = selectedOption.text()
	    
	   	// console.log(selectedOption.text() + " -  selectOption")
	    order_item_cd = selectedOption.val();
	    if(order_item_cd == "제품명 선택"){
	        $("#selItem_cd").val("");
			console.log("기본")
			order_item_cd = ''; 
			return;
		} 
	    
	    if (selectedOption.attr('id') == 'order_item_cd') {
			// 선택한 상품의 제품 코드
	        $("#selItem_cd").val(order_item_cd);
	        

	        // ajax 호출 || 해당 상품의 단위, 해당 상품의 가격(단가)
	       $.ajax({
				url : "/orderReg",
				data :{
					order_item_cd : order_item_cd
				},
				method:"POST",
				success: function(response){
					console.log("ajax success")
					item_unit = (response.item_unit);
					item_cost = (response.item_cost);
				   $("#item_unit").val(item_unit);
				   $("#item_cost").val(item_cost);
					
					
					console.log(item_unit + ' : item_unit');
					console.log(item_cost + ' : item_cost');
				},
			   error: function(status, error){
				console.error("Ajax request failed:", status, error);
			   }
		   }) // ajax
	    }
	});
	
	// 수량 입력하면 합계 변함
	$("#order_qty").change(function(){
		item_cost = $("#item_cost").val();
		order_qty = $("#order_qty").val();
		if(order_qty <= 0 ){
			$("#order_qty").val(1);
			alert("최소 주문 수량은 1개입니다.");
			
		}else{
			order_item_cost = item_cost * order_qty;
		}
		$("#order_item_cost").val(order_item_cost);
		
	})
	$("#addItemLi").click(function(){
		item_cost = 0;
		order_qty = 0;
	})
	
	// 모달을 닫을 때 - value 초기화
	$("#closeBtn").click(resetVal);
	
	// 물품추가 모달의 저장을 눌렀을때
	$("#ord_item_saveBtn").click(function(){
		console.log("--- modal ---")
		// 전부 null이 아니라면 저장하는 코드 실행
		// null 확인 조건문 자리
		
		
		console.log("item_unit -> " + item_unit);
		console.log("order_item_cost -> " + order_item_cost);
		console.log("order_qty -> " + order_qty);
		console.log("item_cost -> " + item_cost);
		console.log("order_item_cost -> " + order_item_cost);
		
		console.log("--- befoer null check ---")
		let checkLi =  ["selItem_cd", "item_nm","item_unit", "order_item_cost","order_qty", "item_cost", "order_item_cost"]
		let check_Notnull = checkLi.every(check => isNotNull(check));
		console.log("modal is not null? -> " + check_Notnull);
		
		
		if(check_Notnull){
			// item 객체로 만든 후 Map에 저장 (key값은 제품 코드)
			let item = {
				item_cd : order_item_cd,
				item_nm : item_nm,
				item_unit : item_unit,
				qty : order_qty,
				item_cost : item_cost,			
				cost : order_item_cost, 
				index : index
			}
			
				// 이미 존재하는지 확인
			if(order_items.has(order_item_cd)){
				alert("이미 존재하는 상품입니다.");
			}else{
				index++;
				// 없으면 추가
				order_items.set(order_item_cd, item);
				let c_ic = addCommas(order_item_cost);
				$("#itemTB").append(
				`<tr class="${order_item_cd}">
					<td><input class="form-check-input" type="checkbox" value="${index}" id="items_index" required=""></td>
						<td>${order_item_cd}</td>
						<td>${item_nm}</td>
						<td>${item_unit}</td>
						<td><div class="btn-group border-1" role="group">
								<button type="button" class="btn btn-light" onclick="decreaseCnt('${order_item_cd}')"><i class="bi bi-dash"></i></button>
								<button type="button" class="btn btn-light" id="${order_item_cd}" disabled>${order_qty}</button>
				                <button type="button" class="btn btn-light" onclick="increaseCnt('${order_item_cd}')"><i class="bi bi-plus"></i></button>
	 						</div></td>
						<td>${item_cost}</td>
						<td id="${order_item_cd}_cost">${c_ic}</td>
				</tr>`)
				
				totalPrice += order_item_cost;
				
				// 모달이 닫힐 때 선택된 옵션 초기화
				// select 초기화 시키는 법??
				resetVal();
				
				alert("추가 되었습니다.")
				
				// 모달 닫기
				$('#disablebackdrop').modal('hide');
				
				$("#totalPrice").text(totalPrice);
	
			}
			}else{
				alert("품목을 선택해주세요!")
			}

		// 출력 확인용		
		for (let [key, value] of order_items) {
		  console.log(`Key: ${key}`);
		  for (let prop in value) {
		    console.log(`  ${prop}: ${value[prop]}`);
		  }
		}
	});


		
	// 모달이 닫힐 때 선택된 옵션 초기화
	function resetVal(){
		console.log("resetVAl__!!")
		$('#item_nm').val('제품명 선택');
		$("#item_unit").val("");			
		$("#order_qty").val("");
		$('#selItem_cd').val('');
		$("#item_cost").val("");
		$("#order_item_cost").val("");
	}
	
	// 물품 삭제 버튼
	$("#deleteBtn").click(function(){
	    // 체크된 체크박스를 찾고
	    $("input[type=checkbox]:checked").each(function(){
	        // 부모 행을 찾아 삭제
	        let selectedItem =  $(this).closest("tr");
	        let sel_item_cd = selectedItem.attr("class"); 
	        
		    // map에서도 삭제
	        order_items.delete(sel_item_cd);
	        selectedItem.remove();
	        console.log(sel_item_cd + " --- delete");
	    });
	    
	});

})
