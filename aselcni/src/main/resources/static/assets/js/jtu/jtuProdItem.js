let startDate = $('#startDate').val();
let endDate = $('#endDate').val();
let proditem_emp_id = "";
let proditem_no = "";
let workprod_no = "";
let whNoAndNameKeyword = "";
let itemNoAndNameKeyword = "";
let currentPage = 1;

let badCdKeyword = "";
let badResKeyword = "";
let bad_cd = "";
let bad_res = "";

let selectedRows = []; // 체크된 행의 데이터를 저장할 리스트
const data = {
	startDate,
	endDate,
	proditem_no,
	workprod_no,
	proditem_emp_id,
	whNoAndNameKeyword,
	itemNoAndNameKeyword,
	currentPage,

	badCdKeyword,
	badResKeyword,
	bad_cd,
	bad_res
}

function changeData(key, value) {
	data[key] = value;
	console.log(data[key], value);
}
//엔터키누르면 검색
$(document).ready(function() {
	$('.container.text-center.m-4 input').keypress(function(e) {

		if (e.which == 13) { // 엔터 키의 키 코드는 13
			getPriListAjax(1);
		}
	});
});

//modal 예상수량-실제수량=불량수량
$(document).ready(function() {
	// RegiModal에 대한 설정
	setupModalQty("#expectedQtyRegiModal", "#actualQtyRegiModal",
		"#defectiveQtyRegiModal");

	// EditModal에 대한 설정
	setupModalQty("#expectedQtyEditModal", "#actualQtyEditModal",
		"#defectiveQtyEditModal");
});
//예상수량-실제수량=불량수량 함수
function setupModalQty(expQty, actQty, defQty) {
    function adjustValues() {
        let expectedQty = parseInt($(expQty).val()) || 0;
        let actualQty = Math.min(Math.max(parseInt($(actQty).val()) || 0, 0), expectedQty);
        let defectiveQty = Math.min(Math.max(expectedQty - actualQty, 0), expectedQty);

        $(actQty).val(actualQty);
        $(defQty).val(defectiveQty);
    }

    function adjustActualFromDefective() {
        let expectedQty = parseInt($(expQty).val()) || 0;
        let defectiveQty = Math.min(Math.max(parseInt($(defQty).val()) || 0, 0), expectedQty);
        let actualQty = Math.max(expectedQty - defectiveQty, 0);

        $(actQty).val(actualQty);
    }

    $(expQty + ", " + actQty).on("input", adjustValues);
    $(defQty).on("input", adjustActualFromDefective);
}



//닫기 버튼 클릭시 modal 입력 내용 클리어
$(document).ready(function() {
	$('button[data-bs-dismiss="modal"]').on('click', function() {

	});
});

//클리어 함수
function modalContentClear() {
	$('#workProdNoRegiModal').text("생산 지시 번호를 선택");
	$(".modal-content input").val('');
	$(".modal-content textarea").val('');
}


//로딩시 날짜 설정
$(document).ready(function() {
	inputToday("#startDate");

	startDate = $('#startDate').val();
	endDate = $('#endDate').val();

	let startDt = new Date(startDate);
	let endDt = new Date(startDate);

	endDt.setDate(startDt.getDate() + 7);

	endDate = endDt.toISOString().slice(0, 10);
	$('#endDate').val(endDate);

	console.log("endDt", endDt);
	console.log("endDate", endDate);

	//시작 날짜와 종료 날짜 논리 일관성
/*	$('#startDate').on('change', function() {
		startDate = $('#startDate').val();
		endDate = $('#endDate').val();

		if (startDate > endDate) {
			$('#startDate').val(endDate);
		}
	});

	//시작 날짜와 종료 날짜 논리 일관성
	$('#endDate').on('change', function() {
		startDate = $('#startDate').val();
		endDate = $('#endDate').val();

		if (startDate > endDate) {
			$('#endDate').val(startDate);
		}
	});*/
});

// 좌우 버튼 누를 때마다 날짜 7일 단위로 바뀜, 
$(document).ready(function() {
	$('#dateRightBtn').click(function() {
		dateShift('right');
	});

	$('#dateLeftBtn').click(function() {
		dateShift('left');
	});
});


// 날짜 조정 함수
function dateShift(direction) {
	startDate = $('#startDate').val();
	endDate = $('#endDate').val();

	// Date 객체로 변환
	let startDt = new Date(startDate);
	let endDt = new Date(endDate);

	// 방향에 따라 날짜를 조정
	if (direction === 'right') {
		startDt.setDate(startDt.getDate() + 7);
		endDt.setDate(endDt.getDate() + 7);
	} else if (direction === 'left') {
		startDt.setDate(startDt.getDate() - 7);
		endDt.setDate(endDt.getDate() - 7);
	}

	// 새로운 날짜를 입력 필드에 설정
	$('#startDate').val(startDt.toISOString().slice(0, 10));
	$('#endDate').val(endDt.toISOString().slice(0, 10));

	changeData('startDate', startDate);
	changeData('endDate', endDate);
}

//모달 창이 좁아지면 텍스트가 움직이게 설정
$(document).ready(function() {
	adjustMarquee();
	$(window).on('resize', adjustMarquee);

	// 모달이 완전히 보여진 후에 실행
	$('#workProdRegiModal').on('shown.bs.modal', adjustMarquee);
	$('#prodItemEditModal').on('shown.bs.modal', adjustMarquee);
});


//모달 창이 좁아지면 텍스트가 움직이게하는 함수
function adjustMarquee() {
	$('.label-marquee').each(function() {
		const label = $(this); // 현재 label
		const text = label.find('.moving-text'); // 현재 label 내의 .moving-text

		// 조건을 검사하여 애니메이션을 적용하거나 제거
		if (text.width() > label.width()) {
			text.addClass('moving-animation'); // 너비가 label보다 클 경우, 애니메이션 클래스 추가
		} else {
			text.removeClass('moving-animation'); // 그렇지 않다면, 애니메이션 클래스 제거
		}
	});
}


//dropdown 기능 
$(document).ready(function() {
	$('#workProdNoRegiModal').dropdown();
	$('#prodItemWHRegiModal').dropdown();
	$('#prodItemWHEditModal').dropdown();
});


//등록버튼 눌렀을때
$(document).ready(function() {
	$("#regiModalBtn").click(function() {
		//오늘날짜 넣기
		inputToday("#prodEndDateRegiModal",);
		//창고 리스트 넣어줌
		getWHListModal("RegiModal");
	})
})

//오늘 날짜 넣어주는 함수
function inputToday(tagId) {
	let todayLong = new Date();
	let today = todayLong.toISOString().slice(0, 10)


	$(tagId).val(today);
}

//창고 리스트 불러오는 함수
function getWHListModal(modalType) {
	var ulSelector = "";
	var itemSelector = "";
	var hiddenSelector = "";

	if (modalType === "RegiModal") {
		ulSelector = "#whListRegiModal";
		itemSelector = "#prodItemWHRegiModal";
		hiddenSelector = "#hiddenProdItemWHCdRegiModal";
	} else if (modalType === "EditModal") {
		ulSelector = "#whListEditModal";
		itemSelector = "#prodItemWHEditModal";
		hiddenSelector = "#hiddenProdItemWHCdEditModal";
	}

	$(ulSelector).find("li").remove();
	$.ajax({
		url: 'getWHListModal',
		method: 'POST',
		dataType: 'json',
		success: function(whList) {
			console.log("whList", whList);
			let ulTag = $(ulSelector);
			$.each(whList, function(index, wh) {
				let liTag = $("<li></li>");
				let aTag = $("<a></a>", {
					"class": "dropdown-item",
					"href": "#",
					"data-val": wh.wh_cd,
					"text": wh.wh_nm + '(' + wh.wh_cd + ')'
				});

				liTag.append(aTag);
				ulTag.append(liTag);
			});

			$(ulSelector + " a").click(function() {
				$(itemSelector).text($(this).text());
				$(hiddenSelector).val($(this).data('val'));

				console.log(hiddenSelector, $(hiddenSelector).val());
			});
		},
		error: function(xhr, status, error) {
			console.error("Error occurred: " + error);
		}
	});
}


//리스트 불러오고 생산 지시번호를 선택하면, 자동 텍스트 입력
$(document).ready(function() {
	$("#workProdNoRegiModal").click(function() {
		$.ajax({
			url: 'getWorkProdNoRegiModalList',
			method: 'POST',
			dataType: 'json',
			success: function(wprList) {
				console.log("wprList", wprList);
				let ulTag = $("#workProdNoRegiModalList");
				ulTag.empty();
				$.each(wprList, function(index, wpr) {
					let liTag = $("<li></li>");
					let aTag = $("<a></a>", {
						"class": "dropdown-item",
						"href": "#",
						"data-value": wpr.workprod_no,
						"text": wpr.workprod_no
					});
					liTag.append(aTag);
					ulTag.append(liTag);
				});//each

				$('#workProdNoRegiModalList a').on('click', function() {
					let selectedValue = $(this).attr('data-value');
					let foundWpr = wprList.find(wpr => wpr.workprod_no == selectedValue);
					console.log("foundWpr", foundWpr);

					$('#workProdNoRegiModal').text(selectedValue);
					$('#hiddenWorkProdNoRegiModal').val(selectedValue);
					$('#workStartDateRegiModal').val(foundWpr.workprod_dt);
					$('#hiddenItemCdRegiModal').val(foundWpr.item_cd);
					$('#itemNameRegiModal').val(foundWpr.item_nm + "(" + foundWpr.item_cd + ")");
					$('#expectedQtyRegiModal').val(foundWpr.qty);
					$('#hiddenExpQtyRegiModal').val(foundWpr.qty);
					
					
					$('#actualQtyRegiModal').attr('max',foundWpr.qty);
					$('#defectiveQtyRegiModal').attr('max',foundWpr.qty);

				});
			},//success
			error: function(xhr, status, error) {
			}
		});//ajax

	});
});


//조회 테이블 행 클릭시 modal 수정창으로 이동
$(document).on('click', 'tr[data-bs-target="#prodItemEditModal"]', function() {
	let prodNo = $(this).find('th:nth-child(1)').text();
	getPriOneAjax(prodNo);
});

//pri 선택하면 상세 보기
function getPriOneAjax(prodNo) {
	data.proditem_no = prodNo;

	$.ajax({
		url: "getPriOneAjax",
		method: "POST",
		data,
		dataType: "json",
		success: function(pri) {
			console.log("pri", pri)

			$('#titleProdItemEditModal').text(pri.proditem_no);
			$('#hiddenProdItemEditModal').val(pri.proditem_no);
			$('#workProdNoEditModal').text(pri.workprod_no);
			$('#proditemUpdateEditModal').val(pri.proditem_update);
			$('#empEditModal').val(pri.proditem_emp_id);
			$('#prodEndDateEditModal').val(pri.proditem_end_dt);
			$('#prodItemWHEditModal').text(pri.wh_nm + '(' + pri.wh_cd + ')');
			$('#hiddenProdItemWHCdEditModal').val(pri.wh_cd);
			$('#itemNameEditModal').val(pri.item_nm + '(' + pri.item_cd + ')');
			$('#hiddenItemCdEditModal').val(pri.item_cd);
			$('#expectedQtyEditModal').val(pri.pln_qty);
			$('#hiddenExpectedQtyEditModal').val(pri.pln_qty);

			$('#actualQtyEditModal').val(pri.prod_qty);
			$('#defectiveQtyEditModal').val(pri.bad_qty);
			$('#remarkEditModal').val(pri.remark);

			if (pri.jpriBadList.length != 0) {
				$('#badListEditModal').empty();
				selectedRows = [];
				$.each(pri.jpriBadList, function(index, row) {
					var trTag = $('<tr></tr>');
					trTag.append('<th scope="row">' + (index + 1) + '</th>'); // 인덱스를 1부터 시작하도록 설정
					trTag.append('<td>' + row.bad_cd + '<input type="hidden" name="jpriBadList[' + index + '].bad_cd" value="' + row.bad_cd + '"></td>');
					trTag.append('<td>' + row.bad_res + '</td>');
					$('#badListEditModal').append(trTag);

					selectedRows.push({ // 예시로 행의 체크박스와 불량 코드를 객체로 저장

						code: row.bad_cd, // 불량 코드 
						res: row.bad_res // 불량 코드 내역
					});
				});
			}

			let disabledList = [$('#workProdNoEditModal'), $('#proditemUpdateEditModal'), $('#empEditModal'), $('#prodEndDateEditModal'), $('#prodItemWHEditModal'), $('#itemNameEditModal'),
			$('#expectedQtyEditModal'), $('#actualQtyEditModal'), $('#defectiveQtyEditModal'), $('#badEditModalBtn'), $('#remarkEditModal')];

			disabledOnoff(disabledList, true)

		},//success
		error: function(xhr, status, error) {
		}
	})//ajax

}
// 수정 버튼 누르면 isDisabled
function disabledOnoff(list, isDisabled) {
	list.forEach(item => {
		item.prop("disabled", isDisabled);
	});
}

//priList 가져오는 함수 p2
function getPriListAjax(page) {
	data.startDate = $('#startDate').val();
	data.endDate = $('#endDate').val();
	data.proditem_no = $("#prodItemNoSearch").val(); //리셋
	data.currentPage = page;

	console.log("getPriListAjax data", data);

	$.ajax({
		url: "getPriListAjax",
		method: "POST",
		data,
		dataType: "json",
		success: function(jpriMap) {
			console.log("jpriMap", jpriMap);
			$("#prodItemTbody").empty();
			$('.pageNum').empty();


			if (jpriMap.priList.length != 0) {
				$("#prevPageLi").show();
				$("#nextPageLi").show();
			} else {
				$("#prevPageLi").hide();
				$("#nextPageLi").hide();
				$("#prodItemTbody").append("<tr><td colspan='7'>해당하는 생산 실적이 조회되지 않습니다.</td></tr>")
			}

			$.each(jpriMap.priList, function(index, pri) {
				$("#prodItemTbody").append(
					'<tr data-bs-toggle="modal" data-bs-target="#prodItemEditModal" style="cursor:pointer;">' +
					'<th scope="row">' + pri.proditem_no + '</th>' +
					'<td>' + pri.workprod_no + '</td>' +
					'<td>' + pri.proditem_end_dt + '</td>' +
					'<td>' + pri.item_nm + '(' + pri.item_cd + ')</td>' +
					'<td>' + pri.wh_nm + '(' + pri.wh_cd + ')</td>' +
					'<td>' + numberWithCommas(pri.pln_qty) + '</td>' +
					'<td>' + numberWithCommas(pri.prod_qty) + '</td>' +
					'<td>' + numberWithCommas(pri.bad_qty) + '</td>' +
					'</tr>'
				);
			});



			for (let i = jpriMap.paging.startPage; i <= jpriMap.paging.endPage; i++) {
				$('#nextPageLi').before(
					`<li class="page-item pageNum"><button class="page-link ${page == i ? 'fw-bold' : ''}" onclick="goPage( ${i} )">${i}</button></li>`
				);

			}
			$("#nextPageBtn").attr("data-total-page", jpriMap.paging.totalPage);




		},//success
		error: function(xhr, status, error) {
			console.error("Error occurred: " + error);
		}
	});//ajax
}

//수정 버튼 눌렀을 때 로직
$(document).ready(function() {
	$("#editModalEditBtn").click(function() {
		let disabledList = [$('#empEditModal'), $('#prodEndDateEditModal'), $('#prodItemWHEditModal'),
		$('#actualQtyEditModal'), $('#defectiveQtyEditModal'), $('#badEditModalBtn'), $('#remarkEditModal')];

		disabledOnoff(disabledList, false);

		$("#prodItemWHEditModal").attr("data-bs-toggle", "dropdown");
		getWHListModal("EditModal");

		$("#editModalEditBtn").hide();
		$("#editModalUpdateBtn").show();
	})
})

//닫기 버튼 or X 버튼 눌렀을 때, 수정 버튼 눌렀을때 로직
$(document).ready(function() {
	$('#prodItemEditModal').on('hidden.bs.modal', function() {

		$("#prodItemWHEditModal").attr("data-bs-toggle", "");

		$("#editModalEditBtn").show();
		$("#editModalUpdateBtn").hide();
	});
})

//삭제 버튼 눌렀을 때 로직
$(document).ready(function() {
	$("#editModaldeleteBtn").click(function() {
		let result = confirm("생산 실적을 삭제하시겠습니까?");
		if (result == true) {
			data.proditem_no = $("#hiddenProdItemEditModal").val();

			console.log("deleteProdItemEditModal data", data);
			$.ajax({
				url: "deleteProdItemEditModal",
				method: 'POST',
				data,
				success: function() {
					alert("삭제 성공");
					$("#prodItemEditModal").modal('hide');
					getPriListAjax(1);
				},//success
				error: function(xhr, status, error) {
					console.error("Error occurred: " + error);
				}
			})//ajax
		}//result
	})

})


/* 	$(document).ready(function() {
		//badModal 닫힐때 regiModal 나오게 하기
		$('#badModal').on('hidden.bs.modal', function (e) {
			$('#workProdRegiModal').modal('show');
		});

	}) */


//코드 선택 눌렀을때 모달 체인지
function openBadModal() {
	$('#badModal').modal('show');

	//불량 코드 리스트 넣어줌
	getBadList();
}


//불량 코드 리스트 불러오는 함수
function getBadList(prodItemNo, badCd, badRes) {
	data.proditem_no = prodItemNo;
	data.badCdKeyword = badCd;
	data.badResKeyword = badRes;

	$.ajax({
		url: 'getBadListModal',
		method: 'POST',
		data,
		dataType: 'json',
		success: function(badList) {
			let tbodyTag = $("#badListBadModal");

			tbodyTag.empty();


			if (badList.length == 0) {
				let trTag = $("<tr></tr>");
				trTag.append("<td colspan='3'> 해당하는 코드가 없습니다. 추가 하고 싶으시다면 코드와 내역을 입력하고, 기타 버튼을 눌러주세요 </td>");
				tbodyTag.append(trTag);
			}

			$.each(badList, function(index, bad) {

				let trTag = $("<tr style='cursor:pointer;'></tr>");
				trTag.append('<td class="checkbox-center"><input class="badCheckBox" type="checkbox"></td>');
				trTag.append("<td>" + bad.bad_cd + "</td>");
				trTag.append("<td>" + bad.bad_res + "</td>");
				trTag.append("<td class='checkbox-center' style='display:none;'><input type='checkbox'></td>");
				tbodyTag.append(trTag);
			});

			// 리스트가 새로 로드된 후에 저장된 항목들을 기반으로 체크박스 체크
			$('#badListBadModal tr').each(function() {
				let tr = $(this);
				let badCd = tr.find('td:nth-child(2)').text();

				let isSelected = selectedRows.some(row => row.code === badCd);

				if (isSelected) {
					tr.find($(".badCheckBox")).prop('checked', true);
				}
			});



			// 체크박스 클릭 이벤트
			$('#badListBadModal tr').click(function(e) {
				var checkbox = $(this).find($(".badCheckBox"));

				// 행이 아닌 체크박스를 직접 클릭한 경우에도 동작하도록 예외 처리
				if (!$(e.target).is('input')) {
					checkbox.prop('checked', !checkbox.prop('checked'));
				}

				// 체크박스가 체크되면 리스트에 추가, 아니면 리스트에서 제거
				if (checkbox.prop('checked')) {
					selectedRows.push({ // 예시로 행의 체크박스와 불량 코드를 객체로 저장
						checkbox: checkbox,
						code: $(this).find('td:nth-child(2)').text(), // 불량 코드 
						res: $(this).find('td:nth-child(3)').text() // 불량 코드 내역
					});
					console.log("selectedRows", selectedRows);
				} else {
					selectedRows = selectedRows.filter(function(row) {
						return row.code !== $(this).find('td:nth-child(2)').text();
					}.bind(this)); // 현재 컨텍스트(this)를 filter 함수 내부로 바인딩
					console.log("selectedRows", selectedRows);
				}
			});



		},
		error: function(xhr, status, error) {
			console.error("Error occurred: " + error);
		}
	});//ajax
}

//선택된 불량 코드를 삭제
function deleteSelectedBad() {
	let result = confirm("정말로 코드를 삭제하시겠습니까?");
	if (result == true) {
		// 선택된 항목들을 삭제
		selectedRows.forEach(function(row) {
			console.log("row", row)
			console.log("row.code", row.code)
			data.bad_cd = row.code;

			$.ajax({
				url: 'deleteBadModal',
				method: 'POST',
				data,
				success: function() {

				},
				error: function(xhr, status, error) {
					console.error("Error occurred: " + error);
				}
			})

			// 체크박스 해제
			row.checkbox.prop('checked', false);

			// 선택햇었던 코드들도 테이블에서 제거
			$("#badListRegiModal tr").each(function() {
				let tdText = $(this).find("td:nth-child(2)").text();

				if (selectedRows.some(function(row) { return row.code === tdText; })) {
					$(this).empty();
				}
			});


		});

		// selectedRows 배열 초기화
		console.log("selectedRows after deletion", selectedRows);
	}
}


//선택된 불량코드를 다른 테이블로 이동
function moveSelectedBad() {
	$('.badListTbody').empty();
	$('#badModal').modal('hide');

	// selectedRows 배열을 순회하며 tbody에 항목을 추가
	$.each(selectedRows, function(index, row) {
		var trTag = $('<tr></tr>');
		trTag.append('<th scope="row">' + (index + 1) + '</th>'); // 인덱스를 1부터 시작하도록 설정
		trTag.append('<td>' + row.code + '<input type="hidden" name="jpriBadList[' + index + '].bad_cd" value="' + row.code + '"></td>');
		trTag.append('<td>' + row.res + '</td>');
		$('.badListTbody').append(trTag);
	});
}



// 기타 버튼을 눌렀을 때 불량 코드를 추가하는 함수
function submitBadModal() {
	if ($('#badCdBadModal').val() === "" || $('#badResBadModal').val() === "") {
		alert("코드와 내역을 입력해주세요");
	} else {
		let result = confirm("코드를 추가 하시겠습니까? 코드를 다시 한번 확인해주세요");
		if (result) {
			// 대문자로 입력되도록 설정
			let data = {
				bad_cd: $('#badCdBadModal').val().toUpperCase(),
				bad_res: $('#badResBadModal').val()
			};

			$.ajax({
				url: 'submitBadModal',
				method: 'POST',
				data,
				success: function() {
					alert('불량코드 추가 성공');
					$("#badCdBadModal").val("");
					$("#badResBadModal").val("");

				},//sucess
				error: function(xhr, status, error) {
					console.error("Error occurred: " + error);
				}
			}); // ajax
		}
	}
}

//paging
function goPage(currentPage) {

	changeData("currentPage", currentPage)

	console.log("currentPage", currentPage);
	console.log("data.currentPage", data.currentPage);

	getPriListAjax(currentPage);
}

//paging
function nextPage(ele) {
	if (data.currentPage == ele.dataset.totalPage) {
		alert('마지막 페이지 입니다.')

	} else {

		data.currentPage = data.currentPage * 1 + 1;

		console.log("currentPage", currentPage);
		console.log("data.currentPage", data.currentPage);

		getPriListAjax(data.currentPage);
	}
}
//paging
function prevPage() {
	if (data.currentPage == 1) {
		alert('첫번째 페이지 입니다.');
	} else {

		data.currentPage = data.currentPage * 1 - 1;

		console.log("currentPage", currentPage);
		console.log("data.currentPage", data.currentPage);

		getPriListAjax(data.currentPage);
	}
}

//천단위마다 컴마찍게 해주는 함수
function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//등록폼 유효성검사
function validateRegiForm() {
	// 입력 필드의 값 검사
	var workProdNo = $("#workProdNoRegiModal").text().trim();
	var workStartDate = $("#workStartDateRegiModal").val().trim();
	var prodItemWH = $("#prodItemWHRegiModal").text().trim().replace(/\s+/g, '');
	console.log('prodItemWH', prodItemWH);
	var itemName = $("#itemNameRegiModal").val().trim();
	var expectedQty = $("#expectedQtyRegiModal").val().trim();
	var actualQty = $("#actualQtyRegiModal").val().trim();
	var defectiveQty = $("#defectiveQtyRegiModal").val().trim();

	// 빈 값 확인
	if (workProdNo === "" || workStartDate === "" || prodItemWH === "제품을넣어둘창고를선택" || itemName === "" || expectedQty === "" || actualQty === "" || defectiveQty === "") {
		alert(" 생산 지시 번호와 창고를 선택하고 필수 입력 필드를 채워주세요.");
		return false; // 폼 제출 방지
	}

	return true;
}
