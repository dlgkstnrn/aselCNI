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
    <script defer src="assets/js/kph/userManagement.js?ver=2"></script>
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
								<input id="search-text" type="text" placeholder="검색어를 입력하세요" value="${keyword }">
								<button id="search-btn">
									<i class="bi bi-search"></i>
								</button>
							</div>
							<select name="search-filter" class="search-filter form-select">
								<c:choose>
									<c:when test="${searchFilter == 'user_nm'}">
										<option value="all">전체</option>
										<option value="user_nm" selected>유저명</option>
										<option value="user_id">유저아이디</option>
									</c:when>
									<c:when test="${searchFilter == 'user_id'}">
										<option value="all">전체</option>
										<option value="user_nm">유저명</option>
										<option value="user_id" selected>유저아이디</option>
									</c:when>
									<c:otherwise>
										<option value="all" selected>전체</option>
										<option value="user_nm">유저명</option>
										<option value="user_id">유저아이디</option>
									</c:otherwise>
								</c:choose>
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
									<th>아이디</th>
									<th>이름</th>
									<th>핸드폰</th>
									<th>내선번호</th>
									<th>이메일</th>
									<th>권한</th>
									<th>삭제</th>
								</tr>
							</thead>
							<c:set var="num" value="${paging.start }"></c:set>
							<tbody>
								<c:forEach var="user" items="${userList}">
									<tr>
										<th>${num}</th>
										<td><a class="user-id" href="/userUpdateForm?user_id=${user.user_id }">${user.user_id }</a></td>
										<td>${user.user_nm }</td>
										<td>${user.user_phone }</td>
										<td>${user.user_tel }</td>
										<td>${user.user_email }</td>
										<td>${user.comm_content}</td>
										<td><button type="button" class="user-delete btn btn-danger">삭제</button></td>
									</tr>
									<c:set var="num" value="${num + 1 }"></c:set>
								</c:forEach>
							</tbody>
						</table>
						<nav class="page-navigation">
							<ul class="pagination">
								<c:if test="${paging.startPage > paging.pageBlock }">
									<li class="page-item"><a class="page-link" href="/userManagement?currentPage=${paging.startPage-paging.pageBlock }&keyword=${keyword}&searchFilter=${searchFilter}"><span>&laquo;</span></a></li>
								</c:if>
								<c:forEach var="i" begin="${paging.startPage }" end="${paging.endPage }">
									<li class="page-item"><a class="page-link" href="/userManagement?currentPage=${i}&keyword=${keyword}&searchFilter=${searchFilter}">${i}</a></li>
								</c:forEach>
								<c:if test="${paging.endPage < paging.totalPage }">
									<li class="page-item"><a class="page-link" href="/userManagement?currentPage=${paging.startPage+paging.pageBlock }&keyword=${keyword}&searchFilter=${searchFilter}"><span>&raquo;</span></a></li>
								</c:if>
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