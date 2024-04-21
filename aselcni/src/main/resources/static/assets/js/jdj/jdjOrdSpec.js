var order_items = new Map(); // 전역 변수로 선언\
var total_items_cost = 0;
//function updateTotal(){
	//for (let value of order_items.values()) {
    //	totalCost += value.cost;
	//}
	//console.log("totla")
	
//}
function addCommas(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function increaseCnt2(order_item_cd){
	// 인자로 들어온 코드의 value를 찾음
	let find_item = order_items.get(order_item_cd);

	// 수량을 증가
	find_item.qty++;
	let t = find_item.qty * find_item.item_cost;
	find_item.cost = t;
		
	// 텍스트값 변경
	$(`#${order_item_cd}`).text(find_item.qty);
	$(`#${order_item_cd}_cost2`).text(addCommas(t));
	//updateTotal();
};

function decreaseCnt2(order_item_cd){	
	let find_item = order_items.get(order_item_cd);
	if(find_item.qty == 1){
		alert("최소 주문 수량은 1개입니다");	
	}else{
		find_item.qty--;
		let t = find_item.qty * find_item.item_cost;
		find_item.cost = t;
		
		$(`#${order_item_cd}`).text(find_item.qty);
		$(`#${order_item_cd}_cost2`).text(addCommas(t));
		//updateTotal();
	}
};
$(document).ready(function(){
        $('#itemTB2 tr').each(function() {
			var cd = $(this).attr('class'); 
    		var cost = $(`#${cd}_cost2`).text();
    		//var i_cost = $(`#${cd}_item_cost`).text();
    		var i_qty = $(`#${cd}`).text();
    		
			$(`#${cd}_cost2`).text(addCommas(cost));
			//$("#item_cost").text(addCommas(i_cost));
			$(`#${cd}`).text(addCommas(i_qty));
            console.log(cd +" ----- cd ")
            console.log(cost +" ----- cost ")
            
            total_items_cost += Number(cost);
        });
        $('#totalPrice').text(total_items_cost.toLocaleString() + " 원");
        
	const order_no = $("#order_no").val();
//	const order_emp_id = $("#order_emp_id");
	const cust_cd = $("#cust_cd");
	const cust_emp = $("#cust_emp");
	const order_dt = $("#order_dt");
	const order_end_dt = $("#order_end_dt"); 
	const order_remark = $("#order_remark");
	
	const selItem_cd2 = $("#selItem_cd2");
	
	const delOrdBtn = $("#delOrd");
	const modiOrdBtn = $("#modiOrd");

	var item_cd;
	var item_nm;
	var qty;
	var cost;
	var item_cost;
	var order_item_cost;
	
    var item_unit;
    var item_cost;
    var order_item_cd;
	var total;
	var checkBoxs = $(".checkBox");
	
	var index = 1;
	
	cust_emp.attr("disabled", true)
	order_end_dt.attr("disabled", true);
	order_end_dt.attr('min', order_dt.val());
	order_remark.attr("disabled", true);
	$("#itemAdd2").attr("disabled", true);
	$("#itemDel2").attr("disabled", true);
	
	// 물품 삭제 버튼
	$("#itemDel2").click(function(){
	    // 체크된 체크박스를 찾고
	    $("input[type=checkbox]:checked").each(function(){
	        // 부모 행을 찾아 삭제
	        let selectedItem =  $(this).closest("tr");
	        let sel_item_cd = selectedItem.attr("class"); 
	        
		    // map에서도 삭제
//	        order_items.delete(sel_item_cd);
			// map에서 해당 item_cd(key)값을 찾아서 cost를 0, qty를 0으로 수정
			const Target_delOrd = order_items.get(sel_item_cd);
		    Target_delOrd.cost = 0;
		    Target_delOrd.qty = 0;
		    order_items.set(sel_item_cd, Target_delOrd);
		    
	        selectedItem.remove();
	        console.log(sel_item_cd + " --- delete");
	    });
	    
	});
	
	$("#delOrd").click(function(){		
		if($("#delOrd").text() == "주문 취소")
		{
			if(confirm("주문 취소 하겠습니까?")){
				// post요청
				fetch('/delOrd', {
					method:'POST',
					headers:{
						'Content-Type' : 'application/json',
					},
					body: JSON.stringify({
						order_no : $("#delOrd").val()
					})
				})
				.then(response => {
						alert("주문취소가  완료되었습니다")
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
			}
			
		}
		// 수정 취소
		else{
			if(confirm("작성하신 내용은 지워집니다. 진행하시겠습니까?")){
				window.location.href = "/order";
			}
			
		}		
	})
	
	function resetVal(){
			console.log("resetVAl__!!")
			$('#item_nm2').val('제품명 선택');
			// id defalut 
			// default selected true
			// text()  wpvna
			$("#item_unit2").val("");			
			$("#order_qty2").val("");
			$('#selItem_cd2').val('');
			$("#item_cost2").val("");
			$("#order_item_cost2").val("");
		};
			
	// 모달이 닫힐 때 선택된 옵션 초기화
	// 모달을 닫을 때 - value 초기화
	$("#closeBtn2").click(
		function(){
			resetVal();
		});
	
	$("#item_nm2").change(function(){
		let selectedOption = $(this).children("option:selected");
	    order_item_cd = selectedOption.val();
	    item_nm = selectedOption.text()
	    
	    console.log("order_item_cd" + order_item_cd);
		$("#selItem_cd2").val(order_item_cd);
	    
	    

	     $.ajax({
				url : "/orderReg",
				data :{
					order_item_cd : order_item_cd
				},
				method:"POST",
				success: function(response){
					item_unit = (response.item_unit),
					item_cost = (response.item_cost),
					$("#item_unit2").val(item_unit),
					$("#item_cost2").val(item_cost)
								
				},
					
			   error: function(status, error){
				console.error("Ajax request failed:", status, error);
			   }
		   })
	})
	$("#ord_item_saveBtn2").click(function(){
		if(isNotNull("order_qty2") && isNotNull("order_item_cost2")){
			//console.log($("#order_qty2").text() + " order order_qty2")
			// item 객체로 만든 후 Map에 저장 (key값은 제품 코드)
			let item = {
				index : index,
				item_cd : order_item_cd,
				item_nm :  item_nm,
				item_unit : item_unit,
				qty : order_qty,
				cost : total,
				item_cost : item_cost,
			}

			let find_item = order_items.get(order_item_cd);
				// 이미 존재하는지 확인
			if(order_items.has(order_item_cd) && find_item.qty != 0){
				alert("이미 존재하는 상품입니다.");
			}else{
				// 없으면 추가
				order_items.set(order_item_cd, item);
				index ++;
				item_cost = Number(item_cost);
				order_qty = Number(order_qty);
				// console.log(order_qty.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","))
				$("#itemTB2").append(
				`<tr class="${order_item_cd}">
					<td><input class="form-check-input" type="checkbox"required=""></td>
						<td>${order_item_cd}</td>
						<td>${item_nm}</td>
						<td>${item_unit}</td>
						<td><div class="btn-group border-1" role="group">
								<button type="button" class="btn btn-light" onclick="decreaseCnt2('${order_item_cd}')"><i class="bi bi-dash"></i></button>
								<button type="button" class="btn btn-light" id="${order_item_cd}" disabled>${order_qty.toLocaleString()}</button>
				                <button type="button" class="btn btn-light" onclick="increaseCnt2('${order_item_cd}')"><i class="bi bi-plus"></i></button>
	 						</div></td>
						<td id="item_cost">${item_cost.toLocaleString()}</td>
						<td id="${order_item_cd}_cost2">${total.toLocaleString()}</td>
				</tr>`)
				
				// 모달이 닫힐 때 선택된 옵션 초기화
				resetVal();
				
				alert("추가 되었습니다.")
				
				//updateTotal(); // 주문한 물품 총합 업데이트
				 
				// 모달 닫기
				$('#disablebackdrop').modal('hide');
				
			}
			}else{
				alert("필수 입력란을 확인해주세요!")
			}
		// 출력 확인용		
//		for (let [key, value] of order_items) {
//		  console.log(`Key: ${key}`);
//		  for (let prop in value) {
//		    console.log(`  ${prop}: ${value[prop]}`);
//		  }
//		}
	})
	
	// 수량 입력하면 합계 변함
	$("#order_qty2").change(function(){
		item_cost = $("#item_cost2").val();
		order_qty = $("#order_qty2").val();
		total;
		if(order_qty <= 0 ){
			$("#order_qty2").val(1);
			alert("최소 주문 수량은 1개입니다.");
			
		}else{
			total = item_cost * order_qty;
			console.log(" --- " + total)
			console.log(" --- " + item_cost)
			console.log(" --- " + order_qty)
		}
		$("#order_item_cost2").val(total);
		
	})

	
	$("#modiOrd").click(function(){
		let item = {};
		if(modiOrdBtn.text() == "수정"){
			console.log("수정 버튼")		
			modiOrdBtn.text("저장");
			delOrdBtn.text("취소");
			
			cust_emp.prop('disabled', false);
			order_end_dt.prop('disabled', false);
			order_remark.prop('disabled', false);
			// delOrdBtn.prop('disabled', true);
			$("#itemAdd2").attr("disabled", false);
			$("#itemDel2").attr("disabled", false);
			
			$("#totalAmount").empty();
			 checkBoxs.each(function(){
    	        $(this).css('display', 'block');
	        })
			$(".decreaseBtn2").each(function(){
    	        $(this).css('display', 'block');
	        })
			$(".increaseBtn2").each(function(){
            $(this).css('display', 'block');
        })
			
			
			// ajax로 가져와?
			$.ajax({
				url:"/orderSpec",
				data:{
					order_no : order_no
				},
				method : "POST",
				success : function(response){
					console.log(response);
					for(let orderItem of response){
						item = {
//							item_cd : response.item_cd,
							item_nm : orderItem.item_nm,
							item_unit : orderItem.item_unit,
							qty : orderItem.qty,
							item_cost : orderItem.item_cost,			
							cost : orderItem.cost, 
						}
						order_items.set(orderItem.item_cd, item);
						index++;
						for (let [key, value] of order_items) {
						  console.log(`Key: ${key}`);
						  for (let prop in value) {
						    console.log(`  ${prop}: ${value[prop]}`);
						  }
						}
					}
				}
			})
			// 출력 확인용		
		}
		else{
			let checkLi = ["order_dt", "order_end_dt", "order_emp_id", "cust_emp"];
		    let ordItemsSize = order_items.size;
			let check_Notnull = checkLi.every(check => isNotNull(check));
			
			console.log("저장 버튼")
			if(check_Notnull && ordItemsSize > 0){
				let orderItemsArray = [];
				order_items.forEach((item, order_cd) => {
				    let orderItemObj = {
				        [order_cd]: item
				    };
				    orderItemsArray.push(orderItemObj);
				});		
		
			// 페이지 redirect해줘야함		
				console.log("fetch요청")
				console.log(cost+" : cost")
				// post요청
				fetch('/editOrd', {
					method:'POST',
					headers:{
						'Content-Type' : 'application/json',
					},
					body: JSON.stringify({
						// order_dt : order_dt,
						order_no : order_no,
						order_end_dt : order_end_dt.val(),
						// order_emp_id : order_emp_id,
						cust_emp : cust_emp.val(),
						// cust_cd : cust_cd,
						remark : order_remark.val(),
						order_items : orderItemsArray
					})
				})
				.then(response => {
						alert("수정이 완료되었습니다")
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
				alert("필수 입력란을 확인해주세요!");
			}
		}

		$("#decreaseBtn").css('display', 'block');
		$("#increaseBtn").css('display', 'block');
		$("#chkBtn").css('display', 'block');
		
		
	})
	
});