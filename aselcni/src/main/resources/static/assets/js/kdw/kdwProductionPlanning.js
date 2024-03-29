$(document).ready(function() {
	// 캘린더
	var calendarEl = $('#calendar')[0];
	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView: 'dayGridMonth'
	});
	calendar.render();


	// 제품선택 중첩모달 셀렉트에 Select2 적용
	$('.select2').select2({
		dropdownParent: $('#nestedModal'), // 부모지정으로 셀렉트박스가  모달창뒤로 가는것을 방지
		placeholder: "선택해주세요", // 필요시 플레이스홀더 지정
		allowClear: true // 선택 해제 가능
	});
	
	// 제품선택 중첩모달 '취소'버튼 클릭시 이전 등록 모달 보이기
    $('#nestedModal .btn-secondary').on('click', function() {
        // 현재 중첩 모달 숨기기
        $('#nestedModal').modal('hide');
        // setTimeout: 모달이 완전히 닫힌 후에 다시 열기 위함(애니메이션중)
        setTimeout(function() {
            $('#verticalycentered').modal('show');
        }, 300); // 300ms(0.3초) 대기 후 이전 모달 표시
    });
});