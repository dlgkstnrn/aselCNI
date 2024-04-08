<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문 상세</title>
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
	</style>

</head>
<body>
<!-- ======= Header ======= -->
    <%@ include file="../header.jsp" %>
    <!-- ======= Sidebar ======= -->
    <%@ include file="../asidebar.jsp" %>
    
    <main id="main" class="main">
    	<div class="pagetitle">
            <h1>주문 상세</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/order">주문 관리</a></li>
                    <li class="breadcrumb-item active">주문 상세</li>
                </ol>
            </nav>
        </div> <!-- page title -->
        
        <section class="section dashboard">
        	<div class="card">		
		        <div class="container">
	        		<div class="card-body">
		        		<!-- 체크하면 수정버전 -->
	        			<div class="form-check form-switch">
	                      <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault">
	                      <label class="form-check-label" for="flexSwitchCheckChecked">읽기 전용</label>
	                	</div>
        				
        				<!-- 수정 버튼  -->
		        		<div class="d-grid gap-2 d-md-flex justify-content-md-end  py-2">
							<button class="btn btn-outline-secondary btn px-4" type="reset">취소</button>
							<button class="d-inline-flex align-items-center btn btn-primary btn px-4" type="button">수정</button>
						</div>
       					
       					<!-- 입력 폼 -->
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label">주문번호</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" value=${orderSpec.order_no} disabled>
							</div>
						</div>
        		
						<div class="row mb-3">
							<label for="order_dt" class="col-sm-2 col-form-label">착수일</label>
							<div class="col-sm-4">
								<input type="date" class="form-control"  value=${orderSpec.order_dt} readonly="readonly" >
							</div>
							<label for="order_end_dt" class="col-sm-2 col-form-label">납기일</label>
							<div class="col-sm-4">
								<input type="date" class="form-control" value=${orderSpec.order_end_dt}>
							</div>
						</div>
        		
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label">매입처</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" value=${orderSpec.cust_nm} readonly="readonly">
							</div>
							<label for="inputText" class="col-sm-2 col-form-label">담당자명</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" value=${orderSpec.user_nm} placeholder="담담자명">
							</div>
						</div>
        		
						<div class="row mb-3">
							<label for="inputPassword" class="col-sm-2 col-form-label">비고</label>
							<div class="col-sm-10">
								<textarea class="form-control" style="height: 100px">${orderSpec.remark}</textarea>
							</div>
						</div>
					<p>
						<div class="col-12">
		                	<label for="inputNanme4" class="form-label">주문 품목 </label>
		                 	<table class="table table-hover text-center">
								<thead><tr>
									<th scope="col"></th>
									<th scope="col">제품코드</th>
									<th scope="col">제품명</th>
									<th scope="col">단위</th>
									<th scope="col">수량</th>
									<th scope="col">단가</th>
								</tr></thead>
								<tbody>
									<c:forEach var = "orderItem" items = "${orderItems}">
									<tr>
										<th><input class="form-check-input" type="checkbox" value="" id="invalidCheck2"></th>
										<td>${orderItem.item_cd}</td>
										<td>${orderItem.item_nm}</td>
										<td>${orderItem.item_unit}</td>
										<td><div class="btn-group border-1" role="group">
							                <button type="button" class="btn btn-light"><i class="bi bi-dash"></i></button>
							                <button type="button" class="btn btn-light" disabled>${orderItem.qty}</button>
							                <button type="button" class="btn btn-light"><i class="bi bi-plus"></i></button>
	             						</div></td>
										<td>${orderItem.cost}</td>
									</tr>									
									</c:forEach>
								</tbody>
							</table>
		                </div> <!-- col-12, 품목 리스트 -->
		                
						<div class="d-grid gap-2 d-md-flex justify-content-md-end">
							<button class="btn btn-danger me-md-2" type="button"><i class="bi bi-trash3-fill"></i> 삭제</button>
							<button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#disablebackdrop">
								<i class="bi bi-bag-plus-fill"></i> 추가
              				</button>
						</div>
					</div>  <!-- card-body1 -->	
						
					<!-- 제품 입력 모달 -->
					<div class="modal fade modal-lg" id="disablebackdrop" tabindex="-1" data-bs-backdrop="false" aria-hidden="true" style="display: none;">
	                	<div class="modal-dialog modal-dialog-centered">
	                  		<div class="modal-content">
	                    		<div class="modal-header">
									<h5 class="modal-title"> 주문 상품 등록</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                    		</div> <!-- modal-header -->
	                    		<div class="modal-body">
	                    		
	                    		<div class="row g-3">
					                
					                <div class="col-md-3">
					                  <label for="inputZip" class="form-label">제품코드</label>
					                  <input type="text" class="form-control" id="inputZip" disabled value="PRD12345678">
					                </div>
					                <div class="col-md-5">
					                  <label for="inputState" class="form-label">제품명</label>
					                  <select id="inputState" class="form-select">
					                    <option selected="">Choose...</option>
					                    <option>...</option>
					                  </select>
					                </div>
					                <div class="col-md-2">
					                  <label for="inputCity" class="form-label">수량</label>
					                  <input type="number" class="form-control" id="inputCity">
					                </div>
					                <div class="col-md-2">
					                  <label for="inputCity" class="form-label">단위</label>
					                  <input type="text" class="form-control" id="inputCity">
					                </div>

					              </div>
             
                    			</div>
	                    		<div class="modal-footer">
					                  <button type="submit" class="btn btn-primary">Submit</button>
					                  <button type="reset" class="btn btn-secondary">Reset</button>
	                      			<button type="button" class="btn btn-primary"> 저장 </button>
	                    		</div> <!-- modal-footer -->
	                  		</div>  <!-- modal-content -->
                		</div>  <!-- modal-dialog -->
               		</div> <!-- modal fade -->	       			
		        </div> <!-- content -->
        	</div> <!-- card -->
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