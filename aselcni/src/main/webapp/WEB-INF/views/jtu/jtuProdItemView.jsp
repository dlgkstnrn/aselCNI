<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>스마트 제조 시스템</title>

<!-- Favicons -->
<link href="assets/img/favicon.png" rel="icon">

<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet"
>

<!-- Vendor CSS Files -->
<link href="assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet"
>
<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet"
>
<link href="assets/vendor/boxicons/css/boxicons.min.css"
	rel="stylesheet"
>
<link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
<link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

<!-- CSS File -->
<link href="assets/css/style.css" rel="stylesheet" type="text/css">
<link href="assets/css/jtu/jtuProdItemView.css" rel="stylesheet"
	type="text/css"
>

<!-- Script -->
<script defer src="assets/js/main.js"></script>
<script src="https://kit.fontawesome.com/0b22ed6a9d.js"
	crossorigin="anonymous"
></script>
<script src="assets/js/jquery-3.7.1.min.js"></script>

<script type="text/javascript">
	let startDate = $('#startDate').val();
	let endDate = $('#endDate').val();
	const data = {
		startDate,
		endDate
	}


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
		// expectedQty, actualQty 값이 변경될 때마다 defectiveQty를 업데이트
		$(expQty + ", " + actQty).on("input",
						function() {
							let expectedQty = parseInt($(expQty)
									.val()) || 0;
							let actualQty = parseInt($(actQty).val()) || 0;
							let defectiveQty = expectedQty - actualQty;
							$(defQty).val(defectiveQty);
						});

		// defectiveQty 값이 변경될 때마다 actualQty를 업데이트
		$(defQty).on("input", function() {
			let expectedQty = parseInt($(expQty).val()) || 0;
			let defectiveQty = parseInt($(this).val()) || 0;
			let actualQty = expectedQty - defectiveQty;
			$(actQty).val(actualQty);
		});
	}

	
	//닫기 버튼 클릭시 modal 입력 내용 클리어
	$(document).ready(function() {
		$('button[data-bs-dismiss="modal"]').on('click', function() {
			modalContentClear();
		});
	});
	
	//클리어 함수
	function modalContentClear() {
		$('#workProdNoRegiModal').text("생산 지시 번호를 선택");
		$(".modal-content input").val('');
		$(".modal-content textarea").val('');
	}

	
	//dropdown 기능 
	$(document).ready(function() {
		$('#workProdNoEditModal').dropdown();
		$('#workProdNoRegiModal').dropdown();
		$('#prodItemWHRegiModal').dropdown();

		//조회 테이블 행 클릭시 modal 수정창으로 이동 
		$('tr[data-bs-toggle="modal"]').on('click', function() {
			let prodNo = $(this).find('td:nth-child(2)').text();
			$('#workProdNoEditModal').val(prodNo);
		});
	});

	//로딩시 날짜 설정
	$(document).ready(function() {
		inputToday("#startDate");
		
		startDate = $('#startDate').val();
		endDate = $('#endDate').val();
		
		let startDt = new Date(startDate);
		let endDt = new Date(startDate);
		
		endDt.setDate(startDt.getDate()+7);
		
		endDate = endDt.toISOString().slice(0,10);
		$('#endDate').val(endDate);
		
		console.log("endDt",endDt);
		console.log("endDate",endDate);
		
		//시작 날짜와 종료 날짜 논리 일관성
		$('#startDate').on('change', function() {
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
		});
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
	
	
	//생산 지시번호를 선택하면 리스트 불러오고, 자동 텍스트 입력
	$(document).ready(function() {
	    $("#workProdNoRegiModal").click(function() {
	        $.ajax({
	            url : 'getWorkProdNoRegiModalList',
	            method : 'POST',
	            dataType : 'json',
	            success : function(wprList) {
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
	                    liTag.append(aTag); // <a> 태그를 <li> 태그에 추가
	                    ulTag.append(liTag); // 완성된 <li> 태그를 <ul> 태그에 추가
	                });//each
                    
        			$('#workProdNoRegiModalList a').on('click', function() {
        				let selectedValue = $(this).attr('data-value');
        				let foundWpr = wprList.find(wpr => wpr.workprod_no == selectedValue);
        				console.log("foundWpr", foundWpr);
        				$('#workProdNoRegiModal').text(selectedValue);
        				$('#hiddenWorkProdNoRegiModal').val(selectedValue);
        				
        				//let wprDate= new Date(foundWpr.workprod_dt);
        				//wprDate.setDate(wprDate.getDate() + foundWpr.work_dt);
       				    //let prodEndDate = wprDate.toISOString().slice(0, 10);
       				    $('#workStartDateRegiModal').val(foundWpr.workprod_dt);
       				    
       				    $('#hiddenItemCdRegiModal').val(foundWpr.item_cd);
       				    $('#itemNameRegiModal').val(foundWpr.item_nm+"("+foundWpr.item_cd+")");
       				    
       				    $('#expectedQtyRegiModal').val(foundWpr.qty);
       				    
        				
        			});
	            },//success
	            error : function(xhr, status, error) {
	            }
	        });//ajax
	       
	    });
	});
	

	//등록버튼 눌렀을때
	$(document).ready(function() {
	    $("#regiModalBtn").click(function() {
	    	//오늘날짜
	    	inputToday("#prodEndDateRegiModal",);
	    	
	    	//창고 리스트 RegiModal에 넣어줌
	    	getWHMstListRegiModalList();
	    })
	})
	
	//오늘 날짜 넣어주는 함수
	function inputToday(tagId){
		let todayLong= new Date();
		let today = todayLong.toISOString().slice(0,10)
		
/* 		let offset = new Date().getTimezoneOffset() * 60000;
		$(tagId).val(new Date(Date.now() - offset).toISOString().substring(0, 10)); */
		
		$(tagId).val(today);
	}
	
	//창고 리스트 RegiModal에 넣는 함수
	function getWHMstListRegiModalList() {
		$("#prodItemWHList").find("li").remove();
        $.ajax({
            url: 'getWHMstListRegiModalList',
            method: 'POST',
            dataType: 'json',
            success: function(whList) {
            	console.log("whList", whList);
                let ulTag = $('#prodItemWHList'); 
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
                });//each
                
                $("#prodItemWHList a").click(function(){
                    $("#prodItemWHRegiModal").text($(this).text());
                    $("#hiddenProdItemWHCdRegiModal").val($(this).data('val'));
                    
                    console.log("hiddenProdItemWHCdRegiModal", $("#hiddenProdItemWHCdRegiModal").val());
                });
            },
            error : function(xhr, status, error) {
            }
        });//ajax
   	}
	

	
	function getPriListAjax(){
		data.startDate = $('#startDate').val();
		data.endDate = $('#endDate').val();

		console.log("data.startDate", data.startDate);
		console.log("data.endDate", data.endDate);

		$.ajax({
			url : "getPriListAjax",
			method : "POST",
			data,
			dataType : "json",
			success : function(priList){
	            let tbody = $("#prodItemTbody");
	            // 기존 tbody 내용을 비웁니다.
	            tbody.empty();
	            // 받은 데이터로 새로운 내용을 생성합니다.
	            $.each(priList, function(index, pri) {
	                // 예시로 item 객체의 일부 속성을 사용합니다.
	                // 실제 속성 이름은 priList의 객체 구조에 따라 다를 수 있습니다.
	                tbody.append(
	                    '<tr data-bs-toggle="modal" data-bs-target="#prodItemEditModal">' +
	                    '<th scope="row">' + pri.proditem_end_dt + '</th>' +
	                    '<td>' + pri.workprod_no + '</td>' +
	                    '<td>' + pri.item_nm + '</td>' +
	                    '<td>' + pri.pln_qty + '</td>' +
	                    '<td>' + pri.bad_qty + '</td>' +
	                    '</tr>'
	                );
	            });
				
			},//success
            error : function(xhr, status, error) {
            }
		});//ajax
	}

</script>


</head>

<body>

	<!-- ======= Header ======= -->
	<%@ include file="../header.jsp"%>

	<!-- ======= Sidebar ======= -->
	<%@ include file="../asidebar.jsp"%>

	<!-- End Sidebar-->

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>생산 실적 조회</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="#">생산 관리</a></li>
					<li class="breadcrumb-item active">생산 실적 조회</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->
		<div class="card">
			<section class="section dashboard">



				<!--등록  버튼  -->

				<div class="col-sm-1 text-end" style="margin-left: auto;">
					<button id="tempBtn" type="button"
						onclick="getPriListAjax()"
						class="btn btn-outline-primary" 
					>임시</button>
					<button id="regiModalBtn" type="button"
						class="btn btn-outline-primary" data-bs-toggle="modal"
						data-bs-target="#workProdRegiModal"
					>등록</button>
				</div>




				<div
					style="display: flex; align-items: center; justify-content: center; gap: 20px; margin: 20px 50px;"
				>

					<button id="dateLeftBtn" type="button" class="btn btn-primary">
						<i class="bi bi-caret-left-fill"></i>
					</button>
					<div>
						<label for="start"></label> <input type="date"
							class="prodItemDate" id="startDate" 
						>&nbsp;&nbsp;~&nbsp;&nbsp;<label for="end"></label> <input
							type="date" class="prodItemDate" id="endDate" 
						>
					</div>

					<button id="dateRightBtn" type="button" class="btn btn-primary">
						<i class="bi bi-caret-right-fill"></i>
					</button>
				</div>
				
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col">생산 완료 일자</th>
							<th scope="col">등록된 생산 지시 번호</th>
							<th scope="col">제품명</th>
							<th scope="col">예정 수량</th>
							<th scope="col">불량 수량</th>
						</tr>
					</thead>
					<c:forEach var="pri" items="${jpriList}">
					<tbody id ="prodItemTbody" >
						<tr data-bs-toggle="modal" data-bs-target="#prodItemEditModal">
							<th scope="row">${pri.proditem_end_dt}</th>
							<td>${pri.workprod_no}</td>
							<td>${pri.item_nm} (${pri.item_cd})</td>
							<td>${pri.pln_qty}</td>
							<td>${pri.bad_qty}</td>
						</tr>
					</tbody>
					</c:forEach>
				</table>



				<!-- Start workProdRegiModal ----m1-->
				<div class="modal fade" id="workProdRegiModal" tabindex="-1"
					style="display: none;" aria-hidden="true"
				>
					<div class="modal-dialog modal-dialog-centered modal-xl">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title">생산 실적 등록</h1>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"
								></button>
							</div>
							<div class="modal-body">

								<!-- Start modal body -->
								<form id=workProdRegiForm action="submitWorkProdNoRegiModal">

									<div class="row mb-3">
										<label class="col-sm-2 col-form-label label-marquee"><span
											class="moving-text"
										>생산 지시 번호</span></label>
										<div class="d-flex justify-content-between col-sm-10">

											<button
												class="btn btn-secondary dropdown-toggle col-sm-4 label-marquee"
												type="button" id="workProdNoRegiModal"
												data-bs-toggle="dropdown" aria-haspopup="true"
												aria-expanded="false"
											>
												<span class="moving-text">생산 지시 번호 선택</span>
											</button>
											<input id="hiddenWorkProdNoRegiModal" type="hidden"
												name="workprod_no"
											>
											<ul id="workProdNoRegiModalList"
												class="dropdown-menu col-sm-3"
												aria-labelledby="workProdNoRegiModal"
											>
											</ul>

											<label for="workStartDateRegiModal"
												class="col-sm-2 col-form-label text-end label-marquee"
											><span class="moving-text">생산 지시 일자</span></label>
											<div class="col-sm-5">
												<input id="workStartDateRegiModal" type="date"
													class="form-control" value="2024-04-01" required readonly
												>
											</div>

										</div>
									</div>

									<div class="row mb-3">
										<label for="empRegiModal"
											class="col-sm-2 col-form-label label-marquee"
										> <span class="moving-text">생산 실적 담당자</span></label>
										<div class="d-flex justify-content-between col-sm-10">
											<div class="col-sm-4">
												<input id="empRegiModal" type="text" class="form-control"
													name="proditem_emp_id" value="jtu" readonly
												>
											</div>


											<label for="prodEndDateRegiModal"
												class="col-sm-2 col-form-label text-end label-marquee"
											> <span class="moving-text">생산 완료 일자</span>
											</label>
											<div class="col-sm-5">
												<input id="prodEndDateRegiModal" type="date"
													name="proditem_end_dt" class="form-control" required
												>
											</div>
										</div>
									</div>


									<div class="row mb-3">
										<label for="prodItemWHRegiModal"
											class="col-sm-2 col-form-label label-marquee"
										><span class="moving-text">입고 창고 이름</span></label>
										<div class="col-sm-10">
											<input id="hiddenProdItemWHCdRegiModal" type="hidden"
												name="wh_cd" class="form-control" value="WHS2404020001"
											>
											<button
												class="btn btn-secondary dropdown-toggle col-sm-12 label-marquee"
												type="button" id="prodItemWHRegiModal"
												data-bs-toggle="dropdown" aria-haspopup="true"
												aria-expanded="false"
											>
												<span class="moving-text moving-animation">제품을 넣어둘
													창고를 선택</span>
											</button>
											<ul id="prodItemWHList" class="dropdown-menu col-sm-9"
												aria-labelledby="prodItemWHRegiModal"
											>
											</ul>

										</div>
									</div>


									<div class="row mb-3">
										<label for="itemNameRegiModal" class="col-sm-2 col-form-label">제품명</label>

										<div class="d-flex justify-content-between col-sm-10">
											<div class="col-sm-4">
												<input id="hiddenItemCdRegiModal" type="hidden"
													name="item_cd" class="form-control" value="buldak001"
												> <input id="itemNameRegiModal" type="text"
													class="form-control" value="붉닭라면(buldak001)" readonly
												>
											</div>


											<label for="expectedQtyRegiModal"
												class="col-sm-2 col-form-label text-end label-marquee"
											><span class="moving-text">예정 생산 수량</span></label>
											<div class="col-sm-5">
												<input id="expectedQtyRegiModal" type="number"
													name="pln_qty" class="form-control" readonly value="50000"
												>
											</div>
										</div>
									</div>

									<div class="row mb-3">
										<label for="actualQtyRegiModal"
											class="col-sm-2 col-form-label label-marquee"
										><span class="moving-text">실제 생산 수량</span></label>

										<div class="d-flex justify-content-between col-sm-10">
											<div class="col-sm-4">
												<input id="actualQtyRegiModal" type="number" name="prod_qty"
													class="form-control" required value="49990"
												>
											</div>
											<label for="defectiveQtyRegiModal"
												class="col-sm-2 col-form-label text-end label-marquee"
											><span class="moving-text">불량 생산 수량</span></label>
											<div class="col-sm-5">
												<input id="defectiveQtyRegiModal" type="number"
													name="bad_qty" class="form-control" required
												>
											</div>
										</div>
									</div>

									<div class="row mb-3">
										<label for="defectiveLogRegiModal"
											class="col-sm-2 col-form-label"
										><span class="moving-text">불량 내역</span></label>
										<div class="col-sm-10">
											<textarea id="defectiveLogRegiModal" class="form-control"
												name="bad_res" style="height: 100px"
											>불닭이 너무매움</textarea>
										</div>
									</div>

									<div class="row mb-3">
										<label for="remarkRegiModal" class="col-sm-2 col-form-label">비고</label>
										<div class="col-sm-10">
											<textarea id="remarkRegiModal" class="form-control"
												name="remark" style="height: 100px"
											>비고 비었음</textarea>
										</div>
									</div>

								</form>

							</div>
							<!-- End modal body -->

							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal"
								>닫기</button>
								<button type="submit" form="workProdRegiForm"
									class="btn btn-primary"
								>등록</button>
							</div>
						</div>
					</div>
				</div>
				<!-- End modal -->




				<!-- Start prodItemEditModal------------m2-------------------->
				<div class="modal fade" id="prodItemEditModal" tabindex="-1"
					style="display: none;" aria-hidden="true"
				>
					<div class="modal-dialog modal-dialog-centered modal-xl">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title">생산 실적 상세</h1>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"
								></button>
							</div>
							<div class="modal-body">

								<!-- Start modal body -->
								<form>
									<div class="row mb-3">
										<label class="col-sm-2 col-form-label label-marquee"><span
											class="moving-text"
										>생산 지시 번호</span></label>
										<div class="d-flex justify-content-between col-sm-10">
											<div class="col-sm-4">
												<input type="text" class="form-control"
													id="workProdNoEditModal" value="생산 지시 번호" readonly
												>
											</div>

											<label for="prodEndDateEditModal"
												class="col-sm-2 col-form-label text-end label-marquee"
											><span class="moving-text">생산 완료 일자</span></label>
											<div class="col-sm-5">
												<input id="prodEndDateEditModal" type="date"
													class="form-control" value="2024-04-12" required
												>
											</div>

										</div>
									</div>

									<div class="row mb-3">
										<label for="empEditModal"
											class="col-sm-2 col-form-label label-marquee"
										> <span class="moving-text">생산 실적 담당자</span></label>
										<div class="d-flex justify-content-between col-sm-10">
											<div class="col-sm-4">
												<input id="empEditModal" type="text" class="form-control"
													value="김씨(kim)" readonly
												>
											</div>


											<label for="modifyDateEditModal"
												class="col-sm-2 col-form-label text-end label-marquee"
											> <span class="moving-text">생산 실적 등록일</span>
											</label>
											<div class="col-sm-5">
												<input id="modifyDateEditModal" type="date"
													class="form-control" value="2024-04-15" readonly
												>
											</div>
										</div>
									</div>


									<div class="row mb-3">
										<label for="prodItemWHEditModal"
											class="col-sm-2 col-form-label label-marquee"
										><span class="moving-text">입고 창고 이름</span></label>
										<div class="col-sm-10">
											<input id="prodItemWHEditModal" type="text"
												class="form-control" readonly
												value="서울특별시 마포구 신촌로 176 창고(CAWH01)"
											>
										</div>
									</div>


									<div class="row mb-3">
										<label for="itemNameEditModal" class="col-sm-2 col-form-label">제품명</label>

										<div class="d-flex justify-content-between col-sm-10">
											<div class="col-sm-4">
												<input id="itemNameEditModal" type="text"
													class="form-control" value="붉닭라면(buldak001)" readonly
												>
											</div>


											<label for="expectedQtyEditModal"
												class="col-sm-2 col-form-label text-end label-marquee"
											><span class="moving-text">예정 생산 수량</span></label>
											<div class="col-sm-5">
												<input id="expectedQtyEditModal" type="number"
													class="form-control" readonly value="50000"
												>
											</div>
										</div>
									</div>

									<div class="row mb-3">
										<label for="actualQtyEditModal"
											class="col-sm-2 col-form-label label-marquee"
										><span class="moving-text">실제 생산 수량</span></label>

										<div class="d-flex justify-content-between col-sm-10">
											<div class="col-sm-4">
												<input id="actualQtyEditModal" type="number"
													class="form-control" required value="49990"
												>
											</div>
											<label for="defectiveQtyEditModal"
												class="col-sm-2 col-form-label text-end label-marquee"
											><span class="moving-text">불량 생산 수량</span></label>
											<div class="col-sm-5">
												<input id="defectiveQtyEditModal" type="number"
													class="form-control" required
												>
											</div>
										</div>
									</div>

									<div class="row mb-3">
										<label for="defectiveLogEditModal"
											class="col-sm-2 col-form-label"
										><span class="moving-text">불량 내역</span></label>
										<div class="col-sm-10">
											<textarea id="defectiveLogEditModal" class="form-control"
												style="height: 100px"
											>불닭이 너무매움</textarea>
										</div>
									</div>

									<div class="row mb-3">
										<label for="remarkEditModal" class="col-sm-2 col-form-label">비고</label>
										<div class="col-sm-10">
											<textarea id="remarkEditModal" class="form-control"
												style="height: 100px"
											>비고 비었음</textarea>
										</div>
									</div>

								</form>

							</div>
							<!-- End modal body -->

							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal"
								>닫기</button>
								<button type="button" class="btn btn-primary">삭제</button>
								<button type="button" class="btn btn-primary">수정</button>
							</div>
						</div>
					</div>
				</div>
				<!-- End modal -->


			</section>
		</div>
	</main>
	<!-- End #main -->

	<!-- ======= Footer ======= -->
	<%@ include file="../footer.jsp"%>
	<!-- End Footer -->

	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"
	><i class="bi bi-arrow-up-short"></i></a>

	<!-- Vendor JS Files -->
	<script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
	<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="assets/vendor/chart.js/chart.umd.js"></script>
	<script src="assets/vendor/echarts/echarts.min.js"></script>
	<script src="assets/vendor/quill/quill.min.js"></script>
	<script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
	<script src="assets/vendor/tinymce/tinymce.min.js"></script>
	<script src="assets/vendor/php-email-form/validate.js"></script>


</body>

</html>