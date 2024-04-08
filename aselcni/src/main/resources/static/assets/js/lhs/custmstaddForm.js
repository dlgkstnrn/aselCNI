const custCdReg = /^\d{3}-\d{2}-\d{5}$/;
const phoneReg = /^\d{2,3}-\d{3,4}-\d{4}$/;

const submitChk = function(){
	if(!custCdReg.test($("#biz_no").val())){
		alert("알맞은 사업자번호 형식이 아닙니다.");
		return false;
	}
	if(!phoneReg.test($("#biz_tel").val())){
		alert("알맞은 전화번호 형식이 아닙니다.");
		return false;
	}
	if(!phoneReg.test($("#biz_fax").val())){
		alert("알맞은 팩스번호 형식이 아닙니다.")
		return false;
	}
	return true;
}