if(custMst == 2){
	document.getElementById("selBtn").className += " btn btn-primary";
	document.getElementById("buyBtn").className += " btn btn-outline-primary";
}else{
	document.getElementById("selBtn").className += " btn btn-outline-primary";
	document.getElementById("buyBtn").className += " btn btn-primary";
}

$("#tb tbody tr").click(function () {
	let cust_cd = document.getElementById("cust_cd");
	let cust_nm = document.getElementById("cust_nm");
	let president_nm = document.getElementById("president_nm");
	let biz_no = document.getElementById("biz_no");
	let biz_cond = document.getElementById("biz_cond");
	let biz_item = document.getElementById("biz_item");
	let biz_addr = document.getElementById("biz_addr");
	let biz_tel = document.getElementById("biz_tel");
	let biz_fax = document.getElementById("biz_fax");
  $.post("custmstSelectOne",{cust_cd : $(this).data().index})
  .done(function(data){
	  cust_cd.value = data.cust_cd;
	  cust_nm.value = data.cust_nm;
	  president_nm.value = data.president_nm;
	  biz_no.value = data.biz_no;
	  biz_cond.value = data.biz_cond;
	  biz_item.value = data.biz_item;
	  biz_addr.value = data.biz_addr;
	  biz_tel.value = data.biz_tel;
	  biz_fax.value = data.biz_fax;
  })
})

$("#delBtn").click(function(){
	location.href="custmstDelete?cust_cd="+document.getElementById("cust_cd").value;
})

