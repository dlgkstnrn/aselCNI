<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문 등록</title>
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
            <h1>주문 등록</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/orderList">주문 관리</a></li>
                    <li class="breadcrumb-item active">주문 등록</li>
                </ol>
            </nav>
        </div>
        
        <section class="section dashboard">
        	<div class="card">
        		<div class="card-body"><form><p>
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label">주문번호</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" value="ORD2403280001" disabled="true">
						</div>
					</div>
					
					<div class="row mb-3">
						<label for="inputDate" class="col-sm-2 col-form-label">착수일</label>
						<div class="col-sm-4">
							<input type="date" class="form-control">
						</div>
						<label for="inputDate" class="col-sm-2 col-form-label">납기일</label>
						<div class="col-sm-4">
							<input type="date" class="form-control">
						</div>
					</div>
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label">매입처</label>
						<div class="col-sm-4">
							<select class="form-select" aria-label="Default select example">
								<option selected="">거래처 목록</option>
								<option value="1">One</option>
								<option value="2">Two</option>
								<option value="3">Three</option>
							</select>
						</div>
						<label for="inputText" class="col-sm-2 col-form-label">담당자명</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" value="거래처 담당자명">
						</div>
					</div>
					<div class="row mb-3">
						<label for="inputPassword" class="col-sm-2 col-form-label">비고</label>
						<div class="col-sm-10">
							<textarea class="form-control" style="height: 100px"></textarea>
						</div>
					</div><p>
					<div class="d-flex gap-2 justify-content-center py-2">
						<button class="d-inline-flex align-items-center btn btn-primary btn px-4 rounded-pill" type="button">저장</button>
						<button class="btn btn-outline-secondary btn px-4 rounded-pill" type="button">취소</button>
					</div>
					<hr>
					
					<!-- 물품 추가해서 생기는 목록 -->
					<div class="card-body">						
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
								<tr>
									<th><input class="form-check-input" type="checkbox" value="" id="invalidCheck2" required=""></th>
									<td>MS12345</td>
									<td>신라면</td>
									<td>박스</td>
									<td><div class="btn-group border-1" role="group">
						                <button type="button" class="btn btn-light"><i class="bi bi-dash"></i></button>
						                <button type="button" class="btn btn-light" disabled>1</button>
						                <button type="button" class="btn btn-light"><i class="bi bi-plus"></i></button>
             						</div></td>
									<td>36,000</td>
								</tr>
								<tr>
									<th><input class="form-check-input" type="checkbox" value="" id="invalidCheck2" required=""></th>
									<td>MS12345</td>
									<td>신라면</td>
									<td>박스</td>
									<td><div class="btn-group border-1" role="group">
						                <button type="button" class="btn btn-light"><i class="bi bi-dash"></i></button>
						                <button type="button" class="btn btn-light" disabled>1</button>
						                <button type="button" class="btn btn-light"><i class="bi bi-plus"></i></button>
             						</div></td>
									<td>36,000</td>
								</tr>
								<tr>
									<th><input class="form-check-input" type="checkbox"
										value="" id="invalidCheck2" required=""></th>
									<td>MS26345</td>
									<td>진라면</td>
									<td>박스</td>
									<td><div class="btn-group border-0" role="group">
						                <button type="button" class="btn btn-outline-secondary"><i class="bi bi-dash"></i></button>
						                <button type="button" class="btn btn-outline-secondary" disabled>1</button>
						                <button type="button" class="btn btn-outline-secondary"><i class="bi bi-plus"></i></button>
           							</div></td>
									<td>34,000</td>
								</tr>
								<tr>
									<th><input class="form-check-input" type="checkbox"
										value="" id="invalidCheck2" required=""></th>
									<td>MS26345</td>
									<td>진라면</td>
									<td>박스</td>
									<td><div class="btn-group border-0" role="group">
						                <button type="button" class="btn btn-outline-secondary"><i class="bi bi-dash"></i></button>
						                <button type="button" class="btn btn-outline-secondary" disabled>1</button>
						                <button type="button" class="btn btn-outline-secondary"><i class="bi bi-plus"></i></button>
           							</div></td>
									<td>34,000</td>
								</tr>
							</tbody>
						</table>
						<div class="d-grid gap-2 d-md-flex justify-content-md-end">
							<button class="btn btn-danger me-md-2" type="button"><i class="bi bi-trash3-fill"></i> 삭제</button>
							<button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#disablebackdrop">
								<i class="bi bi-bag-plus-fill"></i> 추가
              				</button>
						  <a id="list-example" href="#box">
							  <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
							    <i class="bi bi-bag-plus-fill"></i> 추가
							  </button>
						  </a>
						</div>
						<hr><p></p>
						<div id="box" data-bs-spy="scroll" data-bs-target="#list-example" data-bs-smooth-scroll="true" >
						<div class="collapse" id="collapseExample">
						  <div class="card card-body">
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
						                			                
								
				                <div class="d-grid gap-2 d-md-flex justify-content-md-end" id="scrollspyHeading1">
									<button class="btn btn-danger me-md-2" type="reset">취소</button>
									<button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#disablebackdrop">저장</button>
								</div>
								
				              </div>
	                    	</div>
						  </div>
						</div>
						</div>
						
						<!-- 제품 입력 모달 -->
						<div class="modal fade modal-lg" id="disablebackdrop" tabindex="-1" data-bs-backdrop="false" aria-hidden="true" style="display: none;">
		                	<div class="modal-dialog modal-dialog-centered">
		                  		<div class="modal-content">
		                    		<div class="modal-header">
										<h5 class="modal-title"> 주문 상품 등록</h5>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		                    		</div>
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
		                    		</div>
		                  		</div>  <!-- modal-content -->
	                		</div>  <!-- modal-dialog -->
                		</div> <!-- modal fade -->
					</div>  <!-- card-body 2 -->
       			</form></div>  <!-- card-body -->
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