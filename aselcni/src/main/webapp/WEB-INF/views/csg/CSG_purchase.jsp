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
		    <div class="container-fluid bg-white p-4 shadow-lg">
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
			            <div class="col d-flex justify-content-end ">
			                <a href="/purchaseItemForm" class="btn btn-success row mb-4 me-3">신규등록</a>
			                <button class="btn btn-danger mb-4">삭제</button>
			            </div>
			        
			  	      <!-- 검색창과 검색 버튼을 포함하는 row -->
						<div class="col d-flex justify-content-end mb-4">
						    <div class="input-group" style="width: auto;"> <!-- 또는 필요한 너비 지정 -->
						        <input type="search" class="form-control" style="width: 250px;" placeholder="검색">
						        <button class="btn btn-primary" type="button">검색</button>
						    </div>
						</div>

					
		            <!-- Table -->
		            <div class="card shadow-sm rounded-lg">
		                <div class="card-body">
		                    <table class="table table-striped" id="jajeinsertTable">
		                        <thead>
		                            <tr>
		                                <th>선택</th>
		                                <th>번호</th>
		                                <th>발주번호</th>
		                                <th>매입처</th>
		                                <th>자재명</th>
		                                <th>개수</th>
		                                <th>단가 </th>
		                                <th>공급가액</th>
		                                <th>발주등록일자</th>
		                                <th>발주현황</th>
		                            </tr>
		                        </thead>
		                        <tbody>
									<c:forEach var="purchase" items="${purchaseList}" varStatus="status">
									    <tr>
									        <!-- 체크박스를 포함하는 셀 -->
									        <td><input type="checkbox" id="itemSelect${status.index + 1}" name="itemSelect"></td>
									        <!-- 다른 데이터를 포함하는 셀들 -->
									        <td>${status.index + 1}</td> <!-- 행 번호를 동적으로 생성 -->
									        <td>${purchase.purc_no}</td>
									        <td>${purchase.cust_nm}</td>
									        <td>${purchase.item_nm}</td>
											<td><fmt:formatNumber value="${purchase.qty}" pattern="#,##0'개'"/></td>
   											<td><fmt:formatNumber type="number" pattern="#,##0원">${purchase.item_cost}</fmt:formatNumber></td>
   											<td><fmt:formatNumber type="number" pattern="#,##0원">${purchase.purc_cost}</fmt:formatNumber></td>
									        <td>${purchase.purc_dt}</td>
											<td>
								            <c:choose>
								                <c:when test="${purchase.purc_status_chk == 0}">
								                    <button class="btn btn-warning btn-sm">발주진행중</button>
								                </c:when>
								                <c:when test="${purchase.purc_status_chk == 1}">
								                    <button class="btn btn-info btn-sm">일부입고</button>
								                </c:when>
								                <c:when test="${purchase.purc_status_chk == 2}">
								                    <button class="btn btn-success btn-sm">입고완료</button>
								                </c:when>
								            </c:choose>
								        </td>
									    </tr>
									</c:forEach>

		                        </tbody>
		                    </table>
		                </div>
		            </div>
		
		            <!-- Pagination -->
		            <DIV class="d-flex justify-content-center">
			            <div class="d-flex justify-content-end mt-4">
						   <c:if test="${page.startPage > page.pageBlock }">
						      <a href="listEmp?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
						   </c:if>
						   <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
						      <a href="purchase?currentPage=${i}">[${i}]</a>
						   </c:forEach>
						   <c:if test="${page.endPage < page.totalPage }">
						      <a href="purchase?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
						   </c:if>   
			            </div>
		            </DIV>
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