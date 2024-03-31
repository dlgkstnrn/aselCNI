<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <h1>주문 조회</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">주문 관리</a></li>
                    <li class="breadcrumb-item active">주문 조회</li>
                </ol>
            </nav>
        </div>
        
		<section class="section dashboard">
        	<div class="card-body">
				<div class="datatable-wrapper datatable-loading no-footer sortable searchable fixed-columns">
					<div class="row datatable-top">
					    <div class="col-9">
					        <div class="input-group mb-3 row">
					            <select id="inputState" class="form-select col-3" style="width: 10%">
					                <option> 주문번호 </option>
					                <option> 고객사 </option>
					                <option> 담당자 </option>
					            </select>
					            <input type="text" class="form-control col-6" aria-label="Text input with segmented dropdown button" style="width: 60%">
					            <button type="button" class="btn btn-outline-secondary col-1"><i class="bi bi-search"></i></button>
					        </div>
					    </div>
					    <div class="col-2 d-flex justify-content-end" style="width: 24.6%">
					        <button type="button" class="btn btn-primary" onclick="location.href='/order'" style="height: 38px; width: 60px">신규</button>
					    </div>
					</div> <%-- table-top --%>
					<table class="table table-borderless datatable datatable-table text-center">
						<thead><tr>
							<th scope="col" class="text-center">No</th>
							<th scope="col" class="text-center">주문번호</th>
							<th scope="col" class="text-center">고객사</th>
							<th scope="col" class="text-center">제품명</th>
							<th scope="col" class="text-center">담당자</th>
							<th scope="col" data-sortable="true">
								<button class="datatable-sorter text-center"> Start Date </button></th>
							<th scope="col" data-sortable="true">
								<button class="datatable-sorter text-center"> End Date </button></th>
							<th scope="col" class="text-center">진행상태</th>
						</tr></thead>
						<tbody>
							<tr>
								<th scope="row" class="text-center">1</th>
								<td class="text-center">ORD20240330222</td>
								<td>대한식품</td>
								<td><a href="#" class="d-inline-block text-truncate" style="max-width: 100px;">
									신라면매운맛이조으지</a></td>
								<td>정다진</td>
								<td class="datatable">2016-05-25</td>
								<td class="datatable">2016-05-25</td>
								<td class="green"><span class="badge bg-success">진행중</span></td>
							</tr>
							<tr>
								<th scope="row" class="text-center">2</th>
								<td class="text-center">ORD20240331292</td>
								<td>중앙제과</td>
								<td><a href="#" class="d-inline-block text-truncate" style="max-width: 100px;">
									비빔면이랑 짜파게티가 조으지 비빔면이랑 짜파게티가 조으지</a></td>
								<td>정다진</td>
								<td class="datatable">2014-12-05</td>
								<td class="datatable">2014-12-05</td>
								<td class="green"><span class="badge bg-success">진행중</span></td>
							</tr>
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
        </section>
    </main>
    
</body>
</html>