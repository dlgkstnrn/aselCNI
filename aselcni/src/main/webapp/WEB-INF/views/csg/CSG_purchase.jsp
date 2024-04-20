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
<!--     <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet"> -->
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

  	<script defer src="assets/js/csg/modalCategory.js"></script> <!-- 모달 대중소분류 -->
  	<script defer src="assets/js/csg/purchaseCategory.js"></script> <!-- 모달 대중소분류 -->

	
  </head>

  <body>

    <!-- ======= Header ======= -->
    <%@ include file="../header.jsp" %>

      <!-- ======= Sidebar ======= -->
      <%@ include file="../asidebar.jsp" %>

        <!-- End Sidebar-->

        <main id="main" class="main ">
   		 <form id="deleteForm" method="post" action="/deleteSelectedPurchases"> <!-- 삭제를 처리할 URL로 수정하세요 -->
			<input type="hidden" id="selectedIds" name="selectedIds" value="">
	          <div class="pagetitle">
	            <h1>구매 관리</h1>
	            <nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item">구매 관리</li>
						<li class="breadcrumb-item active">발주 관리</li>
					</ol>
	            </nav>
	          </div><!-- End Page Title -->
			<!-- <form action="/searchPurchases" method="POST">-->
	          <section class="section dashboard">
			    <div class="card">
			
			        <!-- Main Content -->
			        <main class="card-body">
	     				<div class="d-flex align-items-end justify-content-between">
							<span class="h5 d-flex align-items-center card-header-title me-auto">발주 관리</span>
	                     								    <a href="/purchaseItemForm" class="btn btn-success">신규</a>
							    <button class="btn btn-danger ms-2" onclick="deleteSelected()">삭제</button>
	               		</div>
						<hr>

	
				  	      <!-- 검색창과 검색 버튼을 포함하는 row @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
							<div id="searchInput" class="container text-center">
								<div class="row">
									<div class="col-md-4">
										<div class="input-group mb-3" style="width: auto;">
								        	<span class="input-group-text" style="min-width: 90px; justify-content: center;">매입처</span>
								        	<input id="cust_nm" name="cust_nm" type="text" class="form-control" placeholder="매입처명" aria-label="매입처명">
							    		</div>
							    	</div>
							    	
									<div class="col-md-4">
							   			 <div class="input-group mb-3" style="width: auto;">
								        	<span class="input-group-text" style="min-width: 90px; justify-content: center;">발주번호</span>
								        	<input id="purc_no" name="purc_no" type="text" class="form-control" placeholder="발주번호" aria-label="발주번호">
							    		</div>
							    	</div>
							    	<div class="col-md-4">
									    <div class="input-group mb-3" style="width: auto;">
									        <span class="input-group-text" style="min-width: 90px; justify-content: center;">자재명</span>
									        <input id="item_nm" name="item_nm" type="text" class="form-control" placeholder="자재명" aria-label="자재명">
									    </div>
								     </div>
							     </div>
							    	
							    <div class="row">
									
								     <!-- 시작일자 입력란 -->
							    	<div class="col-md-5">
									    <div class="input-group mb-3" style="width: auto;">
									        <span class="input-group-text" style="min-width: 90px; justify-content: center;">시작일자</span>
									        <input type="date" id="start_date" name="start_date" class="form-control">
									    </div>
								    </div>
							
								    <!-- 마감일자 입력란 -->
								    <div class="col-md-5">
									    <div class="input-group mb-3" style="width: auto;">
									        <span class="input-group-text" style="min-width: 90px; justify-content: center;">마감일자</span>
									        <input type="date" id="end_date" name="end_date" class="form-control">
									    </div>
							        </div>
							    	<div class="col-md-2 text-end">
								    	<button id="searchButton" class="btn btn-primary ms-4 mb-3" type="button">검색</button>
							    	</div>
						    	</div>
						    	
							</div>
							
			        		<!-- Table -->
				            <!-- <div class="card shadow-sm rounded-lg"> -->
				                <!-- <div class="card-body"> -->
				                    <table class="table table-hover  text-center" id="jajeinsertTable">
				                        <thead>
				                            <tr>
				                                <th></th>
				                                <th>No</th>
				                                <th>발주번호</th>
				                                <th>매입처</th>
				                                <th>자재명</th>
				                                <th>수량</th>
				                                <th>단가 </th>
				                                <th>공급가액</th>
				                                <th>발주일자</th>
				                                <th>진행상태</th>
				                            </tr>
				                        </thead>
				                        <tbody id = "searchPurchase">
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
														<td><c:choose>
											                <c:when test="${purchase.purc_status_chk == 0}">
											                    <!-- <button class="btn btn-warning btn-sm" type="button">발주 완료</button> -->
											                    <span class="badge bg-success">발주진행</span>
											                    
											                </c:when>
											                <c:when test="${purchase.purc_status_chk == 1}">
											                    <!-- <button class="btn btn-info btn-sm" type="button">입고중</button> -->
											                    <span class="badge bg-primary">입고진행</span>
											                </c:when>
											                <c:when test="${purchase.purc_status_chk == 2}">
											                    <!-- <button class="btn btn-success btn-sm" type="button">입고완료</button> -->
											                    <span class="badge bg-warning text-dark">입고완료</span>
											                </c:when>
											            </c:choose></td>
												    </tr>
											</c:forEach>
				                        </tbody>
				                    </table>
				                <!-- </div> -->
				            </div>
						
			            <!-- Pagination -->
			            <div class="d-flex justify-content-center mt-4">
			            
						    <nav aria-label="Page navigation">
						        <ul id="pagination" class="pagination">
						            <c:if test="${page.startPage > 1}">
						                <li class="page-item">
						                    <a class="page-link" href="purchase?currentPage=${page.startPage - 1}" aria-label="Previous">
						                        <span aria-hidden="true">&laquo;</span>
						                    </a>
						                </li>
						            </c:if>
						            <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
						                <li class="page-item ${page.currentPage == i ? 'active' : ''}">
						                    <a class="page-link" href="purchase?currentPage=${i}">${i}</a>
						                </li>
						            </c:forEach>
						            <c:if test="${page.endPage < page.totalPage}">
						                <li class="page-item">
						                    <a class="page-link" href="purchase?currentPage=${page.startPage + page.pageBlock}" aria-label="Next">
						                        <span aria-hidden="true">&raquo;</span>
						                    </a>
						                </li>
						            </c:if>
						        </ul>
						    </nav>
						    
						    
							 <!-- 
							<nav aria-label="Page navigation example">
								<ul class="pagination justify-content-center">
									<li class="page-item">
										<button class="page-link" onclick="prevPage()" aria-label="Previous">
											<span aria-hidden="true">«</span>
										</button>
									</li>
									<c:forEach var="i" begin="${page.startPage}" end="${page.endPage }">
										<li class="page-item pageNum"><button class="page-link"
												onclick="goPage('${i}')">${i }</button></li>
									</c:forEach>
									<li id="nextPageLi" class="page-item">
										<button id="nextPageBtn" class="page-link" onclick="nextPage(this)"
											data-total-page="${page.totalPage }" aria-label="Next">
											<span aria-hidden="true">»</span>
										</button>
									</li>
								</ul>
							</nav>
						     -->   
						    
						    
						</div>
						
		        </main>
		    </div>
		</section>
		</form>

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