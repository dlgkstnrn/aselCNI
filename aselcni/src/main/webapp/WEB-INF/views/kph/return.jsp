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
  	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
    
    <!-- Vendor CSS Files -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <!-- <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet"> -->

    <!-- CSS File -->
    <link href="assets/css/style.css" rel="stylesheet"  type="text/css">
    <link href="assets/css/kph/return.css" rel="stylesheet" type="text/css">
     
     <!-- Script -->
    <script defer src="assets/js/jquery-3.7.1.min.js"></script>
    <script defer src="assets/js/main.js"></script>
    <script defer src="assets/js/kph/return.js"></script>
    <script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>

</head>

<body>

    <!-- ======= Header ======= -->
    <%@ include file="../header.jsp" %>

    <!-- ======= Sidebar ======= -->
    <%@ include file="../asidebar.jsp" %>
    
    <!-- End Sidebar-->

    <main id="main" class="main">

        <div class="pagetitle">
            <h1>반품 관리</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item active"><a href="/return">반품 관리</a></li>
                </ol>
            </nav>
        </div><!-- End Page Title -->

		<section class="section dashboard">
			<div class="card">
				<div class="card-body">
				  <div class="controller">
					<div class="search-bar">
					  <div class="search-form">
						<input id="search-text" type="text" placeholder="검색어를 입력하세요">
						<button id="search-btn"><i class="bi bi-search"></i></button>
					  </div>
					  <select name="search-filter" class="search-filter form-select">
						<option value="all" selected>전체</option>
						<option value="return_no">반품번호</option>
						<option value="outitem_no">출고번호</option>
						<option value="cust_nm">고객사</option>
						<option value="item_nm">제품명</option>
						<option value="user_nm">담당자명</option>
					  </select>
					  <div class="start-end-day">
						<input type="date" class="start-day form-control">
						<span>~</span>
					  	<input type="date" class="end-day form-control">
					  </div>
					</div>
					<button type="button" id="return-add" class="return-add btn btn-primary">신규</button>
				  </div>
				  <div class="table-nav">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>#</th>
								<th>반품번호</th>
								<th>출고번호</th>
								<th>고객사</th>
								<th>제품명</th>
								<th>반품사유</th>
								<th>반품등록일</th>
								<th>담당자</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>1</th>
								<td><a class="return-no" href="#">RET2403200001</a></td>
								<td>OUT2403200001</td>
								<td>(주)농심</td>
								<td>라면땅</td>
								<td>맛이없음</td>
								<td>2024-12-31</td>
								<td>김평화</td>
								<td><button type="button" class="return-delete btn btn-danger">삭제</button></td>
							</tr>
						</tbody>
					</table>
					<nav class="page-navigation">
					  <ul class="pagination">
						<li class="page-item">
						  <a class="page-link" href="#">
							<span>&laquo;</span>
						  </a>
						</li>
						<li class="page-item"><a class="page-link" href="#">1</a></li>
						<li class="page-item"><a class="page-link" href="#">2</a></li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item">
						  <a class="page-link" href="#">
							<span>&raquo;</span>
						  </a>
						</li>
					  </ul>
					</nav>
				  </div>
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