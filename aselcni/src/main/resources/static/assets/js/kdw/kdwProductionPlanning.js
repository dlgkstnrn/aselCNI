$(document).ready(function() {
	// ========== 캘린더 ==========
	var selectedEventId = null;
	var eventColors = {};
	var responseProdPlans;
	var isTooltipEnabled = true; // 툴팁 기본 활성상태

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

			// 자재 정보가 최대 두 개까지만 표시되도록 조정
			var displayedProdItems = prodItems.slice(0, 2);
			var moreItemsText = prodItems.length > 2 ? `<p>그 외 ${prodItems.length - 2}개의 자재...</p>` : '';

			// 자재 합계 금액 계산 (전체 자재에 대한 합계)
			var totalMaterialCost = prodItems.reduce((total, item) => total + (item.in_qty * item.item_cost), 0);

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
			    <li class="tooltip-section-title">투입 자재</li>
		        ${displayedProdItems.map(item => `
		          <div class="material-info">
		            <p>자재 코드: ${item.item_cd}</p>
		            <p>자재 명: ${item.item_nm}</p>
		            <p>자재 수량: ${item.in_qty} 개</p>
		            <p>자재 단가: ${item.item_cost} 원</p>
		            <p>자재 금액: ${item.in_qty * item.item_cost} 원</p>
		          </div>
		        `).join('')}
		        ${moreItemsText}
		        <p>자재 합계 금액: ${totalMaterialCost} 원</p>
			  </div>
			`;

			// 툴팁 위치 계산 및 생성 코드
			var initialTopPosition = info.el.getBoundingClientRect().top + window.scrollY - 300;
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
		},
		dayCellDidMount: function(info) {
			// 마우스 호버 시 커서 변경
			info.el.style.cursor = 'pointer';
			// 마우스 호버 이벤트
			info.el.addEventListener('mouseenter', function() {
				var dayNumberElement = this.querySelector('.fc-daygrid-day-number');
				if (dayNumberElement) {
					dayNumberElement.style.color = 'skyblue'; // 텍스트 색상 변경
					dayNumberElement.style.fontWeight = 'bold'; // 텍스트 두께 변경
				}
			});

			// 마우스가 셀에서 벗어났을 때의 이벤트
			info.el.addEventListener('mouseleave', function() {
				var dayNumberElement = this.querySelector('.fc-daygrid-day-number');
				if (dayNumberElement) {
					dayNumberElement.style.color = ''; // 원래 텍스트 색상
					dayNumberElement.style.fontWeight = ''; // 원래 텍스트 두께
				}
			});
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
