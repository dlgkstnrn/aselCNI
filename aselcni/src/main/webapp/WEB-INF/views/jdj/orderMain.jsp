<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>스마트 제조 시스템</title>
	<!-- Favicons -->
	<link href="assets/img/favicon.png" rel="icon">
	
	<!-- Google Fonts -->
	<link href="https://fonts.gstatic.com" rel="preconnect">
	
	<link
		href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
		rel="stylesheet">
	
	<script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<!-- Vendor CSS Files -->
	<link href="assets/vendor/bootstrap/css/bootstrap.min.css"
		rel="stylesheet">
	<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css"
		rel="stylesheet">
	
	<link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
	<link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
	<link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
	<link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">
	<link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
	
	<!-- CSS File -->
	<link href="assets/css/style.css" rel="stylesheet" type="text/css">
	
	<!-- Script -->
	<script defer src="assets/js/main.js"></script>
	<script src="assets/js/jdj/jdjOrder.js"></script>
	
	
	<style>
		.button {
        	display: inline-block;
	        padding: 10px 20px;
	        background-color: #f0f0f0;
	        border: 1px solid #ccc;
	        cursor: pointer;
	    }
	    .hidden {
	    	display: none != important;
	    }
	</style>
</head>
<body>
<!-- ======= Header ======= -->
<%@ include file="../header.jsp" %>
<!-- ======= Sidebar ======= -->
<%@ include file="../asidebar.jsp" %>
    <main id="main" class="main">
		<div class="pagetitle">
			<h1>영업 관리</h1>
			<nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"> 영업 관리</li>
                    <li class="breadcrumb-item active"><a href="#">주문 관리</a></li>
                </ol>
            </nav>
<!--         				<p class="fs-5">주문 검색</p> -->
			  <!-- <button class="btn btn-primary d-md-flex justify-content-md-end" type="button" onclick="location.href='/orderReg'">신규 등록</button> -->
        </div>
		<!-- 본문 -->	
		<section class="section dashboard">		
			<div class="card">
				<div class="card-body">
									<!-- 카드 제목 부  -->
					<div class="d-flex align-items-center">
						<span class="h5 me-auto card-header-title">주문 조회</span>
						<div>
							<a href="/orderReg" type="button" class="btn btn-success ">신규</a>
						</div>
					</div>
					<hr>
					<div class="row">
						<div class="col-md-3">
							<div class="input-group">
								<span class="input-group-text">주문번호</span>
					            <input id="input_order_no" type="text" class="form-control" aria-label="Username" aria-describedby="basic-addon1">
							</div>
				        </div> <!-- 주문번호 -->
				        <div class="col-md-6">
							<div class="input-group">
								<button style="border-color: #dee2e6 " id="selectDT" class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">기간 선택</button>
								<ul class="dropdown-menu">
									<li><button class="dropdown-item" value="order_dt">주문일자</button></li>
									<li><button class="dropdown-item" value="order_end_dt">납기일자</button></li>
								</ul>
								<input id="input_start_dt" type="date" aria-label="start-dt" class="form-control">
								<input id="input_end_dt" type="date" aria-label="end-dt" class="form-control">
							</div>
						</div> <!-- 검색 기간 -->
						<div class="col-md-3">
							<button type="button" id="serachBtn" class="btn btn-primary">검색</button>
							<button type="reset" id="resetBtn" class="btn btn-primary"><i class="bi bi-arrow-clockwise"></i></button>
						</div> <!-- 검색 버튼 -->	
						<div class="col-md-3">
						</div> <!-- 검색 버튼 -->	
					</div> <!--첫번째 row -->
					<p />
					<div class="row">
						<div class="col-md-6">
							<div class="row g-0  overflow-hidden flex-md-row mb-4  h-md-250 position-relative">
								<div class="col d-flex flex-column position-static">
									<p>
						            <button style="border-color: #dee2e6 " class="btn btn-outline-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCust" aria-expanded="false" aria-controls="collapseUser">
			            				고객사 <i class="bi bi-caret-down-fill"></i></button>
			            			</p> <!-- 고객사 collapse 여는 버튼 -->
									<div class="collapse border" id="collapseCust">
										<div class="dropdown-menu d-block position-static pt-0 mx-0 rounded-3 overflow-hidden w-280px" data-bs-theme="light">  
											<!-- <div class="p-2 mb-2 bg-body-tertiary border-bottom">
												<input type="search" class="form-control" autocomplete="false" placeholder="회사명">
											</div> -->  <!-- 고객사 검색 -->
											<ul class="list-unstyled mb-0 ">
												<c:forEach var = "custMst" items="${custMsts}" varStatus="status">
								                  <li>
								                    <div class="dropdown-item d-flex align-items-center gap-2 py-2">
								                      <div class="form-check">
								                        <input class="custCheckbox form-check-input" type="checkbox" value="${custMst.cust_cd}" id="${custMst.cust_cd}">
								                        <label class="form-check-label" for="${custMst.cust_cd}">
								                          ${custMst.cust_nm}
								                        </label>
								                      </div>
								                    </div>
								                  </li>
								                </c:forEach>
											</ul>
										</div> <!-- dropdown-menu -->
									</div> <!-- collapse -->
								</div> <!-- col d-flex -->
							</div> <!-- row g-0  -->
						</div> <!-- col-md-6 -->
						
						<div class="col-md-6">
							<div class="row g-0  overflow-hidden flex-md-row mb-4  h-md-250 position-relative">
								<div class="col d-flex flex-column position-static">
									<p>
						            <button style="border-color: #dee2e6 " class="btn btn-outline-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseUser" aria-expanded="false" aria-controls="collapseUser">
			            				담당자명 <i class="bi bi-caret-down-fill"></i></button>
			            			</p> <!-- 고객사 collapse 여는 버튼 -->
									<div class="collapse border" id="collapseUser">
										<div class="dropdown-menu d-block position-static pt-0 mx-0 rounded-3 overflow-hidden w-280px" data-bs-theme="light">  
											<!-- <div class="p-2 mb-2 bg-body-tertiary border-bottom">
												<input id="searchUserName" type="search" class="form-control" autocomplete="false" placeholder="담당자명">
											</div> -->  <!-- 고객사 검색 -->
											<ul class="list-unstyled mb-0 ">
												<c:forEach var = "userMst" items="${userMsts}" varStatus="status">
								                  <li>
								                    <div class="userDrop dropdown-item d-flex align-items-center gap-2 py-2">
								                      <div class="form-check">
															<input class="userCheckbox form-check-input" type="checkbox" value="${userMst.user_id}" id="${userMst.user_id}">
									                        <label class="form-check-label" for="${userMst.user_id}">
									                          ${userMst.user_nm}
									                        </label>
								                      </div>
								                    </div>
								                  </li>
								                </c:forEach>
											</ul>
										</div> <!-- dropdown-menu -->
									</div> <!-- collapse -->
								</div> <!-- col d-flex -->
							</div> <!-- row g-0  -->
						</div> <!-- col-md-6 -->
						
					</div> <!-- 두번째 체크박스 row -->
				
				<table class="table table-hover datatable datatable-table text-center" id="orderTable">
					<thead><tr>
						<th scope="col" class="text-center">No</th>
						<th scope="col" class="text-center" id="order_no">주문번호</th>
						<th scope="col" class="text-center" id="cust_nm">고객사</th>
						<th scope="col" class="text-center">주문일자</th>
						<th scope="col" class="text-center">납기일자</th>
						<!-- <th scope="col" data-sortable="false">
							<button class="datatable-sorter text-center"> 주문일자 </button></th>
						<th scope="col" class="text-center" data-sortable="true">
							<button class="datatable-sorter text-center"> 납기일자 </button></th>-->
						<th scope="col" class="text-center">담당자명</th>
						<th scope="col" class="text-center">진행상태</th>
					</tr></thead>
					<tbody id="table_body">
						<c:forEach var = "order" items="${orders}" varStatus="status">
							<tr>
								<th scope="row" class="text-center">${status.index + 1}</th>
									<td><a href="/orderSpec?detailView=${order.order_sec_no}" <%-- %>data-bs-toggle="modal" --%>   data-bs-target="#ExtralargeModal" class="text-center">${order.order_no}</a></td>
									<td> ${order.cust_nm} </td><!-- 대한식품 -->
									<td class="datatable"> ${order.order_dt} </td> <!-- 2016-05-25 -->
									<td class="datatable"> ${order.order_end_dt} </td>
									<td>${order.user_nm}</td> <!-- 담당 직원 -->
									<td class="blue">
										<c:choose>
											<c:when test="${order.order_status_chk == 1}"><span class="badge bg-secondary">주문 취소</span></c:when>
											<c:when test="${order.order_status_chk == 2}"><span class="badge bg-primary">진행중</span></c:when>
											<c:when test="${order.order_status_chk == 3}"><span class="badge bg-success">출고 완료</span></c:when>
											<c:otherwise><span class="badge bg-warning text-dark">주문 완료</span></c:otherwise>
										</c:choose>
									</td>								
								</tr>
							</c:forEach>
						</tbody>
				</table>
				<div class="d-flex justify-content-center mt-4">
					<nav aria-label="Page navigation" id="paging">
					<c:set var = "startPage" value="${((currentPage - 1) div 5) * 5 + 1}"></c:set>
					<c:set var = "endPage" value="${startPage + 4 }" />
					<c:if test = "${endPage  > totalPage}">
						<c:set var = "endPage" value="${totalPage}" />
					</c:if>
					  <ul class="pagination">
					    	<c:if test="${startPage > 1}">
								<li class="page-item">
					      		<a class="page-link" href="?page=${startPage - 5}" aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
					      		</a>
								</li>
					      	</c:if>
					        <c:if test="${totalPage > 0}">
					            <c:forEach var="page" begin="${startPage}" end="${endPage - 1}"  varStatus="status">
					                <li class="page-item"><a class="${page == currentPage ? 'active' : ''} page-link" href="?page=${page + 1}">${status.index+1 }</a></li>
					            </c:forEach>
					        </c:if>
					    <c:if test="${endPage < totalPage}">
					    <li class="page-item">
					      <a class="page-link" href="?page=${startPage + 5}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					    </c:if>
					  </ul>
					</nav>
				</div>
				<%-- <p>${totalPage} : 총 페이지 수</p> --%>
				

				</div> <!-- card-body -->
			</div><!-- card -->		  
        </section>
    </main>

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