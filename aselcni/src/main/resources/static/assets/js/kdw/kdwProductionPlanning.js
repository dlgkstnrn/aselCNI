$(document).ready(function() {
	// ========== 캘린더 ==========
	var selectedEventId = null; // 선택된 이벤트 ID 저장
	var eventColors = {}; // 이벤트 ID를 키로, 색상을 값으로 저장하는 객체

	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView: 'dayGridMonth',
		dayMaxEventRows: 4,
		locale: 'ko',
		events: function(fetchInfo, successCallback, failureCallback) {
			$.ajax({
				url: 'prodplanCalenderList', // 이벤트 데이터를 가져오는 URL
				type: 'GET',
				dataType: 'json',
				success: function(response) {
					var events = response.prodPlans.map(function(plan) {
						return {
							id: plan.prodPlan_no,
							title: plan.prodPlan_no + ' (' + plan.remark + ')',
							start: plan.prodPlan_dt,
							end: plan.prodPlan_end_dt,
							backgroundColor: eventColors[plan.prodPlan_no] || "rgba(13, 110, 253, 0.7)",
							borderColor: 'transparent',
							textColor: '#ffffff',
						};
					});
					successCallback(events);
				},
				error: function(xhr) {
					console.error('Error fetching ProdplanCalenderList: ', xhr.responseText);
					failureCallback(xhr);
				}
			});
		},
		eventClick: function(info) {
			selectedEventId = info.event.id;
			// 이벤트 선택 시, 빨간 테두리 적용
			calendar.getEvents().forEach(function(event) {
				if (event.id === selectedEventId) {
					event.setProp('borderColor', 'black');
				} else {
					event.setProp('borderColor', 'transparent');
				}
				$(event.el).removeClass('selected-event-shadow');
				if (event.id === selectedEventId) {
					$(event.el).addClass('selected-event-shadow');
				}
			});
		},
		eventDidMount: function(info) {
			// 이미 변경된 색상이 있으면 적용
			if (eventColors[info.event.id]) {
				$(info.el).css('background-color', eventColors[info.event.id]);
				$(info.el).css('border-color', eventColors[info.event.id]);
			}
		}
	});

	calendar.render();

	// 랜덤 색상을 생성하는 함수
	function getRandomColor() {
		var letters = '0123456789ABCDEF';
		var color = '#';
		for (var i = 0; i < 6; i++) {
			color += letters[Math.floor(Math.random() * 16)];
		}
		return color;
	}

	// 색상 변경 대화상자 초기화
	$("#colorPickerDialog").dialog({
		autoOpen: false,
		modal: true,
		buttons: {
			"적용": function() {
				var hexColor = $('#eventColorPicker').val(); // 컬러피커에서 선택한 HEX 색상
				var rgbaColor = hexToRGBA(hexColor, 0.7); // RGBA로 변환, 원하는 투명도 설정
				if (selectedEventId) {
					eventColors[selectedEventId] = rgbaColor; // 변경된 RGBA 색상 저장
					var event = calendar.getEventById(selectedEventId);
					if (event) {
						event.setProp('backgroundColor', rgbaColor);
						event.setProp('borderColor', rgbaColor);
						calendar.refetchEvents(); // 변경사항 반영을 위해 이벤트 다시 가져옴
					}
				}
				$(this).dialog("close");
			},
			"취소": function() {
				$(this).dialog("close");
			}
		}
	});

	// 색상 변경 버튼 클릭 이벤트
	$("#changeColorButton").click(function(event) {
		event.preventDefault();
		event.stopPropagation();
		if (!selectedEventId) {
			alert("먼저 이벤트를 선택해주세요.");
			return;
		}
		$("#colorPickerDialog").dialog("open");[]
	});
	// HEX 색상을 RGBA로 변환하는 함수 추가
	function hexToRGBA(hex, alpha = 0.7) { // 기본적으로 70%의 투명도 적용
		var r = parseInt(hex.slice(1, 3), 16),
			g = parseInt(hex.slice(3, 5), 16),
			b = parseInt(hex.slice(5, 7), 16),
			rgba = `rgba(${r}, ${g}, ${b}, ${alpha})`;
		return rgba;
	}
	// ========== End 캘린더 ==========

	// ========== 셀렉트2(제품모달, 투입자재모달) ==========
	// 제품선택 중첩모달 셀렉트에 Select2 적용
	$('#nestedModal .select2-firstModal').select2({
		dropdownParent: $('#nestedModal'), // 부모지정으로 셀렉트박스가 모달창뒤로 가는것을 방지
		placeholder: "선택해주세요", // 드롭다운의 플레이스홀더 텍스트 설정
		allowClear: true, // 선택된 항목을 지울 수 있는 버튼 표시
	}).on("select2:open", function() {
		// 검색 필드에 포커스가 있을 때 플레이스홀더 유지
		$(".select2-search__field").attr("placeholder", "검색어 입력");
	});

	$('#nestedItemModal .select2-secondModal').select2({
		dropdownParent: $('#nestedItemModal'),
		placeholder: "선택해주세요",
		allowClear: true,
		language: {
			noResults: function() {
				return "검색 결과가 없습니다";
			}
		}
	}).on("select2:open", function() {
		$(".select2-search__field").attr("placeholder", "검색어 입력");
	});

	// 모달이 닫힐 때 Select2 초기화 및 폼 리셋
	// hidden.bs.modal 이벤트는 모달이 완전히 닫힌 후에 발생하는 이벤트입니다.
	$('#nestedModal').on('hidden.bs.modal', function() {
		$('.select2-firstModal', this).val(null).trigger('change');
		$(this).find('form').trigger('reset');
		$('#verticalycentered').modal('show');
	});

	$('#nestedItemModal').on('hidden.bs.modal', function() {
		$('.select2-secondModal', this).val(null).trigger('change');
		$(this).find('form').trigger('reset');
		$('#verticalycentered').modal('show');
	});

	// ========== End 셀렉트2(제품모달, 투입자재모달) ==========
}); // !! 건들지말것 !!
