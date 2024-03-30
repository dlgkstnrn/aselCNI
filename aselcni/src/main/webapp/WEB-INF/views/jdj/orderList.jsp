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
				<!-- <h5 class="card-title"> Recent Sales <span>| Today</span></h5> -->
				<div class="datatable-wrapper datatable-loading no-footer sortable searchable fixed-columns">
					<div class="row  datatable-top">
					    <div class="col-3">
					        <select id="inputState" class="form-select">
					            <option selected="">Choose...</option>
					            <option>...</option>
					        </select>
					    </div>
					    <div class="col-3 datatable-search">
					        <input class="datatable-input" placeholder="Search..." type="search" title="Search within table">
					    </div>
					    <div class="col-3"></div>
					    <div class="col-3">
						    <button type="button" class="btn btn-primary" onclick="location.href='/order'">신규</button>
						</div>
					</div>  <!-- row -->
					
				</div>  <!-- datable=rapper 1 -->
					
					<!-- <div class="datatable-wrapper datatable-loading no-footer sortable searchable fixed-columns"> -->
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
              		<!-- </div>  datatable-wrapper -->
				</div>

			</div> <!-- card-body --> 
        </section>
    </main>
</body>
</html>