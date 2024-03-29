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
<!-- <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet"> -->
<!-- <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet"> -->
<!-- <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet"> -->
<!-- <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet"> -->
<!-- <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet"> -->

<!-- CSS File -->
<link href="assets/css/style.css" rel="stylesheet" type="text/css">
<link href="assets/css/jtu/jtuProdItemRegistry.css" rel="stylesheet"
	type="text/css"
>

<!-- Script -->
<script defer src="assets/js/main.js"></script>
<script src="https://kit.fontawesome.com/0b22ed6a9d.js"
	crossorigin="anonymous"
></script>
<script src="assets/js/jquery-3.7.1.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		let expectedQty = parseInt($("#expectedQty").val());
		let actualQty = parseInt($("#actualQty").val());
		let defectiveQty = expectedQty - actualQty;
		$("#defectiveQty").val(defectiveQty);
		$("#actualQty").on("input", function() {
			let expectedQty = parseInt($("#expectedQty").val()) || 0; // 값이 없을 경우를 대비해 0으로 초기화
			let actualQty = parseInt($(this).val()) || 0; // this는 현재 이벤트가 발생한 actualQty 입력 필드를 가리킴
			let defectiveQty = expectedQty - actualQty;

			$("#defectiveQty").val(defectiveQty);
		});
	});

/* 	$(document).ready(function() {
		$('tr[data-bs-toggle="modal"]').on('click', function() {
			var prodNo = $(this).find('td:nth-child(2)').text();
			$("#workProdNo").val(prodNo);
			$("#workProdNo").text(prodNo);


		});
	}); */
	
	document.addEventListener("DOMContentLoaded", function() {
	    $(".dropdown-menu").on("click", ".dropdown-item", function() {
	        var selectedValue = $(this).data("value");
	        $("#dropdownMenuButton").text($(this).text());
	        $("#workProdNo").val(selectedValue);
	    });
	});
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
			<h1>기준 정보 관리</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="#">기준 정보 관리</a></li>
					<li class="breadcrumb-item active">사업장 관리</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->
		<div class="card">
			<section class="section dashboard">

				<div
					style="display: flex; align-items: center; justify-content: space-between;"
				>
					<h1>생산 실적 조회</h1>

					<!--등록, 수정, 삭제 버튼  -->
					<div>
						<button type="button" class="btn btn-primary"
							data-bs-toggle="modal" data-bs-target="#verticalycentered"
						>등록</button>

						<button type="button" class="btn btn-outline-primary">수정</button>
						<button type="button" class="btn btn-outline-primary">삭제</button>
					</div>
				</div>


				<div
					style="display: flex; align-items: center; justify-content: space-between; margin: 20px 50px;"
				>
					<button type="button" class="btn btn-outline-danger">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
							fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16"
						>
	  					<path fill-rule="evenodd"
								d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8"
							/>
					</svg>
						Button
					</button>
					<div>
						<label for="start"></label> <input type="date"
							class="prodItemDate" name="trip-start" value="2024-03-01"
							min="2024-01-01" max="2024-12-31"
						>&nbsp;&nbsp;~&nbsp;&nbsp;<label for="end"></label> <input
							type="date" class="prodItemDate" name="trip-end"
							value="2024-03-07" min="2024-01-01" max="2024-12-31"
						>
					</div>

					<button type="button" class="btn btn-outline-danger">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
							fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16"
						>
					  <path fill-rule="evenodd"
								d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8"
							/>
					</svg>
						Button
					</button>
				</div>

				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col">생산일자</th>
							<th scope="col">지시번호</th>
							<th scope="col">제품명</th>
							<th scope="col">예정수량</th>
							<th scope="col">불량수량</th>
						</tr>
					</thead>
					<tbody>
						<tr data-bs-toggle="modal" data-bs-target="#verticalycentered">
							<th scope="row">1</th>
							<td>WPR202404120001</td>
							<td>Designer</td>
							<td>28</td>
							<td>2016-05-25</td>
							</button>
						</tr>
						<tr>
							<th scope="row">2</th>
							<td>WPR202404120002</td>
							<td>Developer</td>
							<td>35</td>
							<td>2014-12-05</td>
						</tr>
					</tbody>
				</table>



				<!-- Start modal -->
				<div class="modal fade" id="verticalycentered" tabindex="-1"
					style="display: none;" aria-hidden="true"
				>
					<div class="modal-dialog modal-dialog-centered modal-xl">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title">생산 실적 실적 등록</h1>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"
								></button>
							</div>
							<div class="modal-body">

								<!-- Start modal body -->
								<form>

									<div class="row mb-3">
										<label class="col-sm-2 col-form-label">생산 지시 번호</label>
										<div class="col-sm-10">
											<select id="workProdNo" class="form-select"
												aria-label="Default select example"
											>
												<option value="WPR202404110001">WPR202404110001</option>
												<option value="WPR202404110002">WPR202404110002</option>
												<option value="WPR202404110003">WPR202404110003</option>
												<option value="WPR202404110004">WPR202404110004</option>
											</select>
										</div>
									</div>

									<div class="row mb-3">
										<label for="inputDate" class="col-sm-2 col-form-label">생산
											완료 일자</label>
										<div class="col-sm-10">
											<input id="prodEndDate" type="date" class="form-control"
												value="2024-04-12" required
											>
										</div>
									</div>

									<div class="row mb-3">
										<label for="inputText" class="col-sm-2 col-form-label">제품명</label>
										<div class="col-sm-10">
											<input type="text" class="form-control"
												value="붉닭라면(buldak001)"
											>
										</div>
									</div>


									<div class="row mb-3">
										<label for="expectedQty" class="col-sm-2 col-form-label">예정
											생산 수량</label>
										<div class="col-sm-10">
											<input id="expectedQty" type="number" class="form-control"
												readonly value=50000
											>
										</div>
									</div>

									<div class="row mb-3">
										<label for="actualQty" class="col-sm-2 col-form-label">실제
											생산 수량</label>
										<div class="col-sm-10">
											<input id="actualQty" type="number" class="form-control"
												required value=49990
											>
										</div>
									</div>

									<div class="row mb-3">
										<label for="defectiveQty" class="col-sm-2 col-form-label">불량
											수량</label>
										<div class="col-sm-10">
											<input id="defectiveQty" type="number" class="form-control"
												required
											>
										</div>
									</div>


									<div class="row mb-3">
										<label for="inputTextarea" class="col-sm-2 col-form-label">불량
											내역</label>
										<div class="col-sm-10">
											<textarea class="form-control" style="height: 100px">불닭이 너무매움</textarea>
										</div>
									</div>

								</form>

							</div>
							<!-- End modal body -->

							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal"
								>닫기</button>
								<button type="button" class="btn btn-primary">저장</button>
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