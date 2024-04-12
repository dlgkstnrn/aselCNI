const numberReg = /^\d+$/;

if(itemMst == 1){
	document.getElementById("matBtn").className += " btn btn-primary";
	document.getElementById("proBtn").className += " btn btn-outline-primary";
}else{
	document.getElementById("matBtn").className += " btn btn-outline-primary";
	document.getElementById("proBtn").className += " btn btn-primary";
}

const optionEle = function(value,content){
	const option = document.createElement("option");
	option.value = value;
	option.innerText = content;
	return option;
}

const submitChk = function(){
	if($("#modalbig").val() == "대분류" || $("#modalbig").val()==""){
		alert("분류를 선택해주세요");
		return false;
	}
	if($("#mid").val() == "중분류" || $("#mid").val()==""){
		alert("분류를 선택해주세요");
		return false;
	}
	if($("#sml").val() == "소분류" || $("#sml").val()==""){
		alert("분류를 선택해주세요");
		return false;
	}
	if(numberReg.test(document.getElementById("item_cost").value)){
		return true
	}else{
		alert("가격에 숫자만 입력해주세요");
		return false;
	}	
}

$("#tb tbody tr").click(function(){
	$("#mid").empty();
	$("#mid").append(optionEle('0','중분류'));
	$("#sml").empty();
	$("#sml").append(optionEle('0','소분류'));
	$("#cust_cd").empty();
	$("#cust_cd").append(optionEle('','거래처선택'));
	const itemNm = document.getElementById("item_nm");
	const itemSpec = document.getElementById("item_spec");
	const itemUnit = document.getElementById("item_unit");
	const itemCost = document.getElementById("item_cost");
	const itemRemark = document.getElementById("remark");
	const itemCd = document.getElementById("item_cd");
	$.post("itemmstSelectByitemCd",{item_cd : $(this).data().index})
	.done(function(data){
		data['custList'].forEach(function(cust){
			$('#cust_cd').append(optionEle(cust.cust_cd,cust.cust_nm));
		});
		data['midList'].forEach(function(mid){
			$('#mid').append(optionEle(mid.mid_no,mid.mid_content));
		});
		data['smlList'].forEach(function(sml){
			$('#sml').append(optionEle(sml.sml_no,sml.sml_content));
		});
		if(data['item'].cust_cd){
			document.querySelector(`#cust_cd option[value="${data['item'].cust_cd}"]`).setAttribute('selected',true);
		}
		document.querySelector(`.modalbig[value='${data['item'].big_no}']`).setAttribute('selected',true);
		document.querySelector(`#mid option[value="${data['item'].mid_no}"]`).setAttribute('selected',true);
		document.querySelector(`#sml option[value="${data['item'].sml_no}"]`).setAttribute('selected',true);
		itemCd.value = data['item'].item_cd;
		itemNm.value = data['item'].item_nm;
		itemSpec.value = data['item'].item_spec;
		itemUnit.value = data['item'].item_unit;
		itemCost.value = data['item'].item_cost;
		itemRemark.value = data['item'].remark;
	})
})

$("#modalbig").change(function(){
	$("#mid").empty();
	$("#mid").append(optionEle('0','중분류'));
	$("#sml").empty();
	$("#sml").append(optionEle('0','소분류'));
	if($(this).val() !== '대분류'){
		$.post("selectMid",{big_no:$(this).val()}).
		done(function(data){
			data.forEach(function(mid){
				$('#mid').append(optionEle(mid.mid_no,mid.mid_content));
			})
		})
	}
})

$("#mid").change(function(){
	$("#sml").empty();
	$("#sml").append(optionEle('0','소분류'));
	if($(this).val() !== '중분류'){
		$.post("selectSml",{
							big_no:$('#modalbig').val(),
							mid_no:$(this).val()
							}).
		done(function(data){
			data.forEach(function(sml){
				$('#sml').append(optionEle(sml.sml_no,sml.sml_content));
			})
		})
	}
})

$("#delBtn").click(function(){
	location.href="itemDelete?item_cd="+$('#item_cd').val();
})

$("#searchBig").change(function(){
	$("#searchMid").empty();
	$("#searchMid").append(optionEle('0','중분류'));
	$("#searchSml").empty();
	$("#searchSml").append(optionEle('0','소분류'));
	if($(this).val() !== '대분류'){
		$.post("selectMid",{big_no:$(this).val()}).
		done(function(data){
			data.forEach(function(mid){
				$('#searchMid').append(optionEle(mid.mid_no,mid.mid_content));
			})
		})
	}
})

$("#searchMid").change(function(){
	$("#searchSml").empty();
	$("#searchSml").append(optionEle('0','소분류'));
	if($(this).val() !== '중분류'){
		$.post("selectSml",{
							big_no:$('#searchBig').val(),
							mid_no:$(this).val()
							}).
		done(function(data){
			data.forEach(function(sml){
				$('#searchSml').append(optionEle(sml.sml_no,sml.sml_content));
			})
		})
	}
})

const searchsubmitChk = function(){
	if($("#keyword").val() !== '' || $("#keyword").val() !== null){
		if($("#searchFilter").val() == '' || $("#searchFilter").val() == null){
			alert("검색옵션을 선택해주세요");
			return false;
		}
	}
	return true;
}
