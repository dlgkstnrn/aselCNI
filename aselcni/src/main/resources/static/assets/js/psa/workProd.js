$(document).ready(function(){

	// 중첩모달 닫기 클릭하면 첫번째 모달이 보여지도록
	$('#addItem').modal('hide');

	setTimeout(function() {
		$('#prodplan').modal('show');
	}, 300); // 300ms(0.3초) 대기 후 이전 모달 표시
	
	
	// 투입품 추가 버튼 누르면 투입품 추가 모달 띄워지고 값 입력받음
	$(function () {

	    $("#btnSubmit").click(function (e) {
	        e.preventDefault();
	        $('#addItem').modal("show");
	        //
	    });
	
	    $("#btn-submit").click(function() {
	        alert("Submit base form!");
	        $("#btnSubmit").closest("form").submit();
	    });
	});
	
	
	
	// 생산일자는 오늘 날짜로 기본값으로 함
	document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);
	
	const today = new Date();
	const tommorow = new Date(today);
	const yesterday = new Date(today);
	
	tommorow.setDate(today.getDate() + 1);
	yesterday.setDate(today.getDate() - 1);
	
})
