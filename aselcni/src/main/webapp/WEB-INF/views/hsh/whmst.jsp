<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<!-- CSS File -->
<link href="assets/css/style.css" rel="stylesheet" type="text/css">

<!-- Script -->
<script defer src="assets/js/main.js"></script>
<script src="https://kit.fontawesome.com/0b22ed6a9d.js"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

</head>

<body>

	<!-- ======= Header ======= -->
	<%@ include file="../header.jsp"%>

	<!-- ======= Sidebar ======= -->
	<%@ include file="../asidebar.jsp"%>

	<!-- End Sidebar-->

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>창고 관리</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="#">기준 정보 관리</a></li>
					<li class="breadcrumb-item active">창고 관리</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<section class="section dashboard">







			<div class="row">
				<div class="col-lg-12">

					<div class="card">

						<div class="card-body">

							<button type="button" class="btn btn-primary"
								data-bs-toggle="modal" data-bs-target="#verticalycentered">신규</button>


							<div class="modal fade" id="verticalycentered" tabindex="-1">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title">공정등록</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<div class="form-check form-switch">
												<label class="form-check-label" for="flexSwitchCheckDefault">사용여부</label><input
													class="form-check-input" type="checkbox"
													id="flexSwitchCheckDefault">
											</div>

											<div class="row mb-3">
												<label for="inputText" class="col-sm-2 col-form-label">공정명</label>
												<div class="col-sm-8">
													<input type="text" class="form-control">
												</div>
											</div>

											<div class="row mb-3">
												<label for="inputPassword" class="col-sm-2 col-form-label">비고</label>
												<div class="col-sm-10">
													<textarea class="form-control" style="height: 100px"></textarea>
												</div>
											</div>

											<div class="row mb-3">
												<label for="inputText" class="col-sm-3 col-form-label">담당자ID</label>
												<div class="col-sm-8">
													<input type="text" class="form-control">
												</div>
											</div>

										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">닫기</button>
											<button type="button" class="btn btn-primary">등록</button>
										</div>
									</div>
								</div>
							</div>





							<div class="modal fade" id="verticalycentered1" tabindex="-1">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title">공정</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">


											<div class="form-check form-switch">
												<label class="form-check-label" for="flexSwitchCheckDefault">사용여부</label>
												<input class="form-check-input" type="checkbox"
													id="flexSwitchCheckDefault">
											</div>

											<div class="row mb-3">
												<label class="col-sm-3 col-form-label">공정코드</label>
												<div class="col-sm-7">
													<p>15004</p>
												</div>
											</div>

											<div class="row mb-3">
												<label for="inputText" class="col-sm-2 col-form-label">공정명</label>
												<div class="col-sm-8">
													<input type="text" class="form-control">
												</div>
											</div>

											<div class="row mb-3">
												<label class="col-sm-3 col-form-label">등록날짜</label>
												<div class="col-sm-5">
													<p>200-14-45</p>
												</div>
											</div>

											<div class="row mb-3">
												<label class="col-sm-3 col-form-label">수정날짜</label>
												<div class="col-sm-5">
													<p>200-14-45</p>
												</div>
											</div>



											<div class="row mb-3">
												<label for="inputPassword" class="col-sm-2 col-form-label">비고</label>
												<div class="col-sm-10">
													<textarea class="form-control" style="height: 100px"></textarea>
												</div>
											</div>

											<div class="row mb-3">
												<label for="inputText" class="col-sm-3 col-form-label">담당자ID</label>
												<div class="col-sm-8">
													<input type="text" class="form-control">
												</div>
											</div>

										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">닫기</button>
											<button type="button" class="btn btn-primary">수정</button>
										</div>
									</div>
								</div>
							</div>



							<!-- Table with stripped rows -->
							<div
								class="datatable-wrapper datatable-loading no-footer sortable searchable fixed-columns search-results">
								<div class="datatable-top">
									<div class="datatable-dropdown"></div>



									<div class="search-bar">
										<form class="search-form d-flex align-items-center"
											method="POST" action="#">
											<input type="text" name="query" placeholder="공정코드/명"
												title="Enter search keyword">
											<button type="submit" title="Search">
												<i class="bi bi-search"></i>
											</button>
										</form>
									</div>
									<!-- End Search Bar -->




								</div>
								<div class="datatable-container">
									<table class="table datatable datatable-table datatable-table">
										<thead>
											<tr>
												<th><b>N</b>o.</th>
												<th>공정코드</th>
												<th>공정명</th>
												<th>설명</th>
												<th>담당자</th>
												<th>사용여부</th>

											</tr>
										</thead>
										<tbody>
											<tr>
												<td>10</td>
												<td><button type="button"
														class="btn btn-outline-primary" data-bs-toggle="modal"
														data-bs-target="#verticalycentered1">1001312</button></td>
												<td>Monceau-sur-Sambre</td>
												<td>반죽을 하자</td>
												<td>김반죽</td>
												<td>사용</td>
											</tr>

											<tr>
												<td>10</td>
												<td><button type="button"
														class="btn btn-outline-primary" data-bs-toggle="modal"
														data-bs-target="#verticalycentered1">1001312</button></td>
												<td>Monceau-sur-Sambre</td>
												<td>반죽을 하자</td>
												<td>김반죽</td>
												<td>사용</td>
											</tr>

											<tr>
												<td>10</td>
												<td><button type="button"
														class="btn btn-outline-primary" data-bs-toggle="modal"
														data-bs-target="#verticalycentered1">1001312</button></td>
												<td>Monceau-sur-Sambre</td>
												<td>반죽을 하자</td>
												<td>김반죽</td>
												<td>사용</td>
											</tr>

										</tbody>
									</table>
								</div>

							</div>
							<!-- End Table with stripped rows -->

						</div>
					</div>

				</div>
			</div>














			<div class="modal fade" id="verticalycentered1" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">Vertically Centered</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">수정</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
							<button type="button" class="btn btn-primary">Save
								changes</button>
						</div>
					</div>
				</div>
			</div>

		</section>

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
	<script type="text/javascript">
		
	</script>
</body>

</html>