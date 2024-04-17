<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
     </style>
     <!-- Script -->
    <script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script defer="defer" src="assets/js/main.js" type="text/javascript"></script>
	<script defer="defer" type="text/javascript" src="assets/js/lhs/itemmstaddForm.js"></script>
</head>

<body>

    <!-- ======= Header ======= -->
    <%@ include file="../header.jsp" %>

    <!-- ======= Sidebar ======= -->
    <%@ include file="../asidebar.jsp" %>
    
    <!-- End Sidebar-->

    <main id="main" class="main">
      <div class="pagetitle">
        <h1>품목관리</h1>
        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item active">품목관리</li>
            <li class="breadcrumb-item active">신규</li>
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
                <form action="itemmstAdd" method="post" onsubmit="return submitChk()">
                  <input type="hidden" name="item_flag" value="${item_flag}" />
                  <div class="row mb-3">
                    <label for="inputEmail3" class="col-sm-2 col-form-label"
                      >품목 코드<span class="text-danger">*</span></label
                    >
                    <div class="col d-flex">
                      <input id="item_cd" type="text" class="form-control" name="item_cd"
                        placeholder="대문자알파벳3자 + 숫자4 ABC0000" style="width: 400px; margin-right: 15px"/>
                      <input type="button" class="btn btn-primary" value="중복체크"id="chkBtn"/>
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label for="inputEmail3" class="col-sm-2 col-form-label"
                      >품목 명<span class="text-danger">*</span></label
                    >
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="item_nm" required="required" />
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label for="inputEmail3" class="col-sm-2 col-form-label"
                      >거래처<span class="text-danger">*</span></label
                    >
                    <div class="col-sm-10">
                      <select
                        class="form-select"
                        aria-label="Default select example"
                        name="cust_cd"
                      >
                        <option selected="">거래처선택</option>
                        <c:forEach items="${custList }" var="cust">
                        	<option value="${cust.cust_cd }">${cust.cust_nm}</option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>
                  <div class="row mb-3 d-flex">
                    <label for="inputEmail3" class="col-sm-2 col-form-label"
                      >분류<span class="text-danger">*</span></label
                    >
                    <div class="col">
                      <select
                        class="form-select"
                        aria-label="Default select example"
                        name="big_no" id="big">
                        <option selected="">대분류</option>
                        <c:forEach items="${bigList }" var="big">
                        	<option value="${big.big_no }">${big.big_content }</option>
                        </c:forEach>
                      </select>
                    </div>
                    <div class="col">
                      <select class="form-select" aria-label="Default select example" name="mid_no" id="mid">
                        <option selected="">중분류</option>
                      </select>
                    </div>
                    <div class="col">
                      <select class="form-select" aria-label="Default select example" name="sml_no" id="sml">
                        <option selected="">소분류</option>
                      </select>
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label for="inputEmail3" class="col-sm-2 col-form-label"
                      >규격<span class="text-danger">*</span></label
                    >
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="item_spec" required="required"/>
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label for="inputPassword3" class="col-sm-2 col-form-label"
                      >단위<span class="text-danger">*</span></label
                    >
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="item_unit" required="required"/>
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label for="inputPassword3" class="col-sm-2 col-form-label"
                      >단가<span class="text-danger">*</span></label
                    >
                    <div class="col-sm-10">
                      <input id="item_cost" type="text" class="form-control" name="item_cost" required="required"/>
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label for="inputPassword3" class="col-sm-2 col-form-label"
                      >비고</label
                    >
                    <div class="col-sm-10">
                      <input type="text" class="form-control" name="remark" />
                    </div>
                  </div>

                  <div class="text-center">
                    <button type="submit" class="btn btn-primary">저장</button>
                    <a href="itemmst">
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