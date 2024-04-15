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
     <style type="text/css">
     	.insertdiv {
		  background-color: white !important;
		  width: 800px;
		}
		.margin15{
		    margin-right: 15px;
		}
		#componyCode {
		  width: 400px;
		}
     </style>
     <!-- Script -->
    <script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script defer="defer" src="assets/js/main.js" type="text/javascript"></script>
	<script defer="defer" type="text/javascript" src="assets/js/lhs/custmstaddForm.js"></script>
</head>

<body>

    <!-- ======= Header ======= -->
    <%@ include file="../header.jsp" %>

    <!-- ======= Sidebar ======= -->
    <%@ include file="../asidebar.jsp" %>
    
    <!-- End Sidebar-->

    <main id="main" class="main">
      <div class="pagetitle">
        <h1>거래처 관리</h1>
        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item active">
              거래처 관리
            </li>
            <li class="breadcrumb-item active">
              신규등록
            </li>
          </ol>
        </nav>
      </div>
      <!-- End Page Title -->

      <section class="section">
        <div class="maindiv d-flex justify-content-center">
          <div class="insertdiv">
            <div class="card">
              <div class="card-body">
                <h5 class="card-title">신규 등록</h5>

                <!-- Horizontal Form -->
                <form action="custmstAdd" method="post" onsubmit="return submitChk()">
                <input type="hidden" name="biz_flag" value="${biz_flag}">
                  <div class="row mb-3">
                    <label for="inputEmail3" class="col-sm-2 col-form-label"
                      >업체 명<span class="text-danger">*</span></label
                    >
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="cust_nm" required="required"/>
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label for="inputEmail3" class="col-sm-2 col-form-label"
                      >대표자명<span class="text-danger">*</span></label
                    >
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="president_nm" required="required"/>
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label for="inputEmail3" class="col-sm-2 col-form-label"
                      >사업자 번호<span class="text-danger">*</span></label
                    >
                    <div class="col-sm-10">
                      <input type="text" required="required" placeholder="000-00-00000" class="form-control" name="biz_no" id="biz_no" />
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label for="inputPassword3" class="col-sm-2 col-form-label"
                      >종목</label
                    >
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="biz_cond" />
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label for="inputPassword3" class="col-sm-2 col-form-label"
                      >업태</label
                    >
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="biz_item" />
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label for="inputPassword3" class="col-sm-2 col-form-label"
                      >주소<span class="text-danger">*</span></label
                    >
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="biz_addr" required="required"/>
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label for="inputPassword3" class="col-sm-2 col-form-label"
                      >전화번호<span class="text-danger">*</span></label
                    >
                    <div class="col-sm-10">
                      <input type="text" placeholder="000-0000-0000" class="form-control" name="biz_tel" id="biz_tel" required="required"/>
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label for="inputPassword3" class="col-sm-2 col-form-label"
                      >팩스<span class="text-danger">*</span></label
                    >
                    <div class="col-sm-10">
                      <input type="text" placeholder="000-0000-0000" class="form-control" name="biz_fax" id="biz_fax" required="required"/>
                    </div>
                  </div>

                  <div class="text-center">
                    <button type="submit" class="btn btn-primary">저장</button>
                    <a href="custmst">
	                    <button type="button" class="btn btn-secondary">
	                      취소
	                    </button>
                    </a>
                  </div>
                </form>
                <!-- End Horizontal Form -->
              </div>
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