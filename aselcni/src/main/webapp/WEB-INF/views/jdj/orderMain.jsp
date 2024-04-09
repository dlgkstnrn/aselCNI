<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문 조회</title>
	<!-- Favicons -->
	<link href="assets/img/favicon.png" rel="icon">
	
	<!-- Google Fonts -->
	<link href="https://fonts.gstatic.com" rel="preconnect">
	<link
		href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
		rel="stylesheet">
	
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
	<script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		
	
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	
	
	
	<style>
		@font-face {
		    font-family: 'Dovemayo_gothic';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.1/Dovemayo_gothic.woff2') format('woff2');
		    font-weight: normal;
		    font-style: normal;
		}
		@font-face {
		    font-family: 'NEXON Lv2 Gothic';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/NEXON Lv2 Gothic.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		body {
			font-family: 'NEXON Lv2 Gothic';
		}
		.button {
        	display: inline-block;
	        padding: 10px 20px;
	        background-color: #f0f0f0;
	        border: 1px solid #ccc;
	        cursor: pointer;
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
            <h1>주문 조회</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">주문 관리</a></li>
                    <li class="breadcrumb-item active">주문 조회</li>
                </ol>
            </nav>
        </div>
		<!-- 본문 -->
		<section class="section dashboard">		
		<div class="card">
			
		    <div class="d-grid gap-2 d-md-flex justify-content-md-end p-4">
<!--         				<p class="fs-5">주문 검색</p> -->
			  <button class="btn btn-primary me-md-2" type="button" onclick="location.href='/orderReg'">신규 등록</button>
			  
			</div>
			
        	<div class="card-body">
				<div class="datatable-wrapper datatable-loading no-footer sortable searchable fixed-columns">
					<div class="row datatable-top">
						 <div class="row mb-2">
								<!-- 검색 -->
				        	<div class="col-md-4 d-flex flex-column position-static" style="padding-bottom: 1px">
					    		<div class="mb-3">
									<div class="input-group">
										<span class="input-group-text" id="basic-addon3">주문번호</span>
									    <input type="text" class="form-control" id="basic-url" aria-describedby="basic-addon3 basic-addon4">
									</div>
								</div>					        	
					    	</div>
					    	
					    	<!-- 기간 검색 -->
					    	<div class="col-md-8 d-flex flex-column position-static" style="padding-bottom: 1px">
								<div class="row mb-3">
									<label for="inputDate" class="col-sm-1 col-form-label">기간</label>
			                		<div class="col-sm-4">
			                    		<input type="date" class="form-control">
			                  		</div>
									<label for="inputDate" class="col-sm-1 col-form-label" style="width: auto" > ~</label>
			                		<div class="col-sm-4">
			                    		<input type="date" class="form-control">
			                  		</div>
			                  		<button class="btn btn-primary col-2" type="submit">
							            	<i class="bi bi-search"></i> 검색 
			                  		</button>
				                </div>
					    	</div>
					    	
					    	
					    	
				    	</div>
				    	
				    	
						 <div class="row mb-2">
								 <!-- 매입처 drop -->
							<div class="col-md-6 ">
						        <div class="row g-0  overflow-hidden flex-md-row mb-4  h-md-250 position-relative">
									<div class="col d-flex flex-column position-static">
							            <p>
							              <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCust" aria-expanded="false" aria-controls="collapseUser">
							                매입처 <i class="bi bi-caret-down-fill"></i>
							              </button>
							            </p>
										<div class="collapse border" id="collapseCust">
							              <div class="dropdown-menu d-block position-static pt-0 mx-0 rounded-3 overflow-hidden w-280px" data-bs-theme="light">
							                
							                <form class="p-2 mb-2 bg-body-tertiary border-bottom">
							                  <input type="search" class="form-control" autocomplete="false" placeholder="회사명">
							                </form>
							                
							                <ul class="list-unstyled mb-0 ">
								                <c:forEach var = "custMst" items="${custMsts}" varStatus="status">
								                  <li>
								                    <div class="dropdown-item d-flex align-items-center gap-2 py-2">
								                      <div class="form-check">
								                        <input class="form-check-input" type="checkbox" value="${custMst.cust_cd}" id="custMst_nm">
								                        <label class="form-check-label" for="flexCheckDefault">
								                          ${custMst.cust_nm}
								                        </label>
								                      </div>
								                    </div>
								                  </li>
								                </c:forEach>
											</ul>
							              </div> <!-- dropdown-menu -->
										</div> <!-- collapse -->
						        	</div> <!-- col p-4 -->
								</div> <!-- row -->
							</div> <!-- col-md-6 -->
			    			
			    				<!-- 영업 사원 -->
							<div class="col-md-6">
						        <div class="row g-0 rounded overflow-hidden flex-md-row mb-4 h-md-250 position-relative">
						          <div class="col d-flex flex-column position-static">
						            <p>
						              <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseUser" aria-expanded="false" aria-controls="collapseExample">
						                담당자 <i class="bi bi-caret-down-fill"></i>
						              </button>
						            </p>
						            
						            <div class="collapse border" id="collapseUser">
						              <div class="dropdown-menu d-block position-static pt-0 mx-0 overflow-hidden w-280px" data-bs-theme="light">
										<form class="p-2 mb-2 bg-body-tertiary border-bottom">
						                  <input type="search" class="form-control" autocomplete="false" placeholder="담당자명">
						                </form>
						                <ul class="list-unstyled mb-0">
											<c:forEach var = "userMst" items="${userMsts}" varStatus="status">
												<li>
													<div class="dropdown-item d-flex align-items-center gap-2 py-2">
								                      <div class="form-check">
								                        <input class="form-check-input" type="checkbox" value="${userMst.user_id}" id="user_id">
								                        <label class="form-check-label" for="flexCheckDefault">
								                          ${userMst.user_nm}
								                        </label>
								                      </div>
								                    </div>
												</li>
						                  	</c:forEach>
						                </ul>
						              </div>  <!-- collapseCust, dropdown-menu -->
						        	</div> <!-- collapseCust -->
						        	
							      </div> <!--col p-4  -->
							    </div> <!-- row g-0 -->
				    		</div> <!-- col-md-6 -->
	        			</div> <!-- row mb-2 -->
										
					</div> <%-- table-top --%>
					
					<table class="table table-borderless datatable datatable-table text-center">
					
						<thead><tr>
							<th scope="col" class="text-center">No</th>
							<th scope="col" class="text-center" id="order_no">주문번호</th>
							<th scope="col" class="text-center" id="cust_nm">고객사</th>
							<!-- <th scope="col" class="text-center" id="">제품명</th> -->
							<th scope="col" class="text-center">담당자</th>
							<th scope="col" data-sortable="true">
								<button class="datatable-sorter text-center"> 주문 일자 </button></th>
							<th scope="col" data-sortable="true">
								<button class="datatable-sorter text-center"> 마감 기한 </button></th>
							<th scope="col" class="text-center">진행상태</th>
						</tr></thead>
						<tbody>
							<c:forEach var = "order" items="${orders}" varStatus="status">
								<tr>
									<th scope="row" class="text-center">${status.index + 1}</th>
									<%-- <td class="text-center">${order.order_no}</td> --%>  <!-- ORD20240330222 -->
									<td><a href="/orderSpec?detailView=${order.order_sec_no}" <%-- %>data-bs-toggle="modal" --%>   data-bs-target="#ExtralargeModal" class="text-center">${order.order_no}</a></td>
									<td> ${order.cust_nm} </td><!-- 대한식품 -->
									<td>${order.user_nm}</td> <!-- 담당 직원 -->
									<td class="datatable"> ${order.order_dt} </td> <!-- 2016-05-25 -->
									<td class="datatable"> ${order.order_end_dt} </td>
									<td class="blue">
										<c:choose>
											<c:when test="${order.order_status_chk == 1}"><span class="badge bg-secondary">주문 취소</span></c:when>
											<c:when test="${order.order_status_chk == 2}"><span class="badge bg-primary">진행중</span></c:when>
											<c:when test="${order.order_status_chk == 3}"><span class="badge bg-secondary">출고 완료</span></c:when>
											<c:otherwise><span class="badge bg-warning text-dark">주문 완료 </span></c:otherwise>
										</c:choose>
									</td>								
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<nav class="mt-0" aria-label="Page navigation example">
						<ul class="pagination">
						<li class="page-item">
							<a class="page-link" href="#" aria-label="Previous">
							<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
						<li class="page-item"><a class="page-link" href="#">1</a></li>
						<li class="page-item"><a class="page-link" href="#">2</a></li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item">
							<a class="page-link" href="#" aria-label="Next">
							<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
						</ul>
					</nav>
				</div> <!-- datatable -->
			
				
				</div> <!-- card-body --> 
			</div>			  
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