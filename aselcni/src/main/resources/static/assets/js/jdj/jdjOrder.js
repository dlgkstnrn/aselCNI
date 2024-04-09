$(document).ready(function(){
	const curr_dt = new Date();
	
	const year = curr_dt.getFullYear();
	const month = ('0' + curr_dt.getMonth()).slice(-2); // 10월부터는 010이 되기 때문에 마지막 두 자리를 가져옴
	const date = ('0' + curr_dt.getDate()).slice(-2);
	const order_dt = year + '-' + month + '-' + date;
	
	var order_end_dt = '';
	
	const order_items = [];
	
	console.log("order_dt -> " + order_dt );

	$('#ord_save').click(function(){
		
		if(order_dt > order_end_dt){
			alert("납기일을 확인해주세요");
			$('#order_end_dt').val(''); 
		}

		console.log("order_end_date => " + order_end_dt);
	});
	
	// 모달속 아이템 선택후
	$('#item_nm').change(function(){
		console.log("dd")
		/*var selectedItem_cd = $(this).val();
		
		var selItem_unit = $('#item_unit').val();
		var selItem_cost = $('#item_cost').val();
		var selItem_total = $('#ord_item_cost').val();
		
		$('#selItem_cd').val(selectedItem_cd);
		
		fetch('/orderReg', {
			method:'POST',
			headers:{
		      'Content-Type': 'application/json' // 본문의 내용 형식 지정
			}, 
			body:JSON.stringify({
				item_cd : selectedItem_cd	
			})
		})
		.then(res => res.json())
		.then (data => {
			selItem_unit = data.item_unit;
			selItem_cost = data.item_cost;
			selItem_total = selItem_cost * selItem_unit;
		})	
		.catch(error => console.log(error));*/
	});
})