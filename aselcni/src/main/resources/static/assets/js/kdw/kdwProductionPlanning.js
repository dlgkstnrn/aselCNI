$(document).ready(function() {
    // 캘린더
    var calendarEl = $('#calendar')[0];
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth'
    });
    calendar.render();
    
    // 제품선택 중첩모달 셀렉트에 Select2 적용
    $('#nestedModal .select2-firstModal').select2({
        dropdownParent: $('#nestedModal'), // 부모지정으로 셀렉트박스가 모달창뒤로 가는것을 방지
        placeholder: "선택해주세요", // 드롭다운의 플레이스홀더 텍스트 설정
        allowClear: true, // 선택된 항목을 지울 수 있는 버튼 표시
		language: { // 셀렉트 검색 플레이스홀더
			searching: function() {
				return "검색하기...";
			}
		},
    });
    
    $('#nestedItemModal .select2-secondModal').select2({
        dropdownParent: $('#nestedItemModal'),
        placeholder: "선택해주세요",
        allowClear: true,
        language: { // 셀렉트 검색 플레이스홀더
			searching: function() {
				return "검색하기...";
			}
		},
    });
    
    // 모달이 닫힐 때 Select2 초기화 및 폼 리셋
    // hidden.bs.modal 이벤트는 모달이 완전히 닫힌 후에 발생하는 이벤트입니다.
    $('#nestedModal').on('hidden.bs.modal', function () {
        $('.select2-firstModal', this).val(null).trigger('change');
        $(this).find('form').trigger('reset');
        $('#verticalycentered').modal('show');
    });

    $('#nestedItemModal').on('hidden.bs.modal', function () {
        $('.select2-secondModal', this).val(null).trigger('change');
        $(this).find('form').trigger('reset');
        $('#verticalycentered').modal('show');
    });

}); // !! 건들지말것 !!
