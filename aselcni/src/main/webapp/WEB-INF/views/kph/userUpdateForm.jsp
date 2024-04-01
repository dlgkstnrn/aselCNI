<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link href="assets/css/kph/userAddForm.css" rel="stylesheet" type="text/css">
     
     <!-- Script -->
    <script defer src="assets/js/jquery-3.7.1.min.js"></script>
    <script defer src="assets/js/main.js"></script>
    <script defer src="assets/js/kph/userUpdateForm.js"></script>
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
                    <li class="breadcrumb-item"><a href="/userManagement">유저 관리</a></li>
					<li class="breadcrumb-item active">유저 수정</li>
                </ol>
            </nav>
        </div><!-- End Page Title -->

        <section class="section dashboard">
			<div class="card">
				<p>유저 정보 입력</p>
				<form action="/userUpdate" method="post">
					<div>
						<p>아이디</p>
						<div class="id-box">
							<input style="width: 100%; background-color: rgba(128, 128, 128, 0.227);" name="user_id" type="text" class="user-id form-control" value="${user.user_id }" readonly />
						</div>
						<p class="user-alert user-id-alert">아이디를 입력하세요</p>
					</div>
					<div>
						<p>패스워드</p>
						<input name="user_pw" type="password" class="form-control" value="${user.user_pw }" />
						<p class="user-alert user-pw-alert">패스워드를 입력하세요</p>
					</div>
					<div>
						<p>이름</p>
						<input name="user_nm" type="text" class="form-control" value="${user.user_nm }" />
						<p class="user-alert user-nm-alert">이름을 입력하세요</p>
					</div>
					<div>
						<p>핸드폰</p>
						<input name="user_phone" type="text" class="form-control" value="${user.user_phone }" />
						<p class="user-alert user-phone-alert">핸드폰 번호를 입력하세요</p>
					</div>
					<div>
						<p>내선 전화</p>
						<input name="user_tel" type="text" class="form-control" value="${user.user_tel }" />
						<p class="user-alert user-tel-alert">내선 전화를 입력하세요</p>
					</div>
					<div>
						<p>이메일</p>
						<input name="user_email" type="text" class="form-control" value="${user.user_email }" />
						<p class="user-alert user-email-alert">이메일을 입력하세요</p>
					</div>
					<div>
						<p>부서</p>
						<select name="user_comm_code" class="form-select">
							<option value="0">부서를 선택하세요</option>
							<c:forEach var="authority" items="${authorityList }">
								<c:choose>
									<c:when test="${authority.comm_code == user.user_comm_code }">
										<option value="${authority.comm_code }" selected>${authority.comm_content }</option>		
									</c:when>
									<c:otherwise>
										<option value="${authority.comm_code }">${authority.comm_content }</option>	
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
						<p class="user-alert user-comm-code-alert">부서를 입력하세요</p>
					</div>
					<div class="text-center">
						<button type="submit" class="btn btn-primary">저장</button>
						<button type="button" class="cancle-btn btn btn-secondary">취소</button>
					</div>
				</form>
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