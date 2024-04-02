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
    <link href="assets/css/kph/userManagement.css" rel="stylesheet" type="text/css">
     
     <!-- Script -->
    <script defer src="assets/js/jquery-3.7.1.min.js"></script>
    <script defer src="assets/js/main.js"></script>
    <script defer src="assets/js/kph/userManagement.js"></script>
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
            <h1>유저 관리</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item active"><a href="/userManagement">유저 관리</a></li>
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
								<button id="search-btn">
									<i class="bi bi-search"></i>
								</button>
							</div>
							<select name="search-filter" class="search-filter form-select">
								<option value="all" selected>전체</option>
								<option value="project_title">유저명</option>
								<option value="task_title">유저아이디</option>
							</select>
						</div>
						<button type="button" id="user-add"
							class="user-add btn btn-primary">유저 추가</button>
					</div>
					<div class="table-nav">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>#</th>
									<th>프로젝트명</th>
									<th>과업명</th>
									<th>시작일</th>
									<th>종료일</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th>1</th>
									<td><a href="#">Brandon Jacob</a></td>
									<td>Designer</td>
									<td>28</td>
									<td>2016-05-25</td>
								</tr>
								<tr>
									<th>2</th>
									<td>Bridie Kessler</td>
									<td>Developer</td>
									<td>35</td>
									<td>2014-12-05</td>
								</tr>
								<tr>
									<th>3</th>
									<td>Ashleigh Langosh</td>
									<td>Finance</td>
									<td>45</td>
									<td>2011-08-12</td>
								</tr>
								<tr>
									<th>4</th>
									<td>Angus Grady</td>
									<td>HR</td>
									<td>34</td>
									<td>2012-06-11</td>
								</tr>
								<tr>
									<th>5</th>
									<td>Raheem Lehner</td>
									<td>Dynamic Division Officer</td>
									<td>47</td>
									<td>2011-04-19</td>
								</tr>
								<tr>
									<th>6</th>
									<td>Raheem Lehner</td>
									<td>Dynamic Division Officer</td>
									<td>47</td>
									<td>2011-04-19</td>
								</tr>
								<tr>
									<th>7</th>
									<td>Raheem Lehner</td>
									<td>Dynamic Division Officer</td>
									<td>47</td>
									<td>2011-04-19</td>
								</tr>
								<tr>
									<th>8</th>
									<td>Raheem Lehner</td>
									<td>Dynamic Division Officer</td>
									<td>47</td>
									<td>2011-04-19</td>
								</tr>
								<tr>
									<th>9</th>
									<td>Raheem Lehner</td>
									<td>Dynamic Division Officer</td>
									<td>47</td>
									<td>2011-04-19</td>
								</tr>
								<tr>
									<th>10</th>
									<td>Raheem Lehner</td>
									<td>Dynamic Division Officer</td>
									<td>47</td>
									<td>2011-04-19</td>
								</tr>
							</tbody>
						</table>
						<nav class="page-navigation">
							<ul class="pagination">
								<li class="page-item"><a class="page-link" href="#"> <span>&laquo;</span>
								</a></li>
								<li class="page-item"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#"> <span>&raquo;</span>
								</a></li>
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