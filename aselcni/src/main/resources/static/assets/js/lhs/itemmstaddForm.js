let chkResult = 0;

const optionEle = function(value,content){
	const option = document.createElement("option");
	option.value = value;
	option.innerText = content;
	return option;
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
	$.post("itemCdChk",{item_cd:$("#item_nm").val()})
	.done(function(data){
		if(data == 0){
			alert("사용가능한 코드입니다.");
			chkResult = 1
		}else{
			alert("사용불가능한 코드입니다");
		}
	})
})