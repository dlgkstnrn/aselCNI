$(document).ready(function() {
	// ========== 캘린더 ==========
	var selectedEventId = null;
	var eventColors = {};
	var responseProdPlans;
	var isTooltipEnabled = true; // 툴팁 기본 활성상태
	var lastClickedCell = null; // 마지막으로 클릭된 셀을 저장할 변수
	// 기본 색상 정의
	var baseColors = [
		"rgba(191, 0, 35, 0.7)",
		"rgba(0, 81, 212, 0.7)",
		"rgba(217, 4, 114, 0.7)",
		"rgba(219, 90, 4, 0.7)",
		"rgba(0, 165, 168, 0.7)",
		"rgba(204, 170, 0, 0.7)",
		"rgba(0, 92, 9, 0.7)",
		"rgba(99, 0, 145, 0.7)",
	];
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView: 'dayGridMonth',
		dayMaxEventRows: 4,
		locale: 'ko',
		events: function(fetchInfo, successCallback, failureCallback) {
			$.ajax({
				url: 'prodplanCalenderList',
				type: 'GET',
				dataType: 'json',
				success: function(response) {
					responseProdPlans = response;
					updateOrderList(defaultMonth);
					var events = response.prodPlans.map(function(plan, index) {
						// 색상 배열에서 순환하며 색상 선택
						var colorIndex = index % baseColors.length;
						var eventColor = baseColors[colorIndex];
						return {
							id: plan.prodPlan_no,
							title: plan.prodPlan_no + ' (' + plan.remark + ')',
							start: plan.prodPlan_dt,
							end: plan.prodPlan_end_dt,
							backgroundColor: eventColors[plan.prodPlan_no] || eventColor,
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
			if (selectedEventId === info.event.id) {
				selectedEventId = null; // 클릭 상태 해제
			} else {
				selectedEventId = info.event.id;
			}
			calendar.refetchEvents();
		},
		eventDidMount: function(info) {
			if (eventColors[info.event.id]) {
				$(info.el).css('background-color', eventColors[info.event.id]);
				$(info.el).css('border-color', eventColors[info.event.id]);
			}
			if (info.event.id === selectedEventId) {
				info.el.style.fontWeight = 'bold';
				info.el.style.border = '2px solid black';
			}
		},
		eventMouseEnter: function(info) {
			// 툴팁이 비활성화되어 있으면 아무 것도 하지 않음
			if (!isTooltipEnabled) {
				return;
			}
			// 기존 툴팁 제거
			$('.event-tooltip').remove();

			var event = info.event;
			var prodPlanCode = event.id;

			var prodPlan = responseProdPlans.prodPlans.find(function(plan) {
				return plan.prodPlan_no === prodPlanCode;
			});

			var prodItems = responseProdPlans.prodItems.filter(function(item) {
				return item.prodPlan_no === prodPlanCode;
			});

			/*			// 자재정보까지 툴팁으로 넣으면 너무 화면이 난잡해지기때문에 자재정보는 뺐다
						// 툴팁답게 필요한 정보들만 보이게 해야함 : 대신 더블클릭시 상세페이지 뜨게 구현해야함
						// 자재 정보가 최대 두 개까지만 표시되도록 조정
						var displayedProdItems = prodItems.slice(0, 2);
						var moreItemsText = prodItems.length > 2 ? `<p>그 외 ${prodItems.length - 2}개의 자재...</p>` : '';
			
						// 자재 합계 금액 계산 (전체 자재에 대한 합계)
						var totalMaterialCost = prodItems.reduce((total, item) => total + (item.in_qty * item.item_cost), 0);
			*/
			var eventInfo = `
			  <div>
			    <div class="tooltip-title">[ 생산 계획 ]</div>
			    <p>주문 번호: ${prodPlan.order_no}</p>
			    <p>생산계획코드: ${prodPlan.prodPlan_no}[${prodPlan.seq_no}]</p>
			    <p>시작 일자: ${prodPlan.prodPlan_dt}</p>
			    <p>완료 일자: ${prodPlan.prodPlan_end_dt}</p>
			    <p>작업 일수: ${prodPlan.work_dt} 일</p>
			    <p>비고: ${prodPlan.remark}</p>
			    <li class="tooltip-section-title">제 품</li>
			    <div class="prod-info">
				    <p>제품 코드: ${prodPlan.item_cd}</p>
				    <p>제품 명: ${prodPlan.item_nm}</p>
				    <p>제품 수량: ${prodPlan.qty} 개</p>
				    <p>제품 단가: ${prodPlan.item_cost} 원</p>
			    </div><p>
			    <p>제품 합계 금액: ${prodPlan.qty * prodPlan.item_cost} 원</p>
			  </div>
			`;

			// 툴팁 위치 계산 및 생성 코드
			var initialTopPosition = info.el.getBoundingClientRect().top + window.scrollY - 200;
			var initialLeftPosition = info.el.getBoundingClientRect().right + window.scrollX + 2;

			var tooltip = document.createElement('div');
			tooltip.classList.add('event-tooltip');
			tooltip.style.position = 'absolute';
			tooltip.innerHTML = eventInfo;

			// 툴팁을 문서에 추가하기 전에 초기 위치 설정
			tooltip.style.top = initialTopPosition + 'px';
			tooltip.style.left = initialLeftPosition + 'px';

			// 툴팁을 문서에 추가
			document.body.appendChild(tooltip);

			// 추가된 툴팁의 크기와 위치를 계산
			var tooltipRect = tooltip.getBoundingClientRect();

			// 화면의 너비와 높이를 사용하여 경계를 체크
			if (tooltipRect.bottom > window.innerHeight && tooltipRect.top < window.scrollY) {
				// 화면 상하 중앙에 위치시키기
				tooltip.style.top = (window.scrollY + (window.innerHeight - tooltipRect.height) / 2) + 'px';
			} else {
				if (tooltipRect.bottom > window.innerHeight) {
					// 화면 하단으로 넘어가는 경우, 위로 이동
					tooltip.style.top = (window.innerHeight - tooltipRect.height - 20) + 'px';
				}
				if (tooltipRect.top < window.scrollY) {
					// 화면 상단으로 넘어가는 경우, 아래로 이동
					tooltip.style.top = (window.scrollY + 50) + 'px';
				}
			}
		},
		eventMouseLeave: function(info) {
			// 툴팁이 비활성화되어 있으면 아무 것도 하지 않음
			if (!isTooltipEnabled) {
				return;
			}
			$('.event-tooltip').remove(); // 툴팁 제거
		},
		dateClick: function(info) {
			// 선택된 날짜에 해당하는 이벤트 찾기
			var dateEvents = responseProdPlans.prodPlans.filter(function(plan) {
				return plan.prodPlan_dt === info.dateStr ||
					(plan.prodPlan_dt <= info.dateStr && plan.prodPlan_end_dt >= info.dateStr);
			});

			// 주문내역 & 생산계획 리스트 HTML 요소 찾기
			var referenceDateElement = document.querySelector('.referenceDate');
			var orderListElement = document.querySelector('.orderList-item');
			var prodPlanListElement = document.querySelector('.prodPlanList-item');

			// 리스트 초기화
			referenceDateElement.innerHTML = info.dateStr;
			orderListElement.innerHTML = '';
			prodPlanListElement.innerHTML = '';

			// 중복 제품 처리를 위한 객체
			var productQuantities = {};

			// 찾은 이벤트를 HTML 요소에 표시
			dateEvents.forEach(function(event) {
				var productKey = event.cust_nm + '-' + event.item_nm; // 고객사와 제품명을 키로 사용
				if (!productQuantities[productKey]) {
					productQuantities[productKey] =
						{ qty: 0, cust_nm: event.cust_nm, item_nm: event.item_nm };
				}
				productQuantities[productKey].qty += event.qty; // 수량 누적

				// 생산계획 리스트에 이벤트 정보 추가
				var prodPlanListItem = document.createElement('tr');
				prodPlanListItem.innerHTML = `
					<td>${event.item_nm}</td>
					<td>${event.qty}</td>
					<td>${event.work_dt} 일</td>`;
				prodPlanListElement.appendChild(prodPlanListItem);
			});

			// 주문내역 리스트에 중복 처리된 제품 정보 추가
			for (var key in productQuantities) {
				var product = productQuantities[key];
				var orderListItem = document.createElement('tr');
				orderListItem.innerHTML = `
					<td>${product.cust_nm}</td>
					<td>${product.item_nm}</td>
					<td>${product.qty}</td>`;
				orderListElement.appendChild(orderListItem);
			}

			// 클릭된 셀의 .fc-daygrid-day-number 요소 찾기
			var currentClickedElement = info.dayEl.querySelector('.fc-daygrid-day-number');

			// 이전에 클릭된 셀이 있고, 현재 클릭된 셀이 이전에 클릭된 셀과 동일한 경우
			if (lastClickedCell && currentClickedElement === lastClickedCell) {
				// 클릭된 셀의 스타일을 초기화하고 lastClickedCell 참조를 null로 설정
				$(currentClickedElement).removeClass('clicked-cell-style');
				lastClickedCell = null;

				// HTML 내용 초기화 또는 업데이트 필요한 경우 여기에 로직 추가
				referenceDateElement.innerHTML = '';
				orderListElement.innerHTML = '';
				prodPlanListElement.innerHTML = '';
			} else {
				// 새로운 셀을 클릭한 경우, 이전에 클릭된 셀의 스타일을 초기화
				if (lastClickedCell) {
					$(lastClickedCell).removeClass('clicked-cell-style');
				}
				// 현재 클릭된 셀에 스타일 적용
				$(currentClickedElement).addClass('clicked-cell-style');
				// 마지막으로 클릭된 셀 업데이트
				lastClickedCell = currentClickedElement;
			}
		},
		dayCellDidMount: function(info) {
			// 각 일자 셀이 마운트될 때 커서 스타일 적용
			info.el.style.cursor = 'pointer';
		},
	});

	calendar.render();

	// 툴팁창 On/Off 스위치 버튼
	$('#flexSwitchCheckChecked').change(function() {
		isTooltipEnabled = $(this).is(':checked');
		if (!isTooltipEnabled) {
			// 툴팁이 비활성화되면 모든 툴팁 제거
			$('.event-tooltip').remove();
		}
	});

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
	// 제품 대중소 데이터가져오기
	// AJAX 요청으로 대중소 분류 데이터 가져오기
	// 서버로부터 모든 카테고리 데이터 가져오기
	$.ajax({
		url: '/categories', // 서버 엔드포인트 주소 조정 필요
		type: 'GET',
		success: function(data) {

		}
	});

	// 제품선택 중첩모달 셀렉트에 Select2 적용
	$('#nestedModal .select2-firstModal').each(function() {
		var placeholderText;
		switch (this.id) {
			case 'majorCategory1':
				placeholderText = "선택해주세요";
				break;
			case 'middleCategory1':
				placeholderText = "대분류를 선택해주세요";
				break;
			case 'minorCategory1':
				placeholderText = "중분류를 선택해주세요";
				break;
		}
		$(this).select2({
			dropdownParent: $('#nestedModal'), // 부모 지정
			placeholder: placeholderText,
			allowClear: true,
			language: {
				noResults: function() {
					return "검색 결과가 없습니다";
				}
			}
		}).on("select2:open", function() {
			// 검색 필드에 포커스가 있을 때 플레이스홀더 유지
			$(".select2-search__field").attr("placeholder", "검색어 입력");
		});
	});

	$('#nestedItemModal .select2-secondModal').each(function() {
		var placeholderText;
		switch (this.id) {
			case 'majorCategory2':
				placeholderText = "선택해주세요";
				break;
			case 'middleCategory2':
				placeholderText = "대분류를 선택해주세요";
				break;
			case 'minorCategory2':
				placeholderText = "중분류를 선택해주세요";
				break;
		}
		$(this).select2({
			dropdownParent: $('#nestedItemModal'),
			placeholder: placeholderText,
			allowClear: true,
			language: {
				noResults: function() {
					return "검색 결과가 없습니다";
				}
			}
		}).on("select2:open", function() {
			$(".select2-search__field").attr("placeholder", "검색어 입력");
		});
	});
	// 중분류와 소분류 초기 비활성화
	$('#middleCategory1, #middleCategory2').prop('disabled', true);
	$('#minorCategory1, #minorCategory2').prop('disabled', true);

	// 대분류 변경 시 중분류 활성화/비활성화 및 초기화
	$('#majorCategory1, #majorCategory2').change(function() {
		var majorVal = $(this).val();
		if (majorVal) {
			$('#middleCategory1, #middleCategory2').prop('disabled', false);
		} else {
			$('#middleCategory1, #middleCategory2').prop('disabled', true).val('').trigger('change');
		}
	});
	// 중분류 변경 시 소분류 활성화/비활성화 및 초기화
	$('#middleCategory1, #middleCategory2').change(function() {
		var middleVal = $(this).val();
		if (middleVal) {
			$('#minorCategory1, #minorCategory2').prop('disabled', false);
		} else {
			$('#minorCategory1, #minorCategory2').prop('disabled', true).val('').trigger('change');
		}
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

	// ============= 주문번호 선택 중첩모달 ==============
	// 날짜 선택기에서 날짜가 변경될 때마다 실행될 이벤트 핸들러
	// 현재 날짜를 기반으로 yyyy-mm 형식의 문자열 생성
	var today = new Date();
	var currentYear = today.getFullYear();
	var currentMonth = today.getMonth() + 1; // getMonth()는 0부터 시작하므로 +1
	var formattedMonth = currentMonth < 10 ? '0' + currentMonth : currentMonth;
	var defaultMonth = currentYear + '-' + formattedMonth;

	function initializeDatePicker() {
		$('#monthPicker').datepicker({
			language: 'ko',
			format: "yyyy-mm",
			startView: "months",
			minViewMode: "months",
			autoclose: true,
			container: '#oderModal .modal-body'
		}).datepicker('update', defaultMonth);
	}

	initializeDatePicker(); // 달력 초기화 함수 호출

	$('#monthPicker').on('changeDate', function(e) {
		var selectedMonth = e.format(0, "yyyy-mm");
		updateOrderList(selectedMonth);
	});
	// 페이지 로드 시 현재 월에 해당하는 주문 리스트 표시
	function updateOrderList(selectedMonth) {
		// 주문번호 중첩 모달 내 주문 리스트를 나타낼 테이블의 tbody 찾기
		var $orderListTbody = $("#orderListTable tbody");
		$orderListTbody.empty(); // 기존 리스트를 비움

		// responseProdPlans 내에서 해당 월에 해당하는 주문 데이터 필터링
		var filteredOrders = responseProdPlans.prodOrderList.filter(function(order) {
			return order.order_dt.startsWith(selectedMonth);
		});

		// 필터링된 주문 데이터를 테이블에 추가
		filteredOrders.forEach(function(order) {
			var $row = $('<tr>').append(
				$('<td>').append($('<input>').attr({ type: 'radio', name: 'selectedOrder', value: order.order_no })),
				$('<td>').text(order.order_no),
				$('<td>').text(order.cust_nm),
				$('<td>').text(order.remark),
				$('<td>').text(order.order_dt)
			);
			$orderListTbody.append($row);
		});
	}

	// "저장" 버튼 클릭 이벤트
	$('#saveOrderButton').on('click', function() {
		var selectedOrderNo = $('input[name="selectedOrder"]:checked').val();
		if (selectedOrderNo) {
			// 선택된 주문번호를 이전 모달의 주문번호 입력 필드에 설정
			$('#prodPlanNoInput').val(selectedOrderNo);
			// 주문번호 선택 모달 닫기
			$('#oderModal').modal('hide');
		} else {
			alert('주문번호를 선택해주세요.');
		}
	});
	// 이전 모달을 다시 열기
	$('#oderModal').on('hidden.bs.modal', function() {
		// 모달이 닫힐 때 라디오 선택 초기화
		$('input[name="selectedOrder"]:checked').prop('checked', false);
		// 달력을 현재 월로 초기화
		initializeDatePicker();
		// 주문 리스트 초기화
		updateOrderList(defaultMonth);
		$("#searchInput").val(""); // 검색 필드 초기화
		$("#orderListTable tbody tr").show(); // 모든 테이블 행 표시
		$('#verticalycentered').modal('show');
	});

	// 주문번호 모달 검색기능
	$("#searchInput").on("keyup", function() {
		var value = $(this).val().toLowerCase();
		$("#orderListTable tbody tr").filter(function() {
			$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
		});
	});

	// ========== 등록 모달 ==========
	// 시작예정일자 & 완료예정일자
	$('.productStartDateInput').change(function() {
		var startDate = new Date($(this).val());
		var today = new Date();
		today.setHours(0, 0, 0, 0); // 시간을 00:00:00.000으로 설정

		if (startDate < today) {
			alert('시작예정일자는 오늘 일자보다 이전으로 설정할 수 없습니다.');
			$(this).val('');
		}
	});

	$('.productEndDateInput').change(function() {
		var endDate = new Date($(this).val());
		var startDate = new Date($('.productStartDateInput').val());

		if (!$('.productStartDateInput').val()) {
			alert('먼저 시작예정일자를 선택해주세요.');
			$(this).val('');
		} else if (endDate < startDate) {
			alert('완료예정일자는 시작예정일자 이전으로 설정할 수 없습니다.');
			$(this).val('');
		}
	});
	// 작업일수
	$('.prodPlanWorkingDaysInput').on('input', function() {
		var value = parseInt($(this).val(), 10);
		if (value > 99999) {
			$(this).val(99999);
			alert('작업일수는 최대 99999개까지입니다.');
		} else if (value < -99999) {
			$(this).val(-99999);
			alert('작업일수는 최소 -99999개까지입니다.');
		}
	});
	// 생상수량
	$('.prodCount-input').on('input', function() {
		var value = parseInt($(this).val(), 10);
		if (value > 99999) {
			$(this).val(99999);
			alert('생산수량은 최대 99999개까지입니다.');
		} else if (value < -99999) {
			$(this).val(-99999);
			alert('생산수량은 최소 -99999개까지입니다.');
		}
	});
}); // !! 건들지말것 !!
