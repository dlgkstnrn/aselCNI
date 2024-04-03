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
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link href="assets/vendor/boxicons/css/boxicons.min.css"
	rel="stylesheet">
<link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
<link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">
<!-- 제이쿼리에 의존하는 JS들이 있기 때문에 상단에 위치 해야함 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 제이쿼리 UI(컬러피커에 사용) -->
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- 셀렉트박스에 Select2 CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
<!-- Select2 JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

<!-- CSS File -->
<link href="assets/css/style.css" rel="stylesheet" type="text/css">

<!-- Script -->
<script defer src="assets/js/main.js"></script>
<script src="https://kit.fontawesome.com/0b22ed6a9d.js"
	crossorigin="anonymous"></script>
<!-- 풀캘린더 API -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js"></script>
<!-- KDW Main CSS,JS,Script -->
<script src="assets/js/kdw/kdwProductionPlanning.js"></script>
<link href="assets/css/kdw/kdwProductionPlanning.css" rel="stylesheet">
</head>

<body>

	<!-- ======= Header ======= -->
	<%@ include file="../header.jsp"%>

	<!-- ======= Sidebar ======= -->
	<%@ include file="../asidebar.jsp"%>

	<!-- End Sidebar-->

	<main id="main" class="main">
		<!-- Page Title -->
		<div class="pagetitle">
			<h1>생산 계획</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item">
						<a href="productionPlanning">생산 관리</a>
					</li>
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
							<span class="calendar-group-title-text">생산계획표</span>
						</div>
						<div class="btn-container">
							<div class="prodPlan-write">
								<button type="button" class="btn btn-secondary"
									data-bs-toggle="modal" data-bs-target="#verticalycentered">
									등록</button>
							</div>
							<div class="prodPlan-update">
								<a href="/prodPlanUpdate"
									class="pboard-write-Btn btn btn-secondary">수정</a>
							</div>
							<div class="prodPlan-delete">
								<a href="/prodPlanDelete"
									class="pboard-write-Btn btn btn-secondary">삭제</a>
							</div>
						</div>
						<!-- Modal -->
						<div class="prodPlan-modal">
							<div class="modal fade" id="verticalycentered" tabindex="-1"
								style="display: none;" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered custom-modal-css">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title"
												style="font-weight: 700; margin-top: 10px;">생산 계획 등록</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<div class="row mb-3 prodPlanNo">
											    <label for="prodPlanNoInput" class="col-sm-2 col-form-label">생산계획번호</label>
											    <div class="col-sm-7">
											        <input type="text" id="prodPlanNoInput" class="form-control prodPlanNoInput">
											    </div>
											    <!-- 작업일수 -->
											    <label for="prodPlanWorkingDaysInput" class="col-sm-2 col-form-label prodPlanWorkingDaysLabel">작업일수</label>
											    <div class="col-sm-1 prodPlanWorkingDays">
											        <input type="text" id="prodPlanWorkingDaysInput" class="form-control prodPlanWorkingDaysInput">
											    </div>
											</div>
											<div class="row mb-3">
												<label for="inputDate" class="col-sm-2 col-form-label">생산일자</label>
												<div class="col-sm-10">
													<input type="date" class="form-control">
												</div>
											</div>
											<div class="row mb-3">
											    <label for="productName" class="col-sm-2 col-form-label">제품명</label>
											    <div class="col-sm-5">
											        <input type="text" class="form-control productNameInput" id="productName">
											    </div>
											    <!-- 품목선택 버튼 -->
											    <div class="col-sm-2">
											        <button type="button" class="btn btn-primary productSelect" data-bs-toggle="modal" data-bs-target="#nestedModal">품목선택</button>
											    </div>
											    <!-- 생산수량 입력 필드 -->
											    <label for="productionQuantity" class="col-sm-2 col-form-label prodCount">생산수량</label>
											    <div class="col-sm-1 prodCount-input-class">
											        <input type="text" class="form-control prodCount-input" id="productionQuantity">
											    </div>
											</div>
											<!-- 투입자재 -->
											<div class="productItem-container">
											    <div class="row mb-2">
											        <label for="productItemName" class="col-sm-2 col-form-label">투입자재</label>
											        <div class="col-sm-10">
											            <button type="button" class="btn btn-primary productItemSelect" data-bs-toggle="modal" data-bs-target="#nestedItemModal">품목선택</button>
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
																<span>투입자재명</span> <span>수량</span>
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
													<textarea class="form-control"
														style="min-height: 150px; max-height: 150px;"></textarea>
												</div>
											</div>
										</div>
										<div class="modal-footer">
											<button type="reset" class="btn btn-secondary"
												data-bs-dismiss="modal">취소</button>
											<button type="button" class="btn btn-primary">저장</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- End Modal -->
						<!-- 제품 중첩 모달 -->
						<div class="modal fade" id="nestedModal" tabindex="-1"
							aria-hidden="true" style="display: none;">
							<div class="modal-dialog modal-dialog-centered custom-nestedModal-css">
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
												<label for="majorCategory1" class="form-label">대분류</label> 
												<select class="form-control select2-firstModal" id="majorCategory1">
													<option value="">대분류 선택</option>
													<option value="1">국내 라면</option>
													<option value="2">해외 라면</option>
													<!-- 대분류 옵션들 -->
												</select>
											</div>
											<!-- 중분류 선택 -->
											<div class="me-2">
												<label for="middleCategory1" class="form-label">중분류</label> 
												<select class="form-control select2-firstModal" id="middleCategory1">
													<option value="">중분류 선택</option>
													<option value="1">매운 맛</option>
													<option value="2">순한 맛</option>
													<!-- 중분류 옵션들 -->
												</select>
											</div>
											<!-- 소분류 선택 -->
											<div class="me-2">
												<label for="minorCategory1" class="form-label">소분류</label> 
												<select class="form-control select2-firstModal" id="minorCategory1">
													<option value="">소분류 선택</option>
													<option value="1">아아아아아주맛있는컵라면</option>
													<option value="2">봉지라면</option>
													<option value="3">봉지라면</option>
													<option value="4">봉지라면</option>
													<option value="5">봉지라면</option>
													<option value="6">봉지라면</option>
													<option value="7">봉지라면</option>
													<option value="8">봉지라면</option>
													<!-- 소분류 옵션들 -->
												</select>
											</div>
										</div>
									</div>
									<!-- 분류될 리스트 -->
									<div class="row">
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
													<tr>
														<td><input type="radio" name="productSelect" value="제품1"></td>
														<th scope="row">1</th>
														<td>제품 예시 1</td>
														<td>1000원</td>
													</tr>
													<tr>
														<td><input type="radio" name="productSelect" value="제품2"></td>
														<th scope="row">2</th>
														<td>제품 예시 2</td>
														<td>2000원</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									<div class="modal-footer">
										<button type="reset" class="btn btn-secondary"
											data-bs-dismiss="modal">취소</button>
										<button type="button" class="btn btn-primary">저장</button>
									</div>
								</div>
							</div>
						</div>
						<!-- End 제품 중첩 모달 -->
						<!-- 투입자재 중첩 모달 -->
						<div class="modal fade" id="nestedItemModal" tabindex="-1"
							aria-hidden="true" style="display: none;">
							<div class="modal-dialog modal-dialog-centered custom-nestedItemModal-css">
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
												<label for="majorCategory2" class="form-label">대분류</label> 
												<select class="form-control select2-secondModal" id="majorCategory2">
													<option value="">대분류 선택</option>
											        <option value="1">분말스프</option>
											        <option value="2">건더기스프</option>
											        <option value="3">면류</option>
											        <option value="4">맛 기름</option>
													<!-- 대분류 옵션들 -->
												</select>
											</div>
											<!-- 중분류 선택 -->
											<div class="me-2">
												<label for="middleCategory2" class="form-label">중분류</label> 
												<select class="form-control select2-secondModal" id="middleCategory2">
													<option value="">중분류 선택</option>
											        <option value="1">야채</option>
											        <option value="2">육류</option>
											        <option value="3">해산물</option>
											        <option value="4">향신료</option>
													<!-- 중분류 옵션들 -->
												</select>
											</div>
											<!-- 소분류 선택 -->
											<div class="d-flex flex-row align-items-end">
												<div class="me-2">
													<label for="minorCategory2" class="form-label">소분류</label>
													<select class="form-control select2-secondModal"
														id="minorCategory2">
														<option value="">소분류 선택</option>
														<option value="1">양파 분말</option>
														<option value="2">마늘 분말</option>
														<option value="3">돈사골 분말</option>
														<option value="4">건조 파</option>
														<option value="5">건조 새우</option>
														<option value="6">건조 쇠고기</option>
														<option value="7">후추</option>
														<option value="8">참기름</option>
														<!-- 소분류 옵션들 -->
													</select>
												</div>
											</div>
										</div>
									</div>
									<!-- 분류될 리스트 -->
									<div class="row">
										<div class="col-12">
											<table class="table category-search-list" 
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
													<!-- 동적으로 데이터 추가 제품은 한가지만 선택가능 해야하기 때문에 라디오사용 -->
													<tr>
														<td class="checkbox-center"><input type="checkbox" name="productSelect" value="제품1"></td>
														<th scope="row">1</th>
														<td>자재 예시 1</td>
														<td>1000원</td>
														<td><input type="number" name="quantity1" min="1" style="width: 80px;"> 개</td>
													</tr>
													<tr>
														<td class="checkbox-center"><input type="checkbox" name="productSelect" value="제품2"></td>
														<th scope="row">2</th>
														<td>자재 예시 2</td>
														<td>2000원</td>
														<td><input type="number" name="quantity2" min="1" style="width: 80px;"> 개</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									<div class="modal-footer d-flex justify-content-between">
									    <!-- 분류된 항목 개수 -->
									    <div class="prodPlanItemCount d-flex">
									        <label for="itemCountInput" class="form-label me-2 prodPlanItemCountLabel">항목 수</label>
									        <input type="text" id="itemCountInput" readonly class="form-control prodPlanItemCountInput" style="width: 100px; display: inline-block;">
									    </div>
									    <div class="prodPlanItemTotalPrice d-flex">
									        <label for="itemTotalPriceInput" class="form-label me-2 prodPlanItemTotalPriceLabel">합계금액</label>
									        <input type="text" id="itemTotalPriceInput" readonly class="form-control prodPlanItemTotalPriceInput" style="width: 100px; display: inline-block;">
									    </div>
									    <div>
									        <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
									        <button type="button" class="btn btn-primary">저장</button>
									    </div>
									</div>
								</div>
							</div>
						</div>
						<!-- End 투입자재 중첩 모달 -->						
						<!-- Calendar -->
						<div class="calendar-group">
							<div id='calendar'></div>
						</div>
						<div class="colorPicker-group">
						    <!-- 캘린더 각 이벤트 컬러피커 -->
							<div id="colorPickerDialog" title="색상 선택">
								<input type="color" id="eventColorPicker">
							</div>
							<button id="changeColorButton" class="btn btn-primary colorPicker-btn">색상변경</button>
						</div>
						<!-- 스위치 토글 버튼 -->
						<div class="form-check form-switch tooltip-switch-container">
							<label class="form-check-label" for="flexSwitchCheckChecked">툴 팁</label>
							<input class="form-check-input" type="checkbox" id="flexSwitchCheckChecked" checked> 
						</div>
						<!-- End Calendar -->
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
							<!-- End 주문내역 & 생산계획 리스트 -->
						</div>
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