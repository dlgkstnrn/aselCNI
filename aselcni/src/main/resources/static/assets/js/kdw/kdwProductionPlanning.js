$(document).ready(function() {
	// ========== 캘린더 ==========
	var selectedEventId = null;
	var eventColors = {};
	var responseProdPlans;
	var isTooltipEnabled = true; 	// 툴팁 기본 활성상태
	var lastClickedCell = null; 	// 마지막으로 클릭된 셀을 저장할 변수
	var selectedMaterialsInfo = []; // 선택된 자재 정보를 저장할 배열
	var activeModal = null; 		// 현재 활성화된 모달 추적
	var selectedOrderEndDt = ''; 	// 선택된 주문의 주문종료일
	var selectedEvent = null; 		// 선택된 이벤트막대 정보저장
	var materialsToDelete = []; 	// 수정모달 자재삭제 대기 목록

	// 기본 이벤트막대 색상 정의
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
						var endDate = new Date(plan.prodPlan_end_dt);
						endDate.setDate(endDate.getDate() + 1); // 종료 날짜에 하루 추가
						// 색상 배열에서 순환하며 색상 선택
						var colorIndex = index % baseColors.length;
						var eventColor = baseColors[colorIndex];
						return {
							id: plan.prodPlan_no,
							title: plan.prodPlan_no + ' (' + formatNumbersInText(plan.remark) + ')',
							start: plan.prodPlan_dt,
							end: endDate.toISOString().split('T')[0],
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
			selectedEvent = responseProdPlans.prodPlans.find(plan => plan.prodPlan_no === info.event.id);
			if (selectedEventId === info.event.id) {
				selectedEventId = null; // 클릭 상태 해제
				selectedEvent = null; // 선택된 이벤트 정보 해제
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
			// 더블클릭 이벤트 리스너: 이벤트 상세조회
			info.el.addEventListener('dblclick', function() {
				showEventDetails(info.event);
			});
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

			/*			// 자재정보까지 툴팁으로 넣으면 너무 화면이 난잡해지기때문에 자재정보는 뺌
						// 툴팁답게 필요한 정보들만 보이게 해야함 : 대신 더블클릭시 상세페이지 뜨게 구현해야함
						// 자재 정보가 최대 두 개까지만 표시되도록 조정
						var displayedProdItems = prodItems.slice(0, 2);
						var moreItemsText = prodItems.length > 2 ? `<p>그 외 ${prodItems.length - 2}개의 자재...</p>` : '';
			
						// 자재 합계 금액 계산 (전체 자재에 대한 합계)
						var totalMaterialCost = prodItems.reduce((total, item) => total + (item.in_qty * item.item_cost), 0);
			*/
			// ============= 툴팁 정보 뿌리기 ===========
			var eventInfo = `
			  <div>
			    <div class="tooltip-title">[ 생산 계획 ]</div>
			    <p>주문 번호: ${prodPlan.order_no}</p>
			    <p>생산계획코드: ${prodPlan.prodPlan_no}[${prodPlan.seq_no}]</p>
			    <p>시작 일자: ${prodPlan.prodPlan_dt}</p>
			    <p>완료 일자: ${prodPlan.prodPlan_end_dt}</p>
			    <p>작업 일수: ${formatNumber(prodPlan.work_dt)} 일</p>
			    <p>비고: ${prodPlan.remark}</p>
			    <li class="tooltip-section-title">제 품</li>
			    <div class="prod-info">
				    <p>제품 코드: ${prodPlan.item_cd}</p>
				    <p>제품 명: ${prodPlan.item_nm}</p>
				    <p>제품 수량: ${formatNumber(prodPlan.qty)} 개</p>
				    <p>제품 단가: ${formatNumber(prodPlan.item_cost)} 원</p>
			    </div><p>
			    <p>제품 합계 금액: ${formatNumber(prodPlan.qty * prodPlan.item_cost)} 원</p>
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

			// 찾은 이벤트를 생산계획 리스트에 이벤트 정보 추가
			dateEvents.forEach(function(event) {
				var prodPlanListItem = document.createElement('tr');
				prodPlanListItem.innerHTML = `
			        <td>${event.item_nm}</td>
			        <td>${formatNumber(event.qty)} 개</td>
			        <td>${formatNumber(event.work_dt)} 일</td>`;
				prodPlanListElement.appendChild(prodPlanListItem);

				// 주문에 해당하는 아이템 리스트와 수량 찾기
				var orderItems = responseProdPlans.prodOrderItemList.filter(item => item.order_no === event.order_no);

				// 주문번호 별로 주문내역 표시 (주문번호가 같은 경우, 한 번만 표시)
				if (orderListElement.querySelector(`[data-order-no="${event.order_no}"]`) === null) {
					orderItems.forEach(function(item) {
						var orderListItem = document.createElement('tr');
						orderListItem.setAttribute('data-order-no', event.order_no); // 주문번호를 속성으로 추가하여 중복 방지
						orderListItem.innerHTML = `
			                <td>${event.cust_nm}</td>
			                <td>${item.item_nm}</td>
			                <td>${formatNumber(item.qty)} 개</td>`;
						orderListElement.appendChild(orderListItem);
					});
				}
			});

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

	// ============== 상세 모달 정보 뿌리기 ==============
	function showEventDetails(event) {
		// 이벤트에 해당하는 상세 정보 찾기
		var selectedEvent = responseProdPlans.prodPlans.find(plan => plan.prodPlan_no === event.id);

		// 제목에 생산 계획 번호 결합
		var modalTitle = '생산 계획 상세 (' + selectedEvent.prodPlan_no + ')';

		// 제품
		var productNameWithCode = selectedEvent.item_nm + ' (' + selectedEvent.item_cd + ')';

		if (selectedEvent) {
			$('#verticalycentered-read .modal-title').text(modalTitle); 	   			  // 생산계획번호
			$('#prodPlanNoInput-read').val(selectedEvent.order_no);			   			  // 주문번호
			$('#prodPlanWorkingDaysInput-read').val(formatNumber(selectedEvent.work_dt)); // 작업일수
			$('#productStartDateInput-read').val(selectedEvent.prodPlan_dt);   			  // 시작예정일자
			$('#productEndDateInput-read').val(selectedEvent.prodPlan_end_dt); 			  // 완료예정일자
			$('#productionQuantity-read').val(formatNumber(selectedEvent.qty));			  // 제품생산수량
			$('#productName-read').val(productNameWithCode);				   			  // 제품명,제품코드
			$('#productEmp-read').val(selectedEvent.prodplan_emp_name);		   			  // 담당자
			$('textarea#remark-read').val(formatNumbersInText(selectedEvent.remark)); 	  // 비고

			// 투입자재 리스트 처리
			var materialsList = $('#prodItem-list-read');
			materialsList.empty(); // 기존 목록 초기화

			// 해당하는 자재 정보 가져오기
			var materials = responseProdPlans.prodItems.filter(item => item.prodPlan_no === selectedEvent.prodPlan_no);

			// 가져온 자재 정보를 리스트에 추가
			materials.forEach((material, index) => {
				materialsList.append(`<li>
				<span class="material-index-read">${index + 1}</span>
				<span class="material-code-read">${material.item_cd}
					<span class="material-name-read">(${material.item_nm})</span>	
				</span>  
				<span class="material-quantity-read">${formatNumber(material.in_qty)} 개</span>`);
			});

			console.log('상세모달표시');
			// 모달 표시
			$('#verticalycentered-read').modal('show');
		}
	}

	// ============= 상세버튼 클릭시 상세모달 ================
	$("#readButton").click(function(event) {
		event.preventDefault();
		if (selectedEvent) {
			showEventDetails({ id: selectedEvent.prodPlan_no }); // 기존에 선택된 이벤트의 상세 정보를 이용하여 모달 표시
		} else {
			alert("상세 보기 할 이벤트를 먼저 선택해 주세요."); // 선택된 이벤트가 없을 경우 사용자에게 알림
		}
	});
	// ============= End 상세버튼 클릭시 상세모달 ================	

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
	var categoriesData = {
		itemMajorCategories: [],
		itemMiddleCategories: [],
		itemMinorCategories: []
	};
	// 페이지 로딩 시 서버로부터 모든 카테고리 데이터 가져오기
	$.ajax({
		url: '/categories',
		type: 'GET',
		success: function(data) {
			// 받아온 데이터를 categoriesData 객체에 저장
			categoriesData.itemMajorCategories = data.itemMajorCategories;
			categoriesData.itemMiddleCategories = data.itemMiddleCategories;
			categoriesData.itemMinorCategories = data.itemMinorCategories;

			// 제품 대분류 셀렉트 박스에 데이터 채우기
			fillProductCategorySelectBox('#majorCategory1', categoriesData.itemMajorCategories, 'big');
			fillMaterialCategorySelectBox('#majorCategory2', categoriesData.itemMajorCategories, 'big');
		},
		error: function(xhr, status, error) {
			console.error("카테고리 에러: " + status + ", " + error);
		}
	});
	// 제품 셀렉트 박스 리스트채우기
	function fillProductCategorySelectBox(selectBoxId, categories, categoryType) {
		var selectBox = $(selectBoxId);
		selectBox.empty().append('<option value="">선택</option>');
		categories.forEach(category => {
			var value, text;
			if (categoryType === 'big') {
				value = category.big_no;
				text = category.big_content;
				// big_no가 1 또는 2인 항목만 추가 if (value === 1 || value === 2)
				if (value === 1) {
					selectBox.append($('<option>', { value: value, text: text }));
				}
			} else if (categoryType === 'mid') {
				value = category.mid_no;
				text = category.mid_content;
				if (value === 1) {
					selectBox.append($('<option>', { value: value, text: text }));
				}
			} else if (categoryType === 'sml') {
				value = category.sml_no;
				text = category.sml_content;
				selectBox.append($('<option>', { value: value, text: text }));
			}
		});
	}
	// 자재 셀렉트 박스 리스트채우기
	function fillMaterialCategorySelectBox(selectBoxId, categories, categoryType) {
		var selectBox = $(selectBoxId);
		selectBox.empty().append('<option value="">선택</option>');
		categories.forEach(category => {
			var value, text;
			if (categoryType === 'big') {
				value = category.big_no;
				text = category.big_content;
				selectBox.append($('<option>', { value: value, text: text }));
			} else if (categoryType === 'mid') {
				value = category.mid_no;
				text = category.mid_content;
				selectBox.append($('<option>', { value: value, text: text }));
			} else if (categoryType === 'sml') {
				value = category.sml_no;
				text = category.sml_content;
				selectBox.append($('<option>', { value: value, text: text }));
			}
		});
	}

	// 대분류 선택 시 중분류 채우기
	$('#majorCategory1, #majorCategory2').change(function() {
		let selectedBigNo = $(this).val();
		let isMaterialSelect = $(this).attr('id') === 'majorCategory2'; // 자재 대분류 셀렉트 박스인지 확인
		let targetCategory = isMaterialSelect ? '#middleCategory2' : '#middleCategory1'; // 대상 중분류 셀렉트 박스 결정

		let filteredCategories = categoriesData.itemMiddleCategories.filter(category => {
			return category.big_no.toString() === selectedBigNo;
		});
		if (isMaterialSelect && selectedBigNo === '1') {
			// 대분류가 1이고 자재 선택일 때, 중분류 1을 제외
			filteredCategories = filteredCategories.filter(category => category.mid_no !== 1);
		}
		let fillFunction = isMaterialSelect ? fillMaterialCategorySelectBox : fillProductCategorySelectBox;
		fillFunction(targetCategory, filteredCategories, 'mid');
	});

	// 중분류 선택 시 소분류 채우기
	$('#middleCategory1, #middleCategory2').change(function() {
		let selectedBigNo = $(this).is('#middleCategory1') ? $('#majorCategory1').val() : $('#majorCategory2').val();
		let selectedMidNo = $(this).val();
		let targetMinorCategory = $(this).is('#middleCategory1') ? '#minorCategory1' : '#minorCategory2';

		let filteredMinorCategories = categoriesData.itemMinorCategories.filter(category => {
			return category.big_no.toString() === selectedBigNo &&
				category.mid_no.toString() === selectedMidNo;
		});

		// 함수명을 적절히 선택해야 합니다.
		let fillFunction = $(this).is('#middleCategory1') ? fillProductCategorySelectBox : fillMaterialCategorySelectBox;

		fillFunction(targetMinorCategory, filteredMinorCategories, 'sml');
	});

	// 소분류 선택시 리스트 불러오기
	$('#minorCategory1, #minorCategory2').change(function() {
		let bigNo = $(this).is('#minorCategory1') ? $('#majorCategory1').val() : $('#majorCategory2').val();
		let midNo = $(this).is('#minorCategory1') ? $('#middleCategory1').val() : $('#middleCategory2').val();
		let smlNo = $(this).val();

		// 제품 카테고리의 소분류 선택인 경우
		if ($(this).is('#minorCategory1')) {
			if (bigNo && midNo && smlNo) {
				categoriesSearchList(bigNo, midNo, smlNo, 'product');
			}
		}
		// 자재 카테고리의 소분류 선택인 경우
		else if ($(this).is('#minorCategory2')) {
			if (bigNo && midNo && smlNo) {
				categoriesSearchList(bigNo, midNo, smlNo, 'material');
			}
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

	// 대분류 변경 시 중분류 활성화/비활성화 및 초기화, 소분류도 초기화
	$('#majorCategory1, #majorCategory2').change(function() {
		var majorVal = $(this).val();
		if (majorVal) {
			$('#middleCategory1, #middleCategory2').prop('disabled', false);
			$('#minorCategory1, #minorCategory2').prop('disabled', true).val('').trigger('change');
		} else {
			$('#middleCategory1, #middleCategory2').prop('disabled', true).val('').trigger('change');
			$('#minorCategory1, #minorCategory2').prop('disabled', true).val('').trigger('change');
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
		$('.category-search-list tbody').empty();
	});

	$('#nestedItemModal').on('hidden.bs.modal', function() {
		if (activeModal === 'update') {
			$('#verticalycentered-update').modal('show');
		} else {
			$('#verticalycentered').modal('show');
		}
		$('.select2-secondModal', this).val(null).trigger('change');
		$(this).find('form').trigger('reset');
		$('.category-search-material-list tbody').empty();
		$("#itemCountInput").val('0 / 0'); // 항목수 초기화
		$("#itemTotalPriceInput").val('0원'); // 합계금액 초기화
		$(this).find("input[type='checkbox']").prop('checked', false);
		$(this).find("input[type='number']").val('');
		activeModal = null;
	});
	$('#nestedItemModal').on('show.bs.modal', function() {
		// 항목수와 합계금액을 초기 상태로 설정
		$("#itemCountInput").val('0 / 0');
		$("#itemTotalPriceInput").val('0원');
	});
	// 분류된 카테고리 정보를 서버로부터 가져오기 (제품 또는 자재)
	function categoriesSearchList(bigNo, midNo, smlNo, type) {
		console.log("big: " + bigNo, ", mid: " + midNo, ", sml: " + smlNo + ", type: " + type);
		if (!bigNo || !midNo || !smlNo || !type) {
			console.error("모든 카테고리를 선택해주세요.");
			return;
		}
		$.ajax({
			url: '/categoriesSearchList',
			type: 'GET',
			data: { bigNo: bigNo, midNo: midNo, smlNo: smlNo },
			success: function(data) {
				if (type === 'product') {
					populateItemsTable(data);
				} else if (type === 'material') {
					populateMaterialsTable(data);
				}
			},
			error: function(xhr, status, error) {
				console.error("리스트 조회 에러: " + status + ", " + error);
			}
		});
	}
	// 대중소분류된 제품 리스트 뿌려주기
	function populateItemsTable(items) {
		var tableBody = $('.category-search-list tbody');
		tableBody.empty();

		items.forEach(function(item) {
			var row = `<tr>
            <td><input type="radio" 
            	 name="productSelect" value="${item.item_cd}" 
            	 data-product-name="${item.item_nm}">
            </td>
            <th scope="row">${item.item_cd}</th>
            <td>${item.item_nm}</td>
            <td>${item.item_cost}원</td>
        </tr>`;
			tableBody.append(row);
		});
	}

	// 대중소분류된 자재 리스트 뿌려주기
	function populateMaterialsTable(materials) {
		var tableBody = $('.category-search-material-list tbody');
		tableBody.empty();

		materials.forEach(function(material, index) {
			var row = `<tr>
            <td class="checkbox-center"><input type="checkbox" 
                 name="materialSelect" value="${material.item_cd}"></td>
            <th scope="row">${material.item_cd}</th>
            <td>${material.item_nm}</td>
            <td>${material.item_cost}원</td>
            <td><input type="number" class="quantity-input" name="quantity${index + 1}" min="1" 
                 style="width: 80px;"> 개</td>
        </tr>`;
			tableBody.append(row);
		});
		updateItemCount();
	}

	// 자재 생상수량
	$('.category-search-material-list').on('input', '.quantity-input', function() {
		var originalValue = $(this).val();
		var correctedValue = originalValue.replace(/[^\d-]/g, '');

		// 숫자, 음수 부호 외의 문자가 입력되었는지 검사
		if (originalValue !== correctedValue) {
			$(this).val(correctedValue);
		}

		// 정수 범위를 확인하고 필요한 경우 최대 또는 최소값으로 설정
		var intValue = parseInt(correctedValue, 10);
		if (intValue > 999999) {
			$(this).val(999999);
			alert('수량은 최대 999999개까지입니다.');
		} else if (intValue < -999999) {
			$(this).val(-999999);
			alert('수량은 최소 -999999개까지입니다.');
		} else {
			$(this).val(intValue);
		}
	});

	// 제품 저장 버튼 클릭 이벤트 처리
	$(".btn.btn-primary.prodplan-item-save").click(function() {
		// 선택된 라디오 버튼을 가져옴
		var selectedRadio = $("input[type='radio'][name='productSelect']:checked");
		// 선택된 라디오 버튼의 값이 있는지 확인
		if (selectedRadio.length) {
			// 제품 코드와 이름을 가져와서 처리
			var productCode = selectedRadio.val();
			var productName = selectedRadio.data('productName');
			$(".productNameInput").val(productCode + " (" + productName + ")");
		}
		$('#nestedModal').modal('hide');
		$('#verticalycentered').modal('show');
	});

	// 투입자재 저장 버튼 클릭 이벤트 처리
	$(".prodplan-material-save").click(function() {
		var selectedMaterials = $("input[type='checkbox'][name='materialSelect']:checked");

		if (selectedMaterials.length > 0) {
			var tempSelectedMaterialsInfo = [];
			var allQuantitiesEntered = true; // 모든 수량 입력 확인 변수

			selectedMaterials.each(function() {
				var tr = $(this).closest('tr');
				var materialCode = tr.find("th").text();
				var materialName = tr.find("td").eq(1).text();
				var quantity = tr.find("input[type='number']").val();

				// 수량이 입력되지 않았을 경우 반복 종료
				if (quantity === "") {
					allQuantitiesEntered = false;
					return false;
				}

				tempSelectedMaterialsInfo.push({
					code: materialCode,
					name: materialName,
					quantity: quantity
				});
			});

			// 모든 자재의 수량이 입력되지 않았다면 경고 출력 후 함수 종료
			if (!allQuantitiesEntered) {
				alert('모든 선택된 자재의 수량을 입력해야 합니다.');
				return;
			}

			// 정상적인 경우의 로직 처리
			if (activeModal === 'update') {
				appendMaterialsToUpdateModal(tempSelectedMaterialsInfo);
				$('#nestedItemModal').modal('hide');
				$('#verticalycentered-update').modal('show');
			} else {
				tempSelectedMaterialsInfo.forEach(function(materialInfo) {
					selectedMaterialsInfo.push(materialInfo);
				});
				displaySelectedMaterials();
				$('#nestedItemModal').modal('hide');
			}
		} else {
			alert('적어도 하나 이상의 자재를 선택해야 합니다.');
		}
	});

	// 등록 모달에 선택된 자재 정보 표시 및 기본 문구 관리
	function displaySelectedMaterials() {
		$("#prodItem-list").empty(); // 기존 목록 초기화

		if (selectedMaterialsInfo.length > 0) {
			// 자재가 선택된 경우, 기본 문구 숨김
			$("#initial_message").hide();
			selectedMaterialsInfo.forEach(function(material, index) {
				var listItem = $(`<li>
                <span class="delete-selected-material" data-index="${index}">X</span>
                <span class="material-code">${material.code}<span class="material-name">(${material.name})</span></span>
                <span class="material-quantity">${material.quantity} 개</span>
            </li>`); // 클래스명을 추가하여 명확한 식별이 가능하도록 함
				$("#prodItem-list").append(listItem);
			});
		} else {
			// 선택된 자재가 없는 경우, 기본 문구 표시
			$("#initial_message").show();
		}

		// 자재 목록 상단 바 표시 상태 관리
		updateProdItemBarVisibility();
	}

	// 개별 삭제 버튼 클릭 이벤트
	$("#prodItem-list").on("click", ".delete-selected-material", function() {
		var index = $(this).data("index"); // 삭제할 자재 정보의 인덱스
		selectedMaterialsInfo.splice(index, 1); // 배열에서 삭제
		displaySelectedMaterials(); // 목록 다시 표시
	});

	// 자재 목록 상단 바 표시 상태 업데이트
	function updateProdItemBarVisibility() {
		if (selectedMaterialsInfo.length > 0) {
			$("#prodItem-bar").show();
		} else {
			$("#prodItem-bar").hide();
		}
	}
	// 자재 전체 삭제 기능 구현
	$("#delete_all").click(function() {
		$("#prodItem-list").empty(); // 선택된 자재 목록 삭제
		$('#prodItem-bar').hide(); // 선택된 자재 목록 상단 바 숨김
		$('#initial_message').show();
	});

	// 자재리스트 항목수 업데이트
	function updateItemCount() {
		var totalItems = $(".category-search-material-list tbody tr").length;
		var checkedItems = $(".category-search-material-list tbody input[type='checkbox']:checked").length;
		$("#itemCountInput").val(checkedItems + " / " + totalItems);
	}
	// 체크박스 상태 변경 또는 수량 입력 변경 시 합계 금액, 항목 수 업데이트
	$(".category-search-material-list").on("change", "input[type='checkbox'], input[type='number']", function() {
		updateTotalPrice();
		updateItemCount();
	});

	// 자재리스트 합계금액 업데이트
	function updateTotalPrice() {
		var totalPrice = 0;
		$(".category-search-material-list tbody tr").each(function() {
			var $checkbox = $(this).find("input[type='checkbox']");
			if ($checkbox.is(":checked")) {
				var quantity = parseInt($(this).find("input[type='number']").val()) || 0;
				var priceText = $(this).find("td").eq(2).text();
				// '원' 단위 제거 및 숫자만 추출
				var price = parseFloat(priceText.replace(/원/g, "").trim());
				console.log(`Quantity: ${quantity}, PriceText: ${priceText}, Price: ${price}`);
				totalPrice += price * quantity;
			}
		});

		$("#itemTotalPriceInput").val(`${totalPrice.toLocaleString()}원`);
	}

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
		var orderListTbody = $("#orderListTable tbody");
		orderListTbody.empty(); // 테이블 내용 초기화

		// 해당 월에 해당하는 주문 데이터 필터링
		var filteredOrders = responseProdPlans.prodOrderList.filter(function(order) {
			return order.order_dt.startsWith(selectedMonth);
		});

		// 필터링된 주문 데이터를 테이블에 추가
		filteredOrders.forEach(function(order) {
			// 해당 주문번호에 해당하는 제품 목록 필터링
			var orderItems = responseProdPlans.prodOrderItemList.filter(item => item.order_no === order.order_no);
			var productDetails = orderItems.map(item => item.item_nm + ' (' + item.qty + '개)').join(", "); // 제품명+수량
			var customerName = order.cust_nm; // 고객사 처리
			var displayCustomerName = customerName.length > 20 ? customerName.substr(0, 20) + '...' : customerName; // 고객사 툴팁처리

			var row = $('<tr>').append(
				$('<td>').append($('<input>').attr({ type: 'radio', name: 'selectedOrder', value: order.order_no })),
				$('<td>').text(order.order_no),
				$('<td>').text(productDetails.length > 50 ? productDetails.substr(0, 50) + '...' : productDetails)
					.attr('title', productDetails), // 제품명 툴팁 추가
				$('<td>').text(displayCustomerName).attr('title', customerName), // 고객사 이름에 툴팁 추가
				$('<td>').text(order.order_dt),
				$('<td>').text(order.order_end_dt)
			);
			orderListTbody.append(row);
		});
	}

	// "저장" 버튼 클릭 이벤트
	$('#saveOrderButton').on('click', function() {
		var selectedOrderNo = $('input[name="selectedOrder"]:checked').val();
		if (selectedOrderNo) {
			// 선택된 주문의 order_end_dt를 전역 변수에 저장
			var selectedOrder = responseProdPlans.prodOrderList.find(function(order) {
				return order.order_no === selectedOrderNo;
			});
			if (selectedOrder) {
				selectedOrderEndDt = selectedOrder.order_end_dt;
			}
			// 선택된 주문번호를 이전 모달의 주문번호 입력 필드에 설정
			$('#prodPlanNoInput').val(selectedOrderNo);
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
		var orderEndDate = new Date(selectedOrderEndDt);
		if (!$('.productStartDateInput').val()) {
			alert('먼저 시작예정일자를 선택해주세요.');
			$(this).val('');
		} else if (endDate < startDate) {
			alert('완료예정일자는 시작예정일자 이전으로 설정할 수 없습니다.');
			$(this).val('');
		}
		if (endDate > orderEndDate) {
			alert('완료 예정일자는 주문 종료일보다 이후일 수 없습니다.');
			$(this).val('');
		}
	});
	// 작업일수
	$('.prodPlanWorkingDaysInput').on('input', function() {
		var originalValue = $(this).val();
		var correctedValue = originalValue.replace(/[^\d-]/g, '');

		// 숫자, 음수 부호 외의 문자가 입력되었는지 검사
		if (originalValue !== correctedValue) {
			$(this).val(correctedValue);
		}

		// 정수 범위를 확인하고 필요한 경우 최대 또는 최소값으로 설정
		var intValue = parseInt(correctedValue, 10);
		if (intValue > 999999) {
			$(this).val(999999);
			alert('작업일수는 최대 999999개까지입니다.');
		} else if (intValue < -999999) {
			$(this).val(-999999);
			alert('작업일수는 최소 -999999개까지입니다.');
		} else {
			$(this).val(intValue);
		}
	});
	// 생상수량
	$('.prodCount-input').on('input', function() {
		var originalValue = $(this).val();
		var correctedValue = originalValue.replace(/[^\d-]/g, '');

		// 숫자, 음수 부호 외의 문자가 입력되었는지 검사
		if (originalValue !== correctedValue) {
			$(this).val(correctedValue);
		}

		// 정수 범위를 확인하고 필요한 경우 최대 또는 최소값으로 설정
		var intValue = parseInt(correctedValue, 10);
		if (intValue > 999999) {
			$(this).val(999999);
			alert('생산수량은 최대 999999개까지입니다.');
		} else if (intValue < -999999) {
			$(this).val(-999999);
			alert('생산수량은 최소 -999999개까지입니다.');
		} else {
			$(this).val(intValue);
		}
	});

	// 수정모달 투입자재추가 생산수량
	$('#prodItem-list-update').on('input', '.material-quantity-input', function() {
		var value = parseInt($(this).val(), 10);
		if (value > 999999) {
			$(this).val(999999);
			alert('생산수량은 최대 999999개까지입니다.');
		} else if (value < -999999) {
			$(this).val(-999999);
			alert('생산수량은 최소 -999999개까지입니다.');
		}
	});

	// 모달 닫기시 초기화
	$('#verticalycentered').on('hidden.bs.modal', function() {
		if (activeModal === null) { // 어떤 모달도 활성화되지 않았을 때만 초기화
			$(this).find('input[type="text"], input[type="number"], textarea').not('#productEmp').val('');
			$(this).find('input[type="date"]').val('');
			selectedMaterialsInfo = []; // 선택된 자재 정보 배열 초기화
			$('#prodItem-list').empty();
			$('#initial_message').show();
			$('#prodItem-bar').hide();
		}
		activeModal = null;
	});

	// 각 모달로 들어갈때 등록모달이 꺼지고 켜지기때문에 초기화 방지용
	// 주문모달
	$('.OderCodeSelect').click(function() {
		activeModal = 'orderSelect';
	});
	// 제품모달
	$('.productSelect').click(function() {
		activeModal = 'productSelect';
	});
	// 자재모달
	$('.productItemSelect').click(function() {
		activeModal = 'productItemSelect';
	});

	// 등록모달 저장버튼시 DB저장, 필수 입력 값 유효성 검사
	$('#saveButton').click(function(event) {
		event.preventDefault(); // 폼 자동 제출 방지

		// 입력 값 검증
		var isFormValid = true;
		var errorMessage = '';

		// 주문번호 검증
		if ($('#prodPlanNoInput').val() === '') {
			alert('주문번호를 선택해주세요.');
			return;
		}
		// 작업일수 검증
		if ($('#prodPlanWorkingDaysInput').val() === '') {
			alert('작업일수를 입력해주세요.');
			return;
		}
		// 시작예정일자 검증
		if ($('.productStartDateInput').val() === '') {
			alert('시작예정일자를 선택해주세요.');
			return;
		}

		// 완료예정일자 검증
		if ($('.productEndDateInput').val() === '') {
			alert('완료예정일자를 선택해주세요.');
			return;
		}
		// 제품 선택 검증
		if ($('.productNameInput').val() === '') {
			alert('제품을 선택해주세요.');
			return;
		}
		// 투입자재 선택 검증
		if (selectedMaterialsInfo.length === 0) {
			alert('투입자재를 선택해주세요.');
			return;
		}

		// 입력 값이 유효한 경우, AJAX 요청 실행
		if (isFormValid) {
			console.log('폼으로 들어가니?');
			// 제품 정보 수집
			var productCode = $(".productNameInput").val().split(" ")[0]; 				// 제품 코드 파싱
			var productName = $(".productNameInput").val().split(" (")[1].slice(0, -1); // 제품 이름 파싱

			// 자재 정보 수집
			var selectedMaterials = [];
			$('#prodItem-list li').each(function() {
				var fullText = $(this).find('.material-code').text().trim();
				var code = fullText.split('(')[0].trim(); // 괄호 "(" 기준으로 분할 후 첫 번째 부분을 사용

				var material = {
					code: code, 														 // 자재 코드
					name: $(this).find('.material-name').text().trim(), 				 // 자재 이름
					quantity: parseInt($(this).find('.material-quantity').text().trim()) // 자재 수량
				};
				selectedMaterials.push(material);
			});
			var formData = {
				orderNo: $('#prodPlanNoInput').val(),
				workDays: $('#prodPlanWorkingDaysInput').val(),
				startDate: $('.productStartDateInput').val(),
				endDate: $('.productEndDateInput').val(),
				productQty: $('.prodCount-input').val(),
				product: {
					code: productCode,
					name: productName
				},
				materials: selectedMaterials,
				remark: $('textarea[name="remark"]').val()
			};
			console.log(formData);
			$.ajax({
				type: "POST",
				url: "submitProdPlan",
				contentType: "application/json",
				data: JSON.stringify(formData),
				success: function(response) {
					alert('성공적으로 저장되었습니다.');
					$('#verticalycentered').modal('hide');
					calendar.refetchEvents(); // 캘린더리스트 새로고침
				},
				error: function(xhr, status, error) {
					alert('저장에 실패했습니다.');
				}
			});
		} else {
			alert(errorMessage);
		}
	});

	// =============  수정(업데이트) 작업 ===============
	$('#updateButton').click(function() {
		var currentUserName = $('#productEmp').val(); // 담당자 저장

		if (!selectedEvent) {
			alert('수정할 이벤트를 먼저 선택해 주세요.');
			return;
		}
		// 제목에 생산 계획 번호 결합
		var modalTitle = '생산 계획 수정 (' + selectedEvent.prodPlan_no + ')';
		$('#verticalycentered-update .modal-title').text(modalTitle);

		$('.event-tooltip').remove(); // 툴탭제거

		// 제품명과 제품 코드 결합
		var productNameWithCode = selectedEvent.item_nm + ' (' + selectedEvent.item_cd + ')';
		$('#productName-update').val(productNameWithCode);
		// 나머지 필드 설정
		$('#prodPlanNoInput-update').val(selectedEvent.order_no);
		$('#prodPlanWorkingDaysInput-update').val(selectedEvent.work_dt);
		$('.productStartDateInput-update').val(selectedEvent.prodPlan_dt);
		$('.productEndDateInput-update').val(selectedEvent.prodPlan_end_dt);
		$('.productEmpInput-update').val(currentUserName);
		$('.prodCount-input-update').val(selectedEvent.qty);
		$('textarea[name="remark-update"]').val(selectedEvent.remark);

		// 투입자재 목록 채우기
		var selectedMaterials = responseProdPlans.prodItems.filter(item => item.prodPlan_no === selectedEvent.prodPlan_no);
		$('#prodItem-list-update').empty(); // 기존 목록 초기화
		selectedMaterials.forEach(material => {
			var listItem = $(`
                <li class="update-material-item">
                    <span class="material-remove" style="cursor: pointer;">X</span>
                    <span class="material-code">${material.item_cd}<span class="material-name">(${material.item_nm})</span></span>
                    <span class="material-quantity">
                    	<input type="number" class="material-quantity-input" value="${material.in_qty}" min="-999999" max="999999"> 개
                    </span>
                </li>
            `);
			$("#prodItem-list-update").append(listItem);
		});

		updateProdItemListState(); // 상태 업데이트 함수 호출

		// 'X' 버튼 클릭 이벤트 처리 (기존 자재 목록)
		$('#prodItem-list-update').on('click', '.material-remove', function() {
			var materialCode = $(this).siblings('.material-code').text();
			materialsToDelete.push(materialCode); // 삭제 대기 목록에 추가
			console.log(materialsToDelete);
			$(this).closest('li.update-material-item').remove(); // 해당 목록 삭제
			updateProdItemListState(); // 상태 업데이트
		});

		// '투입자재 선택' 버튼 클릭 이벤트
		$('#productItemSelect-update').click(function() {
			activeModal = 'update'; // 현재 활성화된 모달 추적
			$('#nestedItemModal').modal('show');
		});

		// 새로 추가된 자재 목록의 'X' 버튼 클릭 이벤트 처리
		$('#prodItem-list-update').on('click', '.remove-material', function() {
			$(this).closest('li.new-material-item').remove(); // 클릭된 항목 제거
			updateProdItemListState(); // 상태 업데이트 함수 호출
		});

		// '전체 삭제' 버튼 클릭 이벤트 핸들러
		$('#delete_all-update').click(function() {
			console.log('전체 삭제 시작');

			// 기존 자재 목록 순회
			$('#prodItem-list-update .update-material-item').each(function() {
				var materialCode = $(this).find('.material-code').text().trim();
				console.log('삭제 대기열에 추가할 자재 코드:', materialCode);

				// 삭제 대기열에 추가 (중복 체크를 위해 배열을 사용)
				if (!materialsToDelete.includes(materialCode)) {
					materialsToDelete.push(materialCode);
					console.log(materialCode, '삭제 대기열에 추가됨');
				}

				// 화면에서 해당 자재 목록 숨기기
				$(this).empty();
				console.log(materialCode, '기존 자재목록 숨김 처리');
			});

			// 새로 추가된 자재 목록 화면에서 제거
			$('#prodItem-list-update .new-material-item').remove();
			console.log('새로 추가된 자재 목록 제거 완료');

			// 상태 업데이트 및 UI 조정
			updateProdItemListState();

			// 선택된 자재가 없으면 기본 메시지 표시
			if ($("#prodItem-list-update li:visible").length === 0) {
				$("#initial_message-update").show();
				$("#prodItem-bar-update").hide();
			} else {
				$("#initial_message-update").hide();
				$("#prodItem-bar-update").show();
			}

			console.log('삭제 대기열:', materialsToDelete);
		});
		// 수정모달 꺼질때 이벤트 핸들러
		$('#verticalycentered-update').on('hidden.bs.modal', function() {
			materialsToDelete = []; // 삭제 대기 목록 초기화
			$('#prodItem-list-update li.update-material-item').show(); // 모든 숨겨진 항목을 다시 표시
			if ($('#prodItem-list-update').children().length > 0) {
				$("#prodItem-bar-update").show();
			} else {
				$("#initial_message-update").show();
				$("#prodItem-bar-update").hide();
			}
		});

		$('#saveButton-update').click(function() {
			console.log('수정 저장 버튼 오냐?');
			// 수정 모달에서 제품 코드와 제품명 파싱
			var productNameUpdate = $("#productName-update").val().split(" (")[1].slice(0, -1);
			// 수정 모달에서 새로 추가된 투입 자재 목록 수집
			var updatedMaterials = [];

			$('#prodItem-list-update li.new-material-item, #prodItem-list-update li.update-material-item').each(function() {
				var materialInfo = $(this).find('.material-code').text().trim();
				var code = materialInfo.split('(')[0].trim();
				var name = materialInfo.includes('(') ? materialInfo.split('(')[1].slice(0, -1) : '';
				var quantity = parseInt($(this).find('.material-quantity-input').val()); // 자재 수량

				var material = {
					code: code,
					name: name,
					quantity: quantity
				};
				updatedMaterials.push(material);
			});

			var transformedMaterialsToDelete = materialsToDelete.map(item => {
				var parts = item.split('('); // 괄호 '(' 기준으로 분리
				var code = parts[0].trim(); // 자재 코드 추출
				var name = parts[1] ? parts[1].slice(0, -1) : ''; // 괄호 ')' 제거하고 자재 이름 추출, parts[1] 존재 여부 확인
				return { code, name };
			});

			// formData 구성
			var formData = {
				prodPlanData: {
					prodPlanNo: selectedEvent.prodPlan_no,
					orderNo: $('#prodPlanNoInput-update').val(),
					workDays: $('#prodPlanWorkingDaysInput-update').val(),
					startDate: $('.productStartDateInput-update').val(),
					endDate: $('.productEndDateInput-update').val(),
					productQty: $('.prodCount-input-update').val(),
					remark: $('textarea[name="remark-update"]').val(),
					// 제품 정보 추가
					product: {
						code: selectedEvent.item_cd,
						name: productNameUpdate
					}
				},
				newMaterials: updatedMaterials, // 새로 추가된 자재 목록
				materialsToDelete: transformedMaterialsToDelete // 삭제 대기 목록에 있는 자재 코드 목록
			};

			// AJAX 요청을 통해 materialsToDelete 배열에 있는 자재들을 DB에서 삭제하고 수정된 정보 저장
			$.ajax({
				url: 'updateProdPlan',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify(formData),
				success: function(response) {
					alert('성공적으로 수정되었습니다.');
					$('#verticalycentered-update').modal('hide');
				},
				error: function() {
					alert('수정 중 오류가 발생했습니다.');
				}
			});

		});
		$('#verticalycentered-update').modal('show');
	}); // 건들지마셈

	// 상태 업데이트 함수
	function updateProdItemListState() {
		if ($("#prodItem-list-update li").length === 0) {
			$("#initial_message-update").show();
			$("#prodItem-bar-update").hide();
		} else {
			$("#initial_message-update").hide();
			$("#prodItem-bar-update").show();
		}
	}

	// 새로운 자재 목록을 수정 모달에 추가하는 함수
	function appendMaterialsToUpdateModal(materials) {
		materials.forEach(function(material) {
			var listItem = $(`
                    <li class="new-material-item">
                        <span class="remove-material" style="cursor: pointer;">X</span>
                        <span class="material-code">${material.code}<span class="material-name">(${material.name})</span></span>
                        <span class="material-quantity">
                        	<input type="number" class="material-quantity-input" value="${material.quantity}" min="-999999" max="999999"> 개
                        </span>
                    </li>
                `);
			$("#prodItem-list-update").append(listItem);
		});

		updateProdItemListState();
	}

	// ============= End 수정(업데이트) 작업 ===============
	// =========== 생산계획 삭제 ============
	$('#deleteEventButton').click(function() {
		if (!selectedEvent) {
			alert('삭제할 이벤트를 선택해 주세요.');
			return;
		}

		var confirmDelete = confirm('정말로 이 계획을 삭제하시겠습니까?');
		if (confirmDelete) {
			// AJAX 요청으로 서버에 삭제를 요청
			$.ajax({
				url: 'deleteProdPlan',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify({ prodPlan_no: selectedEvent.prodPlan_no }),
				success: function(response) {
					alert('계획이 성공적으로 삭제되었습니다.');
					calendar.refetchEvents();
				},
				error: function(xhr, status, error) {
					alert('계획 삭제 중 오류가 발생했습니다.');
				}
			});
		}
	});
	// 숫자 포멧팅 작업(3자리마다 콤마)
	function formatNumber(num) {
		return Number(num).toLocaleString();
	}

	function formatNumbersInText(text) {
		return text.replace(/\d+/g, function(match) { // 전역으로 하나이상의 숫자를 연속으로 찾아냄(replace: 정규표현식에 해당하는 부분만 교체)
			return parseInt(match).toLocaleString();  // 정규표현식에 매치되는 문자열을찾아 3자리마다 콤마찍음
		});
	}
}); // !! 건들지말것 !!
