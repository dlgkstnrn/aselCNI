let chkResult = 0;
const numberReg = /^\d+$/;
const itemCd = /^[A-Z]{3}\d{4}$/;
const optionEle = function(value,content){
	const option = document.createElement("option");
	option.value = value;
	option.innerText = content;
	return option;
}

const submitChk = function(){
	if(chkResult == 0){
		alert("중복체크를 해주세요");
		return false;
	}
	if($("#big").val() == "대분류" || $("#big").val()==""){
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

$("#big").change(function(){
	$("#mid").empty();
	$("#mid").append(optionEle("","중분류"));
	$("#sml").empty();
	$("#sml").append(optionEle("","소분류"));
	if($(this).val() != "대분류" ){
		$.post("selectMid",{big_no:$(this).val()})
		.done(function(data){
			data.forEach(function(d){
				$("#mid").append(optionEle(d.mid_no,d.mid_content))
			})
		})
	}
})

$("#mid").change(function(){
	$("#sml").empty();
	$("#sml").append(optionEle("","소분류"));
	if($(this).val() != "중분류" ){
		$.post("selectSml",{
							big_no:$("#big").val(),
							mid_no:$(this).val()
							}
			)
		.done(function(data){
			data.forEach(function(d){
				$("#sml").append(optionEle(d.sml_no,d.sml_content))
			})
		})
	}
})

$("#chkBtn").click(function(){
	if(itemCd.test($("#item_cd").val())){
		$.post("itemCdChk",{item_cd:$("#item_cd").val()})
		.done(function(data){
			if(data == 0){
				alert("사용가능한 코드입니다.");
				chkResult = 1
			}else{
				alert("사용불가능한 코드입니다");
			}
		})
	}else{
		alert("알맞지 않은 형식입니다");
	}
})

$("#item_cd").change(function(){
	chkResult = 0;
})