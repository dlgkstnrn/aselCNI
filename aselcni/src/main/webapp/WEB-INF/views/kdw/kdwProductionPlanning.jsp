<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
<link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
<link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">
<!-- 제이쿼리에 의존하는 JS들이 있기 때문에 상단에 위치 해야함 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 제이쿼리 UI(컬러피커에 사용) -->
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- 주문선택 데이트피커 라이브러리 css, js, locale(한글)-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"></script>

<!-- 셀렉트박스에 Select2 CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
<!-- Select2 JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

<!-- CSS File -->
<link href="assets/css/style.css" rel="stylesheet" type="text/css">

<!-- Script -->
<script defer src="assets/js/main.js"></script>
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/b798aa0b92.js" crossorigin="anonymous"></script>
<!-- 풀캘린더 API -->
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js"></script>
<!-- KDW Main CSS,JS,Script -->
<script src="assets/js/kdw/kdwProductionPlanning.js"></script>
<link href="assets/css/kdw/kdwProductionPlanning.css" rel="stylesheet">
</head>

<body>

	<!-- ======= Header ======= -->
	<%@ include file="../header.jsp"%>

	<!-- ======= Sidebar ======= -->
	<%@ include file="../asidebar.jsp"%>
	<script>
	    var currentUserNm = "${sessionScope.user_nm}";
	</script>
	<!-- End Sidebar-->

	<main id="main" class="main">
		<!-- Page Title -->
		<div class="pagetitle">
			<h1>생산 관리</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item">생산
							관리</li>
					<li class="breadcrumb-item active">생산 계획</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<div class="card">
			<section class="section-prodPlan">
				<div class="form-container">
					<form id="productionPlanning-form" action="/prodplan" method="get">
						<div class="calendar-group-title">
							<span class="calendar-group-title-text">생산 계획</span>
						</div>
						<div class="btn-container">
							<div class="prodPlan-read">
							    <button type="button" class="btn btn-secondary" id="readButton">
							    	상세
							    </button>
							</div>
							<div class="prodPlan-write">
								<button type="button" class="btn btn-secondary"
									data-bs-toggle="modal" data-bs-target="#verticalycentered">
									신규
								</button>
							</div>
							<div class="prodPlan-update">
							    <button type="button" class="btn btn-secondary" id="updateButton">
							    	수정
							    </button>
							</div>
						    <div class="prodPlan-delete">
						        <button type="button" class="pboard-write-Btn btn btn-secondary" id="deleteEventButton">
							        삭제
						        </button>
						    </div>
						</div>
						<!-- Modal -->
						<div class="prodPlan-modal">
							<div class="modal fade" id="verticalycentered" tabindex="-1"
								style="display: none;" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered insert-modal-css">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title"
												style="font-weight: 700; margin-top: 10px;">생산 계획 등록</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<div class="row mb-3 oderCode">
												<label for="oderCodeInput" class="col-sm-2 col-form-label">주문번호
													<span class="text-danger">*</span>
												</label>
												<div class="col-sm-5">
													<input type="text" id="prodPlanNoInput"
														class="form-control oderCodeInput" readonly>
												</div>
												<!-- 주문번호 선택 버튼 -->
												<div class="col-sm-2">
													<button type="button"
														class="btn btn-primary OderCodeSelect"
														data-bs-toggle="modal" data-bs-target="#oderModal">주문선택</button>
												</div>
												<!-- 작업일수 -->
												<label for="prodPlanWorkingDaysInput"
													class="col-sm-2 col-form-label prodPlanWorkingDaysLabel">작업일수
													<span class="text-danger">*</span>
												</label>
												<div class="col-sm-1 prodPlanWorkingDays">
													<input type="number"
														class="form-control prodPlanWorkingDaysInput"
														id="prodPlanWorkingDaysInput" min="-99999" max="99999">
												</div>
											</div>
											<div class="row mb-3">
												<label for="inputDate" class="col-sm-2 col-form-label">시작예정일자
													<span class="text-danger">*</span>
												</label>
												<div class="col-sm-7">
													<input type="date"
														class="form-control productStartDateInput">
												</div>
												<label for="productEmp" class="col-sm-2 col-form-label productEmpLabel">담당자</label>
												<div class="col-sm-1">
													<input type="text" class="form-control productEmpInput"
														id="productEmp" name="prodplan_emp_id"
														value="${sessionScope.user_nm }" readonly>
													<!-- 헤더부분 세션값 가져옴 -->
												</div>
											</div>
											<div class="row mb-3">
												<label for="inputDate" class="col-sm-2 col-form-label">완료예정일자
													<span class="text-danger">*</span>
												</label>
												<div class="col-sm-5">
													<input type="date" class="form-control productEndDateInput">
												</div>
												<!-- 생산수량 입력 필드 -->
												<label for="productionQuantity"
													class="col-sm-4 col-form-label prodCount">생산수량
													<span class="text-danger">*</span>
												</label>
												<div class="col-sm-1 prodCount-input-class">
													<input type="number" class="form-control prodCount-input"
														id="productionQuantity" min="-99999" max="99999">
												</div>
											</div>
											<!-- 제품 -->
											<div class="row mb-3">
												<label for="productName" class="col-sm-2 col-form-label">제품명
													<span class="text-danger">*</span>
												</label>
												<div class="col-sm-8">
													<input type="text" class="form-control productNameInput"
														id="productName" readonly>
												</div>
												<!-- 품목선택 버튼 -->
												<div class="col-sm-2">
													<button type="button" class="btn btn-primary productSelect"
														data-bs-toggle="modal" data-bs-target="#nestedModal">품목선택</button>
												</div>
											</div>
											<!-- 투입자재 -->
											<div class="productItem-container">
												<div class="row mb-2">
													<label for="productItemName"
														class="col-sm-2 col-form-label">투입자재
														<span class="text-danger">*</span>
													</label>
													<div class="col-sm-10">
														<button type="button"
															class="btn btn-primary productItemSelect"
															data-bs-toggle="modal" data-bs-target="#nestedItemModal">품목선택</button>
													</div>
												</div>
												<!-- 입력 필드 -->
												<div class="row mb-3">
													<div class="col-sm-12">
														<div id="select_zone" class="prodItem">
															<!-- 초기 안내 문구 -->
															<div id="initial_message"
																style="margin-top: 60px; color: #6c757d; font-weight: 700;">
																투입품을 선택해 주세요.</div>
															<!-- 선택된 자재 목록 상단 바, 자재가 선택되면 표시 -->
															<div id="prodItem-bar" class="prodItem-bar"
																style="display: none;">
																<span id="delete_all" style="cursor: pointer;">X</span>
																<span>투입자재</span> <span>수량</span>
															</div>
															<!-- 선택된 자재 목록 -->
															<ul id="prodItem-list" class="prodItem-list"></ul>
														</div>
													</div>
												</div>
											</div>
											<div class="row mb-3">
												<label for="inputPassword" class="col-sm-2 col-form-label">비고</label>
												<div class="col-sm-10">
													<textarea class="form-control" name="remark"
														style="min-height: 80px; max-height: 80px;"></textarea>
												</div>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">취소</button>
											<button type="submit" class="btn btn-primary" id="saveButton">저장</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- End Modal -->
						<!-- 제품 중첩 모달 -->
						<div class="modal fade" id="nestedModal" tabindex="-1"
							aria-hidden="true" style="display: none;">
							<div
								class="modal-dialog modal-dialog-centered custom-nestedModal-css">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title"
											style="font-weight: 700; margin-top: 10px;">제품 선택</h5>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<!-- 중첩 모달 내용 -->
									<div class="modal-body">
										<!-- 대분류 선택 -->
										<div class="d-flex flex-row justify-content-between">
											<!-- 대분류 선택 -->
											<div class="me-2 category">
												<label for="majorCategory1" class="form-label"
													style="font-weight: 700;">대분류</label> <select
													class="form-control select2-firstModal" id="majorCategory1">
													<!-- 대분류 옵션들 -->
												</select>
											</div>
											<!-- 중분류 선택 -->
											<div class="me-2">
												<label for="middleCategory1" class="form-label"
													style="font-weight: 700;">중분류</label> <select
													class="form-control select2-firstModal"
													id="middleCategory1">
													<!-- 중분류 옵션들 -->
												</select>
											</div>
											<!-- 소분류 선택 -->
											<div class="me-2">
												<label for="minorCategory1" class="form-label"
													style="font-weight: 700;">소분류</label> <select
													class="form-control select2-firstModal" id="minorCategory1">

													<!-- 소분류 옵션들 -->
												</select>
											</div>
										</div>
										<!-- 분류될 리스트 -->
										<div class="row category-search-list-container">
											<div class="col-12">
												<table class="table category-search-list"
													style="border-top: 1px solid #dee2e6; padding-top: 10px;">
													<thead>
														<tr>
															<th scope="col">선택</th>
															<th scope="col">제품코드</th>
															<th scope="col">제품명</th>
															<th scope="col">가격</th>
														</tr>
													</thead>
													<tbody>
														<!-- 동적으로 데이터 추가 제품은 한가지만 선택가능 해야하기 때문에 라디오사용 -->
													</tbody>
												</table>
											</div>
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal">취소</button>
										<button type="button"
											class="btn btn-primary prodplan-item-save">저장</button>
									</div>
								</div>
							</div>
						</div>
						<!-- End 제품 중첩 모달 -->
						<!-- 투입자재 중첩 모달 -->
						<div class="modal fade" id="nestedItemModal" tabindex="-1"
							aria-hidden="true" style="display: none;">
							<div
								class="modal-dialog modal-dialog-centered custom-nestedItemModal-css">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title"
											style="font-weight: 700; margin-top: 10px;">투입자재 선택</h5>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<!-- 중첩 모달 내용 -->
									<div class="modal-body">
										<!-- 대분류 선택 -->
										<div class="d-flex flex-row justify-content-between">
											<!-- 대분류 선택 -->
											<div class="me-2 prodPlanItem-category">
												<label for="majorCategory2" class="form-label"
													style="font-weight: 700;">대분류</label> <select
													class="form-control select2-secondModal"
													id="majorCategory2">
													<!-- 대분류 옵션들 -->
												</select>
											</div>
											<!-- 중분류 선택 -->
											<div class="me-2">
												<label for="middleCategory2" class="form-label"
													style="font-weight: 700;">중분류</label> <select
													class="form-control select2-secondModal"
													id="middleCategory2">
													<!-- 중분류 옵션들 -->
												</select>
											</div>
											<!-- 소분류 선택 -->
											<div class="d-flex flex-row align-items-end">
												<div class="me-2">
													<label for="minorCategory2" class="form-label"
														style="font-weight: 700;">소분류</label> <select
														class="form-control select2-secondModal"
														id="minorCategory2">
														<!-- 소분류 옵션들 -->
													</select>
												</div>
											</div>
										</div>
										<!-- 분류될 리스트 -->
										<div class="row category-search-list-container">
											<div class="col-12">
												<table class="table category-search-material-list"
													style="border-top: 1px solid #dee2e6; padding-top: 10px;">
													<thead>
														<tr>
															<th scope="col">선택</th>
															<th scope="col">자재코드</th>
															<th scope="col" class="prodPlanItem-name">자재명</th>
															<th scope="col" class="prodPlanItem-price">금액</th>
															<th scope="col">수량</th>
														</tr>
													</thead>
													<tbody>
													</tbody>
												</table>
											</div>
										</div>
									</div>
									<div class="modal-footer d-flex justify-content-between">
										<!-- 분류된 항목 개수 -->
										<div class="prodPlanItemCount d-flex">
											<label for="itemCountInput"
												class="form-label me-2 prodPlanItemCountLabel">항목 수</label>
											<input type="text" id="itemCountInput" readonly
												class="form-control prodPlanItemCountInput"
												style="width: 100px; display: inline-block;">
										</div>
										<div class="prodPlanItemTotalPrice d-flex">
											<label for="itemTotalPriceInput"
												class="form-label me-2 prodPlanItemTotalPriceLabel">합계금액</label>
											<input type="text" id="itemTotalPriceInput" readonly
												class="form-control prodPlanItemTotalPriceInput"
												style="width: 100px; display: inline-block;">
										</div>
										<div>
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">취소</button>
											<button type="button"
												class="btn btn-primary prodplan-material-save">저장</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- End 투입자재 중첩 모달 -->
						<!-- 주문번호 중첩 모달 -->
						<div class="modal fade" id="oderModal" tabindex="-1"
							aria-hidden="true" style="display: none;">
							<div
								class="modal-dialog modal-dialog-centered custom-oderModal-css modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title"
											style="font-weight: 700; margin-top: 10px;">주문번호 선택</h5>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<!-- 중첩 모달 내용 -->
									<div class="modal-body">
										<div class="input-group date" id="monthPicker">
											<input type="text" class="form-control"> 
											<span class="input-group-append"> 
												<span class="input-group-text date"> 
													<i class="fa fa-calendar" id="dateIcon"></i>
												</span>
											</span>
										</div>
										<!-- 주문번호 리스트 표시 테이블 -->
										<table class="table" id="orderListTable">
											<thead>
												<tr>
													<th>선택</th>
													<th>주문코드</th>
													<th>제품명(수량)</th>
													<th>고객사</th>
													<th>주문일자</th>
													<th>주문완료일자</th>
												</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
									<div class="modal-footer oderModal">
										<!-- 검색 필드 -->
										<div class="input-group mb-3 oderModal-search">
											<span class="input-group-text" id="basic-addon1"> 
											<i class="bi bi-search"></i>
											</span> <input type="text"
												class="form-control oderModal-search-input" id="searchInput"
												placeholder="검색어를 입력하세요" aria-label="Search"
												aria-describedby="basic-addon1">
										</div>
										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal">취소</button>
										<button type="button" class="btn btn-primary"
											id="saveOrderButton">선택</button>
									</div>
								</div>
							</div>
						</div>
						<!-- End 주문번호 중첩 모달 -->
						<!-- 수정 모달 -->
						<div class="prodPlan-modal-update">
						    <div class="modal fade" id="verticalycentered-update" tabindex="-1" style="display: none;" aria-hidden="true">
						        <div class="modal-dialog modal-dialog-centered insert-modal-css-update">
						            <div class="modal-content">
						                <div class="modal-header">
						                    <h5 class="modal-title" style="font-weight: 700; margin-top: 10px;">생산 계획 수정</h5>
						                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						                </div>
						                <div class="modal-body">
						                    <div class="row mb-3 oderCode-update">
						                        <label for="oderCodeInput-update" class="col-sm-2 col-form-label">주문번호</label>
						                        <div class="col-sm-5">
						                            <input type="text" id="prodPlanNoInput-update" class="form-control oderCodeInput-update" readonly>
						                        </div>
						                        <label for="prodPlanWorkingDaysInput-update" class="col-sm-2 col-form-label prodPlanWorkingDaysLabel-update">작업일수</label>
						                        <div class="col-sm-1 prodPlanWorkingDays-update">
						                            <input type="number" class="form-control prodPlanWorkingDaysInput-update" id="prodPlanWorkingDaysInput-update" min="-99999" max="99999">
						                        </div>
						                    </div>
						                    <div class="row mb-3">
						                        <label for="productStartDateInput-update" class="col-sm-2 col-form-label">시작예정일자</label>
						                        <div class="col-sm-7">
						                            <input type="date" class="form-control productStartDateInput-update" id="productStartDateInput-update">
						                        </div>
                        						<label for="productEmp-update" class="col-sm-2 col-form-label productEmp-update">담당자</label>
						                        <div class="col-sm-1">
						                            <input type="text" class="form-control productEmpInput-update" id="productEmp-update" name="prodplan_emp_id-update" readonly>
						                        </div>
						                    </div>
						                    <div class="row mb-3">
						                        <label for="productEndDateInput-update" class="col-sm-2 col-form-label">완료예정일자</label>
						                        <div class="col-sm-7">
						                            <input type="date" class="form-control productEndDateInput-update" id="productEndDateInput-update">
						                        </div>
						                        <label for="productionQuantity-update" class="col-sm-2 col-form-label prodCount-update">생산수량</label>
						                        <div class="col-sm-1 prodCount-input-class-update">
						                            <input type="number" class="form-control prodCount-input-update" id="productionQuantity-update" min="-99999" max="99999">
						                        </div>
						                    </div>
						                    <div class="row mb-3">
											    <label for="productName-update" class="col-sm-2 col-form-label">제품명</label>
											    <div class="col-sm-10">
											        <input type="text" class="form-control productNameInput-update" id="productName-update" readonly>
											    </div>
											</div>
						                    <div class="productItem-container-update">
						                        <div class="row mb-2">
						                        	 <label for="productItemName-update"
														class="col-sm-2 col-form-label">투입자재</label>
						                            <div class="col-sm-10">
						                                <button type="button" class="btn btn-primary productItemSelect-update" id="productItemSelect-update" 
						                                		data-bs-toggle="modal" data-bs-target="#nestedItemModal">품목선택</button>
						                            </div>
						                        </div>
						                        <div class="row mb-3">
						                            <div class="col-sm-12">
						                                <div id="select_zone-update" class="prodItem-update">
						                                    <div id="initial_message-update" style="margin-top: 60px; color: #6c757d; font-weight: 700;">
						                                        투입품을 선택해 주세요.
						                                    </div>
						                                    <div id="prodItem-bar-update" class="prodItem-bar-update" style="display: none;">
						                                        <span id="delete_all-update" style="cursor: pointer;">X</span>
						                                        <span>투입자재</span> <span>수량</span>
						                                    </div>
						                                    <ul id="prodItem-list-update" class="prodItem-list-update"></ul>
						                                </div>
						                            </div>
						                        </div>
						                    </div>
						                    <div class="row mb-3">
						                        <label for="remark-update" class="col-sm-2 col-form-label">비고</label>
						                        <div class="col-sm-10">
						                            <textarea class="form-control remark-update" id="remark-update" name="remark-update" style="min-height: 80px; max-height: 80px;"></textarea>
						                        </div>
						                    </div>
						                </div>
						                <div class="modal-footer">
						                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						                    <button type="submit" class="btn btn-primary" id="saveButton-update">저장</button>
						                </div>
						            </div>
						        </div>
						    </div>
						</div>
						<!-- End 수정 모달 -->
						<!-- 상세 모달 -->
						<div class="prodPlan-modal-read">
						    <div class="modal fade" id="verticalycentered-read" tabindex="-1" style="display: none;" aria-hidden="true">
						        <div class="modal-dialog modal-dialog-centered insert-modal-css-read">
						            <div class="modal-content">
						                <div class="modal-header">
						                    <h5 class="modal-title" style="font-weight: 700; margin-top: 10px;">생산 계획 상세</h5>
						                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						                </div>
						                <div class="modal-body">
						                    <div class="row mb-3 oderCode-read">
						                        <label for="oderCodeInput-read" class="col-sm-2 col-form-label">주문번호</label>
						                        <div class="col-sm-5">
						                            <input type="text" id="prodPlanNoInput-read" class="form-control oderCodeInput-read" readonly>
						                        </div>
						                        <label for="prodPlanWorkingDaysInput-read" class="col-sm-2 col-form-label prodPlanWorkingDaysLabel-read">작업일수</label>
						                        <div class="col-sm-1 prodPlanWorkingDays-read">
						                            <input type="text" class="form-control prodPlanWorkingDaysInput-read" id="prodPlanWorkingDaysInput-read" min="-99999" max="99999" readonly>
						                        </div>
						                    </div>
						                    <div class="row mb-3">
						                        <label for="productStartDateInput-read" class="col-sm-2 col-form-label">시작예정일자</label>
						                        <div class="col-sm-7">
						                            <input type="date" class="form-control productStartDateInput-read" id="productStartDateInput-read" readonly>
						                        </div>
						                        <label for="productEmp-read" class="col-sm-2 col-form-label productEmp-read">담당자</label>
						                        <div class="col-sm-1">
						                            <input type="text" class="form-control productEmpInput-read" id="productEmp-read" name="prodplan_emp_id-read" readonly>
						                        </div>
						                    </div>
						                    <div class="row mb-3">
						                        <label for="productEndDateInput-read" class="col-sm-2 col-form-label">완료예정일자</label>
						                        <div class="col-sm-7">
						                            <input type="date" class="form-control productEndDateInput-read" id="productEndDateInput-read" readonly>
						                        </div>
						                        <label for="productionQuantity-read" class="col-sm-2 col-form-label prodCount-read">생산수량</label>
						                        <div class="col-sm-1 prodCount-input-class-read">
						                            <input type="text" class="form-control prodCount-input-read" id="productionQuantity-read" min="-99999" max="99999" readonly>
						                        </div>
						                    </div>
						                    <div class="row mb-3">
						                        <label for="productName-read" class="col-sm-2 col-form-label">제품명</label>
						                        <div class="col-sm-10">
						                            <input type="text" class="form-control productNameInput-read" id="productName-read" readonly>
						                        </div>
						                    </div>
						                    <div class="productItem-container-read">
						                        <div class="row mb-3">
						                             <label for="productItemName-read"
						                                class="col-sm-2 col-form-label">투입자재
						                             </label>
							                        <div class="col-sm-10">
							                            <div id="select_zone-read" class="prodItem-read">
							                                <div id="prodItem-bar-read" class="prodItem-bar-read">
							                                    <span id="delete_all-read" style="cursor: pointer;">#</span>
							                                    <span>투입자재</span> <span>수량</span>
							                                </div>
							                                <ul id="prodItem-list-read" class="prodItem-list-read"></ul>
							                            </div>
							                        </div>
						                        </div>
						                    </div>
						                    <div class="row mb-3">
						                        <label for="remark-read" class="col-sm-2 col-form-label">비고</label>
						                        <div class="col-sm-10">
						                            <textarea class="form-control remark-read" id="remark-read" name="remark-read" style="min-height: 120px; max-height: 120px;" readonly></textarea>
						                        </div>
						                    </div>
						                </div>
						                <div class="modal-footer">
						                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
						                </div>
						            </div>
						        </div>
						    </div>
						</div>
						<!-- End 상세 모달 -->
						<!-- Calendar -->
						<div class="calendar-group">
							<div id='calendar'></div>
							<!-- 주문내역 & 생산계획 리스트 -->
							<div class="prodPlan-info">
								<div class="referenceDate-group">
									<div class="referenceDate-prepend-text">기준일자</div>
									<div class="referenceDate"></div>
								</div>
								<div class="orderDetails-info">
									<div id='orderList-group'>
										<div class="orderList-title">주문내역</div>
										<table class="orderList-table">
											<thead>
												<tr>
													<th>고객사</th>
													<th>제품명</th>
													<th>수 량</th>
												</tr>
											</thead>
											<tbody class="orderList-item">
											</tbody>
										</table>
									</div>
								</div>
								<div class="prodPlanDetails-info">
									<div id='prodPlanList-group'>
										<div class="prodPlanList-title">생산계획</div>
										<table class="prodPlanList-table">
											<thead>
												<tr>
													<th>제품명</th>
													<th>수 량</th>
													<th>작업일수</th>
												</tr>
											</thead>
											<tbody class="prodPlanList-item">
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<!-- End 주문내역 & 생산계획 리스트 -->
						</div>
						<div class="colorPicker-group">
							<!-- 캘린더 각 이벤트 컬러피커 -->
							<div id="colorPickerDialog" title="색상 선택">
								<input type="color" id="eventColorPicker">
							</div>
							<button id="changeColorButton"
								class="btn btn-primary colorPicker-btn">색상변경</button>
						</div>
						<!-- 스위치 토글 버튼 -->
						<div class="form-check form-switch tooltip-switch-container">
							<label class="form-check-label" for="flexSwitchCheckChecked">
							툴 팁</label> 
							<input class="form-check-input" type="checkbox" id="flexSwitchCheckChecked" checked>
						</div>
						<!-- End Calendar -->
					</form>
				</div>
			</section>
		</div>
	</main>
	<!-- End #main -->

	<!-- ======= Footer ======= -->
	<%@ include file="../footer.jsp"%>
	<!-- End Footer -->

	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

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