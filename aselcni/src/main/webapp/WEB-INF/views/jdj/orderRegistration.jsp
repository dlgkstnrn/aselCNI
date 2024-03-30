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
                    <li class="breadcrumb-item"><a href="#">주문 관리</a></li>
                    <li class="breadcrumb-item active">주문 등록</li>
                </ol>
            </nav>
        </div>
        
        <section class="section dashboard">
        	<div class="card">
        		<div class="card-body"><form>
		        <p>
        		
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
					</div>
					
					<p>
					
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
									<th><input class="form-check-input" type="checkbox"
										value="" id="invalidCheck2" required=""></th>
									<td>MS12345</td>
									<td>신라면</td>
									<td>박스</td>
									<td>
										<div class="btn-group border-1" role="group">
							                <button type="button" class="btn btn-light"><i class="bi bi-dash"></i></button>
							                <button type="button" class="btn btn-light" disabled>1</button>
							                <button type="button" class="btn btn-light"><i class="bi bi-plus"></i></button>
              							</div>
									</td>
									
									
									<td>36,000</td>
								</tr>
								<tr>
									<th><input class="form-check-input" type="checkbox"
										value="" id="invalidCheck2" required=""></th>
									<td>MS26345</td>
									<td>진라면</td>
									<td>박스</td>
									<td>
										<div class="btn-group border-0" role="group">
							                <button type="button" class="btn btn-outline-secondary"><i class="bi bi-dash"></i></button>
							                <button type="button" class="btn btn-outline-secondary" disabled>1</button>
							                <button type="button" class="btn btn-outline-secondary"><i class="bi bi-plus"></i></button>
              							</div>									
									
									</td>
									
									<td>34,000</td>
								</tr>
							</tbody>
						</table>
						<div class="d-grid gap-2 d-md-flex justify-content-md-end">
						  <button class="btn btn-danger me-md-2" type="button"><i class="bi bi-trash3-fill"></i> 삭제</button>
						  <button class="btn btn-success" type="button"><i class="bi bi-bag-plus-fill"></i> 추가</button>
						</div>
					</div>  <!-- card-body 2 -->
					
					<div class="d-inline-flex gap-2 mb-5 justify-content-center">
					</div>
					
       			</form></div>  <!-- card-body -->
        	</div> <!-- card -->
        </section>
    </main>

</body>
</html>