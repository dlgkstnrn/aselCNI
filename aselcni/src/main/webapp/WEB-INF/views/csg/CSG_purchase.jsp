<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

    <!-- CSS File -->
    <link href="assets/css/style.css" rel="stylesheet" type="text/css">

    <!-- Script -->
    <script defer src="assets/js/main.js"></script>
    <script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  </head>

  <body>

    <!-- ======= Header ======= -->
    <%@ include file="../header.jsp" %>

      <!-- ======= Sidebar ======= -->
      <%@ include file="../asidebar.jsp" %>

        <!-- End Sidebar-->

        <main id="main" class="main ">

          <div class="pagetitle">
            <h1>구매 / 영업 관리</h1>
            <nav>
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">구매 / 영업 관리</a></li>
                <li class="breadcrumb-item active">발주 관리</li>
              </ol>
            </nav>
          </div><!-- End Page Title -->

          <section class="section dashboard">
		    <div class="container-fluid">
		        <!-- Navbar -->
		        <nav class="navbar navbar-light bg-light shadow-sm rounded-lg">
		            <div class="container-fluid">
		                <span class="navbar-brand mb-0 h1">
		                    <i class="fas fa-clipboard-list fa-lg text-primary"></i>
		                    발주 관리
		                </span>
		            </div>
		        </nav>
		
		        <!-- Main Content -->
		        <main class="flex-grow-1">
		            <div class="row align-items-center py-3">
		                <div class="col-md-6">
		                    <input type="search" placeholder="검색" class="form-control">
		                </div>
		                <div class="col-md-6">
		                    <button class="btn btn-primary">검색</button>
		                    <a href="/purchaseItemForm" class="btn btn-success">신규등록</a>
		                    <button class="btn btn-danger">삭제</button>
		                </div>
		            </div>
		
		            <!-- Table -->
		            <div class="card shadow-sm rounded-lg">
		                <div class="card-body">
		                    <table class="table table-striped">
		                        <thead>
		                            <tr>
		                                <th>선택</th>
		                                <th>발주번호 TB_PURCHASE PURC_NO</th>
		                                <th>발주번호 TB_PURCHASED에서 PURC_NO</th>
		                                <th>매입처(거래처)TB_CUSTMST-TB_PURCHASED조인 CUST_CD로 CUST_NM불러오기</th>
		                                <th>자재명 TB_ITEMMST에서 ITEM_NM불러오는데 ITEM_FLAG가 01인애들</th>
		                                <th>발주일자 TB_PURCHASE의 PURC_DT</th>
		                            </tr>
		                        </thead>
		                        <tbody>
		                            <tr>
		                                <td><input type="checkbox" id="itemSelect1" name="itemSelect"></td>
		                                <td>1</td>
		                                <td>11012ba</td>
		                                <td>우리상사</td>
		                                <td>비닐봉지(소분류?)</td>
		                                <td>2024-04-01</td>
		                            </tr>
		                            <tr>
		                                <td><input type="checkbox" id="itemSelect2" name="itemSelect"></td>
		                                <td>2</td>
		                                <td>11012bb</td>
		                                <td>너네리상사</td>
		                                <td>스프용 버섯(소분류?)</td>
		                                <td>2024-04-01</td>
		                            </tr>
		                            <tr>
		                                <td><input type="checkbox" id="itemSelect3" name="itemSelect"></td>
		                                <td>3</td>
		                                <td>11012bc</td>
		                                <td>하늘공사</td>
		                                <td>물감(소분류?)</td>
		                                <td>2024-04-01</td>
		                            </tr>
		                        </tbody>
		                    </table>
		                </div>
		            </div>
		
		            <!-- Pagination -->
		            <div class="d-flex justify-content-end mt-4">
		                <button class="btn btn-outline-primary ml-2">이전</button>
		                <button class="btn btn-outline-primary ml-2">다음</button>
		            </div>
		        </main>
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
          <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
          <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
          <script src="assets/vendor/chart.js/chart.umd.js"></script>
          <script src="assets/vendor/echarts/echarts.min.js"></script>
          <script src="assets/vendor/quill/quill.min.js"></script>
          <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
          <script src="assets/vendor/tinymce/tinymce.min.js"></script>
          <script src="assets/vendor/php-email-form/validate.js"></script>

  </body>

  </html>