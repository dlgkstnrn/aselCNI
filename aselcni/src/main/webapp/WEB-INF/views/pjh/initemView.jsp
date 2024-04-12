<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
		<link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
		<!-- <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet"> -->
		<!-- <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet"> -->
		<!-- <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet"> -->
		<!-- <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet"> -->
		<!-- <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet"> -->

		<!-- CSS File -->
		<link href="assets/css/style.css" rel="stylesheet" type="text/css">
		<!-- Script -->
		<script defer src="assets/js/main.js"></script>
		<script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>
		<script src="assets/js/jquery-3.7.1.min.js"></script>
		<script defer src="assets/js/pjh/initemView.js"></script>
	</head>

	<body>

		<!-- ======= Header ======= -->
		<%@ include file="../header.jsp" %>

			<!-- ======= Sidebar ======= -->
			<%@ include file="../asidebar.jsp" %>

				<!-- End Sidebar-->

				<main id="main" class="main">

					<div class="pagetitle">
						<h1>입고 관리</h1>
						<nav>
							<ol class="breadcrumb">
								<li class="breadcrumb-item">자재관리</li>
								<li class="breadcrumb-item active">입고관리</li>
							</ol>
						</nav>
					</div><!-- End Page Title -->

					<section class="section dashboard h-max">
						<div class="card">
							<div class="card-body">
								<!-- 카드 제목 부  -->
								<div class="d-flex align-items-center">
									<span class="h5 align-baseline me-auto">입고 관리</span>
									<div>
										<a href="/initemWrite" type="button" class="btn btn-primary btn-sm">신규</a>
										<!-- 
		              	<button type="button" class="btn btn-primary btn-sm">수정</button>
		              	<button type="button" class="btn btn-primary btn-sm">삭제</button>
		              	 -->
									</div>
								</div>
								<hr class="my-3">

								<!-- 필터 입력 부 -->
								<div class="container text-center">
									<div class="row">
										<div class="col-md-7">
											<div class="input-group">
												<span class="input-group-text">조회기간</span>
												<input id="start_date" onchange="changeData(this)" type="date" aria-label="startDate" class="form-control">
												<input id="end_date" onchange="changeData(this)" type="date" aria-label="endDate" class="form-control">
											</div>
										</div>
										<div class="col-md-5">
											<div class="input-group">
												<span class="input-group-text">매입처</span>
												<input id="cust_nm" onchange="changeData(this)" type="text" class="form-control" placeholder="매입처명"
													aria-label="매입처명" aria-describedby="button-addon2">
												<!-- <button class="btn btn-outline-secondary" type="button"
													id="button-addon2"><i class="bi bi-search"></i></button> -->
											</div>
										</div>
									</div>

									<div class="row mt-1">
										<div class="col-md-5">
											<div class="input-group">
												<span class="input-group-text">입고번호</span>
												<input id="initem_no" onchange="changeData(this)" type="text" class="form-control" placeholder="입고번호"
													aria-label="입고번호" aria-describedby="button-addon3">
												<!-- <button class="btn btn-outline-secondary" type="button"
													id="button-addon3"><i class="bi bi-search"></i></button> -->
											</div>
										</div>
										<div class="col-md-6">
											<div class="input-group">
												<span class="input-group-text">자재명</span>
												<input id="item_nm" onchange="changeData(this)" type="text" class="form-control" placeholder="자재명"
													aria-label="자재명" aria-describedby="button-addon4">
												<!-- <button class="btn btn-outline-secondary" type="button"
													id="button-addon4"><i class="bi bi-search"></i></button> -->
											</div>
										</div>
										<div class="col-md-1 px-0">
											<button class="btn btn-primary btn-sm" style="height:100%;" onclick="searchInitem()">조회</button>
										</div>
									</div>
								</div>


								<!-- 리스트 조회부 -->
								<table class="table table-hover mt-5">
									<thead>
										<tr>
											<th scope="col">No.</th>
											<th scope="col">입고번호</th>
											<th scope="col">입고일자</th>
											<th scope="col">매입처</th>
											<th scope="col">자재명</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach var="item" varStatus="status" items="${initems}">
										<tr onclick="console.log('${item.initem_no}')" style="cursor:pointer;">
											<th scope="row">${status.count+(page.currentPage-1)*page.rowPage}</th>
											<td>${item.initem_no}</td>
											<td>${item.initem_dt }</td>
											<td>${item.cust_nm }</td>
											<td>${item.item_nm }</td>
										</tr>
									</c:forEach>
										
									</tbody>
								</table>
								<nav aria-label="Page navigation example">
									<ul class="pagination justify-content-center">
										<li class="page-item">
											<a class="page-link" href="#" aria-label="Previous">
												<span aria-hidden="true">«</span>
											</a>
										</li>
										<c:forEach var="i" begin="${page.startPage}" end="${page.endPage }">
										<li class="page-item"><a class="page-link" href="#">${i }</a></li>
										</c:forEach>
										<li class="page-item">
											<a class="page-link" href="#" aria-label="Next">
												<span aria-hidden="true">»</span>
											</a>
										</li>
									</ul>
								</nav>
							</div>
						</div>
					</section>
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