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
     	.topdiv {
		  height: 40px;
		}
		.selectbtndiv {
		  padding: 0px 10px;
		}
		
		.wid150 {
		  width: 150px;
		}
		.bordergray {
		  border: 1px solid gray;
		  color: black;
		}
		.searchdiv {
		  height: 40px;
		  padding: 0px 20px;
		  margin-bottom: 10px;
		}
		.searchselect {
		  width: 150px;
		  margin-right: 10px;
		}
		.searchinput {
		  width: 300px;
		  margin-right: 10px;
		}

     </style>
     <!-- Script -->
    <script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
              <a href="/userManagement">고객사</a>
            </li>
          </ol>
        </nav>
      </div>
      <!-- End Page Title -->

      <section class="section">
        <div class="maindiv">
          <div class="topdiv d-flex justify-content-end">
            <div>
            	<a href="custmstAddForm">
              		<button class="btn btn-primary">신규</button>
              	</a>
              <button class="btn btn-primary">수정</button>
              <button class="btn btn-primary">삭제</button>
            </div>
          </div>
          <div class="selectbtndiv">
            <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
              <li class="nav-item" role="presentation">
                <button
                  class="bordergray nav-link active wid150"
                  id="pills-home-tab"
                  data-bs-toggle="pill"
                  data-bs-target="#pills-home"
                  type="button"
                  role="tab"
                  aria-controls="pills-home"
                  aria-selected="false"
                  tabindex="-1"
                >
                  고객사
                </button>
              </li>
              <li class="nav-item" role="presentation">
                <button
                  class="bordergray nav-link wid150"
                  id="pills-profile-tab"
                  data-bs-toggle="pill"
                  data-bs-target="#pills-profile"
                  type="button"
                  role="tab"
                  aria-controls="pills-profile"
                  aria-selected="true"
                >
                  구매처
                </button>
              </li>
            </ul>
          </div>
          <div class="searchdiv">
            <form action="">
              <div class="d-flex">
                <select
                  class="form-select searchselect"
                  aria-label="Default select example"
                >
                  <option selected="">검색옵션선택</option>
                  <option value="1">코드</option>
                  <option value="2">이름</option>
                </select>
                <input type="text" class="form-control searchinput" />
                <button type="submit" class="btn btn-primary">검색</button>
              </div>
            </form>
          </div>
          <div class="tablediv">
            <table id="tb" class="table table-hover">
              <thead>
                <tr>
                  <th scope="col" style="width: 5%">No</th>
                  <th scope="col" style="width: 10%">업체명</th>
                  <th scope="col" style="width: 10%">대표자명</th>
                  <th scope="col" style="width: 20%">전화번호</th>
                  <th scope="col" style="width: 20%">팩스 번호</th>
                  <th scope="col" style="width: 10%">담당자</th>
                  <th scope="col" style="width: 25%">이메일</th>
                </tr>
              </thead>
              <tbody>
                <!-- <tr data-index="15">
                  <th>1</th>
                  <td>농심</td>
                  <td>이한수</td>
                  <td>010-0000-0000</td>
                  <td>02-0000-0000</td>
                  <td>김평화</td>
                  <td>dlgkstnrn@naver.com</td>
                </tr> -->
              </tbody>
            </table>
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