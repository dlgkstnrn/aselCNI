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
            <h1>영업 관리</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">영업 관리</li>
                    <li class="breadcrumb-item active"><a href="/return">반품 관리</a></li>
                </ol>
                <nav>
            </nav>
            </nav>
        </div><!-- End Page Title -->

		<section class="section dashboard">
			<div class="card">
				<div class="card-body">
				  <div class="top">
					<div class="card-header-title">반품 관리</div>
					<button type="button" id="return-add" class="return-add btn btn-primary">신규</button>
				  </div>
				  <hr />
				  
				  
				  <div class="search">
					<div>
						<div class="input-group day-box">
							<span class="input-group-text">조회기간</span>
							<input type="date" class="start-day form-control" value="${start_day }">
							<input type="date" class="end-day form-control" value="${end_day }">
						</div>
						<div class="input-group return-no-box">
							<span class="input-group-text">반품번호</span>
							<input type="text" class="return-no-text form-control" placeholder="반품번호를 입력하세요" value="${return_no }" />
						</div>
						<div class="input-group outitem-no-box">
							<span class="input-group-text">출고번호</span>
							<input type="text" class="outitem-no-text form-control" placeholder="출고번호를 입력하세요" value="${outitem_no }" />
						</div>
					</div>
					<div>
						<div class="input-group cust-nm-box">
							<span class="input-group-text">고객사명</span>
							<input type="text" class="cust-nm-text form-control" placeholder="고객사명을 입력하세요" value="${cust_nm }" />
						</div>
						<div class="input-group item-nm-box">
							<span class="input-group-text">제품명</span>
							<input type="text" class="item-nm-text form-control" placeholder="제품명을 입력하세요" value="${item_nm }" />
						</div>
						<div class="input-group user-nm-box">
							<span class="input-group-text">담당자명</span>
							<input type="text" class="return-emp-nm-text form-control" placeholder="담당자명을 입력하세요" value="${return_emp_nm }" />
							&nbsp;
		                    <button type="button" id="search-btn" class="search-btn btn btn-primary">조회</button>
						</div>
					</div>
<!-- 					<div class="search-btn-box">
						<button type="button" id="search-btn" class="search-btn btn btn-primary">조회</button>
					</div> -->
				  </div>
				  <div class="table-nav">
					<table class="table table-hover text-center">
						<thead>
							<tr>
								<th>No</th>
								<th>반품번호</th>
								<th>출고번호</th>
								<th>고객사</th>
								<th>제품명</th>
								<th>반품사유</th>
								<th>반품수량</th>
								<th>반품등록일</th>
								<th>담당자</th>
							</tr>
						</thead>
						<c:set var="num" value="${paging.start }"></c:set>
						<tbody>
							<c:forEach var="returnObj" items="${returnList }">
								<tr>
									<th>${num}</th>
									<td><div class="return-no" >${returnObj.return_no }</div></td>
									<td>${returnObj.outitem_no }</td>
									<td>${returnObj.cust_nm }</td>
									<td>${returnObj.item_nm }</td>
									<td>${returnObj.res_rtn }</td>
									<td><fmt:formatNumber value="${returnObj.qty }" pattern="#,###" /></td>
									<td>${returnObj.return_dt }</td>
									<td>${returnObj.return_emp_nm }</td>
								</tr>
								<c:set var="num" value="${num + 1 }"></c:set>
							</c:forEach>
						</tbody>
					</table>
					<nav class="page-navigation">
					  <ul class="pagination">
						<c:if test="${paging.startPage > paging.pageBlock }">
							<li class="page-item"><a class="page-link" href="/return?currentPage=${paging.startPage-paging.pageBlock }&start_day=${start_day}&end_day=${end_day}&return_no=${return_no}&outitem_no=${outitem_no}&cust_nm=${cust_nm}&item_no=${item_nm}&return_emp_nm=${return_emp_nm}"><span>&laquo;</span></a></li>
						</c:if>
						<c:forEach var="i" begin="${paging.startPage }" end="${paging.endPage }">
							<li class="page-item"><a class="page-link" href="/return?currentPage=${i}&start_day=${start_day}&end_day=${end_day}&return_no=${return_no}&outitem_no=${outitem_no}&cust_nm=${cust_nm}&item_no=${item_nm}&return_emp_nm=${return_emp_nm}">${i}</a></li>
						</c:forEach>
						<c:if test="${paging.endPage < paging.totalPage }">
							<li class="page-item"><a class="page-link" href="/return?currentPage=${paging.startPage+paging.pageBlock }&start_day=${start_day}&end_day=${end_day}&return_no=${return_no}&outitem_no=${outitem_no}&cust_nm=${cust_nm}&item_no=${item_nm}&return_emp_nm=${return_emp_nm}"><span>&raquo;</span></a></li>
						</c:if>
					  </ul>
					</nav>
				  </div>
				</div>
			  </div>
		</section>
        <div class="return-detail">
			<div class="return-detail-title">반품 상세</div>
			<div class="return-detail-body">
			
			</div>
			<div class="return-detail-btn-list text-center">
				<button id="return-detail-update" type="button" class="btn btn-primary">수정</button>
				<button id="return-detail-delete" type="button" class="btn btn-danger">삭제</button>
				<button id="return-detail-cancle" type="button" class="btn btn-secondary">닫기</button>
			</div>
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