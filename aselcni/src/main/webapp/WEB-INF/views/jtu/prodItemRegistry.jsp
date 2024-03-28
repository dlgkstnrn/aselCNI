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
<!-- <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="assets/vendor/simple-datatables/style.css" rel="stylesheet"> -->

<!-- CSS File -->
<link href="assets/css/style.css" rel="stylesheet" type="text/css">

<!-- Script -->
<script defer src="assets/js/main.js"></script>
<script src="https://kit.fontawesome.com/0b22ed6a9d.js"
	crossorigin="anonymous"
></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"
></script>

<style>
body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ccc;
	padding: 5px;
}

th {
	text-align: center;
}

.center {
	text-align: center;
}
</style>


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

		<section class="section dashboard">


			<h1>생산실적등록</h1>
			<button type="button" class="btn btn-outline-primary">신규</button>
			<button type="button" class="btn btn-outline-primary">수정</button>
			<button type="button" class="btn btn-outline-primary">삭제</button>

			<div style="display: flex; align-items:center; justify-content: center;">
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
				<p style="margin-top: 16px">생산일자: 2024/03/01 ~ 2024/03/07</p>
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
						<th scope="col">계획번호</th>
						<th scope="col">제품명</th>
						<th scope="col">예정수량</th>
						<th scope="col">불량수량</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row">1</th>
						<td>Brandon Jacob</td>
						<td>Designer</td>
						<td>28</td>
						<td>2016-05-25</td>
					</tr>
					<tr>
						<th scope="row">2</th>
						<td>Bridie Kessler</td>
						<td>Developer</td>
						<td>35</td>
						<td>2014-12-05</td>
					</tr>
				</tbody>
			</table>




		</section>

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