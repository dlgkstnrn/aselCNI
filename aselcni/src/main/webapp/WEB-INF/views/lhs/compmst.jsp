<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<!-- <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet"> -->
<!-- <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet"> -->
<!-- <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet"> -->
<!-- <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet"> -->
<!-- <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet"> -->

<!-- CSS File -->
<link href="assets/css/style.css" rel="stylesheet" type="text/css">
<style type="text/css">
.width1200 {
	min-width: 1200px;
}

.width50 {
	width: 50%;
}

.pic-big-div {
	padding: 10px 10px;
}

.pic-sml-div {
	height: 500px;
	padding: 30px 100px;
}

.pic {
	border: 1px solid #0000002b;
	height: 350px;
	width: 100%;
	margin-bottom: 15px;
}
</style>
<!-- Script -->
<script src="https://kit.fontawesome.com/0b22ed6a9d.js"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script defer="defer" src="assets/js/main.js" type="text/javascript"></script>
<script defer="defer" type="text/javascript"
	src="assets/js/lhs/compmst.js"></script>
</head>

<body>

	<!-- ======= Header ======= -->
	<%@ include file="../header.jsp"%>

	<!-- ======= Sidebar ======= -->
	<%@ include file="../asidebar.jsp"%>

	<!-- End Sidebar-->

	<main id="main" class="main">
		<div class="pagetitle">
			<h1>사업장관리</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item active">사업장관리</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<section class="section">
			<div class="d-flex justify-content-center">
				<div class="card width1200">
					<div class="card-body">
						<!-- Vertical Form -->
						<form class="row g-3" action="compmstUpdate" enctype="multipart/form-data" method="post">
							<div class="d-flex">
								<div class="width50">
									<div class="col-12">
										<label for="inputNanme4" class="form-label">사업장명</label> 
										<input type="text" class="form-control" name="comp_nm" value="${compmst.comp_nm}"/>
									</div>
									<div class="col-12">
										<label for="inputEmail4" class="form-label">대표자명</label> 
										<input type="text" class="form-control" name="comp_president_nm" value="${compmst.comp_president_nm}"/>
									</div>
									<div class="col-12">
										<label for="inputPassword4" class="form-label">사업자 번호</label> 
										<input type="text" class="form-control" name="comp_busi_no" value="${compmst.comp_busi_no}"/>
									</div>
									<div class="col-12">
										<label for="inputAddress" class="form-label">종목</label> 
										<input type="text" class="form-control" name="comp_cond" value="${compmst.comp_cond}"/>
									</div>
									<div class="col-12">
										<label for="inputAddress" class="form-label">업태</label> 
										<input type="text" class="form-control" name="comp_item" value="${compmst.comp_item}"/>
									</div>
									<div class="col-12">
										<label for="inputAddress" class="form-label">주소</label> 
										<input type="text" class="form-control" name="comp_addr" value="${compmst.comp_addr}" />
									</div>
									<div class="col-12">
										<label for="inputAddress" class="form-label">전화번호</label>
										<input type="text" class="form-control" name="comp_tel" value="${compmst.comp_tel}" />
									</div>
									<div class="col-12">
										<label for="inputAddress" class="form-label">팩스</label> 
										<input type="text" class="form-control" name="comp_fax" value="${compmst.comp_fax}"/>
									</div>
								</div>
								<div class="pic-big-div width50">
									<div class="pic-sml-div">
										<div class="d-flex justify-content-center">
											<div class="pic">
												<img id="pic_preview" alt="회사사진" src="${compImage}"
													style="width: 100%; height: 100%; object-fit: cover;">
											</div>
										</div>
										<div class="d-flex justify-content-center">
											<input class="form-control" type="file" name="image_file" id="comp_file" />
										</div>
									</div>
								</div>
							</div>
							<div class="text-center">
								<button type="submit" class="btn btn-primary">저장</button>
								<button type="button" class="btn btn-secondary" onclick="location.href='/main'">취소</button>
							</div>
						</form>
						<!-- Vertical Form -->
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