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
	<!-- 셀렉트박스에  -->
	<!-- Select2 CSS -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
	<!-- Select2 JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
	
    <!-- CSS File -->
    <link href="assets/css/style.css" rel="stylesheet"  type="text/css">
     
     <!-- Script -->
    <script defer src="assets/js/main.js"></script>
    <script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>
    
    
    <!-- KDW Main CSS,JS,Script -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js"></script>
    <script src="assets/js/kdw/kdwProductionPlanning.js"></script>
	<link href="assets/css/kdw/kdwProductionPlanning.css" rel="stylesheet">
</head>

<body>




    <!-- ======= Header ======= -->
    <%@ include file="../header.jsp" %>

    <!-- ======= Sidebar ======= -->
    <%@ include file="../asidebar.jsp" %>
    
    <!-- End Sidebar-->

    <main id="main" class="main">
		<!-- Page Title -->
        <div class="pagetitle">
            <h1>생산 계획</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="productionPlanning">생산 관리</a></li>
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
								<button type="button" class="btn btn-secondary" data-bs-toggle="modal" 
										data-bs-target="#verticalycentered">
									등록
								</button>
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
											<h5 class="modal-title" style="font-weight: 700; margin-top: 10px;">생산 계획 등록</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<div class="row mb-3">
												<label for="inputText" class="col-sm-2 col-form-label">생산계획번호</label>
												<div class="col-sm-10">
													<input type="text" class="form-control">
												</div>
											</div>
											<div class="row mb-3">
												<label for="inputDate" class="col-sm-2 col-form-label">생산일자</label>
												<div class="col-sm-10">
													<input type="date" class="form-control">
												</div>
											</div>
											<div class="row mb-3">
												<label for="inputText" class="col-sm-2 col-form-label">제품명</label>
												<div class="col-sm-8">
													<input type="text" class="form-control productNameInput">
												</div>
												<!-- 제품 중첩 모달 -->
												<div class="col-sm-2">
													<button type="button"
														class="btn btn-secondary productSelect"
														data-bs-toggle="modal" data-bs-target="#nestedModal">품목선택</button>
												</div>
											</div>
											<div class="row mb-3">
												<label for="inputText" class="col-sm-2 col-form-label">생산수량</label>
												<div class="col-sm-10">
													<input type="text" class="form-control">
												</div>
											</div>
											<div class="row mb-3">
												<label for="inputText" class="col-sm-2 col-form-label">투입품</label>
												<div class="col-sm-10">
													<input type="text" class="form-control">
												</div>
											</div>
											<div class="row mb-3">
												<label for="inputText" class="col-sm-2 col-form-label">투입수량</label>
												<div class="col-sm-10">
													<input type="text" class="form-control">
												</div>
											</div>
											<div class="row mb-3">
												<label for="inputText" class="col-sm-2 col-form-label">작업일수</label>
												<div class="col-sm-10">
													<input type="text" class="form-control">
												</div>
											</div>
											<div class="row mb-3">
												<label for="inputPassword" class="col-sm-2 col-form-label">비고</label>
												<div class="col-sm-10">
													<textarea class="form-control" style="min-height: 150px; max-height: 150px;"></textarea>
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
						<!-- 중첩 모달 -->
						<div class="modal fade" id="nestedModal" tabindex="-1" aria-hidden="true" style="display: none;">
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
										<div class="row mb-1">
											<label for="majorCategory" class="col-sm-2 col-form-label">대분류</label>
											<div class="col-sm-8 select-container">
												<select class="form-control select2" id="majorCategory">
													<option value="">대분류 선택</option>
													<option value="1">국내 라면</option>
													<option value="2">해외 라면</option>
													<!-- 대분류 옵션들 -->
												</select>
											</div>
										</div>
										<!-- 중분류 선택 -->
										<div class="row mb-1">
											<label for="middleCategory" class="col-sm-2 col-form-label">중분류</label>
											<div class="col-sm-8 select-container">
												<select class="form-control select2" id="middleCategory">
													<option value="">중분류 선택</option>
													<!-- 중분류 옵션들 -->
													<option value="1">매운 맛</option>
													<option value="2">순한 맛</option>
												</select>
											</div>
										</div>
										<!-- 소분류 선택 -->
										<div class="row mb-1">
											<label for="minorCategory" class="col-sm-2 col-form-label">소분류</label>
											<div class="col-sm-8 select-container">
												<select class="form-control select2" id="minorCategory">
													<option value="">소분류 선택</option>
													<!-- 소분류 옵션들 -->
													<option value="1">컵라면</option>
													<option value="2">봉지라면</option>
												</select>
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
						<!-- End 중첩 모달 -->
						<!-- Calendar -->
						<div class="calendar-group">
							<div id='calendar'></div>
						</div>
						<!-- End Calendar -->
						<div class="prodPlan-info">
							<div class="referenceCode-group">
								<div class="referenceCode-prepend-text">생산계획번호</div>
								<div class="referenceCode"></div>
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
										<tbody>
											<c:forEach var="orderList" items="${orderList }">
												<tr class="orderList-item">
													<td class="customer"></td>
													<td class="order-item"></td>
													<td class="order-item-count"></td>
												</tr>
											</c:forEach>
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
										<tbody>
											<c:forEach var="prodPlanList" items="${prodPlanList }">
												<tr class="prodPlanList-item">
													<td class="prodPlan-item"></td>
													<td class="prodPlan-item-count"></td>
													<td class="prodPlan-workingDays"></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</form>
				</div>
			</section>
		</div>
	</main>
    <!-- End #main -->

    <!-- ======= Footer ======= -->
    <%@ include file="../footer.jsp" %>
    <!-- End Footer -->

    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
            class="bi bi-arrow-up-short"></i></a>

    <!-- Vendor JS Files -->
    <!-- <script src="assets/vendor/apexcharts/apexcharts.min.js"></script> -->
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- <script src="assets/vendor/chart.js/chart.umd.js"></script> -->
    <!-- <script src="assets/vendor/echarts/echarts.min.js"></script> -->
    <!-- <script src="assets/vendor/quill/quill.min.js"></script> -->
 	<!-- <script src="assets/vendor/simple-datatables/simple-datatables.js"></script> -->
  	<!-- <script src="assets/vendor/tinymce/tinymce.min.js"></script> -->
  	<!-- <script src="assets/vendor/php-email-form/validate.js"></script> -->

</body>

</html>